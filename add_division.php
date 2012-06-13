<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newDivisionName = $_POST["newDivision"];
	$db->query("call insert_divisions('" . $newDivisionName . "')");
	$db->close();

	header( 'Location: administration.html' ) ;
?>
