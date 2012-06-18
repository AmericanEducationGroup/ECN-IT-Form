
function showActionOptions(actionCategory)
{
	hideActionOptions();
	var category = actionCategory.options[actionCategory.selectedIndex].value;
	if(category == "general")
	{
		if(document.getElementById("generalOptions") != null)
			document.getElementById("generalOptions").style.display = 'block';
	}
	else if(category == "source")
	{
		if(document.getElementById("sourceOptions") != null)
			document.getElementById("sourceOptions").style.display = 'block';
	}
	else if(category == "distributionGroups")
	{
		if(document.getElementById("distGroupOptions") != null)
			document.getElementById("distGroupOptions").style.display = 'block';
	}
	hideAllActionFields();
}

function hideActionOptions()
{
	if(document.getElementById("generalOptions") != null)
		document.getElementById("generalOptions").style.display = 'none';
	if(document.getElementById("sourceOptions") != null)
		document.getElementById("sourceOptions").style.display = 'none';
	if(document.getElementById("distGroupOptions") != null)
		document.getElementById("distGroupOptions").style.display = 'none';
}

function hideAllActionFields()
{
	if(document.getElementById("addDivisionForm") != null)
		document.getElementById("addDivisionForm").style.display = 'none';
	if(document.getElementById("removeDivisionForm") != null)
		document.getElementById("removeDivisionForm").style.display = 'none';
	if(document.getElementById("addSchoolForm") != null)
		document.getElementById("addSchoolForm").style.display = 'none';
	if(document.getElementById("addDepartmentForm") != null)
		document.getElementById("addDepartmentForm").style.display = 'none';
	if(document.getElementById("removeSchoolForm") != null)
		document.getElementById("removeSchoolForm").style.display = 'none';
	if(document.getElementById("addPositionForm") != null)
		document.getElementById("addPositionForm").style.display = 'none';
}

function showGeneralActionFields(generalAction)
{
	hideAllActionFields();
	var action = generalAction.options[generalAction.selectedIndex].value;
	if(action == "addDivision")
	{
		document.getElementById("addDivisionForm").style.display = 'block';
	}
	else if(action == "removeDivision")
	{
		document.getElementById("removeDivisionForm").style.display = 'block';
	}
	else if(action == "addSchool")
	{
		document.getElementById("addSchoolForm").style.display = 'block';
	}
	else if(action == "addDepartment")
	{
		document.getElementById("addDepartmentForm").style.display = 'block';
	}
	else if(action == "removeSchool")
	{
		document.getElementById("removeSchoolForm").style.display = 'block';
	}
	else if(action == "addPosition")
	{
		document.getElementById("addPositionForm").style.display = 'block';
	}
	else if(action == "removePosition")
	{
		
	}
}

function removeSchoolDD(removedSchoolsDivision)
{
	$.ajax({
		type: "POST",
		url: "removeSchoolDD.php",
		data: "removedSchoolsDivision="+removedSchoolsDivision,
		success: function(msg){ $("#removeSchoolForm").html(msg);}
	});
}

function addPositionDD(addedPositionsDivision)
{
	$.ajax({
		type: "POST",
		url: "addPositionDD.php",
		data: "addedPositionsDivision="+addedPositionsDivision,
		success: function(msg){ $("#addPositionForm").html(msg);}
	});
}

function checkAbbreviation(divisionSelector)
{
	var division = divisionSelector.options[divisionSelector.selectedIndex].value;
	if(division == 1) {
		document.getElementById("schoolAbbrv").value = "N/A";
		document.getElementById("schoolAbbrv").disabled = true;
	} else {
		document.getElementById("schoolAbbrv").disabled = false;
	}
}
