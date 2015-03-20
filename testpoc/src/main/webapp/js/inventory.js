/**
 * This JS file is used to load data from Inventory Service
 */
(function() {
	var app = angular.module("inventory", []);
	/**
	 * This listItemsController is used to fetch items from service using rest
	 * call.
	 */
	app
			.controller(
					'listItemsController',
					[
							'$http',
							function($http) {
								var inventory = this;
								inventory.list = [];
								$http
										.post(
												'http://localhost:8085/rest/item/getAllItems')
										.success(
												function(data, status, headers,
														config) {
													inventory.list = xmlToItems(data);
												})
										.error(
												function(data, status, headers,
														config) {
													alert("Sorry, Unable to fetch items list, Please try after some time.");
												});
								inventory.populate = function(item) {
									var item_name = document
											.getElementById("itemName").value = item.item_name;
									var item_count = document
											.getElementById("itemCount").value = item.item_count;
									var item_description = document
											.getElementById("itemDesc").value = item.item_desc;
									var submit = document
											.getElementById("submit").value = 'Update';

								};
								inventory.submitForm = function() {
									alert("Hi");
								}
							} ]);

	/**
	 * This controller is used to add or update and item.
	 */
	app
			.controller(
					'SubmitFormController',
					[
							'$http',
							function($http) {
								submitCtrl = this;
								submitCtrl.submitForm = function() {
									var item = new Object();
									item.item_desc = document
											.getElementById("itemDesc").value;
									item.item_count = document
											.getElementById("itemCount").value;
									item.item_name = document
											.getElementById("itemName").value;
									var url = 'http://localhost:8085/rest/item/updateItem';
									var status = document
											.getElementById("submit").value;
									if (status == 'ADD') {
										url = 'http://localhost:8085/rest/item/addItem';
									} else {
										url = 'http://localhost:8085/rest/item/updateItem';
									}
									var xmlText = jsonToXML(item);
									$http
											.post(url, xmlText)
											.success(
													function(data, status,
															headers, config) {
														alert(data);
														// inventory.list =
														// xmlToItems(data);
													})
											.error(
													function(data, status,
															headers, config) {
														alert("Sorry, Unable to save this details please try again later.");
													});
								};
								submitCtrl.resetForm = function() {
									var item_name = document
											.getElementById("itemName").value = "";
									var item_count = document
											.getElementById("itemCount").value = '';
									var item_description = document
											.getElementById("itemDesc").value = "";
									var submit = document
											.getElementById("submit").value = 'ADD';
								}

							} ]);

	/**
	 * This function is used to covert items list XML text to items JSON object.
	 * 
	 * @returns items JSON Array
	 */
	function xmlToItems(data) {
		if (window.DOMParser) {
			parser = new DOMParser();
			xmlDoc = parser.parseFromString(data, "text/xml");
		} else // Internet Explorer
		{
			xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async = false;
			xmlDoc.loadXML(txt);
		}
		var items = xmlDoc.getElementsByTagName('item');
		var itemsArray = [];
		for (i = 0; i < items.length; i++) {
			var item = {
				item_name : '',
				item_count : '',
				item_desc : '',
				item_last_updated_tmstmp : ''
			};
			item.item_name = items[i].getElementsByTagName("item_name")[0].childNodes[0].nodeValue;
			item.item_count = items[i].getElementsByTagName("item_count")[0].childNodes[0].nodeValue;
			item.item_desc = items[i].getElementsByTagName("item_desc")[0].childNodes[0].nodeValue;
			item.item_last_updated_tmstmp = items[i]
					.getElementsByTagName("item_last_updated_tmstmp")[0].childNodes[0].nodeValue;
			itemsArray.push(item);
		}
		return itemsArray;
	}
	/**
	 * This method is used to convert item JSon object to XLM text.
	 * @param item in JSON format.
	 * @returns itemXML;
	 */
	function jsonToXML(item) {
		var xmlText = '<item><item_count>' + item.item_count
				+ '</item_count><item_desc>' + item.item_desc
				+ '</item_desc><item_last_updated_tmstmp>' + new Date()
				+ '</item_last_updated_tmstmp><item_name>' + item.item_name
				+ '</item_name></item>';
		return xmlText;
	}
})();
