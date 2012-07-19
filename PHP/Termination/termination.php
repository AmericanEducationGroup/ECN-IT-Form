<?php
	$to      = 'aeg.ecn.it.form@gmail.com';
	$subject = 'ECN-IT-Form Submission: Termination';
	$message = "Please remove all Source permissions, email access, and send/receive DG permissions from this terminated employee:";
	$message = $message . "\r\nFirst Name: " . $_POST['termFirstName'] . "\r\nLast Name: " . $_POST['termLastName'];

	$headers = 'From: ' . $_POST['emailAddress'] . "\r\n" .
	'Reply-To: aeg.ecn.it.form@gmail.com' . "\r\n" .
	'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: ../../HTML/successWebForm.html' ) ;
	} else {
		header( 'Location: ../../HTML/failureWebForm.html') ;
	}
		$db->close();
?>
