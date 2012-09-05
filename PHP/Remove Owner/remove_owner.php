<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedDirectoryOwnerID = $_POST["removedOwnersDirectory"];
	$result = $db->query("DELETE FROM directory_owner WHERE directoryOwnerID = '" . $removedDirectoryOwnerID . "';");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
