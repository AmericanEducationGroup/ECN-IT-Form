<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removeReadPermsDivision = $_POST["removeReadPermsDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $removeReadPermsDivision . "'");
?>

	What is the school or department of the position losing read permissions?
<select onchange='removeReadPermPositionDD(this.value);' name='removedReadPermsSchoolDepartment' id='removedReadPermsSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
