<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$addedOwnersSchoolDepartment = $_REQUEST["addedOwnersSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $addedOwnersSchoolDepartment . "'");
?>

	What is the new owner's position?
	<select onchange='addOwnerParentDirectoryDDFunction(this)' name='addedOwnersPosition' id='addedOwnersPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
