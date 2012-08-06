<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedReadPermSchoolDepartment = $_POST["removedReadPermSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $removedReadPermSchoolDepartment . "'");
?>

	What is the position losing read permissions?
	<select onchange='removeReadPermDirectoryDDFunction(this);' name='removedReadPermsPosition' id='removedReadPermsPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
