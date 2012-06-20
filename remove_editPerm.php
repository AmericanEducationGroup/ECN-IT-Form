<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedEditPermsID = $_POST["removedEditPermsID"];
	$db->query("call remove_edit_permissions('" . $removedEditPermsID . "')");
	$db->close();

	header('Location: administration.php');
?>
