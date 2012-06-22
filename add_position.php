<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newPosition = $_POST["newPosition"];
	$addedPositionsDivision = $_REQUEST["addedPositionsDivision"];
	$addedPositionsSchoolDepartment = $_REQUEST["addedPositionsSchoolDepartment"];
	$result = $db->query("call insert_positions('" . $newPosition . "', '" . $addedPositionsDivision . "', '" . $addedPositionsSchoolDepartment . "')");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
