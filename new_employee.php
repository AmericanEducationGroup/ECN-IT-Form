<?php
	$to      = 'mark.t.arbogast@gmail.com';
	$subject = 'ECN-IT-Form Submission: New Employee';
	$message = "First name: " . $_POST['newEmpFirstName'];
	$message = $message . "\r\nLast Name: " . $_POST['newEmpLastName'];
	$message = $message . "\r\nDivision: " . $_POST['newEmpDivisionHolder'];
	$message = $message . "\r\nSchool/Department: " . $_POST['newEmpSchoolDepHolder'];
	$message = $message . "\r\nPosition: " . $_POST['newEmpPosition'];
	$headers = 'From: marbogast@americanedgroup.com' . "\r\n" .
		'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
		'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: success.html' ) ;
	} else {
		header( 'Location: failure.html') ;
	}
?>
