<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removeDGSendDG = $_POST["removeDGSendDG"];
	$db->query("call remove_send_to_dg('" . $removeDGSendDG . "')");
	$db->close();

	header('Location: administration.php');
?>
