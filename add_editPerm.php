<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newEditPermPosition = $_POST["newEditPermPosition"];
	$newEditPermDirectory = $_POST["newEditPermDirectory"];
	$result = $db->query("call insert_edit_permissions(" . $newEditPermPosition . ", " . $newEditPermDirectory . ")");
	$db->close();

	if($result)
		header( 'Location: success.html' ) ;
	else
		header( 'Location: failure.html') ;
?>
