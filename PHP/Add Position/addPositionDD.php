<?php 

	
	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$addedPositionsDivision = $_REQUEST["addedPositionsDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division = '" . $addedPositionsDivision . "'");
?>

	Which school or department would you like to add a position to?
	<select name='addedPositionsSchoolDepartment' id='addedPositionsSchoolDepartment'>
		<option disabled selected style='display:none;'>Choose a school/department.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
			}
			$db->close();
		?>
	</select>

	<input type="submit" />
