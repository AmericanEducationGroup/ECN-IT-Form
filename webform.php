<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="Javascript/webform.js"></script>
		<link href="webform.css" rel="stylesheet" type="text/css" />
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
				<form id="newEmployeeForm" onsubmit="prepNewEmp()" action="new_employee.php" method="post" style="display: none;">
					What is the new employee's first name?									<input type="text" placeholder="First Name?" name="newEmpFirstName"/><br>
					What is the new employee's last name?									<input type="text" placeholder="Last Name?" name="newEmpLastName"/><br>
					What is the new employee's division?									<?php require 'newEmpDivisionDD.php'; ?>
					<input type="text" placeholder="" id="newEmpDivisionHolder" name="newEmpDivisionHolder" style="display: none;"/>
					<input type="text" placeholder="" id="newEmpSchoolDepHolder" name="newEmpSchoolDepHolder" style="display: none;"/>
				</form>
				

			<!-- New Position -->

			<!-- Additional Position -->

			<!-- Termination -->


	</div>
	</body>
</html>
