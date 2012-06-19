<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$removedPosition = $_POST["removedPosition"];
	$db->query("call remove_positions('" . $removedPosition . "')");
	$db->close();

	header('Location: administration.php');
?>
