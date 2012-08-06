<?php

	require "../dbConnect.php";

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
		header( 'Location: ../../HTML/success.html' ) ;
	else
		header( 'Location: ../../HTML/failure.html') ;
?>
