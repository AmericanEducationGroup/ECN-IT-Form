<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedDGSendPosition = $_POST["removedDGSendPosition"];
	$result = $db->query("SELECT sendToDGID, distributionGroup FROM send_to_dg WHERE position = '" . $removedDGSendPosition . "'");
?>

	Which DG is restricting Send permissions?
	<select  name='removeDGSendDG' id='removeDGSendDG'>
		<option disabled selected style='display:none;'>Choose a DG.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
				$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID='" . $row['distributionGroup'] . "'");
				$row2 = $result2->fetch_assoc();
				echo "<option value=" . $row['sendToDGID'] . ">" . $row2['dgName'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
<input type="submit" />
