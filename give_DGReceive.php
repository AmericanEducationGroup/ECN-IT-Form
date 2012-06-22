<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$giveReceiveDG = $_POST["giveReceiveDG"];
	$giveDGReceivePosition = $_POST["giveDGReceivePosition"];
	$result = $db->query("call insert_receive_dg('" . $giveReceiveDG . "', '" . $giveDGReceivePosition . "')");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
