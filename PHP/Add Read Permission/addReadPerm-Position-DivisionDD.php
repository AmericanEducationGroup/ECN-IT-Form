<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("SELECT name, divisionID FROM divisions");
?>

<select onchange='addReadPermSchoolDepartmentDD(this.value);' name='addedReadPermDivision' id='addedReadPermDivision'>
	<option disabled selected style='display:none;'>Choose a division.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['divisionID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select>
