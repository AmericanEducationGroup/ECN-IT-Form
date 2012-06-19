<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newDirectory = $_POST["newDirectory"];
	$latestDirectory = $_POST["latestAddedDirectory"];
	$db->query("call insert_source_directories('" . $newDirectory . "', " . $latestDirectory . ")");
	$db->close();

	header('Location: administration.php');
?>
