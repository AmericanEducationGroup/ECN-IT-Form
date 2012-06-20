<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedEditPermSchoolDepartment = $_POST["removedEditPermSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $removedEditPermSchoolDepartment . "'");
?>

	What is the position losing edit permissions?
	<select onchange='removeEditPermDirectoryDDFunction(this);' name='removedEditPermsPosition' id='removedEditPermsPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
