<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedDG = $_POST["removedDG"];
	$result = $db->query("call remove_distribution_groups('" . $removedDG . "')");
	$db->close();

	if($result)
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
