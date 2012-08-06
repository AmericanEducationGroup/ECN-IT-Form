<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$addedReadPermsDivision = $_REQUEST["addedReadPermsDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $addedReadPermsDivision . "'");
?>

	What school or department is the position with new read permissions in?
<select onchange='addReadPermPositionDD(this.value);' name='addReadPermSchoolDepartment' id='addReadPermSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
