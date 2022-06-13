package com.snackking.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewDTO {
	private int re_num;
	private String id;
	private String re_title;
	private String re_content;
	private Timestamp re_regDate;
	private String re_rate;
	private int product_id;
	private int readCount;
}
