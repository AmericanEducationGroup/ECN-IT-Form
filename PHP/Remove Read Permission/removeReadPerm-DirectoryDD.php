<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedReadPermsPosition = $_POST["removedReadPermsPosition"];
	$result = $db->query("SELECT readPermissionID, directory FROM read_permissions WHERE position = '" . $removedReadPermsPosition . "'");

	if($result->num_rows > 0)
	{
		echo "Which directory would you like to remove read permissions from?";
		echo "<select name='removedReadPermsID' id='removedReadPermsID'>";
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
				echo "<option value=" . $row['readPermissionID'] . ">" . $directory_path . "</option>\n";
		}
		$db->close();
		echo "</select><br>";
	}
?>
<input type="submit" />
