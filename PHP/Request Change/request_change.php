<?php
	$to      = 'aeg.ecn.it.form@gmail.com';
	$subject = 'ECN-IT-Form Submission: Request Changes';
	$message = "Please make these changes to the ECN-IT-Form";
	$message = $message . "\r\nRequest: " . $_POST['request'];
	
	$headers = 'From: ' . 'marbogast@americanedgroup.com' . "\r\n" .
		'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
		'X-Mailer: PHP/' . phpversion();
		

	if (mail($to, $subject, $message, $headers)) {
		header( 'Location: ../../HTML/successWebForm.html' ) ;
	} else {
		header( 'Location: ../../HTML/failureWebForm.html') ;
	}
		$db->close();
?>
