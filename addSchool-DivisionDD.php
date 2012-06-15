<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("SELECT name FROM divisions");

	echo "<select name=\"newSchoolDivision\" id=\"newSchoolDivision\">\n"; ?>

<option disabled selected style='display:none;'>Choose a division.</option> 
<?php
	$i = 1;
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $i . ">" . $row['name'] . "</option>\n";
			$i++;
	}

	echo "</select>";
	$db->close();

?>
