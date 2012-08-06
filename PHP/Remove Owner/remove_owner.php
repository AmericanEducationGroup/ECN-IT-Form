<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedDirectoryOwnerID = $_POST["removedOwnersDirectory"];
	echo $removedOwnersPosition . " " . $removedOwnersDirectory;
	$result = $db->query("call remove_directory_owner(" . $removedDirectoryOwnerID . ")");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
