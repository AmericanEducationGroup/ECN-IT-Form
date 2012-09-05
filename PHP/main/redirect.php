<?php 
	$entered = $_POST['pw'];

	if($entered == "0-admin")
	{
		session_start();
		$_SESSION['admin'] = "yes";
		header( 'Location: administration.php');
	}
	else
	{
		header( 'Location: login.php');
	}
?>
