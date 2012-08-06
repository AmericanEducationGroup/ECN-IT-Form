<?php 

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$removedDGReceivePosition = $_POST["removedDGReceivePosition"];
	$result = $db->query("SELECT receiveDGID, distributionGroup FROM receive_dg WHERE position = '" . $removedDGReceivePosition . "'");
?>

	Which DG is restricting Receive permissions?
	<select  name='removeDGReceiveDG' id='removeDGReceiveDG'>
		<option disabled selected style='display:none;'>Choose a DG.</option>

		<?php
			while ($row = $result->fetch_assoc())
			{
				$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID='" . $row['distributionGroup'] . "'");
				$row2 = $result2->fetch_assoc();
				echo "<option value=" . $row['receiveDGID'] . ">" . $row2['dgName'] . "</option>\n";
			}
			$db->close();
		?>
	</select><br>
<input type="submit" />
