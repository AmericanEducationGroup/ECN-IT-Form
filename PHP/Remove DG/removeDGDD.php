<?php

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	$result = $db->query("SELECT distributionGroupID, dgName FROM distribution_groups;");
?>

<select name='removedDG' id='removedDG'>
	<option disabled selected style='display:none;'>Choose a Distribution Group.</option> 

<?php
	while ($row = $result->fetch_assoc())
	{
		echo "<option value=" . $row['distributionGroupID'] . ">" . $row['dgName'] . "</option>\n";
	}
	$db->close();
?>

</select>
