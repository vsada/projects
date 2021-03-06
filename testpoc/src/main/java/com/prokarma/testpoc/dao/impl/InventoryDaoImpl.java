package com.prokarma.testpoc.dao.impl;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.prokarma.testpoc.dao.InventoryDAOI;
import com.prokarma.testpoc.exceptions.DataErrorException;
import com.prokarma.testpoc.to.Item;
import com.prokarma.testpoc.util.Constants;

public class InventoryDaoImpl implements InventoryDAOI {
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public ArrayList<Item> insertItem(Item item) throws DataErrorException {
		String sql = Constants.INSERT_ITME;
		try {
			if (!isItemExisted(item)) {
				int result = jdbcTemplate.update(sql, item.getItem_name(),
						item.getItem_desc(), item.getItem_count());
				if (result > 0)
					return getAllItems();
			} else {
				throw new DataErrorException(Constants.ITEM_EXISTED_ERROR);
			}
		} catch (Exception e) {
			throw new DataErrorException(e.getMessage());
		}
		return null;
	}

	@Override
	public ArrayList<Item> updateItem(Item item) throws DataErrorException {
		try {
			String sql = Constants.ITEM_UPDATE;
			int result = jdbcTemplate.update(sql, item.getItem_desc(),
					item.getItem_count(),
					new Timestamp(System.currentTimeMillis()),
					item.getItem_name());
			if (result > 0)
				return getAllItems();
			else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new DataErrorException(e.getMessage());
		}
	}

	@Override
	public ArrayList<Item> getAllItems() throws DataErrorException {
		ArrayList<Item> items = new ArrayList<Item>();
		try {
			SqlRowSet rowSet = jdbcTemplate
					.queryForRowSet(Constants.SELECT_ITMES);
			if (rowSet.first())
				while (rowSet.isAfterLast() == false) {
					Item item_fetched = new Item();
					item_fetched.setItem_name(rowSet
							.getString(Constants.ITEM_NAME));
					item_fetched.setItem_count(rowSet
							.getInt(Constants.ITEM_COUNT));
					item_fetched.setItem_desc(rowSet
							.getString(Constants.ITEM_DESC));
					item_fetched.setItem_last_updated_tmstmp(rowSet
							.getTimestamp(Constants.ITEM_LAST_UDATED_TIME)
							.toString());
					items.add(item_fetched);
					rowSet.next();
				}
		} catch (Exception e) {
			throw new DataErrorException(e.getMessage());
		}
		return items;
	}

	@Override
	public boolean logItems(String log) {
		String sql = Constants.INSERT_INVALID_REQ;
		int result = jdbcTemplate.update(sql, log);
		return result > 0;
	}

	@Override
	public boolean isItemExisted(Item item) {
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(Constants.CHECK_ITEM,
				item.getItem_name());
		return rowSet.first();
	}

	@Override
	public boolean deleteItem(Item item) throws DataErrorException {
		try {
			int result = jdbcTemplate.update(
					"delete from item_stock where item_name=?",
					item.getItem_name());
			return result > 0;
		} catch (Exception e) {
			throw new DataErrorException(e.getMessage() + "");
		}
	}
}
