<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
?>
	What directory does the new owner own?

<?php
	$result = $db->query("SELECT name, sourceDirectoryID FROM source_directories WHERE (parent = 1 AND name <> 'American Education Group')");

	if($result->num_rows > 0)
	{
		echo "<select onchange='addOwnerDirectoryDDFunction(this.value, this);' name='addOwnerParentDirectoryDD' id='addOwnerParentDirectoryDD'>";
		echo "<option disabled selected style='display:none;'>Choose a directory.</option>";
		while ($row = $result->fetch_assoc())
		{
				echo "<option value=" . $row['sourceDirectoryID'] . ">" . $row['name'] . "</option>\n";
		}
	}
	$db->close();
?>

</select>
	<input type="submit" id="addOwnerSubmit"/>
