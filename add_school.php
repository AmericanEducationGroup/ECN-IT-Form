<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$newSchool = $_POST["newSchool"];
	$newSchoolAbbreviation = $_POST["newSchoolAbbreviation"];
	$newSchoolDivision = $_POST["newSchoolDivision"];
	$newSchoolEmailDomain = $_POST["newSchoolEmailDomain"];
	echo $newSchool . " " . $newSchoolAbbreviation . " " . $newSchoolDivision . " " . $newSchoolEmailDomain;
	$result = $db->query("call insert_school('" . $newSchool . "','" . $newSchoolAbbreviation  . "','" . $newSchoolDivision . "', '" . $newSchoolEmailDomain . "')");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
