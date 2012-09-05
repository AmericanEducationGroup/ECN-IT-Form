<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$latestOwnersDirectory = $_POST["latestOwnersDirectory"];
	$latestOwnersPosition = $_POST["latestOwnersPosition"];
	$result = $db->query("INSERT INTO directory_owner (directory, owner_position) VALUES ('" . $latestOwnersDirectory . "', '" . $latestOwnersPosition . "');");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
