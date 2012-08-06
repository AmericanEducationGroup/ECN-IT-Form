<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedEditPermsPosition = $_POST["removedEditPermsPosition"];
	$result = $db->query("SELECT editPermissionID, directory FROM edit_permissions WHERE position = '" . $removedEditPermsPosition . "'");

	if($result->num_rows > 0)
	{
		echo "Which directory would you like to remove edit permissions from?";
		echo "<select name='removedEditPermsID' id='removedEditPermsID'>";
		echo "<option disabled selected style='display:none;'>Choose a directory.</option>";
		while ($row = $result->fetch_assoc())
		{
			$i = $row['directory'];
			$directory_path = "";
			while($i != 1)
			{
				$directory_result = $db->query("SELECT name, parent FROM source_directories WHERE sourceDirectoryID = '" . $i . "'");
				$directory_row = $directory_result->fetch_assoc();
				$directory_path = $directory_row['name'] . "/" . $directory_path;
				$i = $directory_row['parent'];
			}
			$directory_path = "/American Education Group/" . $directory_path;
				echo "<option value=" . $row['editPermissionID'] . ">" . $directory_path . "</option>\n";
		}
		$db->close();
		echo "</select><br>";
	}
?>
<input type="submit" />
