<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedSchoolDepartmentID = $_POST["removedSchoolDepartmentID"];
	$result = $db->query("DELETE FROM schools_departments WHERE schoolDepartmentID = '" . $removedSchoolDepartmentID . "'");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
