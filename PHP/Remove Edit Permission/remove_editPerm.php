<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedEditPermsID = $_POST["removedEditPermsID"];
	$result = $db->query("DELETE FROM edit_permissions WHERE editPermissionID = '" . $removedEditPermsID . "';");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
