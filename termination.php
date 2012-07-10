<?php
	$to      = 'mark.t.arbogast@gmail.com';
	$subject = 'ECN-IT-Form Submission: Termination';
	$message = "Please remove all Source permissions, email access, and send/receive DG permissions from this terminated employee:";
	$message = $message . "\r\nFirst Name: " . $_POST['termFirstName'] . "\r\nLast Name: " . $_POST['termLastName'];

	$headers = 'From: marbogast@americanedgroup.com' . "\r\n" .
	'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
	'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: successWebForm.html' ) ;
	} else {
		header( 'Location: failureWebForm.html') ;
	}
		$db->close();
?>
