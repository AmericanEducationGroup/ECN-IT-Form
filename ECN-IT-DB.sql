-- CREATE DATABASE  IF NOT EXISTS ecn_it_db
-- USE ecn_it_db;

-- Drop Tables

DROP TABLE IF EXISTS Receive_DG;
DROP TABLE IF EXISTS Send_To_DG;
DROP TABLE IF EXISTS Distribution_Groups;
DROP TABLE IF EXISTS Edit_Permissions;
DROP TABLE IF EXISTS Read_Permissions;
DROP TABLE IF EXISTS Directory_Owner;
DROP TABLE IF EXISTS Source_Directories;
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

CREATE TABLE Source_Directories(
	sourceDirectoryID INT AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	parent INT NOT NULL,
	UNIQUE KEY (name, parent),
	PRIMARY KEY (sourceDirectoryID),
	FOREIGN KEY (parent) REFERENCES Source_Directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Directory_Owner(
	directoryOwnerID INT AUTO_INCREMENT,
	directory INT NOT NULL,
	owner_position INT NOT NULL,
	PRIMARY KEY (directoryOwnerID),
	UNIQUE KEY (directory, owner_position),
	FOREIGN KEY (directory) REFERENCES Source_Directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (owner_position) REFERENCES Positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
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
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Long Island", "LI", 2);             -- 22
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Westchester", "WE", 2);          -- 23
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Regional", "WE", 2);             -- 24
--  Lexis
INSERT INTO Schools_Departments (name, division) VALUES ("Barnstable Academy", 3);                              -- 25
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
INSERT INTO Schools_Departments (name, division) VALUES ("Little Sprouts Corporate", 4);                        -- 44

-- Positions
--  Corporate
--    Administration
INSERT INTO Positions (title, division, school_department) VALUES ("President", 1, 1);                                  -- 1
INSERT INTO Positions (title, division, school_department) VALUES ("CEO", 1, 1);                                        -- 2
INSERT INTO Positions (title, division, school_department) VALUES ("Senior Vice President", 1, 1);                      -- 3 
INSERT INTO Positions (title, division, school_department) VALUES ("COO of Fusion", 1, 1);                              -- 4
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Assistant", 1, 1);                        -- 5
INSERT INTO Positions (title, division, school_department) VALUES ("DePauw Intern", 1, 1);                              -- 6
--    Coaching and Learning
INSERT INTO Positions (title, division, school_department) VALUES ("VP of Education", 1, 2);                            -- 7
INSERT INTO Positions (title, division, school_department) VALUES ("General Manager of Lexis", 1, 2);                   -- 8
INSERT INTO Positions (title, division, school_department) VALUES ("Education Manager", 1, 2);                          -- 9
INSERT INTO Positions (title, division, school_department) VALUES ("New Talent Coordinator", 1, 2);                     -- 10
--    Human Resources
INSERT INTO Positions (title, division, school_department) VALUES ("VP of Human Resources", 1, 3);                      -- 11
INSERT INTO Positions (title, division, school_department) VALUES ("Human Resources Manager", 1, 3);                    -- 12
INSERT INTO Positions (title, division, school_department) VALUES ("Human Resources Associate", 1, 3);                  -- 13
--    Information Technology
INSERT INTO Positions (title, division, school_department) VALUES ("IT Manager", 1, 4);                                 -- 14
INSERT INTO Positions (title, division, school_department) VALUES ("IT Intern", 1, 4);                                  -- 15
--    Finance
INSERT INTO Positions (title, division, school_department) VALUES ("Vice President of Finance", 1, 5);                  -- 16
INSERT INTO Positions (title, division, school_department) VALUES ("CFO", 1, 5);                                        -- 17
INSERT INTO Positions (title, division, school_department) VALUES ("Corporate Controller", 1, 5);                       -- 18
INSERT INTO Positions (title, division, school_department) VALUES ("Accounting Associate", 1, 5);                       -- 19
INSERT INTO Positions (title, division, school_department) VALUES ("Accounts Payable Specialist", 1, 5);                -- 20
INSERT INTO Positions (title, division, school_department) VALUES ("Accounting Temp", 1, 5);                            -- 21
INSERT INTO Positions (title, division, school_department) VALUES ("Accounting Intern", 1, 5);                          -- 22
--    Marketing
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Marketing", 1, 6);                      -- 23
INSERT INTO Positions (title, division, school_department) VALUES ("Marketing Manager", 1, 6);                          -- 24
INSERT INTO Positions (title, division, school_department) VALUES ("Marketing Specialist", 1, 6);                       -- 25
INSERT INTO Positions (title, division, school_department) VALUES ("SEM Marketing Analyst", 1, 6);                      -- 26
INSERT INTO Positions (title, division, school_department) VALUES ("Marketing PPC", 1, 6);                              -- 27
INSERT INTO Positions (title, division, school_department) VALUES ("Marketing Intern", 1, 6);                           -- 28
INSERT INTO Positions (title, division, school_department) VALUES ("Social Media Intern", 1, 6);                        -- 29
INSERT INTO Positions (title, division, school_department) VALUES ("Marketing Consultant", 1, 6);                       -- 30
--    New Business Development
INSERT INTO Positions (title, division, school_department) VALUES ("Vice President of New Business Development", 1, 7); -- 31
INSERT INTO Positions (title, division, school_department) VALUES ("School Launch Manager", 1, 7);                      -- 32
--    Procurement
INSERT INTO Positions (title, division, school_department) VALUES ("Administrative Assistant", 1, 8);                   -- 33
--  Fusion
--    Fusion Huntington Beach
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 9);                         -- 34
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 9);                                  -- 35
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 9);      -- 36
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 9);              -- 37
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 9);            -- 38
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 9);                       -- 39
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 9);                              -- 40
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 9);                             -- 41
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 9);                     -- 42
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 9);                             -- 43
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 9);                                  -- 44
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 9);                         -- 45
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 9);                                    -- 46
--    Fusion Los Angeles
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 10);                        -- 47
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 10);                                 -- 48
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 10);     -- 49
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 10);             -- 50
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 10);           -- 51
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 10);                      -- 52
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 10);                             -- 53
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 10);                            -- 54
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 10);                    -- 55
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 10);                            -- 56
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 10);                                 -- 57
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 10);                        -- 58
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 10);                                   -- 59
--    Fusion Los Gatos
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 11);                        -- 60
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 11);                                 -- 61
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 11);     -- 62
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 11);             -- 63
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 11);           -- 64
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 11);                      -- 65
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 11);                             -- 66
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 11);                            -- 67
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 11);                    -- 68
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 11);                            -- 69
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 11);                                 -- 70
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 11);                        -- 71
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 11);                                   -- 72
--    Fusion Mission Viejo
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 12);                        -- 73
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 12);                                 -- 74
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 12);     -- 75
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 12);             -- 76
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 12);           -- 77
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 12);                      -- 78
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 12);                             -- 79
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 12);                            -- 80
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 12);                    -- 81
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 12);                            -- 82
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 12);                                 -- 83
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 12);                        -- 84
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 12);                                   -- 85
--    Fusion Pasadena
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 13);                        -- 86
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 13);                                 -- 87
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 13);     -- 88
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 13);             -- 89
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 13);           -- 90
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 13);                      -- 91
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 13);                             -- 92
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 13);                            -- 93
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 13);                    -- 94
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 13);                            -- 95
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 13);                                 -- 96
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 13);                        -- 97
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 13);                                   -- 98
--    Fusion San Diego
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 14);                        -- 99
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 14);                                 -- 100
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 14);     -- 101
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 14);             -- 102
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 14);           -- 103
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 14);                      -- 104
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 14);                             -- 105
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 14);                            -- 106
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 14);                    -- 107
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 14);                            -- 108
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 14);                                 -- 109
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 14);                        -- 110
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 14);                                   -- 111
--    Fusion San Francisco
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 15);                        -- 112
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 15);                                 -- 113
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 15);     -- 114
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 15);             -- 115
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 15);           -- 116
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 15);                      -- 117
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 15);                             -- 118
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 15);                            -- 119
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 15);                    -- 120
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 15);                            -- 121
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 15);                                 -- 122
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 15);                        -- 123
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 15);                                   -- 124
--    Fusion San Mateo
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 16);                        -- 125
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 16);                                 -- 126
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 16);     -- 127
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 16);             -- 128
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 16);           -- 129
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 16);                      -- 130
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 16);                             -- 131
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 16);                            -- 132
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 16);                    -- 133
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 16);                            -- 134
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 16);                                 -- 135
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 16);                        -- 136
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 16);                                   -- 137
--    Fusion South Bay
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 17);                        -- 138
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 17);                                 -- 139
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 17);     -- 140
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 17);             -- 141
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 17);           -- 142
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 17);                      -- 143
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 17);                             -- 144
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 17);                            -- 145
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 17);                    -- 146
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 17);                            -- 147
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 17);                                 -- 148
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 17);                        -- 149
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 17);                                   -- 150
--    Fusion Solana Beach
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 18);                        -- 151
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 18);                                 -- 152
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 18);     -- 153
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 18);             -- 154
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 18);           -- 155
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 18);                      -- 156
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 18);                             -- 157
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 18);                            -- 158
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 18);                    -- 159
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 18);                            -- 160
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 18);                                 -- 161
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 18);                        -- 162
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 18);                                   -- 163
--    Fusion Walnut Creek
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 19);                        -- 164
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 19);                                 -- 165
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 19);     -- 166
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 19);             -- 167
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 19);           -- 168
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 19);                      -- 169
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 19);                             -- 170
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 19);                            -- 171
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 19);                    -- 172
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 19);                            -- 173
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 19);                                 -- 174
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 19);                        -- 175
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 19);                                   -- 176
--    Fusion Warner Center
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 20);                        -- 177
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 20);                                 -- 178
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 20);     -- 179
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 20);             -- 180
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 20);           -- 181
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 20);                      -- 182
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 20);                             -- 183
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 20);                            -- 184
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 20);                    -- 185
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 20);                            -- 186
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 20);                                 -- 187
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 20);                        -- 188
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 20);                                   -- 189
--    Fusion Manhattan
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 21);                        -- 190
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 21);                                 -- 191
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 21);     -- 192
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 21);             -- 193
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 21);           -- 194
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 21);                      -- 195
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 21);                             -- 196
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 21);                            -- 197
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 21);                    -- 198
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 21);                            -- 199
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 21);                                 -- 200
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 21);                        -- 201
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 21);                                   -- 202
--    Fusion Long Island
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 22);                        -- 203
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 22);                                 -- 204
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 22);     -- 205
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 22);             -- 206
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 22);           -- 207
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 22);                      -- 208
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 22);                             -- 209
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 22);                            -- 210
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 22);                    -- 211
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 22);                            -- 212
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 22);                                 -- 213
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 22);                        -- 214
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 22);                                   -- 215
--    Fusion Westchester
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Director", 2, 23);                        -- 216
INSERT INTO Positions (title, division, school_department) VALUES ("Counselor", 2, 23);                                 -- 217
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 23);     -- 218
INSERT INTO Positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 23);             -- 219
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Student Development", 2, 23);           -- 220
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 23);                      -- 221
INSERT INTO Positions (title, division, school_department) VALUES ("Fusionologist", 2, 23);                             -- 222
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 2, 23);                            -- 223
INSERT INTO Positions (title, division, school_department) VALUES ("Information Specialist", 2, 23);                    -- 224
INSERT INTO Positions (title, division, school_department) VALUES ("Master Teacher", 2, 23);                            -- 225
INSERT INTO Positions (title, division, school_department) VALUES ("Registrar", 2, 23);                                 -- 226
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 23);                        -- 227
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 2, 23);                                   -- 228
--    Fusion Regional
INSERT INTO Positions (title, division, school_department) VALUES ("Regional Assistant", 2, 24);                        -- 229
INSERT INTO Positions (title, division, school_department) VALUES ("Regional Director of Community Outreach", 2, 24);   -- 230
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Operations", 2, 24);                    -- 231
INSERT INTO Positions (title, division, school_department) VALUES ("New Talent Coordinator", 2, 24);                    -- 232
--  Lexis
--    Barnstable Academy
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 3, 25);                            -- 233
INSERT INTO Positions (title, division, school_department) VALUES ("Assistant Head of School", 3, 25);                  -- 234
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Admissions", 3, 25);                    -- 235
INSERT INTO Positions (title, division, school_department) VALUES ("Business Manager", 3, 25);                          -- 236
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 3, 25);                                   -- 237
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 25);                        -- 238
--    Shreiner Academy
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 3, 26);                            -- 239
INSERT INTO Positions (title, division, school_department) VALUES ("Admissions Coordinator", 3, 26);                    -- 240
INSERT INTO Positions (title, division, school_department) VALUES ("MS Director", 3, 26);                               -- 241
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 3, 26);                                   -- 242
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 26);                        -- 243
--    Tampa Day School
INSERT INTO Positions (title, division, school_department) VALUES ("Head of School", 3, 27);                            -- 244
INSERT INTO Positions (title, division, school_department) VALUES ("Psychologist", 3, 27);                              -- 245
INSERT INTO Positions (title, division, school_department) VALUES ("Outreach", 3, 27);                                  -- 246
INSERT INTO Positions (title, division, school_department) VALUES ("Principal", 3, 27);                                 -- 247
INSERT INTO Positions (title, division, school_department) VALUES ("Admin/Admissions Coordinator", 3, 27);              -- 248
INSERT INTO Positions (title, division, school_department) VALUES ("Office Manager", 3, 27);                            -- 249
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 3, 27);                                   -- 250
INSERT INTO Positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 27);                        -- 251
--  Little Sprouts
--    Amesbury
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 28);                        -- 252
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 28);                                   -- 253
--    Andover
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 29);                        -- 254
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 29);                                   -- 255
--    Andover Industrial
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 30);                        -- 256
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 30);                                   -- 257
--    Brighton
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 31);                        -- 258
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 31);                                   -- 259
--    Dedham
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 32);                        -- 260
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 32);                                   -- 261
--    Haverhill
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 33);                        -- 262
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 33);                                   -- 263
--    Haverhill NECC
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 34);                        -- 264
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 34);                                   -- 265
--    Lawrence
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 35);                        -- 266
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 35);                                   -- 267
--    Lowell
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 36);                        -- 268
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 36);                                   -- 269
--    Methuen
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 37);                        -- 270
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 37);                                   -- 271
--    North Andover
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 38);                        -- 272
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 38);                                   -- 273
--    Roxbury RCC
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 39);                        -- 274
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 39);                                   -- 275
--    Wilmington
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 40);                        -- 276
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 40);                                   -- 277
--    Woburn
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 41);                        -- 278
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 41);                                   -- 279
--    Boston
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 42);                        -- 280
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 42);                                   -- 281
--    Nashua
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Director", 4, 43);                        -- 282
INSERT INTO Positions (title, division, school_department) VALUES ("Teacher", 4, 43);                                   -- 283
--    Little Sprouts Corporate
INSERT INTO Positions (title, division, school_department) VALUES ("President", 4, 44);                                 -- 284
INSERT INTO Positions (title, division, school_department) VALUES ("VP of Finance", 4, 44);                             -- 285
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Operations", 4, 44);                    -- 286
INSERT INTO Positions (title, division, school_department) VALUES ("Regional Director", 4, 44);                         -- 287
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Research & Development", 4, 44);        -- 288
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Human Resources", 4, 44);               -- 289
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Operations & Facilities", 4, 44);       -- 290
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Curriculum", 4, 44);                    -- 291
INSERT INTO Positions (title, division, school_department) VALUES ("Director of Talent", 4, 44);                        -- 292
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Assistant to the President", 4, 44);      -- 293
INSERT INTO Positions (title, division, school_department) VALUES ("Executive Assistant to Finance", 4, 44);            -- 294

-- Added Positions
INSERT INTO Positions (title, division, school_department) VALUES ("Regional Fusionologist", 2, 24);                    -- 295
INSERT INTO Positions (title, division, school_department) VALUES ("Regional Director", 2, 24);                         -- 296

-- Source_Directories
INSERT INTO Source_Directories (name, parent) VALUES ("American Education Group", 1);           -- 1
-- American Education Group/
INSERT INTO Source_Directories (name, parent) VALUES ("AEG", 1);                                -- 2
INSERT INTO Source_Directories (name, parent) VALUES ("Schools", 1);                            -- 3
INSERT INTO Source_Directories (name, parent) VALUES ("Team Sites", 1);                         -- 4
-- American Education Group/AEG/
INSERT INTO Source_Directories (name, parent) VALUES ("Administration", 2);                     -- 5
INSERT INTO Source_Directories (name, parent) VALUES ("Information Technology", 2);             -- 6
INSERT INTO Source_Directories (name, parent) VALUES ("Marketing", 2);                          -- 7
INSERT INTO Source_Directories (name, parent) VALUES ("Human Resources", 2);                    -- 8
INSERT INTO Source_Directories (name, parent) VALUES ("Finance", 2);                            -- 9
INSERT INTO Source_Directories (name, parent) VALUES ("Coaching and Learning", 2);              -- 10
INSERT INTO Source_Directories (name, parent) VALUES ("New Business Development", 2);           -- 11
INSERT INTO Source_Directories (name, parent) VALUES ("Procurement", 2);                        -- 12
-- American Education Group/Schools/
INSERT INTO Source_Directories (name, parent) VALUES ("Fusion Division", 3);                    -- 13
INSERT INTO Source_Directories (name, parent) VALUES ("Lexis", 3);                              -- 14
INSERT INTO Source_Directories (name, parent) VALUES ("Little Sprouts", 3);                     -- 15
-- American Education Group/Team Sites/
INSERT INTO Source_Directories (name, parent) VALUES ("AEG R.O.C.K.S!", 4);                     -- 16
INSERT INTO Source_Directories (name, parent) VALUES ("NSO", 4);                                -- 17
INSERT INTO Source_Directories (name, parent) VALUES ("MPOPs", 4);                              -- 18
INSERT INTO Source_Directories (name, parent) VALUES ("EPIC! Portal", 4);                       -- 19
INSERT INTO Source_Directories (name, parent) VALUES ("1:1 Digital Curriculum", 4);             -- 20
-- American Education Group/AEG/Administration/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 5);                            -- 21
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 5);                             -- 22
-- American Education Group/AEG/Information Technology/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 6);                            -- 23
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 6);                             -- 24
INSERT INTO Source_Directories (name, parent) VALUES ("IT Planning", 6);                        -- 25
INSERT INTO Source_Directories (name, parent) VALUES ("Corporate Email Migration", 6);          -- 26
-- American Education Group/AEG/Marketing/
INSERT INTO Source_Directories (name, parent) VALUES ("Test Marketing", 7);                     -- 27
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 7);                            -- 28
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 7);                             -- 29
INSERT INTO Source_Directories (name, parent) VALUES ("Task List", 7);                          -- 30
INSERT INTO Source_Directories (name, parent) VALUES ("Project Tasks", 7);                      -- 31
-- American Education Group/AEG/Human Resources/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 8);                            -- 32
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 8);                             -- 33
INSERT INTO Source_Directories (name, parent) VALUES ("New Hire Paperwork", 8);                 -- 34
INSERT INTO Source_Directories (name, parent) VALUES ("Benefits", 8);                           -- 35
INSERT INTO Source_Directories (name, parent) VALUES ("Observation", 8);                        -- 36
INSERT INTO Source_Directories (name, parent) VALUES ("Fusionology", 8);                        -- 37
INSERT INTO Source_Directories (name, parent) VALUES ("HR Resources", 8);                       -- 38
-- American Education Group/AEG/Finance/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 9);                            -- 39
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 9);                             -- 40
INSERT INTO Source_Directories (name, parent) VALUES ("Administrator", 9);                      -- 41
-- American Education Group/AEG/New Business Development/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 11);                           -- 42
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 11);                            -- 43
-- American Education Group/AEG/Procurement/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 12);                           -- 44
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 12);                            -- 45
INSERT INTO Source_Directories (name, parent) VALUES ("Master Task List", 12);                  -- 46
INSERT INTO Source_Directories (name, parent) VALUES ("Master Calendar", 12);                   -- 47
-- American Education Group/Schools/Fusion Division/
INSERT INTO Source_Directories (name, parent) VALUES ("Huntington Beach", 13);                  -- 48
INSERT INTO Source_Directories (name, parent) VALUES ("Long Island", 13);                       -- 49
INSERT INTO Source_Directories (name, parent) VALUES ("Los Angeles", 13);                       -- 50
INSERT INTO Source_Directories (name, parent) VALUES ("Los Gatos", 13);                         -- 51
INSERT INTO Source_Directories (name, parent) VALUES ("Manhattan", 13);                         -- 52
INSERT INTO Source_Directories (name, parent) VALUES ("Mission Viejo", 13);                     -- 53
INSERT INTO Source_Directories (name, parent) VALUES ("Pasadena", 13);                          -- 54
INSERT INTO Source_Directories (name, parent) VALUES ("Regional", 13);                          -- 55
INSERT INTO Source_Directories (name, parent) VALUES ("San Francisco", 13);                     -- 56
INSERT INTO Source_Directories (name, parent) VALUES ("San Mateo", 13);                         -- 57
INSERT INTO Source_Directories (name, parent) VALUES ("Solana Beach", 13);                      -- 58
INSERT INTO Source_Directories (name, parent) VALUES ("South Bay", 13);                         -- 59
INSERT INTO Source_Directories (name, parent) VALUES ("Walnut Creek", 13);                      -- 60
INSERT INTO Source_Directories (name, parent) VALUES ("Warner Center", 13);                     -- 61
INSERT INTO Source_Directories (name, parent) VALUES ("Fusionology", 13);                       -- 62
INSERT INTO Source_Directories (name, parent) VALUES ("Discussion Board", 13);                  -- 63
INSERT INTO Source_Directories (name, parent) VALUES ("Outreach", 13);                          -- 64
INSERT INTO Source_Directories (name, parent) VALUES ("Accounting", 13);                        -- 65
INSERT INTO Source_Directories (name, parent) VALUES ("Leadership", 13);                        -- 66
INSERT INTO Source_Directories (name, parent) VALUES ("Registrar", 13);                         -- 67
INSERT INTO Source_Directories (name, parent) VALUES ("Curriculum", 13);                        -- 68
INSERT INTO Source_Directories (name, parent) VALUES ("Training", 13);                          -- 69
-- American Education Group/Schools/Lexis/
INSERT INTO Source_Directories (name, parent) VALUES ("Barnstable", 14);                        -- 70
INSERT INTO Source_Directories (name, parent) VALUES ("Shreiner", 14);                          -- 71
INSERT INTO Source_Directories (name, parent) VALUES ("Tampa Day", 14);                         -- 72
INSERT INTO Source_Directories (name, parent) VALUES ("Talking Heads", 14);                     -- 73
INSERT INTO Source_Directories (name, parent) VALUES ("Curriculum", 14);                        -- 74
INSERT INTO Source_Directories (name, parent) VALUES ("Scholarship", 14);                       -- 75
-- American Education Group/Schools/Little Sprouts/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 15);                           -- 76
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 15);                            -- 77
INSERT INTO Source_Directories (name, parent) VALUES ("SMK", 15);                               -- 78
INSERT INTO Source_Directories (name, parent) VALUES ("Financials", 15);                        -- 79
INSERT INTO Source_Directories (name, parent) VALUES ("Data Centralization", 15);               -- 80
-- American Education Group/Team Sites/AEG R.O.C.K.S!/
INSERT INTO Source_Directories (name, parent) VALUES ("Corporate", 16);                         -- 81
INSERT INTO Source_Directories (name, parent) VALUES ("Fusion", 16);                            -- 82
INSERT INTO Source_Directories (name, parent) VALUES ("Little Sprouts", 16);                    -- 83
-- American Education Group/Team Sites/NSO/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 17);                           -- 84
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 17);                            -- 85
INSERT INTO Source_Directories (name, parent) VALUES ("New Business Development", 17);          -- 86
INSERT INTO Source_Directories (name, parent) VALUES ("Construction Folder", 17);               -- 87
INSERT INTO Source_Directories (name, parent) VALUES ("Real Estate Folder", 17);                -- 88
INSERT INTO Source_Directories (name, parent) VALUES ("Project Tasks", 17);                     -- 89
INSERT INTO Source_Directories (name, parent) VALUES ("Project Calendar", 17);                  -- 90
-- American Education Group/Team Sites/MPOPs/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 18);                           -- 91
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 18);                            -- 92
INSERT INTO Source_Directories (name, parent) VALUES ("Little Sprouts", 18);                    -- 93
INSERT INTO Source_Directories (name, parent) VALUES ("Fusion Division", 18);                   -- 94
INSERT INTO Source_Directories (name, parent) VALUES ("Tampa Day School", 18);                  -- 95
INSERT INTO Source_Directories (name, parent) VALUES ("Barnstable Academy", 18);                -- 96
INSERT INTO Source_Directories (name, parent) VALUES ("Shreiner Academy", 18);                  -- 97
-- American Education Group/Team Sites/EPIC! Portal/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 19);                           -- 98
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 19);                            -- 99
INSERT INTO Source_Directories (name, parent) VALUES ("EPIC! Summits", 19);                     -- 100
INSERT INTO Source_Directories (name, parent) VALUES ("Reinventing School News", 19);           -- 101
INSERT INTO Source_Directories (name, parent) VALUES ("Rock 'N' CultuRoll Awareness", 19);      -- 102
-- American Education Group/Schools/Fusion Division/Huntington Beach/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 48);                             -- 103
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 48);                            -- 104
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 48);                    -- 105
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 48);                    -- 106
-- American Education Group/Schools/Fusion Division/Long Island/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 49);                             -- 107
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 49);                            -- 108
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 49);                    -- 109
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 49);                    -- 110
-- American Education Group/Schools/Fusion Division/Los Angeles/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 50);                             -- 111
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 50);                            -- 112
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 50);                    -- 113
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 50);                    -- 114
-- American Education Group/Schools/Fusion Division/Los Gatos/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 51);                             -- 115
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 51);                            -- 116
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 51);                    -- 117
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 51);                    -- 118
-- American Education Group/Schools/Fusion Division/Manhattan/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 52);                             -- 119
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 52);                            -- 120
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 52);                    -- 121
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 52);                    -- 122
-- American Education Group/Schools/Fusion Division/Mission Viejo/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 53);                             -- 123
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 53);                            -- 124
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 53);                    -- 125
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 53);                    -- 126
-- American Education Group/Schools/Fusion Division/Pasadena/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 54);                             -- 127
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 54);                            -- 128
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 54);                    -- 129
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 54);                    -- 130
-- American Education Group/Schools/Fusion Division/Regional/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 55);                             -- 131
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 55);                            -- 132
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 55);                    -- 133
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 55);                    -- 134
-- American Education Group/Schools/Fusion Division/San Francisco/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 56);                             -- 135
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 56);                            -- 136
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 56);                    -- 137
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 56);                    -- 138
-- American Education Group/Schools/Fusion Division/San Mateo/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 57);                             -- 139
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 57);                            -- 140
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 57);                    -- 141
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 57);                    -- 142
-- American Education Group/Schools/Fusion Division/Solana Beach/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 58);                             -- 143
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 58);                            -- 144
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 58);                    -- 145
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 58);                    -- 146
-- American Education Group/Schools/Fusion Division/South Bay/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 59);                             -- 147
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 59);                            -- 148
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 59);                    -- 149
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 59);                    -- 150
-- American Education Group/Schools/Fusion Division/Walnut Creek/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 60);                             -- 151
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 60);                            -- 152
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 60);                    -- 153
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 60);                    -- 154
-- American Education Group/Schools/Fusion Division/Warner Center/
INSERT INTO Source_Directories (name, parent) VALUES ("Staff", 61);                             -- 155
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 61);                            -- 156
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 61);                    -- 157
INSERT INTO Source_Directories (name, parent) VALUES ("Head of School", 61);                    -- 158
-- American Education Group/Schools/Fusion Division/Fusionology/
INSERT INTO Source_Directories (name, parent) VALUES ("Fusionology Content", 62);               -- 159
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 62);                           -- 160
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 62);                            -- 161
INSERT INTO Source_Directories (name, parent) VALUES ("Collaboration", 62);                     -- 162
-- American Education Group/Schools/Fusion Division/Discussion Board/
INSERT INTO Source_Directories (name, parent) VALUES ("Marketing", 63);                         -- 163
-- American Education Group/Schools/Fusion Division/Outreach/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 64);                           -- 164
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 64);                            -- 165
INSERT INTO Source_Directories (name, parent) VALUES ("Outreach Discussions", 64);              -- 166
-- American Education Group/Schools/Fusion Division/Accounting/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 65);                           -- 167
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 65);                            -- 168
INSERT INTO Source_Directories (name, parent) VALUES ("Billing", 65);                           -- 169
INSERT INTO Source_Directories (name, parent) VALUES ("Budget", 65);                            -- 170
-- American Education Group/Schools/Fusion Division/Leadership/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 66);                           -- 171
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 66);                            -- 172
-- American Education Group/Schools/Fusion Division/Registrar/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 67);                           -- 173
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 67);                            -- 174
INSERT INTO Source_Directories (name, parent) VALUES ("Site Pages", 67);                        -- 175
INSERT INTO Source_Directories (name, parent) VALUES ("Transcript Requests", 67);               -- 176
INSERT INTO Source_Directories (name, parent) VALUES ("POC", 67);                               -- 177
-- American Education Group/Schools/Fusion Division/Curriculum/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 68);                           -- 178
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 68);                            -- 179
INSERT INTO Source_Directories (name, parent) VALUES ("EPICenter!", 68);                        -- 180
-- American Education Group/Schools/Fusion Division/Training/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 69);                           -- 181
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 69);                            -- 182
-- American Education Group/Schools/Lexis/Barnstable/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 70);                           -- 183
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 70);                            -- 184
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 70);                    -- 185
INSERT INTO Source_Directories (name, parent) VALUES ("School", 70);                            -- 186
INSERT INTO Source_Directories (name, parent) VALUES ("Sick or Coverage", 70);                  -- 187
-- American Education Group/Schools/Lexis/Shreiner/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 71);                           -- 188
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 71);                            -- 189
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 71);                    -- 190
INSERT INTO Source_Directories (name, parent) VALUES ("School", 71);                            -- 191
INSERT INTO Source_Directories (name, parent) VALUES ("Sick or Coverage", 71);                  -- 192
-- American Education Group/Schools/Lexis/Tampa Day/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 72);                           -- 193
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 72);                            -- 194
INSERT INTO Source_Directories (name, parent) VALUES ("Administrators", 72);                    -- 195
INSERT INTO Source_Directories (name, parent) VALUES ("School", 72);                            -- 196
INSERT INTO Source_Directories (name, parent) VALUES ("Sick or Coverage", 72);                  -- 197
-- American Education Group/Schools/Lexis/Talking Heads/
INSERT INTO Source_Directories (name, parent) VALUES ("Leadership", 73);                        -- 198
INSERT INTO Source_Directories (name, parent) VALUES ("EPIC! Customer Service", 73);            -- 199
-- American Education Group/Schools/Lexis/Curriculum/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 74);                           -- 200
INSERT INTO Source_Directories (name, parent) VALUES ("Public", 74);                            -- 201
-- American Education Group/Schools/Lexis/Scholarship/
INSERT INTO Source_Directories (name, parent) VALUES ("Private", 75);                           -- 202

-- directory_owner
-- American Ed Group/
INSERT INTO Directory_Owner (directory, owner_position) VALUES (1, 1);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (1, 2);

--   AEG
INSERT INTO Directory_Owner (directory, owner_position) VALUES (2, 1);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (2, 2);

--   Schools
INSERT INTO Directory_Owner (directory, owner_position) VALUES (3, 7);

--   Team Sites
INSERT INTO Directory_Owner (directory, owner_position) VALUES (4, 3);

-- American Education Group/AEG/
--   Administration
INSERT INTO Directory_Owner (directory, owner_position) VALUES (5, 1);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (5, 2);

--   Information Technology
INSERT INTO Directory_Owner (directory, owner_position) VALUES (6, 14);

--   Marketing
INSERT INTO Directory_Owner (directory, owner_position) VALUES (7, 23);

--   Human Resources
INSERT INTO Directory_Owner (directory, owner_position) VALUES (8, 11);

--   Finance
INSERT INTO Directory_Owner (directory, owner_position) VALUES (9, 16);

--   Coaching and Learning
INSERT INTO Directory_Owner (directory, owner_position) VALUES (10, 7);

--   New Business Development
INSERT INTO Directory_Owner (directory, owner_position) VALUES (11, 31);

--   Procurement
INSERT INTO Directory_Owner (directory, owner_position) VALUES (12, 33);

-- American Education Group/Schools/
--   Fusion Division
INSERT INTO Directory_Owner (directory, owner_position) VALUES (13, 7);

--   Lexis
INSERT INTO Directory_Owner (directory, owner_position) VALUES (14, 7);

--   Little Sprouts
INSERT INTO Directory_Owner (directory, owner_position) VALUES (15, 7);

-- American Education Group/Team Sites/
--   AEG R.O.C.K.S!
INSERT INTO Directory_Owner (directory, owner_position) VALUES (16, 33);

--   NSO
INSERT INTO Directory_Owner (directory, owner_position) VALUES (17, 11);

--   MPOPs
INSERT INTO Directory_Owner (directory, owner_position) VALUES (18, 33);

--   EPIC! Portal
INSERT INTO Directory_Owner (directory, owner_position) VALUES (19, 33);

--   1:1 Digital Curriculum
INSERT INTO Directory_Owner (directory, owner_position) VALUES (20, 9);

-- American Education Group/AEG/Administration/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (21, 1);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (21, 2);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (22, 1);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (22, 2);


-- American Education Group/AEG/Information Technology/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (23, 14);

--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (24, 14);

--   IT Planning
INSERT INTO Directory_Owner (directory, owner_position) VALUES (25, 14);

--   Corporate Email Migration
INSERT INTO Directory_Owner (directory, owner_position) VALUES (26, 14);

-- American Education Group/AEG/Marketing/
--   Test Marketing
INSERT INTO Directory_Owner (directory, owner_position) VALUES (27, 23);

--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (28, 23);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (29, 23);

--   Task List
INSERT INTO Directory_Owner (directory, owner_position) VALUES (30, 23);

--   Project Tasks
INSERT INTO Directory_Owner (directory, owner_position) VALUES (31, 23);

-- American Education Group/AEG/Human Resources/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (32, 11);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (33, 11);

--   New Hire Paperwork
INSERT INTO Directory_Owner (directory, owner_position) VALUES (34, 11);

--   Benefits
INSERT INTO Directory_Owner (directory, owner_position) VALUES (35, 11);

--   Observation
INSERT INTO Directory_Owner (directory, owner_position) VALUES (36, 11);

--   Fusionology
INSERT INTO Directory_Owner (directory, owner_position) VALUES (37, 11);

--   HR Resources
INSERT INTO Directory_Owner (directory, owner_position) VALUES (38, 11);

-- American Education Group/AEG/Finance/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (39, 16);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (40, 16);

--   Administrator
INSERT INTO Directory_Owner (directory, owner_position) VALUES (41, 16);

-- American Education Group/AEG/New Business Development/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (42, 31);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (43, 31);

-- American education Groupo/AEG/Procurement/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (44, 33);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (45, 33);

--   Master Task List
INSERT INTO Directory_Owner (directory, owner_position) VALUES (46, 33);

--   Master Calendar
INSERT INTO Directory_Owner (directory, owner_position) VALUES (47, 33);

-- American Education Group/Schools/Fusion Division/
--   Huntington Beach
INSERT INTO Directory_Owner (directory, owner_position) VALUES (48, 41);

--   Long Island
INSERT INTO Directory_Owner (directory, owner_position) VALUES (49, 210);

--   Los Angeles
INSERT INTO Directory_Owner (directory, owner_position) VALUES (50, 54);

--   Los Gatos
INSERT INTO Directory_Owner (directory, owner_position) VALUES (51, 67);

--   Manhattan
INSERT INTO Directory_Owner (directory, owner_position) VALUES (52, 197);

--   Mission Viejo
INSERT INTO Directory_Owner (directory, owner_position) VALUES (53, 80);

--   Pasadena
INSERT INTO Directory_Owner (directory, owner_position) VALUES (54, 93);

--   Regional
INSERT INTO Directory_Owner (directory, owner_position) VALUES (55, 231);

--   San Francisco
INSERT INTO Directory_Owner (directory, owner_position) VALUES (56, 106);

--   San Mateo
INSERT INTO Directory_Owner (directory, owner_position) VALUES (57, 132);

--   Solana Beach
INSERT INTO Directory_Owner (directory, owner_position) VALUES (58, 158);

--   South Bay
INSERT INTO Directory_Owner (directory, owner_position) VALUES (59, 145);

--   Walnut Creek
INSERT INTO Directory_Owner (directory, owner_position) VALUES (60, 171);

--   Warner Center
INSERT INTO Directory_Owner (directory, owner_position) VALUES (61, 184);

--   Fusionology
INSERT INTO Directory_Owner (directory, owner_position) VALUES (62, 195);

--   Discussion Board
INSERT INTO Directory_Owner (directory, owner_position) VALUES (63, 26);

--   Outreach
INSERT INTO Directory_Owner (directory, owner_position) VALUES (64, 25);

--   Accounting
INSERT INTO Directory_Owner (directory, owner_position) VALUES (65, 18);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (65, 16);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (65, 17);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (65, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (65, 287);

--   Leadership
INSERT INTO Directory_Owner (directory, owner_position) VALUES (66, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (66, 287);

--   Registrar
INSERT INTO Directory_Owner (directory, owner_position) VALUES (67, 161);

--   Curriculum
INSERT INTO Directory_Owner (directory, owner_position) VALUES (68, 231);

--   Training
INSERT INTO Directory_Owner (directory, owner_position) VALUES (69, 231);

-- American Education Group/Schools/Lexis/
--   Barnstable
INSERT INTO Directory_Owner (directory, owner_position) VALUES (70, 233);

--   Shreiner
INSERT INTO Directory_Owner (directory, owner_position) VALUES (71, 239);

--   Tampa Day
INSERT INTO Directory_Owner (directory, owner_position) VALUES (72, 244);

--   Talking Heads
INSERT INTO Directory_Owner (directory, owner_position) VALUES (73, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (73, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (73, 244);

--   Curriculum
INSERT INTO Directory_Owner (directory, owner_position) VALUES (74, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (74, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (74, 244);

--   Scholarship
INSERT INTO Directory_Owner (directory, owner_position) VALUES (75, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (75, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (75, 244);

-- American Education Group/Schools/Little Sprouts/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (76, 284);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (77, 284);

--   SMK
INSERT INTO Directory_Owner (directory, owner_position) VALUES (78, 284);

--   Financials
INSERT INTO Directory_Owner (directory, owner_position) VALUES (79, 285);

--   Data Centralization
INSERT INTO Directory_Owner (directory, owner_position) VALUES (80, 286);

-- American Education Group/Team Sites/AEG R.O.C.K.S/
--   Corporate
INSERT INTO Directory_Owner (directory, owner_position) VALUES (81, 33);

--   Fusion
INSERT INTO Directory_Owner (directory, owner_position) VALUES (82, 33);

--   Little Sprouts
INSERT INTO Directory_Owner (directory, owner_position) VALUES (83, 33);

-- American Education Group/Team Site/NSO/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (84, 11);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (85, 11);

--   New Business Development
INSERT INTO Directory_Owner (directory, owner_position) VALUES (86, 11);

--   Construction Folder
INSERT INTO Directory_Owner (directory, owner_position) VALUES (87, 11);

--   Real Estate Folder
INSERT INTO Directory_Owner (directory, owner_position) VALUES (88, 11);

--   Project Tasks
INSERT INTO Directory_Owner (directory, owner_position) VALUES (89, 11);

--   Project Calendar
INSERT INTO Directory_Owner (directory, owner_position) VALUES (90, 11);

-- American Education Group/Team Sites/MPOPs/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (91, 11);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (92, 11);

--   Little Sprouts
INSERT INTO Directory_Owner (directory, owner_position) VALUES (93, 11);

--   Fusion Division
INSERT INTO Directory_Owner (directory, owner_position) VALUES (94, 11);

--   Tampa Day School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (95, 11);

--   Barnstable Academy
INSERT INTO Directory_Owner (directory, owner_position) VALUES (96, 11);

--   Shreiner Academy
INSERT INTO Directory_Owner (directory, owner_position) VALUES (97, 11);

-- American Education Group/Team Sites/EPIC! Portal/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (98, 11);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (99, 11);

--   EPIC! Summits
INSERT INTO Directory_Owner (directory, owner_position) VALUES (100, 11);

--   Reinventing School News
INSERT INTO Directory_Owner (directory, owner_position) VALUES (101, 11);

--   Rock 'N' CulturRoll Awareness
INSERT INTO Directory_Owner (directory, owner_position) VALUES (102, 11);

-- American Education Group/Schools/Fusion Division/Huntington Beach/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (103, 41);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (104, 41);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (105, 41);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (106, 41);

-- American Education Group/Schools/Fusion Division/Long Island/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (107, 210);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (108, 210);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (109, 210);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (110, 210);

-- American Education Group/Schools/Fusion Division/Los Angeles/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (111, 54);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (112, 54);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (113, 54);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (114, 54);

-- American Education Group/Schools/Fusion Division/Los Gatos/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (115, 67);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (116, 67);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (117, 67);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (118, 67);

-- American Education Group/Schools/Fusion Division/Manhattan/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (119, 197);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (120, 197);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (121, 197);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (122, 197);

-- American Education Group/Schools/Fusion Division/Mission Viejo/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (123, 80);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (124, 80);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (125, 80);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (126, 80);

-- American Education Group/Schools/Fusion Division/Pasadena/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (127, 93);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (128, 93);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (129, 93);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (130, 93);

-- American Education Group/Schools/Fusion Division/Regional/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (131, 231);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (132, 231);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (133, 231);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (134, 231);

-- American Education Group/Schools/Fusion Division/San Francisco/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (135, 119);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (136, 119);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (137, 119);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (138, 119);

-- American Education Group/Schools/Fusion Division/San Mateo/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (139, 132);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (140, 132);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (141, 132);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (142, 132);

-- American Education Group/Schools/Fusion Division/Solana Beach/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (143, 158);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (144, 158);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (145, 158);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (146, 158);

-- American Education Group/Schools/Fusion Division/South Bay/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (147, 145);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (148, 145);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (149, 145);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (150, 145);

-- American Education Group/Schools/Fusion Division/Walnut Creek/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (151, 171);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (152, 171);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (153, 171);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (154, 171);

-- American Education Group/Schools/Fusion Division/Warner Center/
--   Staff
INSERT INTO Directory_Owner (directory, owner_position) VALUES (155, 184);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (156, 184);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (157, 184);

--   Head of School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (158, 184);

-- American Education Group/Schools/Fusion Division/Fusionology/
--   Fusionology Content
INSERT INTO Directory_Owner (directory, owner_position) VALUES (159, 295);

--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (160, 295);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (161, 295);

--   Collaboration
INSERT INTO Directory_Owner (directory, owner_position) VALUES (162, 295);

-- American Education Group/Schools/Fusion Division/Discussion Board/
--   Marketing
INSERT INTO Directory_Owner (directory, owner_position) VALUES (163, 26);

-- American Education Group/Schools/Fusion Division/Outreach/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (164, 25);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (165, 25);

--   Outreach Discussions
INSERT INTO Directory_Owner (directory, owner_position) VALUES (166, 25);

-- American Education Group/Schools/Fusion Division/Accounting/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (167, 18);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (167, 16);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (167, 17);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (167, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (167, 287);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (168, 16);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (168, 17);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (168, 18);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (168, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (168, 287);

--   Billing
INSERT INTO Directory_Owner (directory, owner_position) VALUES (169, 16);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (169, 17);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (169, 18);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (169, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (169, 287);

--   Budget
INSERT INTO Directory_Owner (directory, owner_position) VALUES (170, 16);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (170, 17);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (170, 18);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (170, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (170, 287);

-- American Education Group/Schools/Fusion Division/Leadership/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (171, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (171, 287);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (172, 286);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (172, 287);

-- American Education Group/Schools/Fusion Division/Registrar/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (173, 161);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (174, 161);

--   Site Pages
INSERT INTO Directory_Owner (directory, owner_position) VALUES (175, 161);

--   Transcript Requests
INSERT INTO Directory_Owner (directory, owner_position) VALUES (176, 161);

--   POC
INSERT INTO Directory_Owner (directory, owner_position) VALUES (177, 161);

-- Americane Education Group/Schools/Fusion Division/Curriculum/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (178, 231);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (179, 231);

--   EPICenter!
INSERT INTO Directory_Owner (directory, owner_position) VALUES (180, 231);

-- American Education Group/Schools/Fusion Division/Training/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (181, 231);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (182, 231);

-- American Education Group/Schools/Lexis/Barnstable/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (183, 233);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (184, 233);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (185, 233);

--   School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (186, 233);

--   Sick or Coverage
INSERT INTO Directory_Owner (directory, owner_position) VALUES (187, 233);

-- American Education Group/Schools/Lexis/Shreiner/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (188, 239);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (189, 239);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (190, 239);

--   School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (191, 239);

--   Sick or Coverage
INSERT INTO Directory_Owner (directory, owner_position) VALUES (192, 239);


-- American Education Group/Schools/Lexis/Tampa Day/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (193, 244);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (194, 244);

--   Administrators
INSERT INTO Directory_Owner (directory, owner_position) VALUES (195, 244);

--   School
INSERT INTO Directory_Owner (directory, owner_position) VALUES (196, 244);

--   Sick or Coverage
INSERT INTO Directory_Owner (directory, owner_position) VALUES (197, 244);

-- American Education Group/Schools/Lexis/Talking Heads/
--   Leadership
INSERT INTO Directory_Owner (directory, owner_position) VALUES (198, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (198, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (198, 244);

--   EPIC! Customer Service
INSERT INTO Directory_Owner (directory, owner_position) VALUES (199, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (199, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (199, 244);

-- American Education Group/Schools/Lexis/Curriculum/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (200, 7);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (200, 8);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (200, 9);

--   Public
INSERT INTO Directory_Owner (directory, owner_position) VALUES (201, 7);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (201, 8);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (201, 9);


-- American Education Group/Schools/Lexis/Scholarship/
--   Private
INSERT INTO Directory_Owner (directory, owner_position) VALUES (202, 233);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (202, 239);
INSERT INTO Directory_Owner (directory, owner_position) VALUES (202, 244);

-- 