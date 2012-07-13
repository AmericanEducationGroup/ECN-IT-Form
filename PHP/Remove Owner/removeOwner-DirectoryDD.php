<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedOwnersPosition = $_POST["removedOwnersPosition"];
	$result = $db->query("SELECT directoryOwnerID, directory FROM directory_owner WHERE owner_position = '" . $removedOwnersPosition . "'");

	if($result->num_rows > 0)
	{
		echo "Which directory would you like to remove ownership from?";
		echo "<select name='removedOwnersDirectory' id='removedOwnersDirectory'>";
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
				echo "<option value=" . $row['directoryOwnerID'] . ">" . $directory_path . "</option>\n";
		}
		$db->close();
		echo "</select><br>";
	}
?>
<input type="submit" />
