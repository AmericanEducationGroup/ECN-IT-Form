<?php
	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("call viewAll_distribution_groups()");
?>

<select onchange='giveDGReceive-PositionDD(this)' name='giveReceiveDG' id='giveReceiveDG'>
	<option disabled selected style='display:none;'>Choose a Distribution Group.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
		echo "<option value=" . $row['distributionGroupID'] . ">" . $row['dgName'] . "</option>\n";
	}
	$db->close();
?>

</select>
