<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$givenDGReceiveDivision = $_POST["givenDGReceiveDivision"];
	$result = $db->query("SELECT name, schoolDepartmentID FROM schools_departments WHERE division ='" . $givenDGReceiveDivision . "'");
?>

	What is the school or department of the position getting DG Receive permissions?
<select onchange='giveDGReceivePositionDD(this.value);' name='giveDGReceiveSchoolDepartment' id='giveDGReceiveSchoolDepartment'>
	<option disabled selected style='display:none;'>Choose a school/department.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
			echo "<option value=" . $row['schoolDepartmentID'] . ">" . $row['name'] . "</option>\n";
	}

	$db->close();
?>

</select><br>
