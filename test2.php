<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newSchool = "Test";
	$newSchoolAbbreviation = "TES";
	$newSchoolDivision = 1;

	$db->query("call insert_school('" . $newSchool . "','" . $newSchoolAbbreviation  . "','" .$newSchoolDivision . "')");

	$db->close();

?>
