<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removeDGReceiveDG = $_POST["removeDGReceiveDG"];
	$db->query("call remove_receive_dg('" . $removeDGReceiveDG . "')");
	$db->close();

	header('Location: administration.php');
?>