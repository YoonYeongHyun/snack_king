package com.snackking.model;

import lombok.Data;

@Data
public class CartDTO {
	private int cart_num;
	private String id;
	private int product_id;
	private int product_amount;
}
