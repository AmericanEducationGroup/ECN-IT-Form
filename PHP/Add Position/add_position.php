<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newPosition = $_POST["newPosition"];
	$addedPositionsDivision = $_REQUEST["addedPositionsDivision"];
	$addedPositionsSchoolDepartment = $_REQUEST["addedPositionsSchoolDepartment"];
	$result = $db->query("INSERT INTO positions (title, division, school_department) VALUES ('" . $newPosition . "', '" . $addedPositionsDivision . "', '" . $addedPositionsSchoolDepartment . "');");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
