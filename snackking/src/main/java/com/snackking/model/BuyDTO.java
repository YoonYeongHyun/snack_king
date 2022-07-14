package com.snackking.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BuyDTO {
	private String buy_id;
	private int product_id;
	private String id;
	private String product_name;
	private String product_image;
	private int buy_amount;
	private int buy_price;
	private Timestamp buy_date;
	private String buy_info;
	private String buyer;
	private String buyer_tel;
	private String buyer_addr;
	private String buyer_email;
	private String recipient;
	private String recipient_addr;
	private String recipient_tel;
		

	private int product_qty;
}
