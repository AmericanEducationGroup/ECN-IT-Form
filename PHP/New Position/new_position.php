<?php
	$to      = $_POST['emailAddress'];
	$subject = 'ECN-IT-Form Submission: New Position';
	$message = "Please remove all current Source permissions, send/receive DG permissions, and (if necessary) this user's email account. Replace with the following:";
	$message = $message . "\r\nFirst name: " . $_POST['newPosFirstName'];
	$message = $message . "\r\nLast Name: " . $_POST['newPosLastName'];
	$message = $message . "\r\nDivision: " . $_POST['newPosDivisionHolder'];
	$message = $message . "\r\nSchool/Department: " . $_POST['newPosSchoolDepHolder'];
	$message = $message . "\r\nPosition: " . $_POST['newPosPositionHolder'];

	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	// phone number
	$result = $db->query("SELECT phoneNumber FROM schools_departments WHERE schoolDepartmentID = '" . $_POST['newPosSchoolDepartment'] . "'\r\n");
	$row = $result->fetch_assoc();
	$phone = $row['phoneNumber'];
	$message = $message . "\r\nPhone Number: " . $phone;

	// create email address
	$result = $db->query("SELECT emailDomain FROM schools_departments WHERE schoolDepartmentID = '" . $_POST['newPosSchoolDepartment'] . "'\r\n");
	$row = $result->fetch_assoc();
	$email = substr($_POST['newPosFirstName'], 0,1) . $_POST['newPosLastName'] . "@" . $row['emailDomain'];
	$message = $message . "\r\nEmail: " . $email;
	$message = $message . "\r\nPassword: 0-password";

	
	
	// create curriculum loft account
	$school = $_POST['newPosSchoolDepHolder'];
	if($school=="Fusion Mission Viejo" || $school=="Fusion Solana Beach" || $school=="Fusion Los Angeles" || $school=="Fusion Pasadena" || $school=="Fusion Warner Center" || $school=="Fusion Walnut Creek" || $school=="Fusion San Francisco")
	{
		$position = $_POST['newPosPositionHolder'];
		if($position=="Head of School" || $position=="Assistant Director")
		{
			$message = $message . "\r\nCurriculum Loft: Administrator";
		}
		else
		{
			$message = $message . "\r\nCurriculum Loft: Teacher (don't change if employee is already an Administrator)";
		}
	}
	else
	{
		$message = $message . "\r\nCurriculum Loft: None (don't remove if employee is already a user)";
	}

	// Remove OLD Source read permissions
	$message = $message . "\r\n\r\nRemove OLD Source READ permissions:";
	$result = $db->query("SELECT readPermissionID, directory FROM read_permissions WHERE position = '" . $_POST['oldPosPosition'] . "'");
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
			$message = $message . "\r\n" . $directory_path;
		}
	}

	// Remove OLD Source edit permissions
	$message = $message . "\r\n\r\nRemove OLD Source CONTRIBUTE permissions:";
	$result = $db->query("SELECT editPermissionID, directory FROM edit_permissions WHERE position = '" . $_POST['oldPosPosition'] . "'");
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
			$message = $message . "\r\n" . $directory_path;
		}
	}

	// Add NEW Source read permissions
	$message = $message . "\r\n\r\nAdd NEW Source READ permissions:";
	$result = $db->query("SELECT readPermissionID, directory FROM read_permissions WHERE position = '" . $_POST['newPosPosition'] . "'");
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
			$message = $message . "\r\n" . $directory_path;
		}
	}


	// Add NEW Source edit permissions
	$message = $message . "\r\n\r\nAdd NEW Source CONTRIBUTE permissions:";
	$result = $db->query("SELECT editPermissionID, directory FROM edit_permissions WHERE position = '" . $_POST['newPosPosition'] . "'");
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
			$message = $message . "\r\n" . $directory_path;
		}
	}

	// receive DG
	$message = $message . "\r\n\r\nThis employee should RECEIVE emails sent to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM receive_dg WHERE position = '" . $_POST['newPosPosition'] . "'");
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
	$message = $message . "\r\n\r\nThis employee should be able to SEND to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM send_to_dg WHERE position = '" . $_POST['newPosPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'] . "\r\n";
		}
	}
	
	$headers = 'From: ECN-IT-Form@noreply.com' . "\r\n" .
	'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
	'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: ../../HTML/successWebForm.html' ) ;
	} else {
		header( 'Location: ../../HTML/failureWebForm.html') ;
	}
		$db->close();
?>
