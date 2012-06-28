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
		success: function(msg) { $("#newEmployeeForm").append(msg); }
	});
}

function newEmpPositionDD(newEmpsSchoolDepartment)
{
	document.getElementById("newEmpSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "newEmpPositionDD.php",
		data: "newEmpsSchoolDepartment="+newEmpsSchoolDepartment,
		success: function(msg) { #("#newEmployeeForm").append(msg);}
	});
}


