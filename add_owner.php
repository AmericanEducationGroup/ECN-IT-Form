<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$latestOwnersDirectory = $_POST["latestOwnersDirectory"];
	$latestOwnersPosition = $_POST["latestOwnersPosition"];
	$result = $db->query("call insert_directory_owner('" . $latestOwnersDirectory . "', '" . $latestOwnersPosition . "')");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
