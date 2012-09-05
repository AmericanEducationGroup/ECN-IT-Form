<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$giveReceiveDG = $_POST["giveReceiveDG"];
	$giveDGReceivePosition = $_POST["giveDGReceivePosition"];
	$result = $db->query("INSERT INTO receive_dg (distributionGroup, position) VALUES ('" . $giveReceiveDG . "', '" . $giveDGReceivePosition . "');");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
