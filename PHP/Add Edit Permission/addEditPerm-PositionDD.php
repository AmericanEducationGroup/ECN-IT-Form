<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$addedEditPermsSchoolDepartment = $_REQUEST["addedEditPermsSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $addedEditPermsSchoolDepartment . "'");
?>

	What position has a new edit permission?
	<select onchange='addEditPermParentDirectoryDDFunction(this)' name='addedEditPermsPosition' id='addedEditPermsPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
