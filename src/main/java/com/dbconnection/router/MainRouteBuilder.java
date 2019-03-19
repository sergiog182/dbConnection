package com.dbconnection.router;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.converter.jaxb.JaxbDataFormat;
import org.apache.camel.spi.DataFormat;

import com.dbconnection.processors.OrderProcessor;

public class MainRouteBuilder extends RouteBuilder{
	@Override
	public void configure() {
		DataFormat jaxb = new JaxbDataFormat("com.dbconnection.classes");
		
		from("file:files/incoming?noop=true")
		.unmarshal(jaxb)
		.process(new OrderProcessor())
		.marshal(jaxb)
		
		.setHeader("bodyXML", body())
		.setHeader("name", xpath("/order/name/text()", String.class))
		.setHeader("country", xpath("/order/country/text()", String.class))
		.setHeader("total", xpath("/order/total/text()", String.class))
		.setHeader("accepted", xpath("/order/accepted/text()", String.class))
		.setHeader("itemsQuantity", xpath("/order/itemsQuantity/text()", String.class))
		.setHeader("comments", xpath("/order/comments/text()", String.class))
		
		.to("sqlComponent:"
				+ "insert into orders "
				+ "(name, country, total, accepted, itemsQuantity, comments) "
				+ "values "
				+ "(:#name, :#country, :#total, :#accepted, :#itemsQuantity, :#comments);")
		
		.to("sqlComponent:SELECT LAST_INSERT_ID();?outputType=SelectOne")
		.setHeader("orderId", body())
		
		.setBody(header("bodyXML"))
		.split().tokenizeXML("item").streaming()
			.setHeader("itemName", xpath("item/itemName/text()", String.class))
			.setHeader("itemValue", xpath("item/value/text()", String.class))
			.setHeader("quantity", xpath("item/quantity/text()", String.class))
			.to("sqlComponent:select IFNULL((select id from items where itemName = :#itemName), 0 ) as id;?outputType=SelectOne")
			.setHeader("itemId", body())
			
			.choice()
				.when()
				.simple("${headers.itemId} == 0")
				.to("sqlComponent:insert into items (itemName, value) values (:#itemName, :#itemValue);")
				.to("sqlComponent:select LAST_INSERT_ID();?outputType=SelectOne")
				.setHeader("itemId", body())
			.end()
			.to("sqlComponent:insert into orderitems (idOrder, idItem, quantity) values (:#orderId, :#itemId, :#quantity);")
		.end();
	}
}
