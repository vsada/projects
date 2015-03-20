<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home - Inventory management System</title>
<style type="text/css">
h2, h3, tr th, .form-group {
	text-align: center;
	margin: auto;
}

#itemNameDiv {
	margin-top: 50px;
}
</style>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
<script src="./js/inventory.js"></script>
</head>
<body class='container' ng-app="inventory">
	<h1></h1>
	<div id='maindiv' class='row'>
		<div id='list_items_div' class='col-md-6'
			ng-controller='listItemsController as inventory'>
			<h3 class="text-muted">List of Items</h3>
			<div ng-show='inventory.list.length > 0 '>
				<input type="text" ng-model='searchText' class="form-control"
					placeholder="Search">
				<table border="1" class="table">
					<tr>
						<th>Item Name</th>
						<th>Item Count</th>
					</tr>
					<tr ng-repeat='item in inventory.list | filter:searchText'>
						<td><a href='' ng-click="inventory.populate(item)">{{item.item_name}}</a></td>
						<td>{{item.item_count}}</td>
					</tr>
				</table>
			</div>
		</div>
		<div id='add_items_div' class='col-md-6 container addItems'
			ng-controller='SubmitFormController as submitCtrl'>
			<h3 class="text-muted">Add Items</h3>
			<!-- <form action="" novalidate="novalidate"> -->
			<div class='form-group' id='itemNameDiv'>
				<label labelfor='itemName'>Item Name</label> <input type='text'
					id='itemName' required>
			</div>
			<div class='form-group'>
				<label labelfor='itemCount'>Item Count</label> <input type='text'
					id='itemCount' required>
			</div>
			<div class='form-group'>
				<label labelfor='itemDesc'>Item Descr </label>
				<textarea type='textarea' id='itemDesc' required></textarea>
			</div>
			<div class='form-group'>
				<input type="button" class="btn btn-success" value='ADD' id='submit'
					ng-click='submitCtrl.submitForm()'> <input type="button"
					class="btn btn-success" value='Reset' id='submit'
					ng-click='submitCtrl.resetForm()'>
			</div>
			<!-- </form> -->

		</div>
	</div>
</body>
</html>