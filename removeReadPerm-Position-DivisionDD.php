<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("SELECT name, divisionID FROM divisions");
?>

<select onchange='removeReadPermSchoolDepartmentDD(this.value);' name='removedReadPermsDivision' id='removedReadPermsDivision'>
	<option disabled selected style='display:none;'>Choose a division.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['divisionID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select>
