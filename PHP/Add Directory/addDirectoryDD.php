<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	$parent = $_REQUEST["parent"];
	$result = $db->query("SELECT name, sourceDirectoryID FROM source_directories WHERE parent = '" . $parent . "'");

	if($result->num_rows > 0)
	{
		echo "<select onchange='addDirectoryDDFunction(this.value, this);' name='addDirectoryDD' id='addDirectoryDD'>";
		echo "<option disabled selected style='display:none;'>(parent directory)</option>";
		while ($row = $result->fetch_assoc())
		{
				echo "<option value=" . $row['sourceDirectoryID'] . ">" . $row['name'] . "</option>\n";
		}
	}
?>

</select>
					<input type="submit" id="addDirectorySubmit"/><br>
