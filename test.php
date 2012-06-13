<?php

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	
	$test2 = "test";
	//$db->query("call insert_source_directories('" . $test2 . "', 1)");
	//$db->query("call insert_send_to_dg(1,1)");
	$res = $db->query("call viewSchools_Departments_Names_By_Division(2)");
	$rows = $res->fetch_all(MYSQLI_NUM);
	echo nl2br(str_replace(' ', ' ', print_r($rows, true)));
/* 


*/
	$db->close();
?>
