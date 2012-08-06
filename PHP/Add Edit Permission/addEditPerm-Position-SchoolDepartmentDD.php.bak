<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$addedEditPermsDivision = $_REQUEST["addedEditPermsDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $addedEditPermsDivision . "'");
?>

	What school or department is the position with new edit permissions in?
<select onchange='addEditPermPositionDD(this.value);' name='addEditPermSchoolDepartment' id='addEditPermSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
