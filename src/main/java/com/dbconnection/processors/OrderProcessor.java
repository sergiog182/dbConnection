package com.dbconnection.processors;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

import com.dbconnection.classes.*;

public class OrderProcessor implements Processor{
	@Override
	public void process(Exchange ex) {
		Order order = ex.getIn().getBody(Order.class);
		int total = Integer.parseInt(order.getTotal());
		int totalItems = 0;
		int totalValue = 0;
		for (Item item : order.getItems().getItem()) {
			totalItems = totalItems + Integer.parseInt(item.getQuantity());
			totalValue = totalValue + Integer.parseInt(item.getValue());
		}
		if (totalValue != total) {
			order.setComments("Valor ajustado: " + total);
			total = totalValue;
		} else {
			order.setComments("Valor no ajustado");
		}
		order.setItemsQuantity(Integer.toString(totalItems));
		if (Integer.parseInt(order.getTotal()) >= 1000000) {
			order.setAccepted("Accepted");
		} else {
			order.setAccepted("Rejected");
		}
	}
}
