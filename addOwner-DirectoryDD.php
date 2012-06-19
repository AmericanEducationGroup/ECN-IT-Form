<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	$parent = $_REQUEST["parent"];
	$result = $db->query("SELECT name, sourceDirectoryID FROM source_directories WHERE parent = '" . $parent . "'");

	if($result->num_rows > 0)
	{
		echo "<select onchange='addOwnerDirectoryDDFunction(this.value, this);' name='addOwnerDirectoryDD' id='addOwnerDirectoryDD'>";
		echo "<option disabled selected style='display:none;'>(parent directory)</option>";
		while ($row = $result->fetch_assoc())
		{
				echo "<option value=" . $row['sourceDirectoryID'] . ">" . $row['name'] . "</option>\n";
		}
	}
?>

</select>
