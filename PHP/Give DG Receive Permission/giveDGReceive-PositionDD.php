<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$givenDGReceiveSchoolDepartment = $_POST["givenDGReceiveSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $givenDGReceiveSchoolDepartment . "'");
?>

	What is the position getting DG Receive permissions?
	<select name='giveDGReceivePosition' id='giveDGReceivePosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
<input type="submit" />
