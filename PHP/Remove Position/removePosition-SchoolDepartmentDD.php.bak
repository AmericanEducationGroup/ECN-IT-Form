<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$removedPositionsDivision = $_REQUEST["removedPositionsDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $removedPositionsDivision . "'");
?>

	Which school or department would you like to remove a position from?
<select onchange='removePositionDD(this.value);' name='removedPositionsSchoolDepartment' id='removedPositionsSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
