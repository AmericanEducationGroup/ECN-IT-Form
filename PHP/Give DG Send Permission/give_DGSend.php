<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$giveSendDG = $_POST["giveSendDG"];
	$giveDGSendPosition = $_POST["giveDGSendPosition"];
	$result = $db->query("INSERT INTO send_to_dg (distributionGroup, position) VALUES ('" . $giveSendDG . "', '" . $giveDGSendPosition . "');");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
