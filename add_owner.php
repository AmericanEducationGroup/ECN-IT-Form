<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$latestOwnersDirectory = $_POST["latestOwnersDirectory"];
	$latestOwnersPosition = $_POST["latestOwnersPosition"];
	$db->query("call insert_directory_owner('" . $latestOwnersDirectory . "', '" . $latestOwnersPosition . "')");
	$db->close();

	header('Location: administration.php');
?>
