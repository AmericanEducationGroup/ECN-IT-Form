<?php 
	session_start();
	if(isset($_SESSION['admin']))
	{
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>ECN IT Administration</title>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../Javascript/administration.js"></script>
		<link href="../../CSS/administration.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
	<a href="webform.php">Web Form</a>
	<div class="styled-select" id="styled-select">
		<div class="title-wording">
		<a href="administration.php"><img src="../../Resources/AdministrationTitle.png" alt="Administrative Web Form" /></a>
		<h3>What administrative action would you like to take?</h3>
		</div>
		<select id="actionCategory" onchange="showActionOptions(this);">
			<option disabled selected style='display:none;'>Choose an action category.</option>
			<option value="general">General</option>
			<option value="source">Source</option>
			<option value="distributionGroups">Distribution Groups</option>
		</select>

			<!-- GENERAL -->
			<select id="generalOptions" onchange="showGeneralActionFields(this);" style="display: none;">
				<option disabled selected style='display:none;'>Choose an action.</option>
				<option value="addDivision">Add a division.</option>
				<option value="removeDivision">Remove a division.</option>
				<option value="addSchool">Add a school or department.</option>
				<option value="removeSchool">Remove a school or department.</option>
				<option value="addPosition">Add a position.</option>
				<option value="removePosition">Remove a position.</option>
			</select>

				<!-- Add Division -->
				<form id="addDivisionForm" action="../Add%20Division/add_division.php" method="post" style="display: none;">
					<br>What is the name of the new division? 									<input type="text" placeholder="Division name?" name="newDivision"/>
					<br><br><input type="submit" />
				</form>

				<!-- Remove Division -->
				<form id="removeDivisionForm" action="../Remove%20Division/remove_division.php" method="post" style="display: none;">
					<br>Which division would you like to remove?								<?php require '../Remove Division/removeDivisionDD.php'; ?>
					<br><br><input type="submit" />
				</form>

				<!-- Add School or Department -->
				<form id="addSchoolForm" action="../Add%20School/add_school.php" method="post" style="display: none;">
					<br>What is the name of the new school or department? 						<input type="text" placeholder="School name?" name="newSchool"/><br>
					<div id=addSchoolAbbrDiv>
						<br>What is the abbreviation of the new school (3 letters)? 				<input type="text" id="newSchoolAbbreviation" placeholder="School abbreviation?" name="newSchoolAbbreviation">
					</div>
					<br>What is the email domain of the new school?								<input type="text" id="newSchoolEmailDomain" placeholder="Email Domain?" name="newSchoolEmailDomain"><br>
					<br>What is the phone number of the new school?								<input type="text" id="newSchoolPhoneNumber" placeholder="Phone Number?" name="newSchoolPhoneNumber"><br>
					<br>Which division would you like to add a school/department to?			<?php require '../Add School/addSchool-DivisionDD.php'; ?>
					<br><br><input type="submit" />
				</form>

				<!-- Remove School or Department -->
				<form id="removeSchoolForm" action="../Remove%20School/remove_school.php" method="post" style="display: none;">
					<br>Which division is the school or department being removed from? 			 <?php require '../Remove School/removeSchool-DivisionDD.php'; ?><br>
				</form>

	
				<!-- Add Position -->
				<form onsubmit="document.getElementById('addedPositionsDivision').disabled = false;" id="addPositionForm" action="../Add%20Position/add_position.php" method="post" style="display: none;">
					<br>What is the name of the new position? 									<input type="text" placeholder="Position name?" id="newPosition" name="newPosition"/><br>
					<br>Which division is the position being added to? 			 				<?php require '../Add Position/addPosition-DivisionDD.php'; ?><br>
				</form>

				<!-- Remove Position -->
				<form id="removePositionForm" action="../Remove%20Position/remove_position.php" method="post" style="display: none;">
					<br>Which division is the position being removed from?		 				<?php require '../Remove Position/removePosition-DivisionDD.php'; ?><br>
				</form>
			
			

			
			<!-- SOURCE -->
			<select id="sourceOptions" onchange="showSourceActionFields(this);" style="display: none;">
				<option disabled selected style='display:none;'>Choose an action.</option>
				<option value="addDirectory">Add a Source directory.</option>
				<option value="removeDirectory">Remove a Source directory.</option>
				<option value="addOwner">Add a Source directory owner.</option>
				<option value="removeOwner">Remove a Source directory owner.</option>
				<option value="addReadPerm">Add Source directory read permissions.</option>
				<option value="removeReadPerm">Remove Source directory read permissions.</option>
				<option value="addEditPerm">Add Source directory edit permissions.</option>
				<option value="removeEditPerm">Remove Source directory edit permissions.</option>
			</select>
			
			
				<!-- Add Directory -->
				<form id="addDirectoryForm" action="../Add%20Directory/add_directory.php" method="post" style="display: none;">
					<br>What is the name of the new directory? 									<input type="text" placeholder="Directory name?" name="newDirectory"/><br>
																							<input type="text" placeholder="Latest" id="latestAddedDirectory" name="latestAddedDirectory" style="display: none;"/>
					<br>What is the new directory's parent directory?		 					<?php require '../Add Directory/addDirectory-ParentDD.php'; ?>
				</form>
			
			
				<!-- Remove Directory -->
				<form id="removeDirectoryForm" action="../Remove%20Directory/remove_directory.php" method="post" style="display: none;">
																							<input type="text" placeholder="Latest" id="latestRemovedDirectory" name="latestRemovedDirectory" style="display: none;"/>
					<br>What directory is being removed?		 								<?php require '../Remove Directory/removeDirectory-ParentDD.php'; ?>
				</form>
			
			
				<!-- Add Owner -->
				<form id="addOwnerForm" action="../Add%20Owner/add_owner.php" method="post" style="display: none;">
																							<input type="text" placeholder="" id="latestOwnersDirectory" name="latestOwnersDirectory" style="display: none;"/>
																							<input type="text" placeholder="" id="latestOwnersPosition" name="latestOwnersPosition" style="display: none;"/>
					<br>What division is the new owner in?		 								<?php require '../Add Owner/addOwner-Position-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Remove Owner -->
				<form id="removeOwnerForm" onsubmit="removeOwnerEnable();" action="../Remove%20Owner/remove_owner.php" method="post" style="display: none;">
					<br>What is the removed owner's division?	 								<?php require '../Remove Owner/removeOwner-Position-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Add Read Permissions -->
				<form id="addReadPermForm" action="../Add%20Read%20Permission/add_readPerm.php" method="post" style="display: none;">
																							<input type="text" placeholder="" id="newReadPermPosition" name="newReadPermPosition" style="display: none;"/>
																							<input type="text" placeholder="" id="newReadPermDirectory" name="newReadPermDirectory" style="display: none;"/>
					<br>What division is the position with new read permissions in?		 		<?php require '../Add Read Permission/addReadPerm-Position-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Remove Read Permissions -->
				<form id="removeReadPermForm" action="../Remove%20Read%20Permission/remove_readPerm.php" method="post" style="display: none;">
																							<input type="text" placeholder="" id="removedReadPermPosition" name="removedReadPermPosition" style="display: none;"/>
					<br>What is the division of the position losing read permissions?	 		<?php require '../Remove Read Permission/removeReadPerm-Position-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Add Edit Permissions -->
				<form id="addEditPermForm" action="../Add%20Edit%20Permission/add_editPerm.php" method="post" style="display: none;">
																							<input type="text" placeholder="" id="newEditPermPosition" name="newEditPermPosition" style="display: none;"/>
																							<input type="text" placeholder="" id="newEditPermDirectory" name="newEditPermDirectory" style="display: none;"/>
					<br>What division is the position with new edit permissions in?		 		<?php require '../Add Edit Permission/addEditPerm-Position-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Remove Edit Permissions -->
				<form id="removeEditPermForm" action="../Remove%20Edit%20Permission/remove_editPerm.php" method="post" style="display: none;">
																							<input type="text" placeholder="" id="removedEditPermPosition" name="removedEditPermPosition" style="display: none;"/>
					<br>What is the division of the position losing edit permissions?	 		<?php require '../Remove Edit Permission/removeEditPerm-Position-DivisionDD.php'; ?><br>
				</form>
		

			
			
			<!-- DISTRIBUTION GROUPS -->
			<select id="distGroupOptions" onchange="showDGActionFields(this);" style="display: none;">
				<option disabled selected style='display:none;'>Choose an action.</option>
				<option value="addDG">Add an email distribution group.</option>
				<option value="removeDG">Remove an email distribution group.</option>
				<option value="giveDGSend">Give new distribution group send permissions.</option>
				<option value="removeDGSend">Remove distribution group send permissions.</option>
				<option value="giveDGReceive">Give new distribution group receive permissions.</option>
				<option value="removeDGReceive">Remove distribution group receive permissions.</option>
			</select>
			
			
				<!-- Add Distribution Group -->
				<form id="addDGForm" action="../Add%20DG/add_DG.php" method="post" style="display: none;">
					<br>What is the name of the new Distribution Group? 						<input type="text" placeholder="Distribution Group name?" name="newDG"/>
					<br><br><input type="submit" />
				</form>
			
			
				<!-- Remove Distribution Group -->
				<form id="removeDGForm" action="../Remove%20DG/remove_DG.php" method="post" style="display: none;">
					<br>Which Distribution Group would you like to remove? 						<?php require '../Remove DG/removeDGDD.php'; ?><br>
					<br><br><input type="submit" />
				</form>
			
			
				<!-- Give Distribution Group Send Permissions -->
				<form id="giveDGSendForm" action="../Give%20DG%20Send%20Permission/give_DGSend.php" method="post" style="display: none;">
					<br>Which DG would you like to add Send permissions to? 					<?php require '../Give DG Send Permission/giveDGSendDD.php'; ?><br>
					<br>Which division is the position getting new DG Send permissions in?		<?php require '../Give DG Send Permission/giveDGSend-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Remove Distribution Group Send Permissions -->
				<form id="removeDGSendForm" action="../Remove%20DG%20Send%20Permission/remove_DGSend.php" method="post" style="display: none;">
					<br>Which division is the position losing DG Send permissions in?		<?php require '../Remove DG Send Permission/removeDGSend-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Give Distribution Group Receive Permissions -->
				<form id="giveDGReceiveForm" action="../Give%20DG%20Receive%20Permission/give_DGReceive.php" method="post" style="display: none;">
					<br>Which DG would you like to add Receive permissions to? 					<?php require '../Give DG Receive Permission/giveDGReceiveDD.php'; ?><br>
					<br>Which division is the position getting new DG Receive permissions in?		<?php require '../Give DG Receive Permission/giveDGReceive-DivisionDD.php'; ?><br>
				</form>
			
			
				<!-- Remove Distribution Group Receive Permissions -->
				<form id="removeDGReceiveForm" action="../Remove%20DG%20Receive%20Permission/remove_DGReceive.php" method="post" style="display: none;">
					<br>Which division is the position losing DG Receive permissions in?		<?php require '../Remove DG Receive Permission/removeDGReceive-DivisionDD.php'; ?><br>
				</form>

	</div>
	</body>
</html>

<?php 
	}
	else
	{
   		header( 'Location: login.php' ) ;
	}
?>
