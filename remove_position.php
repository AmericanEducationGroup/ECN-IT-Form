<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$removedPosition = $_POST["removedPosition"];
	$addedPositionsDivision = $_REQUEST["addedPositionsDivision"];
	$addedPositionsSchoolDepartment = $_REQUEST["addedPositionsSchoolDepartment"];
	echo $newPosition . " " . $addedPositionsDivision . " " . $addedPositionsSchoolDepartment;
	$db->query("call insert_positions('" . $newPosition . "', '" . $addedPositionsDivision . "', '" . $addedPositionsSchoolDepartment . "')");
	$db->close();

	header('Location: administration.php');
?>
