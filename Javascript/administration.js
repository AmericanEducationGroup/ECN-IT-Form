
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
	if(document.getElementById("addReadPermForm") != null)
		document.getElementById("addReadPermForm").style.display = 'none';
	if(document.getElementById("removeReadPermForm") != null) 
		document.getElementById("removeReadPermForm").style.display = 'none';
	if(document.getElementById("addEditPermForm") != null) 
		document.getElementById("addEditPermForm").style.display = 'none';
	if(document.getElementById("removeEditPermForm") != null) 
		document.getElementById("removeEditPermForm").style.display = 'none';
	if(document.getElementById("addDGForm") != null) 
		document.getElementById("addDGForm").style.display = 'none';
	if(document.getElementById("removeDGForm") != null) 
		document.getElementById("removeDGForm").style.display = 'none';
	if(document.getElementById("giveDGSendForm") != null) 
		document.getElementById("giveDGSendForm").style.display = 'none';
	if(document.getElementById("removeDGSendForm") != null) 
		document.getElementById("removeDGSendForm").style.display = 'none';
	if(document.getElementById("giveDGReceiveForm") != null) 
		document.getElementById("giveDGReceiveForm").style.display = 'none';
	if(document.getElementById("removeDGReceiveForm") != null) 
		document.getElementById("removeDGReceiveForm").style.display = 'none';
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


function showDGActionFields(dgAction)
{
	hideAllActionFields();
	var action = dgAction.options[dgAction.selectedIndex].value;
	if(action == "addDG")
	{
		document.getElementById("addDGForm").style.display = 'block';
	}
	if(action == "removeDG")
	{
		document.getElementById("removeDGForm").style.display = 'block';
	}
	if(action == "giveDGSend")
	{
		document.getElementById("giveDGSendForm").style.display = 'block';
	}
	if(action == "removeDGSend")
	{
		document.getElementById("removeDGSendForm").style.display = 'block';
	}
	if(action == "giveDGReceive")
	{
		document.getElementById("giveDGReceiveForm").style.display = 'block';
	}
	if(action == "removeDGReceive")
	{
		document.getElementById("removeDGReceiveForm").style.display = 'block';
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
	else if(action == "addReadPerm")
	{
		document.getElementById("addReadPermForm").style.display = 'block';
	}
	else if(action == "removeReadPerm")
	{
		document.getElementById("removeReadPermForm").style.display = 'block';
	}
	else if(action == "addEditPerm")
	{
		document.getElementById("addEditPermForm").style.display = 'block';
	}
	else if(action == "removeEditPerm")
	{
		document.getElementById("removeEditPermForm").style.display = 'block';
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





// Add Read Permissions
function addReadPermSchoolDepartmentDD(addedReadPermsDivision)
{
	document.getElementById("addedReadPermDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "addReadPerm-Position-SchoolDepartmentDD.php",
		data: "addedReadPermsDivision="+addedReadPermsDivision,
		success: function(msg){ $("#addReadPermForm").append(msg);}
	});
}

function addReadPermPositionDD(addedReadPermsSchoolDepartment)
{
	document.getElementById("addReadPermSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "addReadPerm-PositionDD.php",
		data: "addedReadPermsSchoolDepartment="+addedReadPermsSchoolDepartment,
		success: function(msg){ $("#addReadPermForm").append(msg);}
	});
}

function addReadPermParentDirectoryDDFunction(positionDD)
{
	newReadPermPosition.value = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "addReadPerm-ParentDirectoryDD.php",
		success: function(msg){ $("#addReadPermForm").append(msg);}
	});
}

function addReadPermDirectoryDDFunction(parent, parentDD)
{
	parentDD.disabled = true;
	document.getElementById("newReadPermDirectory").value = parentDD.value;
	$.ajax({
		type: "POST",
		url: "addReadPerm-DirectoryDD.php",
		data: "parent="+parent,
		success: function(msg){ $("#addReadPermForm").append(msg);}
	});
}


// Remove Read Permissions
function removeReadPermSchoolDepartmentDD(removeReadPermsDivision)
{
	document.getElementById("removedReadPermsDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeReadPerm-Position-SchoolDepartment.php",
		data: "removeReadPermsDivision="+removeReadPermsDivision,
		success: function(msg){ $("#removeReadPermForm").append(msg);}
	});
}

function removeReadPermPositionDD(removedReadPermSchoolDepartment)
{
	document.getElementById("removedReadPermsSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeReadPerm-PositionDD.php",
		data: "removedReadPermSchoolDepartment="+removedReadPermSchoolDepartment,
		success: function(msg){ $("#removeReadPermForm").append(msg);}
	});
}

function removeReadPermDirectoryDDFunction(positionDD)
{
	document.getElementById("removedReadPermPosition").value = positionDD.value;
	removedReadPermsPosition = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "removeReadPerm-DirectoryDD.php",
		data: "removedReadPermsPosition="+removedReadPermsPosition,
		success: function(msg) { $("#removeReadPermForm").append(msg);}
	});
}





// Add Edit Permissions
function addEditPermSchoolDepartmentDD(addedEditPermsDivision)
{
	document.getElementById("addedEditPermDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "addEditPerm-Position-SchoolDepartmentDD.php",
		data: "addedEditPermsDivision="+addedEditPermsDivision,
		success: function(msg){ $("#addEditPermForm").append(msg);}
	});
}

function addEditPermPositionDD(addedEditPermsSchoolDepartment)
{
	document.getElementById("addEditPermSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "addEditPerm-PositionDD.php",
		data: "addedEditPermsSchoolDepartment="+addedEditPermsSchoolDepartment,
		success: function(msg){ $("#addEditPermForm").append(msg);}
	});
}

function addEditPermParentDirectoryDDFunction(positionDD)
{
	newEditPermPosition.value = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "addEditPerm-ParentDirectoryDD.php",
		success: function(msg){ $("#addEditPermForm").append(msg);}
	});
}

function addEditPermDirectoryDDFunction(parent, parentDD)
{
	parentDD.disabled = true;
	document.getElementById("newEditPermDirectory").value = parentDD.value;
	$.ajax({
		type: "POST",
		url: "addEditPerm-DirectoryDD.php",
		data: "parent="+parent,
		success: function(msg){ $("#addEditPermForm").append(msg);}
	});
}


// Remove Edit Permissions
function removeEditPermSchoolDepartmentDD(removeEditPermsDivision)
{
	document.getElementById("removedEditPermsDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeEditPerm-Position-SchoolDepartment.php",
		data: "removeEditPermsDivision="+removeEditPermsDivision,
		success: function(msg){ $("#removeEditPermForm").append(msg);}
	});
}

function removeEditPermPositionDD(removedEditPermSchoolDepartment)
{
	document.getElementById("removedEditPermsSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeEditPerm-PositionDD.php",
		data: "removedEditPermSchoolDepartment="+removedEditPermSchoolDepartment,
		success: function(msg){ $("#removeEditPermForm").append(msg);}
	});
}

function removeEditPermDirectoryDDFunction(positionDD)
{
	document.getElementById("removedEditPermPosition").value = positionDD.value;
	removedEditPermsPosition = positionDD.value;
	positionDD.disabled = true;
	$.ajax({
		type: "POST",
		url: "removeEditPerm-DirectoryDD.php",
		data: "removedEditPermsPosition="+removedEditPermsPosition,
		success: function(msg) { $("#removeEditPermForm").append(msg);}
	});
}



// Give DG Send Permissions
function giveDGSendDepartmentSchoolDD(givenDGSendDivision)
{
	document.getElementById("giveDGSendDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "giveDGSend-SchoolDepartmentDD.php",
		data: "givenDGSendDivision="+givenDGSendDivision,
		success: function(msg){ $("#giveDGSendForm").append(msg);}
	});
}

function giveDGSendPositionDD(givenDGSendSchoolDepartment)
{
	document.getElementById("giveDGSendSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "giveDGSend-PositionDD.php",
		data: "givenDGSendSchoolDepartment="+givenDGSendSchoolDepartment,
		success: function(msg){ $("#giveDGSendForm").append(msg);}
	});
}



// Remove DG Send Permissions
function removeDGSendDepartmentSchoolDD(removedDGSendDivision)
{
	document.getElementById("removeDGSendDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeDGSend-SchoolDepartmentDD.php",
		data: "removedDGSendDivision="+removedDGSendDivision,
		success: function(msg){ $("#removeDGSendForm").append(msg);}
	});
}

function removeDGSendPositionDD(removedDGSendSchoolDepartment)
{
	document.getElementById("removeDGSendSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeDGSend-PositionDD.php",
		data: "removedDGSendSchoolDepartment="+removedDGSendSchoolDepartment,
		success: function(msg){ $("#removeDGSendForm").append(msg);}
	});
}

function removeDGSendDGDD(removedDGSendPosition)
{
	document.getElementById("removeDGSendPosition").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeDGSendDGDD.php",
		data: "removedDGSendPosition="+removedDGSendPosition,
		success: function(msg){ $("#removeDGSendForm").append(msg);}
	});
}



// Give DG Receive Permissions
function giveDGReceiveDepartmentSchoolDD(givenDGReceiveDivision)
{
	document.getElementById("giveDGReceiveDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "giveDGReceive-SchoolDepartmentDD.php",
		data: "givenDGReceiveDivision="+givenDGReceiveDivision,
		success: function(msg){ $("#giveDGReceiveForm").append(msg);}
	});
}

function giveDGReceivePositionDD(givenDGReceiveSchoolDepartment)
{
	document.getElementById("giveDGReceiveSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "giveDGReceive-PositionDD.php",
		data: "givenDGReceiveSchoolDepartment="+givenDGReceiveSchoolDepartment,
		success: function(msg){ $("#giveDGReceiveForm").append(msg);}
	});
}



// Remove DG Receive Permissions
function removeDGReceiveDepartmentSchoolDD(removedDGReceiveDivision)
{
	document.getElementById("removeDGReceiveDivision").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeDGReceive-SchoolDepartmentDD.php",
		data: "removedDGReceiveDivision="+removedDGReceiveDivision,
		success: function(msg){ $("#removeDGReceiveForm").append(msg);}
	});
}

function removeDGReceivePositionDD(removedDGReceiveSchoolDepartment)
{
	document.getElementById("removeDGReceiveSchoolDepartment").disabled = true;
	$.ajax({
		type: "POST",
		url: "removeDGReceive-PositionDD.php",
		data: "removedDGReceiveSchoolDepartment="+removedDGReceiveSchoolDepartment,
		success: function(msg){ $("#removeDGReceiveForm").append(msg);}
	});
}

function removeDGReceiveDGDD(removedDGReceivePosition)
{
	document.getElementById("removeDGReceivePosition").disabled = true;
	$.ajax({

		type: "POST",
		url: "removeDGReceiveDGDD.php",
		data: "removedDGReceivePosition="+removedDGReceivePosition,
		success: function(msg){ $("#removeDGReceiveForm").append(msg);}
	});
}


















