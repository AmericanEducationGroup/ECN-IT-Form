<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="Javascript/administration.js"></script>
	</head>

	<h1>ECN IT Administration</h1>

	<h3>What administrative action would you like to take?</h3>
	<select id="actionCategory" onchange="showActionOptions(this)"">
		<option disabled selected style='display:none;'>Choose an action category.</option>
		<option value="general"">General</option>
		<option value="source">Source</option>
		<option value="distributionGroups">Distribution Groups</option>
	</select>

		<!-- GENERAL -->
		<select id="generalOptions" onchange="showGeneralActionFields(this)" style="display: none;">
			<option disabled selected style='display:none;'>Choose an action.</option>
			<option value="addDivision">Add a division.</option>
			<option value="removeDivision">Remove a division.</option>
			<option value="addSchool">Add a school or department.</option>
			<option value="removeSchool">Remove a school or department.</option>
			<option value="addPosition">Add a position.</option>
			<option value="removePosition">Remove a position.</option>
		</select>

			<!-- Add Division -->
			<form id="addDivisionForm" action="add_division.php" method="post" style="display: none;">
				What is the name of the new division? 									<input type="text" placeholder="Division name?" name="newDivision"/>
				<input type="submit" />
			</form>

			<!-- Remove Division -->
			<form id="removeDivisionForm" action="remove_division.php" method="post" style="display: none;">
				Which division would you like to remove?								<?php require 'removeDivisionDD.php'; ?>
				<input type="submit" />
			</form>
			
			<!-- Add School or Department-->
			<form id="addSchoolForm" action="add_school.php" method="post" style="display: none;">
				What is the name of the new school or department? 						<input type="text" placeholder="School name?" name="newSchool"/><br>
				What is the abbreviation of the new school (3 letters)? 				<input type="text" id="schoolAbbrv" placeholder="School abbreviation?" name="newSchoolAbbreviation"/><br>
				Which division would you like to add a school/department to?			<?php require 'addSchool-DivisionDD.php'; ?>
				<input type="submit" />
			</form>
			
			<!-- Remove School or Department -->
			<form id="removeSchoolForm" action="remove_school.php" method="post" style="display: none;">
				Which division is the school or department being removed from? 			 <?php require 'removeSchool-DivisionDD.php'; ?><br>
			</form>
						
			
			<!-- Add Position -->
			<form onsubmit="document.getElementById('addedPositionsDivision').disabled = false;" id="addPositionForm" action="add_position.php" method="post" style="display: none;">
				What is the name of the new position? 									<input type="text" placeholder="Position name?" id="newPosition" name="newPosition"/><br>
				Which division is the position being added to? 			 				<?php require 'addPosition-DivisionDD.php'; ?><br>
			</form>
			
			
			<!-- Remove Position -->
			<form id="removePositionForm" action="remove_position.php" method="post" style="display: none;">
				Which division is the position being removed from?		 				<?php require 'removePosition-DivisionDD.php'; ?><br>
			</form>
			
						

			
		<!-- SOURCE -->
		<select id="sourceOptions" onchange="showSourceActionFields(this)" style="display: none;">
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
			<form id="addDirectoryForm" action="add_directory.php" method="post" style="display: none;">
				What is the name of the new directory? 									<input type="text" placeholder="Directory name?" name="newDirectory"/><br>
																						<input type="text" placeholder="Latest" id="latestAddedDirectory" name="latestAddedDirectory" style="display: none;"/>
				<input type="submit" />
				What is the new directory's parent directory?		 					<?php require 'addDirectory-ParentDD.php'; ?>
			</form>
			
			
			<!-- Remove Directory -->
			<form id="removeDirectoryForm" action="remove_directory.php" method="post" style="display: none;">
																						<input type="text" placeholder="Latest" id="latestRemovedDirectory" name="latestRemovedDirectory" style="display: none;"/>
				<input type="submit" />
				What directory is being removed?		 								<?php require 'removeDirectory-ParentDD.php'; ?>
			</form>
			
			
			<!-- Add Owner -->
			<form id="addOwnerForm" action="add_owner.php" method="post" style="display: none;">
																						<input type="text" placeholder="" id="latestOwnersDirectory" name="latestOwnersDirectory" style="display: none;"/>
																						<input type="text" placeholder="" id="latestOwnersPosition" name="latestOwnersPosition" style="display: none;"/>
				What division is the new owner in?		 								<?php require 'addOwner-Position-DivisionDD.php'; ?><br>
			</form>
			
			
			<!-- Remove Owner -->
			<form id="removeOwnerForm" onsubmit="removeOwnerEnable();" action="remove_owner.php" method="post" style="display: none;">
				What is the removed owner's division?	 								<?php require 'removeOwner-Position-DivisionDD.php'; ?><br>
			</form>
			
			
			<!-- Add Read Permissions -->
			
			
			<!-- Remove Read Permissions -->
			
			
			<!-- Add Edit Permissions -->
			
			
			<!-- Remove Edit Permissions -->
			
			
		<!-- DISTRIBUTION GROUPS -->
		<select id="distGroupOptions" onchange="" style="display: none;">
			<option disabled selected style='display:none;'>Choose an action.</option>
			<option value="addDG">Add an email distribution group.</option>
			<option value="removeDG">Remove an email distribution group.</option>
			<option value="giveDGSend">Give new distribution group send permissions.</option>
			<option value="removeDGSend">Remove distribution group send permissions.</option>
			<option value="giveDGReceive">Give new distribution group receive permissions.</option>
			<option value="removeDGReceive">Remove distribution group receive permissions.</option>
		</select>


	<!-- JAVASCRIPT -->


<!-- 
	<form action="add_division.php" method="post">
		New Division: <input type="text" name="newDivision" />
		<input type="submit" />
	</form>
-->


</html>
