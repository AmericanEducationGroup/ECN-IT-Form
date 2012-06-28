function hideAllActionFields()
{
	if(document.getElementById("newEmployeeForm") != null)
		document.getElementById("newEmployeeForm").style.display = 'none';
	if(document.getElementById("newPositionForm") != null)
		document.getElementById("newPositionForm").style.display = 'none';
	if(document.getElementById("additionalPositionForm") != null)
		document.getElementById("additionalPositionForm").style.display = 'none';
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
		document.getElementById("additionalPositionForm").style.display = 'block';
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


function newEmpSchoolDepartmentDD(newEmpsDivision)
{
	document.getElementById("newEmpDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "newEmpSchoolDepartmentDD.php",
		data: "newEmpsDivision="+newEmpsDivision,
		success: function(msg){ $("#newEmployeeForm").append(msg);}
	});
}

function newEmpPositionDD(newEmpsSchoolDepartment)
{
	document.getElementById("newEmpSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "newEmpPositionDD.php",
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
}


