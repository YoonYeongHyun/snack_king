package com.snackking.model;

import java.sql.Timestamp;

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
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_kind() {
		return product_kind;
	}
	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public int getProduct_sale_price() {
		return product_sale_price;
	}
	public void setProduct_sale_price(int product_sale_price) {
		this.product_sale_price = product_sale_price;
	}
	public int getProduct_qty() {
		return product_qty;
	}
	public void setProduct_qty(int product_qty) {
		this.product_qty = product_qty;
	}
	public int getProduct_sales() {
		return product_sales;
	}
	public void setProduct_sales(int product_sales) {
		this.product_sales = product_sales;
	}
	public String getProduct_brand() {
		return product_brand;
	}
	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public String getProduct_content() {
		return product_content;
	}
	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}
	public String getProduct_content_image() {
		return product_content_image;
	}
	public void setProduct_content_image(String product_content_image) {
		this.product_content_image = product_content_image;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_kind=" + product_kind + ", product_name="
				+ product_name + ", product_price=" + product_price + ", discount_rate=" + discount_rate
				+ ", product_sale_price=" + product_sale_price + ", product_qty=" + product_qty + ", product_sales="
				+ product_sales + ", product_brand=" + product_brand + ", product_image=" + product_image
				+ ", product_content=" + product_content + ", product_content_image=" + product_content_image
				+ ", reg_date=" + reg_date + "]";
	}
	
	
}
