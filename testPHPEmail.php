<?php
$to      = 'mark.t.arbogast@gmail.com';
$subject = 'the subject';
$message = $_POST["message"];
$headers = 'From: marbogast@americanedgroup.com' . "\r\n" .
    'Reply-To: marbogast@americanedgroup.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();
    

if (mail($to, $subject, $message, $headers)) {
   echo("<p>Message successfully sent!</p>");
  } else {
   echo("<p>Message delivery failed...</p>");
  }
?>
