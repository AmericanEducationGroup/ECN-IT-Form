<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newDG = $_POST["newDG"];
	$db->query("call insert_distribution_groups('" . $newDG . "')");
	$db->close();

	header('Location: administration.php');
?>
