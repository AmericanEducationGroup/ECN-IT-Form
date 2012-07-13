<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="Javascript/webform.js"></script>
		<link href="CSS/webform.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
	<div class="styled-select" id="styled-select">
		<div class="title-wording">
		<h1>ECN IT Web Form</h1>
		<h3>What action would you like to take?</h3>
		</div>
		<select id="actionCategory" onchange="showActionFields(this);"">
			<option disabled selected style='display:none;'>Choose an action category.</option>
			<option value="newEmployee"">New Employee - Give a new employee IT permissions</option>
			<option value="newPosition">New Position - Replace an existing employee's IT permissions</option>
			<option value="additionalPosition">Additional Position - Give an existing employee additional IT permissions</option>
			<option value="termination">Termination - Remove all of an employee's IT permissions</option>
		</select>
			<!-- New Employee -->
				<form id="newEmployeeForm" onsubmit="prepNewEmp()" action="PHP/New Employee/new_employee.php" method="post" style="display: none;">
					What is the new employee's first name?									<input type="text" placeholder="First Name?" name="newEmpFirstName"/><br>
					What is the new employee's last name?									<input type="text" placeholder="Last Name?" name="newEmpLastName"/><br>
					What is the new employee's division?									<?php require 'PHP/New Employee/newEmpDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newEmpDivisionHolder" name="newEmpDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newEmpSchoolDepHolder" name="newEmpSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newEmpPositionHolder" name="newEmpPositionHolder" style="display: none;"/>
				</form>


			<!-- New Position -->
				<form id="newPositionForm" onsubmit="prepNewPos()" action="PHP/New Position/new_position.php" method="post" style="display: none;">
					What is the employee's first name'?										<input type="text" placeholder="First Name?" name="newPosFirstName"/><br>
					What is the employee's last name?										<input type="text" placeholder="Last Name?" name="newPosLastName"/><br>
					<h3>New Position Details</h3>
					What division is the new position in?									<?php require 'PHP/New Position/newPosDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newPosDivisionHolder" name="newPosDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newPosSchoolDepHolder" name="newPosSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newPosPositionHolder" name="newPosPositionHolder" style="display: none;"/>
				</form>

			<!-- Additional Position -->
				<form id="newAddPositionForm" onsubmit="prepNewAddPos()" action="PHP/New Additional Position/new_add_position.php" method="post" style="display: none;">
					What is the employee's first name'?										<input type="text" placeholder="First Name?" name="newAddPosFirstName"/><br>
					What is the employee's last name?										<input type="text" placeholder="Last Name?" name="newAddPosLastName"/><br>
					<h3>Additional Position Details</h3>
					What division is the new position in?									<?php require 'PHP/New Additional Position/newAddPosDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newAddPosDivisionHolder" name="newAddPosDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newAddPosSchoolDepHolder" name="newAddPosSchoolDepHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newAddPosPositionHolder" name="newAddPosPositionHolder" style="display: none;"/>
				</form>

			<!-- Termination -->
				<form id="terminationForm" action="PHP/Termination/termination.php" method="post" style="display: none;">
					What is the first name of the terminated employee?						<input type="text" placeholder="First Name?" name="termFirstName"/><br>
					What is the last name of the terminated employee?						<input type="text" placeholder="Last Name?" name="termLastName"/><br>
					<input type="submit">
				</form>


	</div>
	</body>
</html>
