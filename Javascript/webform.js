function hideAllActionFields()
{
	if(document.getElementById("newEmployeeForm") != null)
		document.getElementById("newEmployeeForm").style.display = 'none';
	if(document.getElementById("newPositionForm") != null)
		document.getElementById("newPositionForm").style.display = 'none';
	if(document.getElementById("newAddPositionForm") != null)
		document.getElementById("newAddPositionForm").style.display = 'none';
	if(document.getElementById("terminationForm") != null)
		document.getElementById("terminationForm").style.display = 'none';
	if(document.getElementById("requestChangeForm") != null)
		document.getElementById("requestChangeForm").style.display = 'none';
}

function showActionFields(generalAction)
{
	hideAllActionFields();
	var action = generalAction.options[generalAction.selectedIndex].value;
	if(action == "newEmployee")
	{
		document.getElementById("newEmployeeForm").style.display = 'block';
	}
	else if(action == "newPosition")
	{
		document.getElementById("newPositionForm").style.display = 'block';
	}
	else if(action == "additionalPosition")
	{
		document.getElementById("newAddPositionForm").style.display = 'block';
	}
	else if(action == "termination")
	{
		document.getElementById("terminationForm").style.display = 'block';
	}
	else if(action == "requestChange")
	{
		document.getElementById("requestChangeForm").style.display = 'block';
	}
}

function removeById(elementID)
{
	var oldElement = document.getElementById(elementID);
	oldElement.parentNode.removeChild(oldElement);
}



/* 	A simple check for a valid email address.
	From w3schools.com/js/js_form_validation.asp */
function validEmail(email)
{
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	{
		alert("Please enter a valid e-mail address.");
		return false;
	}
	return true;
}

/*	Simple check for a valid first name */
function validFirstName(firstName)
{
	if(firstName == null || firstName == "" || !(/^[a-zA-Z\s\-]+$/.test(firstName)))
	{
		alert("Please enter a valid first name.");
		return false;
	}
	return true;
}

/*	Simple check for a valid last name */
function validLastName(lastName)
{
	if(lastName == null || lastName == "" || !(/^[a-zA-Z\s\-]+$/.test(lastName)))
	{
		alert("Please enter a valid last name.");
		return false;
	}
	return true;
}

/* Confirms that a position was chosen (default for unchosen == 0) */
function validPosition(position)
{
	if(position == 0)
	{
		alert("Please choose a position.");
		return false;
	}
	return true;
}

// New Employee
function newEmpSchoolDepartmentDD(newEmpsDivision)
{
	document.getElementById("newEmpDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Employee/newEmpSchoolDepartmentDD.php",
		data: "newEmpsDivision="+newEmpsDivision,
		success: function(msg){ $("#newEmployeeForm").append(msg);}
	});
}

function newEmpPositionDD(newEmpsSchoolDepartment)
{
	document.getElementById("newEmpSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Employee/newEmpPositionDD.php",
		data: "newEmpsSchoolDepartment="+newEmpsSchoolDepartment,
		success: function(msg){ $("#newEmployeeForm").append(msg);}
	});
}

function prepNewEmp()
{
	/* Check for valid form inputs */
	var email = document.getElementById("newEmpEmailAddress").value;
	var firstName = document.getElementById("newEmpFirstName").value;
	var lastName = document.getElementById("newEmpLastName").value;
	var position = document.getElementById("newEmpPosition").selectedIndex	// position of 0 means no choice was made
	
	if(!validEmail(email) || !validFirstName(firstName) || !validLastName(lastName) || !validPosition(position))
	{
		return false;
	}
		
	document.getElementById("newEmpDivision").disabled = false;
	document.getElementById("newEmpSchoolDepartment").disabled = false;

	document.getElementById("newEmpDivisionHolder").value = document.getElementById("newEmpDivision").options[document.getElementById("newEmpDivision").selectedIndex].text;
	document.getElementById("newEmpSchoolDepHolder").value = document.getElementById("newEmpSchoolDepartment").options[document.getElementById("newEmpSchoolDepartment").selectedIndex].text;
	document.getElementById("newEmpPositionHolder").value = document.getElementById("newEmpPosition").options[document.getElementById("newEmpPosition").selectedIndex].text;

	return true;
}

// New Position
function oldPosSchoolDepartmentDD(oldPosDivision)
{
	document.getElementById("oldPosDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Position/oldPosSchoolDepartmentDD.php",
		data: "oldPosDivision="+oldPosDivision,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function oldPosPositionDD(oldPosSchoolDepartment)
{
	document.getElementById("oldPosSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Position/oldPosPositionDD.php",
		data: "oldPosSchoolDepartment="+oldPosSchoolDepartment,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function newPosSchoolDepartmentDD(newPosDivision)
{
	document.getElementById("newPosDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Position/newPosSchoolDepartmentDD.php",
		data: "newPosDivision="+newPosDivision,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function newPosPositionDD(newPosSchoolDepartment)
{
	document.getElementById("newPosSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Position/newPosPositionDD.php",
		data: "newPosSchoolDepartment="+newPosSchoolDepartment,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function prepNewPos()
{
	/* Check for valid form inputs */
	var email = document.getElementById("newPosEmailAddress").value;
	var firstName = document.getElementById("newPosFirstName").value;
	var lastName = document.getElementById("newPosLastName").value;
	var oldPosition = document.getElementById("oldPosPosition").selectedIndex	// position of 0 means no choice was made
	var newPosition = document.getElementById("newPosPosition").selectedIndex	// position of 0 means no choice was made
	
	if(!validEmail(email) || !validFirstName(firstName) || !validLastName(lastName) || !validPosition(oldPosition) || !validPosition(newPosition))
	{
		return false;
	}
	document.getElementById("newPosDivision").disabled = false;
	document.getElementById("newPosSchoolDepartment").disabled = false;

	document.getElementById("newPosDivisionHolder").value = document.getElementById("newPosDivision").options[document.getElementById("newPosDivision").selectedIndex].text;
	document.getElementById("newPosSchoolDepHolder").value = document.getElementById("newPosSchoolDepartment").options[document.getElementById("newPosSchoolDepartment").selectedIndex].text;
	document.getElementById("newPosPositionHolder").value = document.getElementById("newPosPosition").options[document.getElementById("newPosPosition").selectedIndex].text;
	
	document.getElementById("oldPosDivision").disabled = false;
	document.getElementById("oldPosSchoolDepartment").disabled = false;

	document.getElementById("oldPosDivisionHolder").value = document.getElementById("oldPosDivision").options[document.getElementById("oldPosDivision").selectedIndex].text;
	document.getElementById("oldPosSchoolDepHolder").value = document.getElementById("oldPosSchoolDepartment").options[document.getElementById("oldPosSchoolDepartment").selectedIndex].text;
	document.getElementById("oldPosPositionHolder").value = document.getElementById("oldPosPosition").options[document.getElementById("oldPosPosition").selectedIndex].text;

	return true;
}

// Additional Position
function newAddPosSchoolDepartmentDD(newPosDivision)
{
	document.getElementById("newAddPosDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Additional Position/newAddPosSchoolDepartmentDD.php",
		data: "newAddPosDivision="+newPosDivision,
		success: function(msg){ $("#newAddPositionForm").append(msg);}
	});
}

function newAddPosPositionDD(newPosSchoolDepartment)
{
	document.getElementById("newAddPosSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "../New Additional Position/newAddPosPositionDD.php",
		data: "newAddPosSchoolDepartment="+newPosSchoolDepartment,
		success: function(msg){ $("#newAddPositionForm").append(msg);}
	});
}

function prepNewAddPos()
{
	/* Check for valid form inputs */
	var email = document.getElementById("newAddPosEmailAddress").value;
	var firstName = document.getElementById("newAddPosFirstName").value;
	var lastName = document.getElementById("newAddPosLastName").value;
	var position = document.getElementById("newAddPosPosition").selectedIndex	// position of 0 means no choice was made
	
	if(!validEmail(email) || !validFirstName(firstName) || !validLastName(lastName) || !validPosition(position))
	{
		return false;
	}
	
	document.getElementById("newAddPosDivision").disabled = false;
	document.getElementById("newAddPosSchoolDepartment").disabled = false;
	document.getElementById("newAddPosDivisionHolder").value = document.getElementById("newAddPosDivision").options[document.getElementById("newAddPosDivision").selectedIndex].text;
	document.getElementById("newAddPosSchoolDepHolder").value = document.getElementById("newAddPosSchoolDepartment").options[document.getElementById("newAddPosSchoolDepartment").selectedIndex].text;
	document.getElementById("newAddPosPositionHolder").value = document.getElementById("newAddPosPosition").options[document.getElementById("newAddPosPosition").selectedIndex].text;

	return true;
}

// Termination
function prepTermination()
{
	/* Check for valid form inputs */
	var email = document.getElementById("termEmailAddress").value;
	var firstName = document.getElementById("termFirstName").value;
	var lastName = document.getElementById("termLastName").value;
	
	if(!validEmail(email) || !validFirstName(firstName) || !validLastName(lastName))
	{
		return false;
	}
	return true;

}


