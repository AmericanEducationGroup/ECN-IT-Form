<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedDivision = $_POST["removedDivision"];
	$db->query("DELETE FROM divisions WHERE name = '" . $removedDivision . "'");
	$db->close();

	header( 'Location: administration.php' ) ;
?>
