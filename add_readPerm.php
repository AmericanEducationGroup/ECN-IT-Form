<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newReadPermPosition = $_POST["newReadPermPosition"];
	$newReadPermDirectory = $_POST["newReadPermDirectory"];
	echo $newReadPermPosition . " " . $newReadPermDirectory;
	$result = $db->query("call insert_read_permissions(" . $newReadPermPosition . ", " . $newReadPermDirectory . ")");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
