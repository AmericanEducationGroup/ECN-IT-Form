<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedDGSendSchoolDepartment = $_POST["removedDGSendSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $removedDGSendSchoolDepartment . "'");
?>

	What is the position losing DG Send permissions?
	<select onchange='removeDGSendDGDD(this.value)' name='removeDGSendPosition' id='removeDGSendPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
