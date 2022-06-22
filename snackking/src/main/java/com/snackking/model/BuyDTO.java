package com.snackking.model;

import lombok.Data;

@Data
public class BuyDTO {
	 	String buy_id;
	    int product_id;
	    String id;
	    String product_name;
	    String product_image;
	    int buy_amount;
	    int buy_price;
		int buy_date;
		String buy_info;
		String buyer;
		String buyer_tel;
		String buyer_addr;
		String buyer_email;
		String recipient;
		String recipient_addr;
		String recipient_tel;
}
