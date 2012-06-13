<?php 

	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}
	
	$result = $db->query("SELECT name FROM divisions");

    echo "<select style="width: 277px;" name="title">"; while ($row = $result->fetch_assoc()) { unset($id, $name); $id = $row['journal_id']; $name = $row['journal_name']; echo '<option value="'.$name.'">'.$name.'</option>'; } echo "</select>";

?>
