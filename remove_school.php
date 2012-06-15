<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedSchool = $_POST["removedSchool"];
	$db->query("DELETE FROM schools WHERE name = '" . $removedSchool . "'");
	$db->close();

	header( 'Location: administration.php' ) ;
?>
