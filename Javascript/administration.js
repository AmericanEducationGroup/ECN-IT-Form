
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
	if(document.getElementById("removePositionForm") != null)
		document.getElementById("removePositionForm").style.display = 'none';
	if(document.getElementById("addDirectoryForm") != null)
		document.getElementById("addDirectoryForm").style.display = 'none';
	if(document.getElementById("removeDirectoryForm") != null)
		document.getElementById("removeDirectoryForm").style.display = 'none';
	if(document.getElementById("addOwnerForm") != null)
		document.getElementById("addOwnerForm").style.display = 'none';
	if(document.getElementById("removeOwnerForm") != null)
		document.getElementById("removeOwnerForm").style.display = 'none';
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
		document.getElementById("removePositionForm").style.display = 'block';
	}
}

function showSourceActionFields(sourceAction)
{
	hideAllActionFields();
	var action = sourceAction.options[sourceAction.selectedIndex].value;
	if(action == "addDirectory")
	{
		document.getElementById("addDirectoryForm").style.display = 'block';
	}
	else if(action == "removeDirectory")
	{
		document.getElementById("removeDirectoryForm").style.display = 'block';
	}
	else if(action == "addOwner")
	{
		document.getElementById("addOwnerForm").style.display = 'block';
	}
	else if(action == "removeOwner")
	{
		document.getElementById("removeOwnerForm").style.display = 'block';
	}
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

// Remove School
function removeSchoolDD(removedSchoolsDivision)
{
	$.ajax({
		type: "POST",
		url: "removeSchoolDD.php",
		data: "removedSchoolsDivision="+removedSchoolsDivision,
		success: function(msg){ $("#removeSchoolForm").html(msg);}
	});
}


// Add Position
function addPositionDD(addedPositionsDivision)
{
	document.getElementById("addedPositionsDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "addPositionDD.php",
		data: "addedPositionsDivision="+addedPositionsDivision,
		success: function(msg){ $("#addPositionForm").append(msg);}
	});
}


// Remove Position
function removePositionSchoolDepartmentDD(removedPositionsDivision)
{
	document.getElementById("removedPositionsDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removePosition-SchoolDepartmentDD.php",
		data: "removedPositionsDivision="+removedPositionsDivision,
		success: function(msg){ $("#removePositionForm").append(msg);}
	});
}

function removePositionDD(removedPositionsSchoolDepartment)
{
	document.getElementById("removedPositionsSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removePositionDD.php",
		data: "removedPositionsSchoolDepartment="+removedPositionsSchoolDepartment,
		success: function(msg){ $("#removePositionForm").append(msg);}
	});
}


// Add Directory
function addDirectoryDDFunction(parent, parentDD)
{
	parentDD.disabled = true;
	document.getElementById("latestAddedDirectory").value = parentDD.value;
	$.ajax({
		type: "POST",
		url: "addDirectoryDD.php",
		data: "parent="+parent,
		success: function(msg){ $("#addDirectoryForm").append(msg);}
	});
}


// Remove Directory
function removeDirectoryDDFunction(parent, parentDD)
{
	parentDD.disabled = true;
	document.getElementById("latestRemovedDirectory").value = parent;
	$.ajax({
		type: "POST",
		url: "removeDirectoryDD.php",
		data: "parent="+parent,
		success: function(msg){ $("#removeDirectoryForm").append(msg);}
	});
}




// Add Owner
function addOwnersSchoolDepartmentDD(addedOwnersDivision)
{
	document.getElementById("addedOwnersDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "addOwner-Position-SchoolDepartment.php",
		data: "addedOwnersDivision="+addedOwnersDivision,
		success: function(msg){ $("#addOwnerForm").append(msg);}
	});
}

function addOwnerPositionDD(addedOwnersSchoolDepartment)
{
	document.getElementById("addedOwnersSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "addOwner-PositionDD.php",
		data: "addedOwnersSchoolDepartment="+addedOwnersSchoolDepartment,
		success: function(msg){ $("#addOwnerForm").append(msg);}
	});
}

function addOwnerParentDirectoryDDFunction(positionDD)
{
	latestOwnersPosition.value = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "addOwner-ParentDirectoryDD.php",
		success: function(msg){ $("#addOwnerForm").append(msg);}
	});
}

function addOwnerDirectoryDDFunction(parent, parentDD)
{
	parentDD.disabled = true;
	document.getElementById("latestOwnersDirectory").value = parentDD.value;
	$.ajax({
		type: "POST",
		url: "addOwner-DirectoryDD.php",
		data: "parent="+parent,
		success: function(msg){ $("#addOwnerForm").append(msg);}
	});
}


// Remove Owner
function removeOwnersSchoolDepartmentDD(removedOwnersDivision)
{
	document.getElementById("removedOwnersDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeOwner-Position-SchoolDepartment.php",
		data: "removedOwnersDivision="+removedOwnersDivision,
		success: function(msg){ $("#removeOwnerForm").append(msg);}
	});
}

function removeOwnerPositionDD(removedOwnersSchoolDepartment)
{
	document.getElementById("removedOwnersSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeOwner-PositionDD.php",
		data: "removedOwnersSchoolDepartment="+removedOwnersSchoolDepartment,
		success: function(msg){ $("#removeOwnerForm").append(msg);}
	});
}

function removeOwnerDirectoryDDFunction(positionDD)
{
	removedOwnersPosition = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "removeOwner-DirectoryDD.php",
		data: "removedOwnersPosition="+removedOwnersPosition,
		success: function(msg) { $("#removeOwnerForm").append(msg);}
	});
}

function removeOwnerEnable()
{
	document.getElementById("removedOwnersPosition").disabled = false;
}























