<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$addedReadPermsSchoolDepartment = $_REQUEST["addedReadPermsSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $addedReadPermsSchoolDepartment . "'");
?>

	What position has a new read permission?
	<select onchange='addReadPermParentDirectoryDDFunction(this)' name='addedReadPermsPosition' id='addedReadPermsPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
