<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$newEditPermPosition = $_POST["newEditPermPosition"];
	$newEditPermDirectory = $_POST["newEditPermDirectory"];
	echo $newEditPermPosition . " " . $newEditPermDirectory;
	$db->query("call insert_edit_permissions(" . $newEditPermPosition . ", " . $newEditPermDirectory . ")");
	$db->close();

	header('Location: administration.php');
?>
