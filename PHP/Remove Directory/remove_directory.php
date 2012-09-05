<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$latestDirectory = $_POST["latestRemovedDirectory"];
	$result = $db->query("DELETE FROM source_directories WHERE sourceDirectoryID = '" . $latestDirectory . "';");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
