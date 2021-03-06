<?php 
	session_start();
	if(isset($_SESSION['user']))
	{
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>ECN IT Web Form</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../Javascript/webform.js"></script>
		<link href="../../CSS/webform.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
	<a href="administration.php">IT Administration</a>
	<div class="styled-select" id="styled-select">
		<div class="title-wording">
		<a href="webform.php"><img src="/Resources/WebFormTitle.PNG" alt="Web Form"></a> 
		<!-- <h1>ECN IT Web Form</h1>-->
		</div>
		<h3>What action would you like to take?</h3>
		<select id="actionCategory" onchange="showActionFields(this);">
			<option disabled selected style='display:none;'>Choose an action.</option>
			<option value="newEmployee">New Employee - Give a new employee IT permissions</option>
			<option value="newPosition">New Position - Replace an existing employee's IT permissions</option>
			<option value="additionalPosition">Additional Position - Give an existing employee additional IT permissions</option>
			<option value="termination">Termination - Remove all of an employee's IT permissions</option>
			<option value="requestChange">Request a change to this form (e.g., new position, new school, additional field, etc.)</option>
		</select>
			<!-- New Employee -->
				<form id="newEmployeeForm" onsubmit="return prepNewEmp();" action="../New%20Employee/new_employee.php" method="post" style="display: none;">
					What is your email address?												<input type="text" placeholder="Email Address?" id="newEmpEmailAddress"  name="emailAddress">
					What is the new employee's first name?									<input type="text" placeholder="First Name?" id="newEmpFirstName" name="newEmpFirstName"/><br>
					What is the new employee's last name?									<input type="text" placeholder="Last Name?" id="newEmpLastName" name="newEmpLastName"/><br>
					What is the new employee's division?									<?php require '../New Employee/newEmpDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newEmpDivisionHolder" name="newEmpDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newEmpSchoolDepHolder" name="newEmpSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newEmpPositionHolder" name="newEmpPositionHolder" style="display: none;"/>
				</form>


			<!-- New Position -->
				<form id="newPositionForm" onsubmit="return prepNewPos();" action="../New%20Position/new_position.php" method="post" style="display: none;">
					What is your email address?												<input type="text" placeholder="Email Address?" id="newPosEmailAddress"  name="emailAddress">
					What is the employee's first name?										<input type="text" placeholder="First Name?" id="newPosFirstName" name="newPosFirstName"/><br>
					What is the employee's last name?										<input type="text" placeholder="Last Name?" id="newPosLastName" name="newPosLastName"/><br>	
									
					<h3>Old Position Details</h3>
					What division was the old position in?									<?php require '../New Position/oldPosDivisionDD.php'; ?>
					<input type="text" placeholder="" id="oldPosDivisionHolder" name="oldPosDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="oldPosSchoolDepHolder" name="oldPosSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="oldPosPositionHolder" name="oldPosPositionHolder" style="display: none;"/>
				</form>

			<!-- Additional Position -->
				<form id="newAddPositionForm" onsubmit="return prepNewAddPos();" action="../New%20Additional%20Position/new_add_position.php" method="post" style="display: none;">
					What is your email address?												<input type="text" placeholder="Email Address?" id="newAddPosEmailAddress" name="emailAddress">
					What is the employee's first name?										<input type="text" placeholder="First Name?" id="newAddPosFirstName" name="newAddPosFirstName"/><br>
					What is the employee's last name?										<input type="text" placeholder="Last Name?" id="newAddPosLastName" name="newAddPosLastName"/><br>
					<h3>Additional Position Details</h3>
					What division is the new position in?									<?php require '../New Additional Position/newAddPosDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newAddPosDivisionHolder" name="newAddPosDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newAddPosSchoolDepHolder" name="newAddPosSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newAddPosPositionHolder" name="newAddPosPositionHolder" style="display: none;"/>
				</form>

			<!-- Termination -->
				<form id="terminationForm" onsubmit="return prepTermination();" action="../Termination/termination.php" method="post" style="display: none;">
					What is your email address?												<input type="text" placeholder="Email Address?" id="termEmailAddress" name="emailAddress">
					What is the first name of the terminated employee?						<input type="text" placeholder="First Name?" id="termFirstName" name="termFirstName"/><br>
					What is the last name of the terminated employee?						<input type="text" placeholder="Last Name?" id="termLastName" name="termLastName"/><br>
					What should the terminated employee's Automatic Email Response be?		<br><textarea rows="3" cols="80" placeholder="Automated email response?" id="termAutoResponse" name="autoResponse"></textarea><br>
					<input type="submit">
				</form>
				
			<!-- Request Change -->
				<form id="requestChangeForm" action="../Request%20Change/request_change.php" method="post" style="display: none;">
					<br>Please describe the changes you would like to make (the more specific, the better):			<br><textarea rows=3 cols=80 placeholder="Write your request here..."  name="request"></textarea>
					<br><input type="submit">
				</form>


	</div>
	</body>
</html>
<?php 
	}
	else
	{
   		header( 'Location: login_webform.php' ) ;
	}
?>

