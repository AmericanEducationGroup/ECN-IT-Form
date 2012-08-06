<?php

	require "../dbConnect.php";

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
	$result = $db->query("INSERT INTO Schools_Departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ('" .$newSchool . "','" . $newSchoolAbbreviation . "','" . $newSchoolDivision . "', '" . $newSchoolEmailDomain . "', '1234');");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
