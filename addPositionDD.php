<?php 

	
	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedSchoolsDivision = $_REQUEST["removedSchoolsDivision"];
	$result = $db->query("SELECT name FROM schools_departments WHERE division = '" . $removedSchoolsDivision . "'");
?>

	Which school or department would you like to remove?
	<select name='removedSchool' id='removedSchool'>
		<option disabled selected style='display:none;'>Choose a school/department.</option>

		<?php

			while ($row = $result->fetch_assoc())
			{
					echo "<option value=" . $row['name'] . ">" . $row['name'] . "</option>\n";
			}
			$db->close(); 
		?>
	</select>

	<input type="submit" />
