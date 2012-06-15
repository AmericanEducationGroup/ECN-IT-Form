
function showActionOptions(actionCategory)
{
	var category = actionCategory.options[actionCategory.selectedIndex].value;
	if(category == "general")
	{
		document.getElementById("generalOptions").style.display = 'block';
		document.getElementById("sourceOptions").style.display = 'none';
		document.getElementById("distGroupOptions").style.display = 'none';
	}
	else if(category == "source")
	{
		document.getElementById("generalOptions").style.display = 'none';
		document.getElementById("sourceOptions").style.display = 'block';
		document.getElementById("distGroupOptions").style.display = 'none';
	}
	else if(category == "distributionGroups")
	{
		document.getElementById("generalOptions").style.display = 'none';
		document.getElementById("sourceOptions").style.display = 'none';
		document.getElementById("distGroupOptions").style.display = 'block';
	}
	hideAllActionFields();
}

function hideAllActionFields()
{
	if(document.getElementById("addDivisionForm") != null)
		document.getElementById("addDivisionForm").style.display = 'none';
	if(document.getElementById("removeDivisionForm") != null)
		document.getElementById("removeDivisionForm").style.display = 'none';
	if(document.getElementById("addSchoolForm") != null)
		document.getElementById("addSchoolForm").style.display = 'none';
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
	else if(action == "removeSchool")
	{
		
	}
	else if(action == "addDepartment")
	{
		
	}
	else if(action == "removeDepartment")
	{
		
	}
	else if(action == "addPosition")
	{
		
	}
	else if(action == "removePosition")
	{
		
	}
	
}
