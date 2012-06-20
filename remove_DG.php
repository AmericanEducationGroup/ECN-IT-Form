<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedDG = $_POST["removedDG"];
	$db->query("call remove_distribution_groups('" . $removedDG . "')");
	$db->close();

	header('Location: administration.php');
?>
