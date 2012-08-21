<?php
	$to      = $_POST['emailAddress'];
	$subject = 'ECN-IT-Form Submission: New Employee';
	$message = "First name: " . $_POST['newEmpFirstName'];
	$message = $message . "\r\nLast Name: " . $_POST['newEmpLastName'];
	$message = $message . "\r\nDivision: " . $_POST['newEmpDivisionHolder'];
	$message = $message . "\r\nSchool/Department: " . $_POST['newEmpSchoolDepHolder'];
	$message = $message . "\r\nPosition: " . $_POST['newEmpPositionHolder'];
	
	
	
	require "../dbConnect.php";

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	// phone number
	$result = $db->query("SELECT phoneNumber FROM schools_departments WHERE schoolDepartmentID = '" . $_POST['newEmpSchoolDepartment'] . "'\r\n");
	$row = $result->fetch_assoc();
	$phone = $row['phoneNumber'];
	$message = $message . "\r\nPhone Number: " . $phone;

	// create email address
	$result = $db->query("SELECT emailDomain FROM schools_departments WHERE schoolDepartmentID = '" . $_POST['newEmpSchoolDepartment'] . "'");
	$row = $result->fetch_assoc();
	$email = substr($_POST['newEmpFirstName'], 0,1) . $_POST['newEmpLastName'] . "@" . $row['emailDomain'];
	$message = $message . "\r\nEmail: " . $email;
	$message = $message . "\r\nPassword: 0-password";
	
	// create curriculum loft account
	$school = $_POST['newEmpSchoolDepHolder'];
	if($school=="Fusion Mission Viejo" || $school=="Fusion Solana Beach" || $school=="Fusion Los Angeles" || $school=="Fusion Pasadena" || $school=="Fusion Warner Center" || $school=="Fusion Walnut Creek" || $school=="Fusion San Francisco")
	{
		$position = $_POST['newEmpPositionHolder'];
		if($position=="Head of School" || $position=="Assistant Director")
		{
			$message = $message . "\r\nCurriculum Loft: Administrator";
		}
		else
		{
			$message = $message . "\r\nCurriculum Loft: Teacher";
		}
	}
	else
	{
		$message = $message . "\r\nCurriculum Loft: None";
	}
	
	// Source read permissions
	$message = $message . "\r\n\r\nSource READ permissions:";
	$result = $db->query("SELECT readPermissionID, directory FROM read_permissions WHERE position = '" . $_POST['newEmpPosition'] . "'");
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
	

	// Source edit permissions
	$message = $message . "\r\n\r\nSource CONTRIBUTE permissions:";
	$result = $db->query("SELECT editPermissionID, directory FROM edit_permissions WHERE position = '" . $_POST['newEmpPosition'] . "'");
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
	$result = $db->query("SELECT distributionGroup FROM receive_dg WHERE position = '" . $_POST['newEmpPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'];
		}
	}

	// send DG
	$message = $message . "\r\n\r\nThis employee should be able to SEND to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM send_to_dg WHERE position = '" . $_POST['newEmpPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'];
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
