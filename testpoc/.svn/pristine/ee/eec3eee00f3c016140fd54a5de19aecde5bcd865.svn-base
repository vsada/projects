package com.prokarma.testpoc.ws;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.prokarma.testpoc.dao.impl.InventoryDaoImpl;
import com.prokarma.testpoc.exceptions.DataErrorException;
import com.prokarma.testpoc.to.Item;
import com.prokarma.testpoc.util.Constants;
import com.prokarma.testpoc.util.POCUtil;

/**
 * This class is a web service class. This class will receive request from
 * Jersey webservice and executes the corresponding method
 * 
 * @author skalesha
 */
@Path("/item")
public class ItemWebService {
	@GET
	@Path("/")
	String wecomeMethod() {
		System.out.println("welcome to ");
		return "welcome to response body";
	}

	/**
	 * This method is used to add a new items in the db sample date
	 * ---------------------------------------------------------------------
	 * &lt item &gt &lt item_count &gt 10&lt/item_count &gt &lt item_desc &gt
	 * welcome to item&lt/item_desc &gt &lt item_name &gt Pen&lt/item_name &gt
	 * &lt last_updated_time &gt 10-01-2015 18:15:20&lt/last_updated_time&gt
	 * &lt/item &gt
	 * 
	 */
	@Produces(MediaType.APPLICATION_XML)
	@Path("/addItem")
	@POST
	public Response addItem(String itemStr) {
		Response response = null;
		Item item = POCUtil.parseXMLString(itemStr);
		try {
			if (POCUtil.validateNewItem(item)) {
				ArrayList items;
				items = ((InventoryDaoImpl) POCUtil
						.getApplicationContext(Constants.INVEN_DAOIMPL_BEAN_ID))
						.insertItem(item);
				response = Response.status(200)
						.entity(new GenericEntity<ArrayList<Item>>(items) {
						}).build();
			} else {
				((InventoryDaoImpl) POCUtil
						.getApplicationContext(Constants.INVEN_DAOIMPL_BEAN_ID))
						.logItems(itemStr);
				response = Response.status(400).entity(Constants.INVALID_REQ)
						.build();
			}
		} catch (DataErrorException e) {
			response = Response.status(400).entity(e.getMessage()).build();
		}
		return response;

	}

	/** This method is used to update an item in the db */
	@Produces(MediaType.APPLICATION_XML)
	@Path("/updateItem")
	@POST
	public Response upateItem(String str) {
		Response response = null;
		Item item = POCUtil.parseXMLString(str);
		try {
			if (POCUtil.validateUpdateItem(item)) {
				ArrayList<Item> items = ((InventoryDaoImpl) POCUtil
						.getApplicationContext(Constants.INVEN_DAOIMPL_BEAN_ID))
						.updateItem(item);
				response = Response.status(200)
						.entity(new GenericEntity<ArrayList<Item>>(items) {
						}).build();
			} else {
				response = Response.status(400).entity(Constants.INVALID_REQ)
						.build();
			}
		} catch (DataErrorException e) {
			response = Response.status(400).entity(e.getMessage()).build();
		}
		return response;
	}

	/** This method is used to get list of all items form the db */
	@Produces(MediaType.APPLICATION_XML)
	@Path("/getAllItems")
	@POST
	public Response getAllItems() {
		Response response = null;
		try {
			ArrayList<Item> items = ((InventoryDaoImpl) POCUtil
					.getApplicationContext(Constants.INVEN_DAOIMPL_BEAN_ID))
					.getAllItems();
			response = Response.status(200)
					.entity(new GenericEntity<ArrayList<Item>>(items) {
					}).build();
		} catch (DataErrorException e) {
			response = Response.status(400).entity(e.getMessage()).build();
		}
		return response;
	}
}
