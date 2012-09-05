<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newDepartment = $_POST["newSchool"];
	$result = $db->query('INSERT INTO Schools_Departments (name, division, emailDomain, phoneNumber) VALUES ('" .$newDepartment . "', 1, "americanedgroup.com", "616-301-1221");');
	$db->close();

	if($result)
		//header( 'Location: ../../HTML/success.html' ) ;
	//else
		//header( 'Location: ../../HTML/failure.html') ;
?>
