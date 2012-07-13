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
}

function removeById(elementID)
{
	var oldElement = document.getElementById(elementID);
	oldElement.parentNode.removeChild(oldElement);
}

// New Employee
function newEmpSchoolDepartmentDD(newEmpsDivision)
{
	document.getElementById("newEmpDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Employee/newEmpSchoolDepartmentDD.php",
		data: "newEmpsDivision="+newEmpsDivision,
		success: function(msg){ $("#newEmployeeForm").append(msg);}
	});
}

function newEmpPositionDD(newEmpsSchoolDepartment)
{
	document.getElementById("newEmpSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Employee/newEmpPositionDD.php",
		data: "newEmpsSchoolDepartment="+newEmpsSchoolDepartment,
		success: function(msg){ $("#newEmployeeForm").append(msg);}
	});
}

function prepNewEmp()
{
	document.getElementById("newEmpDivision").disabled = false;
	document.getElementById("newEmpSchoolDepartment").disabled = false;

	document.getElementById("newEmpDivisionHolder").value = document.getElementById("newEmpDivision").options[document.getElementById("newEmpDivision").selectedIndex].text;
	document.getElementById("newEmpSchoolDepHolder").value = document.getElementById("newEmpSchoolDepartment").options[document.getElementById("newEmpSchoolDepartment").selectedIndex].text;
	document.getElementById("newEmpPositionHolder").value = document.getElementById("newEmpPosition").options[document.getElementById("newEmpPosition").selectedIndex].text;
}

// New Position
function newPosSchoolDepartmentDD(newPosDivision)
{
	document.getElementById("newPosDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Position/newPosSchoolDepartmentDD.php",
		data: "newPosDivision="+newPosDivision,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function newPosPositionDD(newPosSchoolDepartment)
{
	document.getElementById("newPosSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Position/newPosPositionDD.php",
		data: "newPosSchoolDepartment="+newPosSchoolDepartment,
		success: function(msg){ $("#newPositionForm").append(msg);}
	});
}

function prepNewPos()
{
	document.getElementById("newPosDivision").disabled = false;
	document.getElementById("newPosSchoolDepartment").disabled = false;

	document.getElementById("newPosDivisionHolder").value = document.getElementById("newPosDivision").options[document.getElementById("newPosDivision").selectedIndex].text;
	document.getElementById("newPosSchoolDepHolder").value = document.getElementById("newPosSchoolDepartment").options[document.getElementById("newPosSchoolDepartment").selectedIndex].text;
	document.getElementById("newPosPositionHolder").value = document.getElementById("newPosPosition").options[document.getElementById("newPosPosition").selectedIndex].text;
}

// Additional Position
function newAddPosSchoolDepartmentDD(newPosDivision)
{
	document.getElementById("newAddPosDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Additional Position/newAddPosSchoolDepartmentDD.php",
		data: "newAddPosDivision="+newPosDivision,
		success: function(msg){ $("#newAddPositionForm").append(msg);}
	});
}

function newAddPosPositionDD(newPosSchoolDepartment)
{
	document.getElementById("newAddPosSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "PHP/New Additional Position/newAddPosPositionDD.php",
		data: "newAddPosSchoolDepartment="+newPosSchoolDepartment,
		success: function(msg){ $("#newAddPositionForm").append(msg);}
	});
}

function prepNewAddPos()
{
	document.getElementById("newAddPosDivision").disabled = false;
	document.getElementById("newAddPosSchoolDepartment").disabled = false;
	document.getElementById("newAddPosDivisionHolder").value = document.getElementById("newAddPosDivision").options[document.getElementById("newAddPosDivision").selectedIndex].text;
	document.getElementById("newAddPosSchoolDepHolder").value = document.getElementById("newAddPosSchoolDepartment").options[document.getElementById("newAddPosSchoolDepartment").selectedIndex].text;
	document.getElementById("newAddPosPositionHolder").value = document.getElementById("newAddPosPosition").options[document.getElementById("newAddPosPosition").selectedIndex].text;
}


