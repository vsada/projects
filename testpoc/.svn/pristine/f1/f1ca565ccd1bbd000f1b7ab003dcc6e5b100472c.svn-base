package com.prokarma.testpoc;

import org.junit.*;

import com.prokarma.testpoc.dao.impl.InventoryDaoImpl;
import com.prokarma.testpoc.exceptions.DataErrorException;
import com.prokarma.testpoc.to.Item;
import com.prokarma.testpoc.util.Constants;
import com.prokarma.testpoc.util.POCUtil;

import static org.junit.Assert.*;

import java.util.*;

/**
 * @author skalesha This class is used to test {@link InventoryDaoImpl} class
 */
public class InventoryDAOImplTest {

	private Item item;
	private final String itemXML = "<item><item_count>10</item_count><item_desc>testing12345</item_desc><item_last_updated_tmstmp>2015-01-30 18:42:02.0</item_last_updated_tmstmp><item_name>Abc</item_name> </item>";
	private InventoryDaoImpl daoImpl;

	/**
	 * This method is used to instantiate item Object
	 * 
	 * @throws DataErrorException
	 * */
	@Before
	public void setUp() throws DataErrorException {
		item = new Item();
		daoImpl = (InventoryDaoImpl) POCUtil
				.getApplicationContext(Constants.INVEN_DAOIMPL_BEAN_ID);
		item.setItem_name("ABC");
		item.setItem_desc("some description for this item.");
		item.setItem_count(10);
	}

	/**
	 * This method is used to making item reference to null after finishing test
	 * case execution
	 * */
	@After
	public void tearDown() {
		item = null;
		daoImpl = null;
	}

	/**
	 * This method will insert a new item in to the data base
	 * */
	@Test
	public void insert() throws DataErrorException {
		daoImpl.deleteItem(item);
		ArrayList<Item> items = daoImpl.insertItem(item);
		assertTrue("inserting item into db", items.size() > 0);
	}

	/**
	 * This method is used to test the Item updating in to the db
	 */
	@Test
	public void updateItem() throws DataErrorException {
		item.setItem_desc("Updated item count to 50 in updateItem method");
		item.setItem_count(50);
		ArrayList<Item> items = daoImpl.updateItem(item);
		assertTrue("updating item", items.size() > 0);
	}

	/**
	 * This method is used to test inserting error log details in to database
	 */
	@Test
	public void logXMLString() {
		item.setItem_desc("Updated item count to 50 in updateItem method");
		item.setItem_count(50);
		assertTrue(daoImpl.logItems(itemXML));
	}

	/**
	 * This method is used to test getAllItems() method in InventoryDaoImpl
	 * class
	 */
	@Test
	public void getAllItems() throws DataErrorException {
		assertTrue(daoImpl.getAllItems().size() > 0);
	}

}