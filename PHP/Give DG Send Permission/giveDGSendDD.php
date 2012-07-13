<?php
	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("call viewAll_distribution_groups()");
?>

<select name='giveSendDG' id='giveSendDG'>
	<option disabled selected style='display:none;'>Choose a Distribution Group.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
		echo "<option value=" . $row['distributionGroupID'] . ">" . $row['dgName'] . "</option>\n";
	}
	$db->close();
?>

</select>
