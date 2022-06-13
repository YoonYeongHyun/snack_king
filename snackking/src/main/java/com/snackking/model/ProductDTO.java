package com.snackking.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductDTO {

	private int product_id;
	private String product_kind;
	private String product_name;
	private int product_price;
	private int discount_rate;
	private int product_sale_price;
	private int product_qty;
	private int product_sales;
	private String product_brand;
	private String product_image;
	private String product_content;
	private String product_content_image;
	private Timestamp reg_date;
		
}
