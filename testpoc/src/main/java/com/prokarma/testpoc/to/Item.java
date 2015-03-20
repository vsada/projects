package com.prokarma.testpoc.to;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * @author skalesha
 *
 */
@XmlRootElement
public class Item {

	private String item_name;
	private String item_desc;
	private long item_count;
	private String item_last_updated_tmstmp;

	@XmlElement
	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	@XmlElement
	public String getItem_desc() {
		return item_desc;
	}

	public void setItem_desc(String item_desc) {
		this.item_desc = item_desc;
	}

	@XmlElement
	public long getItem_count() {
		return item_count;
	}

	public void setItem_count(long item_count) {
		this.item_count = item_count;
	}

	@XmlElement
	public String getItem_last_updated_tmstmp() {
		return item_last_updated_tmstmp;
	}

	public void setItem_last_updated_tmstmp(String item_last_updated_tmstmp) {
		this.item_last_updated_tmstmp = item_last_updated_tmstmp;
	}

	@Override
	public String toString() {
		return "Item [item_name=" + item_name + ", item_desc=" + item_desc
				+ ", item_count=" + item_count + ", last_updated_time="
				+ item_last_updated_tmstmp + "]";
	}

}
