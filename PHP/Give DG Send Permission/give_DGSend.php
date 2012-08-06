<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$giveSendDG = $_POST["giveSendDG"];
	$giveDGSendPosition = $_POST["giveDGSendPosition"];
	$result = $db->query("call insert_send_to_dg('" . $giveSendDG . "', '" . $giveDGSendPosition . "')");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
