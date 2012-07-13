<?php
	$to      = 'mark.t.arbogast@gmail.com';
	$subject = 'ECN-IT-Form Submission: New Employee';
	$message = "First name: " . $_POST['newEmpFirstName'];
	$message = $message . "\r\nLast Name: " . $_POST['newEmpLastName'];
	$message = $message . "\r\nDivision: " . $_POST['newEmpDivisionHolder'];
	$message = $message . "\r\nSchool/Department: " . $_POST['newEmpSchoolDepHolder'];
	$message = $message . "\r\nPosition: " . $_POST['newEmpPositionHolder'];
	
	
	
	$db = new mysqli("localhost:3306", "root", "", "ecn-it-db");

	if($db->connect_errno)
	{
		printf("Connect failed: %s\n", $mysqli->connect_error);
		exit();
	}

	// create email address
	$result = $db->query("SELECT emailDomain FROM schools_departments WHERE schoolDepartmentID = '" . $_POST['newEmpSchoolDepartment'] . "'");

	$row = $result->fetch_assoc();

	$email = substr($_POST['newEmpFirstName'], 0,1) . $_POST['newEmpLastName'] . "@" . $row['emailDomain'];
	$message = $message . "\r\nEmail: " . $email;
	$message = $message . "\r\nPassword: 0-password";
	$message = $message . "\r\nSource READ permissions:";

	// Source read permissions
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
			$message = $message . "\r\n" . $directory_path . "\r\n";
		}
	}
	
	$message = $message . "\r\nSource EDIT/DELETE permissions:";

	// Source edit permissions
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
			$message = $message . "\r\n" . $directory_path . "\r\n";
		}
	}

	// receive DG
	$message = $message . "\r\nThis employee should RECEIVE emails sent to these distribution groups:";
	$result = $db->query("SELECT distributionGroup FROM receive_dg WHERE position = '" . $_POST['newEmpPosition'] . "'");
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
	$result = $db->query("SELECT distributionGroup FROM send_to_dg WHERE position = '" . $_POST['newEmpPosition'] . "'");
	if($result->num_rows > 0)
	{
		while ($row = $result->fetch_assoc())
		{
			$result2 = $db->query("SELECT dgName FROM distribution_groups WHERE distributionGroupID = '" . $row['distributionGroup'] . "'");
			$row2 = $result2->fetch_assoc();
			$message = $message . "\r\n" . $row2['dgName'] . "\r\n";
		}
	}
	
	$headers = 'From: marbogast@americanedgroup.com' . "\r\n" .
		'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
		'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: ../../HTML/successWebForm.html' ) ;
	} else {
		header( 'Location: ../../HTML/failureWebForm.html') ;
	}
		$db->close();
?>
