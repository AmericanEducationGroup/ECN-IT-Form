<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newDepartment = $_POST["newDepartment"];
	$db->query("call insert_department('" .$newDepartment . "', 1)");
	$db->close();

	header( 'Location: administration.php' ) ;
?>
