<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedDGReceiveSchoolDepartment = $_POST["removedDGReceiveSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $removedDGReceiveSchoolDepartment . "'");
?>

	What is the position losing DG Receive permissions?
	<select onchange='removeDGReceiveDGDD(this.value)' name='removeDGReceivePosition' id='removeDGReceivePosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
