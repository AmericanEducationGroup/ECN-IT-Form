DROP PROCEDURE IF EXISTS insert_directory_owner;
DROP PROCEDURE IF EXISTS insert_distribution_groups;
DROP PROCEDURE IF EXISTS insert_divisions;
DROP PROCEDURE IF EXISTS insert_edit_permissions;
DROP PROCEDURE IF EXISTS insert_positions;
DROP PROCEDURE IF EXISTS insert_read_permissions;
DROP PROCEDURE IF EXISTS insert_receive_dg;
DROP PROCEDURE IF EXISTS insert_school;
DROP PROCEDURE IF EXISTS insert_department;
DROP PROCEDURE IF EXISTS insert_send_to_dg;
DROP PROCEDURE IF EXISTS insert_source_directories;

DROP PROCEDURE IF EXISTS remove_directory_owner;
DROP PROCEDURE IF EXISTS remove_distribution_groups;
DROP PROCEDURE IF EXISTS remove_divisions;
DROP PROCEDURE IF EXISTS remove_edit_permissions;
DROP PROCEDURE IF EXISTS remove_positions;
DROP PROCEDURE IF EXISTS remove_read_permissions;
DROP PROCEDURE IF EXISTS remove_receive_dg;
DROP PROCEDURE IF EXISTS remove_schools_departments;
DROP PROCEDURE IF EXISTS remove_send_to_dg;
DROP PROCEDURE IF EXISTS remove_source_directories;

DROP PROCEDURE IF EXISTS viewAll_directory_owner;
DROP PROCEDURE IF EXISTS viewAll_distribution_groups;
DROP PROCEDURE IF EXISTS viewAll_divisions;
DROP PROCEDURE IF EXISTS viewAll_edit_permissions;
DROP PROCEDURE IF EXISTS viewAll_positions;
DROP PROCEDURE IF EXISTS viewAll_read_permissions;
DROP PROCEDURE IF EXISTS viewAll_receive_dg;
DROP PROCEDURE IF EXISTS viewAll_schools_departments;
DROP PROCEDURE IF EXISTS viewAll_send_to_dg;
DROP PROCEDURE IF EXISTS viewAll_source_directories;

DROP PROCEDURE IF EXISTS viewSchools_Departments_Names_By_Division;

DELIMITER //

CREATE PROCEDURE insert_directory_owner(IN pDirectory INT, pOwner_Position INT)
BEGIN
INSERT INTO directory_owner (directory, owner_position) VALUES (pDirectory, pOwner_Position);
END //

CREATE PROCEDURE insert_distribution_groups(IN pDGName VARCHAR(64))
BEGIN
INSERT INTO distribution_groups (dgName) VALUES (pDGName);
END //

CREATE PROCEDURE insert_divisions(IN pName VARCHAR(64))
BEGIN
INSERT INTO divisions (name) VALUES (pName);
END //

CREATE PROCEDURE insert_edit_permissions(IN pPosition INT, IN pDirectory INT)
BEGIN
INSERT INTO edit_permissions (position, directory) VALUES (pPosition, pDirectory);
END //

CREATE PROCEDURE insert_positions(IN pTitle VARCHAR(64), IN pDivision INT, IN pSchool_Department INT)
BEGIN
INSERT INTO positions (title, division, school_department) VALUES (pTitle, pDivision, pSchool_Department);
END //

CREATE PROCEDURE insert_read_permissions(IN pPosition INT, IN pDirectory INT)
BEGIN
INSERT INTO read_permissions (position, directory) VALUES (pPosition, pDirectory);
END //

CREATE PROCEDURE insert_receive_dg(IN pDistributionGroup INT, IN pPosition INT)
BEGIN
INSERT INTO receive_dg (distributionGroup, position) VALUES (pDistributionGroup, pPosition);
END //

CREATE PROCEDURE insert_school(IN pName VARCHAR(64), IN pAbbreviation VARCHAR(3), IN pDivision INT, IN pEmailDomain VARCHAR(64))
BEGIN
INSERT INTO schools_departments (name, abbreviation, division, emailDomain) VALUES (pName, pAbbreviation, pDivision, pEmailDomain);
END //

CREATE PROCEDURE insert_department(IN pName VARCHAR(64), IN pDivision INT)
BEGIN
INSERT INTO schools_departments (name, division) VALUES (pName, pDivision);
END //

CREATE PROCEDURE insert_send_to_dg(IN pDistributionGroup INT, IN pPosition INT)
BEGIN
INSERT INTO send_to_dg (distributionGroup, position) VALUES (pDistributionGroup, pPosition);
END //

CREATE PROCEDURE insert_source_directories(IN pName VARCHAR(128), IN pParent INT)
BEGIN
INSERT INTO source_directories (name, parent) VALUES (pName, pParent);
END //

CREATE PROCEDURE remove_directory_owner(IN pID INT)
BEGIN
DELETE FROM directory_owner WHERE pID = directoryOwnerID;
END //

CREATE PROCEDURE remove_distribution_groups(IN pID INT)
BEGIN
DELETE FROM distribution_groups WHERE pID = distributionGroupID;
END //

CREATE PROCEDURE remove_divisions(IN pID INT)
BEGIN
DELETE FROM divisions WHERE pID = divisionID;
END //

CREATE PROCEDURE remove_edit_permissions(IN pID INT)
BEGIN
DELETE FROM edit_permissions WHERE pID = editPermissionID;
END //

CREATE PROCEDURE remove_positions(IN pID INT)
BEGIN
DELETE FROM positions WHERE pID = positionID;
END //

CREATE PROCEDURE remove_read_permissions(IN pID INT)
BEGIN
DELETE FROM read_permissions WHERE pID = readPermissionID;
END //

CREATE PROCEDURE remove_receive_dg(IN pID INT)
BEGIN
DELETE FROM receive_dg WHERE pID = receiveDGID;
END //

CREATE PROCEDURE remove_schools_departments(IN pName VARCHAR(64))
BEGIN
DELETE FROM schools_departments WHERE pName = name;
END //

CREATE PROCEDURE remove_send_to_dg(IN pID INT)
BEGIN
DELETE FROM send_to_dg WHERE pID = sendToDGID;
END //

CREATE PROCEDURE remove_source_directories(IN pID INT)
BEGIN
DELETE FROM source_directories WHERE pID = sourceDirectoryID;
END //

CREATE PROCEDURE viewAll_directory_owner()
BEGIN
SELECT * FROM directory_owner;
END //

CREATE PROCEDURE viewAll_distribution_groups()
BEGIN
SELECT * FROM distribution_groups;
END //

CREATE PROCEDURE viewAll_divisions()
BEGIN
SELECT * FROM divisions;
END //

CREATE PROCEDURE viewAll_edit_permissions()
BEGIN
SELECT * FROM edit_permissions;
END //

CREATE PROCEDURE viewAll_positions()
BEGIN
SELECT * FROM positions;
END //

CREATE PROCEDURE viewAll_read_permissions()
BEGIN
SELECT * FROM read_permissions;
END //

CREATE PROCEDURE viewAll_receive_dg()
BEGIN
SELECT * FROM receive_dg;
END //

CREATE PROCEDURE viewAll_schools_departments()
BEGIN
SELECT * FROM schools_departments;
END //

CREATE PROCEDURE viewAll_send_to_dg()
BEGIN
SELECT * FROM send_to_dg;
END //

CREATE PROCEDURE viewAll_source_directories()
BEGIN
SELECT * FROM source_directories;
END //

CREATE PROCEDURE viewSchools_Departments_Names_By_Division(IN pDivision INT)
BEGIN
SELECT name FROM schools_departments WHERE division = pDivision;
END //

DELIMITER ;



























