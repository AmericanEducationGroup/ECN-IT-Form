<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newDirectory = $_POST["newDirectory"];
	$latestDirectory = $_POST["latestAddedDirectory"];
	$result = $db->query("call insert_source_directories('" . $newDirectory . "', " . $latestDirectory . ")");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
