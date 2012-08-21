<?php
	$to      = $_POST['emailAddress'];
	$subject = 'ECN-IT-Form Submission: Termination';
	$message = "Please remove all Source permissions, email access, curriculum loft access, and send/receive DG permissions from this terminated employee:";
	$message = $message . "\r\nFirst Name: " . $_POST['termFirstName'] . "\r\nLast Name: " . $_POST['termLastName'] . "\r\n";

	$message = $message . "Automated Email Response: " . $_POST['autoResponse'];

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

