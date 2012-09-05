<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removeDGSendDG = $_POST["removeDGSendDG"];
	$result = $db->query("DELETE FROM send_to_dg WHERE sendToDGID = '" . $removeDGSendDG . "';");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
