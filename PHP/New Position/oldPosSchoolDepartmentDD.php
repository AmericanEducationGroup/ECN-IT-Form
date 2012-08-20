<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$oldPosDivision = $_REQUEST["oldPosDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $oldPosDivision . "'");
?>

	What is the school or department?
<select onchange='oldPosPositionDD(this.value);' name='oldPosSchoolDepartment' id='oldPosSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
