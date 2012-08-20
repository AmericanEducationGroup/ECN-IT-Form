<?php
	$to      = 'aeg.ecn.it.form@gmail.com';
	$subject = 'ECN-IT-Form Submission: Additional Position';
	$message = "Please give this employee the following additional Source permissions and send/receive DG permissions:";
	$message = $message . "\r\nFirst name: " . $_POST['newAddPosFirstName'];
	$message = $message . "\r\nLast Name: " . $_POST['newAddPosLastName'];
	$message = $message . "\r\nDivision: " . $_POST['newAddPosDivisionHolder'];
	$message = $message . "\r\nSchool/Department: " . $_POST['newAddPosSchoolDepHolder'];
	$message = $message . "\r\nPosition: " . $_POST['newAddPosPositionHolder'];
	
	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}


	// Source read permissions
	$message = $message . "\r\nSource READ permissions:";
	$result = $db->query("SELECT readPermissionID, directory FROM read_permissions WHERE position = '" . $_POST['newAddPosPosition'] . "'");
	if($result->num_rows > 0)
	{
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
			$message = $message . "\r\n" . $directory_path . "\r\n";
		}
	}
	
	$message = $message . "\r\nSource CONTRIBUTE permissions:";

	// Source edit permissions
	$result = $db->query("SELECT editPermissionID, directory FROM edit_permissions WHERE position = '" . $_POST['newAddPosPosition'] . "'");
	if($result->num_rows > 0)
	{
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
			$message = $message . "\r\n" . $directory_path . "\r\n";
		}
	}

	// receive DG
	$message = $message . "\r\nThis employee should RECEIVE emails sent to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM receive_dg WHERE position = '" . $_POST['newAddPosPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'] . "\r\n";
		}
	}

	// send DG
	$message = $message . "\r\nThis employee should be able to SEND to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM send_to_dg WHERE position = '" . $_POST['newAddPosPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'] . "\r\n";
		}
	}
	
	$headers = 'From: ' . $_POST['emailAddress'] . "\r\n" .
		'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
		'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: ../../HTML/successWebForm.html' ) ;
	} else {
		header( 'Location: ../../HTML/failureWebForm.html') ;
	}
		$db->close();
?>
