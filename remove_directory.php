<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$latestDirectory = $_POST["latestRemovedDirectory"];
	$result = $db->query("call remove_source_directories('" . $latestDirectory . "')");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
