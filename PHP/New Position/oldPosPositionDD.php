<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$oldPosSchoolDepartment = $_REQUEST["oldPosSchoolDepartment"];
	$result = $db->query("SELECT positionID, title FROM positions WHERE school_department = '" . $oldPosSchoolDepartment . "'");
?>

	What is the employee's old position?
	<select name='oldPosPosition' id='oldPosPosition'>
		<option disabled selected style='display:none;'>Choose a position.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['positionID'] . ">" . $row['title'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>

					
					<h3>New Position Details</h3>
					What division is the new position in?									<?php require '../New Position/newPosDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newPosDivisionHolder" name="newPosDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newPosSchoolDepHolder" name="newPosSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newPosPositionHolder" name="newPosPositionHolder" style="display: none;"/>
