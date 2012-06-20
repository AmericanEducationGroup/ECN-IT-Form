<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedReadPermsID = $_POST["removedReadPermsID"];
	$db->query("call remove_read_permissions('" . $removedReadPermsID . "')");
	$db->close();

	header('Location: administration.php');
?>
