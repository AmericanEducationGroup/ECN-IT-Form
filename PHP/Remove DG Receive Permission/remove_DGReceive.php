<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removeDGReceiveDG = $_POST["removeDGReceiveDG"];
	$result = $db->query("DELETE FROM receive_dg WHERE receiveDGID = '" . $removeDGReceiveDG . "';");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
