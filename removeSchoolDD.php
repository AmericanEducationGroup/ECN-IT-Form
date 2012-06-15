<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("SELECT name FROM schools");

	echo "<select name=\"removedDivision\" id=\"removedDivision\">\n"; ?>
	
<option disabled selected style='display:none;'>Choose a division.</option> 
<?php

	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['name'] . ">" . $row['name'] . "</option>\n";
	}

	echo "</select>";
	$db->close();

?>
