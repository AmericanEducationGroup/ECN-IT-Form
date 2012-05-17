-- CREATE DATABASE  IF NOT EXISTS ecn_it_db
-- USE ecn_it_db;

-- Drop Tables
DROP TABLE IF EXISTS Receive_DG;
DROP TABLE IF EXISTS Send_To_DG;
DROP TABLE IF EXISTS Distribution_Groups;
DROP TABLE IF EXISTS Edit_Permissions;
DROP TABLE IF EXISTS Read_Permissions;
DROP TABLE IF EXISTS Source_Directories;
DROP TABLE IF EXISTS Owners;
DROP TABLE IF EXISTS Positions;
DROP TABLE IF EXISTS Schools_Departments;
DROP TABLE IF EXISTS Divisions;

-- Create Tables
CREATE TABLE Divisions(
	divisionID INT AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	PRIMARY KEY (divisionID),
	UNIQUE KEY (name)
);

CREATE TABLE Schools_Departments(
	schoolDepartmentID INT AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
  abbreviation VARCHAR(3),
	division INT NOT NULL,
	PRIMARY KEY (schoolDepartmentID),
	UNIQUE KEY (name),
	FOREIGN KEY (division) REFERENCES Divisions(divisionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Positions(
	positionID INT AUTO_INCREMENT,
	title VARCHAR(64) NOT NULL,
	division INT NOT NULL,
	school_department INT NOT NULL,
	PRIMARY KEY (positionID),
	UNIQUE KEY (title, division, school_department),
	FOREIGN KEY (division) REFERENCES Divisions(divisionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(school_department) REFERENCES Schools_Departments(schoolDepartmentID) ON UPDATE CASCADE ON DELETE CASCADE 
) ENGINE=InnoDB;

CREATE TABLE Owners(
	ownerID INT AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	email VARCHAR(128) NOT NULL,
	PRIMARY KEY (ownerID),
	UNIQUE KEY (name)
) ENGINE=InnoDB;

CREATE TABLE Source_Directories(
	sourceDirectoryID INT AUTO_INCREMENT,
	parent INT NOT NULL,
	owner INT NOT NULL,
	PRIMARY KEY (sourceDirectoryID),
	FOREIGN KEY (parent) REFERENCES Source_Directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (owner) REFERENCES Owners(ownerID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Read_Permissions(
	readPermissionID INT AUTO_INCREMENT,
	position INT NOT NULL,
	directory INT NOT NULL,
	PRIMARY KEY (readPermissionID),
	UNIQUE KEY (position, directory),
	FOREIGN KEY (position) REFERENCES Positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (directory) REFERENCES Source_Directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Edit_Permissions(
	editPermissionID INT AUTO_INCREMENT,
	position INT NOT NULL,
	directory INT NOT NULL,
	PRIMARY KEY (editPermissionID),
	UNIQUE KEY (position, directory),
	FOREIGN KEY (position) REFERENCES Positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (directory) REFERENCES Source_Directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Distribution_Groups(
	distributionGroupID INT AUTO_INCREMENT,
	PRIMARY KEY (distributionGroupID)
) ENGINE=InnoDB;

CREATE TABLE Send_To_DG(
	sendToDGID INT AUTO_INCREMENT,
	distributionGroup INT NOT NULL,
	position INT NOT NULL,
	PRIMARY KEY (sendToDGID),
	UNIQUE KEY (distributionGroup, position),
	FOREIGN KEY (distributionGroup) REFERENCES Distribution_Groups(distributionGroupID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (position) REFERENCES Positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Receive_DG(
	receiveDGID INT AUTO_INCREMENT,
	distributionGroup INT NOT NULL,
	position INT NOT NULL,
	PRIMARY KEY (receiveDGID),
	UNIQUE KEY (distributionGroup, position),
	FOREIGN KEY (distributionGroup) REFERENCES Distribution_Groups(distributionGroupID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (position) REFERENCES Positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Add data
-- Divisions
INSERT INTO Divisions (name) VALUES ("Corporate");      -- 1
INSERT INTO Divisions (name) VALUES ("Fusion");         -- 2
INSERT INTO Divisions (name) VALUES ("Lexis");          -- 3
INSERT INTO Divisions (name) VALUES ("Little Sprouts"); -- 4

-- Schools_Departments
--  Corporate
INSERT INTO Schools_Departments (name, division) VALUES ("Administration", 1);                                  -- 1
INSERT INTO Schools_Departments (name, division) VALUES ("Coaching and Learning", 1);                           -- 2
INSERT INTO Schools_Departments (name, division) VALUES ("Human Resources", 1);                                 -- 3
INSERT INTO Schools_Departments (name, division) VALUES ("Information Technology", 1);                          -- 4
INSERT INTO Schools_Departments (name, division) VALUES ("Finance", 1);                                         -- 5
INSERT INTO Schools_Departments (name, division) VALUES ("Marketing", 1);                                       -- 6
INSERT INTO Schools_Departments (name, division) VALUES ("New Business Development", 1);                        -- 7
INSERT INTO Schools_Departments (name, division) VALUES ("Procurement", 1);                                     -- 8
--  Fusion
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Huntington Beach", "HB", 2);     -- 9
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Los Angeles", "LA", 2);          -- 10
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Los Gatos", "LG", 2);            -- 11
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Mission Viejo", "MV", 2);        -- 12
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Pasadena", "PA", 2);             -- 13
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion San Diego", "SD", 2);            -- 14
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion San Francisco", "SF", 2);        -- 15
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion San Mateo", "SM", 2);            -- 16
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion South Bay", "SB", 2);            -- 17
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Solana Beach", "SLB", 2);        -- 18
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Walnut Creek", "WCR", 2);        -- 19
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Warner Center", "WC", 2);        -- 20
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Manhattan", "MN", 2);            -- 21
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion New York", "NY", 2);             -- 22
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Westchester", "WE", 2);          -- 23
--  Lexis
INSERT INTO Schools_Departments (name, division) VALUES ("Barnstable Academy", 3);                              -- 24
INSERT INTO Schools_Departments (name, division) VALUES ("Lexis Preparatory School", 3);                        -- 25
INSERT INTO Schools_Departments (name, division) VALUES ("Shreiner Academy", 3);                                -- 26
INSERT INTO Schools_Departments (name, division) VALUES ("Tampa Day School", 3);                                -- 27
--  Little Sprouts
INSERT INTO Schools_Departments (name, division) VALUES ("Amesbury", 4);                                        -- 28
INSERT INTO Schools_Departments (name, division) VALUES ("Andover", 4);                                         -- 29
INSERT INTO Schools_Departments (name, division) VALUES ("Andover Industrial", 4);                              -- 30
INSERT INTO Schools_Departments (name, division) VALUES ("Brighton", 4);                                        -- 31
INSERT INTO Schools_Departments (name, division) VALUES ("Dedham", 4);                                          -- 32
INSERT INTO Schools_Departments (name, division) VALUES ("Haverhill", 4);                                       -- 33
INSERT INTO Schools_Departments (name, division) VALUES ("Haverhill NECC", 4);                                  -- 34
INSERT INTO Schools_Departments (name, division) VALUES ("Lawrence", 4);                                        -- 35
INSERT INTO Schools_Departments (name, division) VALUES ("Lowell", 4);                                          -- 36
INSERT INTO Schools_Departments (name, division) VALUES ("Methuen", 4);                                         -- 37
INSERT INTO Schools_Departments (name, division) VALUES ("North Andover", 4);                                   -- 38
INSERT INTO Schools_Departments (name, division) VALUES ("Roxbury RCC", 4);                                     -- 39
INSERT INTO Schools_Departments (name, division) VALUES ("Wilmington", 4);                                      -- 40
INSERT INTO Schools_Departments (name, division) VALUES ("Woburn", 4);                                          -- 41
INSERT INTO Schools_Departments (name, division) VALUES ("Boston", 4);                                          -- 42
INSERT INTO Schools_Departments (name, division) VALUES ("Nashua", 4);                                          -- 43

-- Positions
--  Corporate
--    Administration
INSERT INTO Positions (title, division, school_department) VALUES ("President", 1, 1);
INSERT INTO Positions (title, division, school_department) VALUES ("CEO", 1, 1);
INSERT INTO Positions (title, division, school_department) VALUES ("Senior Vice President", 1, 1);
INSERT INTO Positions (title, division, school_department) VALUES ("COO of Fusion", 1, 1);
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Assistant", 1, 1);
INSERT INTO Positions (title, division, school_department) VALUES ("DePauw Intern", 1, 1);
--    Coaching and Learning
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);
INSERT INTO Positions (title, division, school_department) VALUES ("", 1, 2);