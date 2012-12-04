<?php 
	$entered = $_POST['pw'];

	if($entered == "0-webform")
	{
		session_start();
		$_SESSION['user'] = "yes";
		header( 'Location: webform.php');
	}
	else
	{
		header( 'Location: login_webform.php');
	}
?>
