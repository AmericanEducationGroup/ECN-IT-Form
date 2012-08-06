<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$addedOwnersDivision = $_REQUEST["addedOwnersDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $addedOwnersDivision . "'");
?>

	What is the new owner's school or department?
<select onchange='addOwnerPositionDD(this.value);' name='addedOwnersSchoolDepartment' id='addedOwnersSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
