package com.prokarma.testpoc.util;

import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.prokarma.testpoc.to.Item;

public class POCUtil {
	private static ApplicationContext context;

	private POCUtil() {
	}

	/**
	 * This method used to parse xml string to and item java object
	 * 
	 * @param {@link String}
	 * @return {@link Item} or null if xml having any error
	 */
	public static Item parseXMLString(String xmlString) {
		try {
			Document document = DocumentHelper.parseText(xmlString);
			Element parentNode = document.getRootElement();
			Iterator nodes = parentNode.nodeIterator();
			if (nodes != null) {
				Item item = new Item();
				while (nodes.hasNext()) {
					org.dom4j.Node node = (org.dom4j.Node) nodes.next();
					if (node.getName() != null)
						if (node.getName().equals(Constants.ITEM_COUNT)) {
							item.setItem_count(Long.valueOf(node
									.getStringValue()));
						} else if (node.getName().equals(Constants.ITEM_DESC)) {
							item.setItem_desc(node.getText());
						} else if (node.getName().equals(Constants.ITEM_NAME)) {
							item.setItem_name(node.getText());
						} else if (node.getName().equals(
								Constants.ITEM_LAST_UDATED_TIME)) {
							item.setItem_last_updated_tmstmp(node.getText());
						}
				}
				return item;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * this method is used to validating a new item at the time of adding
	 * 
	 * @param {@link Item}
	 * @return true if item having item name and false if item doesn't have item
	 *         name
	 */
	public static boolean validateNewItem(Item item) {
		if (item != null && item.getItem_name() != null
				&& item.getItem_name().trim().length() > 0) {
			return true;
		} else
			return false;
	}

	/**
	 * this method is used to validating a existed item at the time of update
	 * 
	 * @param {@link Item}
	 * @return <b>true</b> if item having item name <br/>
	 *         <b>false</b> if item doesn't have item name or last updated time
	 */
	public static boolean validateUpdateItem(Item item) {
		if (item != null && item.getItem_name() != null
				&& item.getItem_name().trim().length() > 0
				&& item.getItem_last_updated_tmstmp() != null
				&& item.getItem_last_updated_tmstmp().trim().length() > 0) {
			return true;
		} else
			return false;
	}

	/** This method return an object depend on bean id else throws exception */
	public static Object getApplicationContext(String beanId) {
		if (context == null) {
			context = new ClassPathXmlApplicationContext(
					"application_context.xml");
		}
		return context.getBean(beanId);
	}

}
