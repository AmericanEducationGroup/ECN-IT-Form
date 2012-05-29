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
INSERT INTO Schools_Departments (name, abbreviation, division) VALUES ("Fusion Long Island", "LI", 2);          -- 22
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






-- Read_Permissions & Edit Permissions
-- directory_owner
-- American Ed Group/
--   AEG
--   Schools
--   Team Sites

-- American Education Group/AEG/
--   Administration
-- INSERT INTO Read_Permissions(position, directory) VALUES (1,5);
-- INSERT INTO Read_Permissions(position, directory) VALUES (2,5);
-- INSERT INTO Read_Permissions(position, directory) VALUES (3,5);
-- INSERT INTO Read_Permissions(position, directory) VALUES (4,5);
-- INSERT INTO Read_Permissions(position, directory) VALUES (5,5);
-- INSERT INTO Read_Permissions(position, directory) VALUES (6,5);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (1,5);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (2,5);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (3,5);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (4,5);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (5,5);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (6,5);

--   Information Technology
-- INSERT INTO Read_Permissions(position, directory) VALUES (14,6);
-- INSERT INTO Read_Permissions(position, directory) VALUES (15,6);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (14,6);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (15,6);

--   Marketing
-- INSERT INTO Read_Permissions(position, directory) VALUES (23,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (24,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (25,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (26,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (27,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (28,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (29,7);
-- INSERT INTO Read_Permissions(position, directory) VALUES (30,7);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (23,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (24,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (25,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (26,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (27,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (28,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (29,7);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (30,7);

--   Human Resources
-- INSERT INTO Read_Permissions(position, directory) VALUES (11,8);
-- INSERT INTO Read_Permissions(position, directory) VALUES (12,8);
-- INSERT INTO Read_Permissions(position, directory) VALUES (13,8);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (11,8);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (12,8);
-- INSERT INTO Edit_Permissions(position, directory) VALUES (13,8);

--   Finance
-- INSERT INTO Read_Permissions(position, directory) VALUES (,9);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,9);

--   Coaching and Learning
-- INSERT INTO Read_Permissions(position, directory) VALUES (,10);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,10);
--   New Business Development
-- INSERT INTO Read_Permissions(position, directory) VALUES (,11);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,11);
--   Procurement
-- INSERT INTO Read_Permissions(position, directory) VALUES (,12);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,12);

-- American Education Group/Schools/
--   Fusion Division
-- INSERT INTO Read_Permissions(position, directory) VALUES (,13);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,13);
--   Lexis
-- INSERT INTO Read_Permissions(position, directory) VALUES (,14);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,14);
--   Little Sprouts
-- INSERT INTO Read_Permissions(position, directory) VALUES (,15);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,15);

-- American Education Group/Team Sites/
--   AEG R.O.C.K.S!
-- INSERT INTO Read_Permissions(position, directory) VALUES (,16);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,16);
--   NSO
-- INSERT INTO Read_Permissions(position, directory) VALUES (,17);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,17);
--   MPOPs
-- INSERT INTO Read_Permissions(position, directory) VALUES (,18);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,18);
--   EPIC! Portal
-- INSERT INTO Read_Permissions(position, directory) VALUES (,19);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,19);
--   1:1 Digital Curriculum
-- INSERT INTO Read_Permissions(position, directory) VALUES (,20);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,20);

-- American Education Group/AEG/Administration/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (1,21);
INSERT INTO Read_Permissions(position, directory) VALUES (2,21);
INSERT INTO Read_Permissions(position, directory) VALUES (3,21);
INSERT INTO Read_Permissions(position, directory) VALUES (4,21);
INSERT INTO Read_Permissions(position, directory) VALUES (5,21);
INSERT INTO Read_Permissions(position, directory) VALUES (6,21);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,21);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,21);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,21);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,21);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,21);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,21);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (1,22);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,22);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,22);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,22);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,22);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,22);

-- American Education Group/AEG/Information Technology/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (14,23);
INSERT INTO Read_Permissions(position, directory) VALUES (15,23);

INSERT INTO Edit_Permissions(position, directory) VALUES (14,23);
INSERT INTO Edit_Permissions(position, directory) VALUES (15,23);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (14,24);
INSERT INTO Edit_Permissions(position, directory) VALUES (15,24);

--   IT Planning
INSERT INTO Read_Permissions(position, directory) VALUES (14,25);
INSERT INTO Read_Permissions(position, directory) VALUES (15,25);

INSERT INTO Edit_Permissions(position, directory) VALUES (14,25);
INSERT INTO Edit_Permissions(position, directory) VALUES (15,25);

--   Corporate Email Migration
INSERT INTO Read_Permissions(position, directory) VALUES (14,26);
INSERT INTO Read_Permissions(position, directory) VALUES (15,26);

INSERT INTO Edit_Permissions(position, directory) VALUES (14,26);
INSERT INTO Edit_Permissions(position, directory) VALUES (15,26);

-- American Education Group/AEG/Marketing/
--   Test Marketing
INSERT INTO Read_Permissions(position, directory) VALUES (23,27);
INSERT INTO Read_Permissions(position, directory) VALUES (24,27);
INSERT INTO Read_Permissions(position, directory) VALUES (25,27);
INSERT INTO Read_Permissions(position, directory) VALUES (26,27);
INSERT INTO Read_Permissions(position, directory) VALUES (27,27);
INSERT INTO Read_Permissions(position, directory) VALUES (28,27);
INSERT INTO Read_Permissions(position, directory) VALUES (29,27);
INSERT INTO Read_Permissions(position, directory) VALUES (30,27);

INSERT INTO Edit_Permissions(position, directory) VALUES (23,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (27,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,27);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,27);

--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (23,28);
INSERT INTO Read_Permissions(position, directory) VALUES (24,28);
INSERT INTO Read_Permissions(position, directory) VALUES (25,28);
INSERT INTO Read_Permissions(position, directory) VALUES (26,28);
INSERT INTO Read_Permissions(position, directory) VALUES (27,28);
INSERT INTO Read_Permissions(position, directory) VALUES (27,28);
INSERT INTO Read_Permissions(position, directory) VALUES (29,28);
INSERT INTO Read_Permissions(position, directory) VALUES (30,28);

INSERT INTO Edit_Permissions(position, directory) VALUES (23,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,28);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,28);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (23,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (27,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,29);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,29);

--   Task List
INSERT INTO Read_Permissions(position, directory) VALUES (23,30);
INSERT INTO Read_Permissions(position, directory) VALUES (24,30);
INSERT INTO Read_Permissions(position, directory) VALUES (25,30);
INSERT INTO Read_Permissions(position, directory) VALUES (26,30);
INSERT INTO Read_Permissions(position, directory) VALUES (27,30);
INSERT INTO Read_Permissions(position, directory) VALUES (28,30);
INSERT INTO Read_Permissions(position, directory) VALUES (29,30);
INSERT INTO Read_Permissions(position, directory) VALUES (30,30);

INSERT INTO Edit_Permissions(position, directory) VALUES (23,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (27,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,30);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,30);

--   Project Tasks
INSERT INTO Read_Permissions(position, directory) VALUES (23,31);
INSERT INTO Read_Permissions(position, directory) VALUES (24,31);
INSERT INTO Read_Permissions(position, directory) VALUES (25,31);
INSERT INTO Read_Permissions(position, directory) VALUES (26,31);
INSERT INTO Read_Permissions(position, directory) VALUES (27,31);
INSERT INTO Read_Permissions(position, directory) VALUES (28,31);
INSERT INTO Read_Permissions(position, directory) VALUES (29,31);
INSERT INTO Read_Permissions(position, directory) VALUES (30,31);

INSERT INTO Edit_Permissions(position, directory) VALUES (23,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (27,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,31);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,31);

-- American Education Group/AEG/Human Resources/

--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (11,32);
INSERT INTO Read_Permissions(position, directory) VALUES (12,32);
INSERT INTO Read_Permissions(position, directory) VALUES (13,32);

INSERT INTO Edit_Permissions(position, directory) VALUES (11,32);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,32);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,32);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (11,33);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,33);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,33);

--   New Hire Paperwork
INSERT INTO Read_Permissions(position, directory) VALUES (11,34);
INSERT INTO Read_Permissions(position, directory) VALUES (12,34);
INSERT INTO Read_Permissions(position, directory) VALUES (13,34);
--     DFI
INSERT INTO Read_Permissions(position, directory) VALUES (37,34);
INSERT INTO Read_Permissions(position, directory) VALUES (50,34);
INSERT INTO Read_Permissions(position, directory) VALUES (63,34);
INSERT INTO Read_Permissions(position, directory) VALUES (76,34);
INSERT INTO Read_Permissions(position, directory) VALUES (89,34);
INSERT INTO Read_Permissions(position, directory) VALUES (102,34);
INSERT INTO Read_Permissions(position, directory) VALUES (115,34);
INSERT INTO Read_Permissions(position, directory) VALUES (128,34);
INSERT INTO Read_Permissions(position, directory) VALUES (121,34);
INSERT INTO Read_Permissions(position, directory) VALUES (154,34);
INSERT INTO Read_Permissions(position, directory) VALUES (167,34);
INSERT INTO Read_Permissions(position, directory) VALUES (180,34);
INSERT INTO Read_Permissions(position, directory) VALUES (193,34);
INSERT INTO Read_Permissions(position, directory) VALUES (206,34);
INSERT INTO Read_Permissions(position, directory) VALUES (219,34);
--     Assistant Director
INSERT INTO Read_Permissions(position, directory) VALUES (34,34);
INSERT INTO Read_Permissions(position, directory) VALUES (47,34);
INSERT INTO Read_Permissions(position, directory) VALUES (60,34);
INSERT INTO Read_Permissions(position, directory) VALUES (73,34);
INSERT INTO Read_Permissions(position, directory) VALUES (86,34);
INSERT INTO Read_Permissions(position, directory) VALUES (99,34);
INSERT INTO Read_Permissions(position, directory) VALUES (112,34);
INSERT INTO Read_Permissions(position, directory) VALUES (125,34);
INSERT INTO Read_Permissions(position, directory) VALUES (138,34);
INSERT INTO Read_Permissions(position, directory) VALUES (151,34);
INSERT INTO Read_Permissions(position, directory) VALUES (164,34);
INSERT INTO Read_Permissions(position, directory) VALUES (177,34);
INSERT INTO Read_Permissions(position, directory) VALUES (190,34);
INSERT INTO Read_Permissions(position, directory) VALUES (203,34);
INSERT INTO Read_Permissions(position, directory) VALUES (216,34);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,34);
INSERT INTO Read_Permissions(position, directory) VALUES (54,34);
INSERT INTO Read_Permissions(position, directory) VALUES (67,34);
INSERT INTO Read_Permissions(position, directory) VALUES (80,34);
INSERT INTO Read_Permissions(position, directory) VALUES (93,34);
INSERT INTO Read_Permissions(position, directory) VALUES (106,34);
INSERT INTO Read_Permissions(position, directory) VALUES (119,34);
INSERT INTO Read_Permissions(position, directory) VALUES (132,34);
INSERT INTO Read_Permissions(position, directory) VALUES (145,34);
INSERT INTO Read_Permissions(position, directory) VALUES (158,34);
INSERT INTO Read_Permissions(position, directory) VALUES (171,34);
INSERT INTO Read_Permissions(position, directory) VALUES (184,34);
INSERT INTO Read_Permissions(position, directory) VALUES (197,34);
INSERT INTO Read_Permissions(position, directory) VALUES (210,34);
INSERT INTO Read_Permissions(position, directory) VALUES (223,34);
INSERT INTO Read_Permissions(position, directory) VALUES (233,34);
INSERT INTO Read_Permissions(position, directory) VALUES (239,34);
INSERT INTO Read_Permissions(position, directory) VALUES (244,34);


INSERT INTO Edit_Permissions(position, directory) VALUES (11,34);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,34);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,34);

--   Benefits
INSERT INTO Read_Permissions(position, directory) VALUES (11,35);
INSERT INTO Read_Permissions(position, directory) VALUES (12,35);
INSERT INTO Read_Permissions(position, directory) VALUES (13,35);
--     DFI
INSERT INTO Read_Permissions(position, directory) VALUES (37,35);
INSERT INTO Read_Permissions(position, directory) VALUES (50,35);
INSERT INTO Read_Permissions(position, directory) VALUES (63,35);
INSERT INTO Read_Permissions(position, directory) VALUES (76,35);
INSERT INTO Read_Permissions(position, directory) VALUES (89,35);
INSERT INTO Read_Permissions(position, directory) VALUES (102,35);
INSERT INTO Read_Permissions(position, directory) VALUES (115,35);
INSERT INTO Read_Permissions(position, directory) VALUES (128,35);
INSERT INTO Read_Permissions(position, directory) VALUES (121,35);
INSERT INTO Read_Permissions(position, directory) VALUES (154,35);
INSERT INTO Read_Permissions(position, directory) VALUES (167,35);
INSERT INTO Read_Permissions(position, directory) VALUES (180,35);
INSERT INTO Read_Permissions(position, directory) VALUES (193,35);
INSERT INTO Read_Permissions(position, directory) VALUES (206,35);
INSERT INTO Read_Permissions(position, directory) VALUES (219,35);
--     Assistant Director
INSERT INTO Read_Permissions(position, directory) VALUES (35,35);
INSERT INTO Read_Permissions(position, directory) VALUES (47,35);
INSERT INTO Read_Permissions(position, directory) VALUES (60,35);
INSERT INTO Read_Permissions(position, directory) VALUES (73,35);
INSERT INTO Read_Permissions(position, directory) VALUES (86,35);
INSERT INTO Read_Permissions(position, directory) VALUES (99,35);
INSERT INTO Read_Permissions(position, directory) VALUES (112,35);
INSERT INTO Read_Permissions(position, directory) VALUES (125,35);
INSERT INTO Read_Permissions(position, directory) VALUES (138,35);
INSERT INTO Read_Permissions(position, directory) VALUES (151,35);
INSERT INTO Read_Permissions(position, directory) VALUES (164,35);
INSERT INTO Read_Permissions(position, directory) VALUES (177,35);
INSERT INTO Read_Permissions(position, directory) VALUES (190,35);
INSERT INTO Read_Permissions(position, directory) VALUES (203,35);
INSERT INTO Read_Permissions(position, directory) VALUES (216,35);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,35);
INSERT INTO Read_Permissions(position, directory) VALUES (54,35);
INSERT INTO Read_Permissions(position, directory) VALUES (67,35);
INSERT INTO Read_Permissions(position, directory) VALUES (80,35);
INSERT INTO Read_Permissions(position, directory) VALUES (93,35);
INSERT INTO Read_Permissions(position, directory) VALUES (106,35);
INSERT INTO Read_Permissions(position, directory) VALUES (119,35);
INSERT INTO Read_Permissions(position, directory) VALUES (132,35);
INSERT INTO Read_Permissions(position, directory) VALUES (145,35);
INSERT INTO Read_Permissions(position, directory) VALUES (158,35);
INSERT INTO Read_Permissions(position, directory) VALUES (171,35);
INSERT INTO Read_Permissions(position, directory) VALUES (184,35);
INSERT INTO Read_Permissions(position, directory) VALUES (197,35);
INSERT INTO Read_Permissions(position, directory) VALUES (210,35);
INSERT INTO Read_Permissions(position, directory) VALUES (223,35);
INSERT INTO Read_Permissions(position, directory) VALUES (233,35);
INSERT INTO Read_Permissions(position, directory) VALUES (239,35);
INSERT INTO Read_Permissions(position, directory) VALUES (244,35);


INSERT INTO Edit_Permissions(position, directory) VALUES (11,35);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,35);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,35);

--   Observation
INSERT INTO Read_Permissions(position, directory) VALUES (11,36);
INSERT INTO Read_Permissions(position, directory) VALUES (12,36);
INSERT INTO Read_Permissions(position, directory) VALUES (13,36);
--     DFI
INSERT INTO Read_Permissions(position, directory) VALUES (37,36);
INSERT INTO Read_Permissions(position, directory) VALUES (50,36);
INSERT INTO Read_Permissions(position, directory) VALUES (63,36);
INSERT INTO Read_Permissions(position, directory) VALUES (76,36);
INSERT INTO Read_Permissions(position, directory) VALUES (89,36);
INSERT INTO Read_Permissions(position, directory) VALUES (102,36);
INSERT INTO Read_Permissions(position, directory) VALUES (115,36);
INSERT INTO Read_Permissions(position, directory) VALUES (128,36);
INSERT INTO Read_Permissions(position, directory) VALUES (121,36);
INSERT INTO Read_Permissions(position, directory) VALUES (154,36);
INSERT INTO Read_Permissions(position, directory) VALUES (167,36);
INSERT INTO Read_Permissions(position, directory) VALUES (180,36);
INSERT INTO Read_Permissions(position, directory) VALUES (193,36);
INSERT INTO Read_Permissions(position, directory) VALUES (206,36);
INSERT INTO Read_Permissions(position, directory) VALUES (219,36);
--     Assistant Director
INSERT INTO Read_Permissions(position, directory) VALUES (36,36);
INSERT INTO Read_Permissions(position, directory) VALUES (47,36);
INSERT INTO Read_Permissions(position, directory) VALUES (60,36);
INSERT INTO Read_Permissions(position, directory) VALUES (73,36);
INSERT INTO Read_Permissions(position, directory) VALUES (86,36);
INSERT INTO Read_Permissions(position, directory) VALUES (99,36);
INSERT INTO Read_Permissions(position, directory) VALUES (112,36);
INSERT INTO Read_Permissions(position, directory) VALUES (125,36);
INSERT INTO Read_Permissions(position, directory) VALUES (138,36);
INSERT INTO Read_Permissions(position, directory) VALUES (151,36);
INSERT INTO Read_Permissions(position, directory) VALUES (164,36);
INSERT INTO Read_Permissions(position, directory) VALUES (177,36);
INSERT INTO Read_Permissions(position, directory) VALUES (190,36);
INSERT INTO Read_Permissions(position, directory) VALUES (203,36);
INSERT INTO Read_Permissions(position, directory) VALUES (216,36);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,36);
INSERT INTO Read_Permissions(position, directory) VALUES (54,36);
INSERT INTO Read_Permissions(position, directory) VALUES (67,36);
INSERT INTO Read_Permissions(position, directory) VALUES (80,36);
INSERT INTO Read_Permissions(position, directory) VALUES (93,36);
INSERT INTO Read_Permissions(position, directory) VALUES (106,36);
INSERT INTO Read_Permissions(position, directory) VALUES (119,36);
INSERT INTO Read_Permissions(position, directory) VALUES (132,36);
INSERT INTO Read_Permissions(position, directory) VALUES (145,36);
INSERT INTO Read_Permissions(position, directory) VALUES (158,36);
INSERT INTO Read_Permissions(position, directory) VALUES (171,36);
INSERT INTO Read_Permissions(position, directory) VALUES (184,36);
INSERT INTO Read_Permissions(position, directory) VALUES (197,36);
INSERT INTO Read_Permissions(position, directory) VALUES (210,36);
INSERT INTO Read_Permissions(position, directory) VALUES (223,36);
INSERT INTO Read_Permissions(position, directory) VALUES (233,36);
INSERT INTO Read_Permissions(position, directory) VALUES (239,36);
INSERT INTO Read_Permissions(position, directory) VALUES (244,36);


INSERT INTO Edit_Permissions(position, directory) VALUES (11,36);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,36);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,36);

--   Fusionology
INSERT INTO Read_Permissions(position, directory) VALUES (11,37);
INSERT INTO Read_Permissions(position, directory) VALUES (12,37);
INSERT INTO Read_Permissions(position, directory) VALUES (13,37);
--     Director of Operations
INSERT INTO Read_Permissions(position, directory) VALUES (231,37);

INSERT INTO Edit_Permissions(position, directory) VALUES (11,37);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,37);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,37);
--     Director of Operations
INSERT INTO Edit_Permissions(position, directory) VALUES (231,37);

--   HR Resources
INSERT INTO Read_Permissions(position, directory) VALUES (11,38);
INSERT INTO Read_Permissions(position, directory) VALUES (12,38);
INSERT INTO Read_Permissions(position, directory) VALUES (13,38);
--     DFI
INSERT INTO Read_Permissions(position, directory) VALUES (37,38);
INSERT INTO Read_Permissions(position, directory) VALUES (50,38);
INSERT INTO Read_Permissions(position, directory) VALUES (63,38);
INSERT INTO Read_Permissions(position, directory) VALUES (76,38);
INSERT INTO Read_Permissions(position, directory) VALUES (89,38);
INSERT INTO Read_Permissions(position, directory) VALUES (102,38);
INSERT INTO Read_Permissions(position, directory) VALUES (115,38);
INSERT INTO Read_Permissions(position, directory) VALUES (128,38);
INSERT INTO Read_Permissions(position, directory) VALUES (121,38);
INSERT INTO Read_Permissions(position, directory) VALUES (154,38);
INSERT INTO Read_Permissions(position, directory) VALUES (167,38);
INSERT INTO Read_Permissions(position, directory) VALUES (180,38);
INSERT INTO Read_Permissions(position, directory) VALUES (193,38);
INSERT INTO Read_Permissions(position, directory) VALUES (206,38);
INSERT INTO Read_Permissions(position, directory) VALUES (219,38);
--     Assistant Director
INSERT INTO Read_Permissions(position, directory) VALUES (38,38);
INSERT INTO Read_Permissions(position, directory) VALUES (47,38);
INSERT INTO Read_Permissions(position, directory) VALUES (60,38);
INSERT INTO Read_Permissions(position, directory) VALUES (73,38);
INSERT INTO Read_Permissions(position, directory) VALUES (86,38);
INSERT INTO Read_Permissions(position, directory) VALUES (99,38);
INSERT INTO Read_Permissions(position, directory) VALUES (112,38);
INSERT INTO Read_Permissions(position, directory) VALUES (125,38);
INSERT INTO Read_Permissions(position, directory) VALUES (138,38);
INSERT INTO Read_Permissions(position, directory) VALUES (151,38);
INSERT INTO Read_Permissions(position, directory) VALUES (164,38);
INSERT INTO Read_Permissions(position, directory) VALUES (177,38);
INSERT INTO Read_Permissions(position, directory) VALUES (190,38);
INSERT INTO Read_Permissions(position, directory) VALUES (203,38);
INSERT INTO Read_Permissions(position, directory) VALUES (216,38);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,38);
INSERT INTO Read_Permissions(position, directory) VALUES (54,38);
INSERT INTO Read_Permissions(position, directory) VALUES (67,38);
INSERT INTO Read_Permissions(position, directory) VALUES (80,38);
INSERT INTO Read_Permissions(position, directory) VALUES (93,38);
INSERT INTO Read_Permissions(position, directory) VALUES (106,38);
INSERT INTO Read_Permissions(position, directory) VALUES (119,38);
INSERT INTO Read_Permissions(position, directory) VALUES (132,38);
INSERT INTO Read_Permissions(position, directory) VALUES (145,38);
INSERT INTO Read_Permissions(position, directory) VALUES (158,38);
INSERT INTO Read_Permissions(position, directory) VALUES (171,38);
INSERT INTO Read_Permissions(position, directory) VALUES (184,38);
INSERT INTO Read_Permissions(position, directory) VALUES (197,38);
INSERT INTO Read_Permissions(position, directory) VALUES (210,38);
INSERT INTO Read_Permissions(position, directory) VALUES (223,38);
INSERT INTO Read_Permissions(position, directory) VALUES (233,38);
INSERT INTO Read_Permissions(position, directory) VALUES (239,38);
INSERT INTO Read_Permissions(position, directory) VALUES (244,38);


INSERT INTO Edit_Permissions(position, directory) VALUES (11,38);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,38);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,38);

-- American Education Group/AEG/Finance/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (16,39);
INSERT INTO Read_Permissions(position, directory) VALUES (17,39);
INSERT INTO Read_Permissions(position, directory) VALUES (18,39);
INSERT INTO Read_Permissions(position, directory) VALUES (19,39);
INSERT INTO Read_Permissions(position, directory) VALUES (20,39);
INSERT INTO Read_Permissions(position, directory) VALUES (21,39);
INSERT INTO Read_Permissions(position, directory) VALUES (22,39);

INSERT INTO Edit_Permissions(position, directory) VALUES (16,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (17,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (18,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (19,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (20,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (21,39);
INSERT INTO Edit_Permissions(position, directory) VALUES (22,39);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (16,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (17,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (18,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (19,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (20,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (21,40);
INSERT INTO Edit_Permissions(position, directory) VALUES (22,40);

--   Administrator
INSERT INTO Read_Permissions(position, directory) VALUES (16,41);
INSERT INTO Read_Permissions(position, directory) VALUES (17,41);
INSERT INTO Read_Permissions(position, directory) VALUES (18,41);
INSERT INTO Read_Permissions(position, directory) VALUES (19,41);
INSERT INTO Read_Permissions(position, directory) VALUES (20,41);
INSERT INTO Read_Permissions(position, directory) VALUES (21,41);
INSERT INTO Read_Permissions(position, directory) VALUES (22,41);

INSERT INTO Edit_Permissions(position, directory) VALUES (16,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (17,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (18,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (19,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (20,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (21,41);
INSERT INTO Edit_Permissions(position, directory) VALUES (22,41);

-- American Education Group/AEG/New Business Development/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (31,42);
INSERT INTO Read_Permissions(position, directory) VALUES (32,42);

INSERT INTO Edit_Permissions(position, directory) VALUES (31,42);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,42);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (31,43);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,43);

-- American education Groupo/AEG/Procurement/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (33,44);

INSERT INTO Edit_Permissions(position, directory) VALUES (33,44);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (33,45);

--   Master Task List
INSERT INTO Read_Permissions(position, directory) VALUES (33,46);

INSERT INTO Edit_Permissions(position, directory) VALUES (33,46);

--   Master Calendar
INSERT INTO Read_Permissions(position, directory) VALUES (33,47);

INSERT INTO Edit_Permissions(position, directory) VALUES (33,47);

-- American Education Group/Schools/Fusion Division/
--   Huntington Beach
-- INSERT INTO Read_Permissions(position, directory) VALUES (,48);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,48);

--   Long Island
-- INSERT INTO Read_Permissions(position, directory) VALUES (,49);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,49);

--   Los Angeles
-- INSERT INTO Read_Permissions(position, directory) VALUES (,50);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,50);

--   Los Gatos
-- INSERT INTO Read_Permissions(position, directory) VALUES (,51);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,51);

--   Manhattan
-- INSERT INTO Read_Permissions(position, directory) VALUES (,52);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,52);

--   Mission Viejo
-- INSERT INTO Read_Permissions(position, directory) VALUES (,53);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,53);

--   Pasadena
-- INSERT INTO Read_Permissions(position, directory) VALUES (,54);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,54);

--   Regional
-- INSERT INTO Read_Permissions(position, directory) VALUES (,55);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,55);

--   San Francisco
-- INSERT INTO Read_Permissions(position, directory) VALUES (,56);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,56);

--   San Mateo
-- INSERT INTO Read_Permissions(position, directory) VALUES (,57);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,57);

--   Solana Beach
-- INSERT INTO Read_Permissions(position, directory) VALUES (,58);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,58);

--   South Bay
-- INSERT INTO Read_Permissions(position, directory) VALUES (,59);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,59);

--   Walnut Creek
-- INSERT INTO Read_Permissions(position, directory) VALUES (,60);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,60);

--   Warner Center
-- INSERT INTO Read_Permissions(position, directory) VALUES (,61);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,61);

--   Fusionology
-- INSERT INTO Read_Permissions(position, directory) VALUES (,62);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,62);

--   Discussion Board
-- INSERT INTO Read_Permissions(position, directory) VALUES (,63);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,63);

--   Outreach
-- INSERT INTO Read_Permissions(position, directory) VALUES (,64);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,64);

--   Accounting
-- INSERT INTO Read_Permissions(position, directory) VALUES (,65);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,65);

--   Leadership
-- INSERT INTO Read_Permissions(position, directory) VALUES (,66);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,66);

--   Registrar
-- INSERT INTO Read_Permissions(position, directory) VALUES (,67);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,67);

--   Curriculum
-- INSERT INTO Read_Permissions(position, directory) VALUES (,68);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,68);

--   Training
-- INSERT INTO Read_Permissions(position, directory) VALUES (,69);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,69);

-- American Education Group/Schools/Lexis/
--   Barnstable
-- INSERT INTO Read_Permissions(position, directory) VALUES (,70);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,70);

--   Shreiner
-- INSERT INTO Read_Permissions(position, directory) VALUES (,71);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,71);

--   Tampa Day
-- INSERT INTO Read_Permissions(position, directory) VALUES (,72);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,72);

--   Talking Heads
-- INSERT INTO Read_Permissions(position, directory) VALUES (,73);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,73);

--   Curriculum
-- INSERT INTO Read_Permissions(position, directory) VALUES (,74);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,74);

--   Scholarship
-- INSERT INTO Read_Permissions(position, directory) VALUES (,75);

-- INSERT INTO Edit_Permissions(position, directory) VALUES (,75);

-- American Education Group/Schools/Little Sprouts/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (252,76);
INSERT INTO Read_Permissions(position, directory) VALUES (253,76);
INSERT INTO Read_Permissions(position, directory) VALUES (254,76);
INSERT INTO Read_Permissions(position, directory) VALUES (255,76);
INSERT INTO Read_Permissions(position, directory) VALUES (256,76);
INSERT INTO Read_Permissions(position, directory) VALUES (257,76);
INSERT INTO Read_Permissions(position, directory) VALUES (258,76);
INSERT INTO Read_Permissions(position, directory) VALUES (259,76);
INSERT INTO Read_Permissions(position, directory) VALUES (260,76);
INSERT INTO Read_Permissions(position, directory) VALUES (261,76);
INSERT INTO Read_Permissions(position, directory) VALUES (262,76);
INSERT INTO Read_Permissions(position, directory) VALUES (263,76);
INSERT INTO Read_Permissions(position, directory) VALUES (264,76);
INSERT INTO Read_Permissions(position, directory) VALUES (265,76);
INSERT INTO Read_Permissions(position, directory) VALUES (266,76);
INSERT INTO Read_Permissions(position, directory) VALUES (267,76);
INSERT INTO Read_Permissions(position, directory) VALUES (268,76);
INSERT INTO Read_Permissions(position, directory) VALUES (269,76);
INSERT INTO Read_Permissions(position, directory) VALUES (270,76);
INSERT INTO Read_Permissions(position, directory) VALUES (271,76);
INSERT INTO Read_Permissions(position, directory) VALUES (272,76);
INSERT INTO Read_Permissions(position, directory) VALUES (273,76);
INSERT INTO Read_Permissions(position, directory) VALUES (274,76);
INSERT INTO Read_Permissions(position, directory) VALUES (275,76);
INSERT INTO Read_Permissions(position, directory) VALUES (276,76);
INSERT INTO Read_Permissions(position, directory) VALUES (277,76);
INSERT INTO Read_Permissions(position, directory) VALUES (278,76);
INSERT INTO Read_Permissions(position, directory) VALUES (279,76);
INSERT INTO Read_Permissions(position, directory) VALUES (280,76);
INSERT INTO Read_Permissions(position, directory) VALUES (281,76);
INSERT INTO Read_Permissions(position, directory) VALUES (282,76);
INSERT INTO Read_Permissions(position, directory) VALUES (283,76);
INSERT INTO Read_Permissions(position, directory) VALUES (284,76);
INSERT INTO Read_Permissions(position, directory) VALUES (285,76);
INSERT INTO Read_Permissions(position, directory) VALUES (286,76);
INSERT INTO Read_Permissions(position, directory) VALUES (287,76);
INSERT INTO Read_Permissions(position, directory) VALUES (288,76);
INSERT INTO Read_Permissions(position, directory) VALUES (289,76);
INSERT INTO Read_Permissions(position, directory) VALUES (290,76);
INSERT INTO Read_Permissions(position, directory) VALUES (291,76);
INSERT INTO Read_Permissions(position, directory) VALUES (292,76);
INSERT INTO Read_Permissions(position, directory) VALUES (293,76);
INSERT INTO Read_Permissions(position, directory) VALUES (294,76);

INSERT INTO Edit_Permissions(position, directory) VALUES (252,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (253,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (254,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (255,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (256,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (257,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (258,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (259,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (260,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (261,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (262,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (263,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (264,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (265,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (266,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (267,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (268,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (269,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (270,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (271,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (272,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (273,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (274,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (275,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (276,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (277,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (278,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (279,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (280,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (281,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (282,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (283,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (284,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,76);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,76);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (252,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (253,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (254,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (255,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (256,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (257,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (258,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (259,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (260,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (261,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (262,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (263,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (264,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (265,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (266,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (267,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (268,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (269,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (270,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (271,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (272,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (273,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (274,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (275,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (277,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (277,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (278,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (279,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (280,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (281,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (282,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (283,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (284,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,77);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,77);

--   SMK
INSERT INTO Read_Permissions(position, directory) VALUES (284,78);
INSERT INTO Read_Permissions(position, directory) VALUES (285,78);
INSERT INTO Read_Permissions(position, directory) VALUES (286,78);
INSERT INTO Read_Permissions(position, directory) VALUES (287,78);
INSERT INTO Read_Permissions(position, directory) VALUES (288,78);
INSERT INTO Read_Permissions(position, directory) VALUES (289,78);
INSERT INTO Read_Permissions(position, directory) VALUES (290,78);
INSERT INTO Read_Permissions(position, directory) VALUES (291,78);
INSERT INTO Read_Permissions(position, directory) VALUES (292,78);
INSERT INTO Read_Permissions(position, directory) VALUES (293,78);
INSERT INTO Read_Permissions(position, directory) VALUES (294,78);

INSERT INTO Edit_Permissions(position, directory) VALUES (284,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,78);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,78);


--   Financials
INSERT INTO Read_Permissions(position, directory) VALUES (285,79);
INSERT INTO Read_Permissions(position, directory) VALUES (294,79);

INSERT INTO Edit_Permissions(position, directory) VALUES (285,79);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,79);

--   Data Centralization
INSERT INTO Read_Permissions(position, directory) VALUES (284,80);
INSERT INTO Read_Permissions(position, directory) VALUES (285,80);
INSERT INTO Read_Permissions(position, directory) VALUES (286,80);
INSERT INTO Read_Permissions(position, directory) VALUES (287,80);
INSERT INTO Read_Permissions(position, directory) VALUES (288,80);
INSERT INTO Read_Permissions(position, directory) VALUES (289,80);
INSERT INTO Read_Permissions(position, directory) VALUES (290,80);
INSERT INTO Read_Permissions(position, directory) VALUES (291,80);
INSERT INTO Read_Permissions(position, directory) VALUES (292,80);
INSERT INTO Read_Permissions(position, directory) VALUES (293,80);
INSERT INTO Read_Permissions(position, directory) VALUES (294,80);

INSERT INTO Edit_Permissions(position, directory) VALUES (284,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,80);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,80);

-- American Education Group/Team Sites/AEG R.O.C.K.S/
--   Corporate
INSERT INTO Read_Permissions(position, directory) VALUES (1,81);
INSERT INTO Read_Permissions(position, directory) VALUES (2,81);
INSERT INTO Read_Permissions(position, directory) VALUES (3,81);
INSERT INTO Read_Permissions(position, directory) VALUES (4,81);
INSERT INTO Read_Permissions(position, directory) VALUES (5,81);
INSERT INTO Read_Permissions(position, directory) VALUES (6,81);
INSERT INTO Read_Permissions(position, directory) VALUES (7,81);
INSERT INTO Read_Permissions(position, directory) VALUES (8,81);
INSERT INTO Read_Permissions(position, directory) VALUES (9,81);
INSERT INTO Read_Permissions(position, directory) VALUES (10,81);
INSERT INTO Read_Permissions(position, directory) VALUES (11,81);
INSERT INTO Read_Permissions(position, directory) VALUES (12,81);
INSERT INTO Read_Permissions(position, directory) VALUES (13,81);
INSERT INTO Read_Permissions(position, directory) VALUES (14,81);
INSERT INTO Read_Permissions(position, directory) VALUES (15,81);
INSERT INTO Read_Permissions(position, directory) VALUES (16,81);
INSERT INTO Read_Permissions(position, directory) VALUES (17,81);
INSERT INTO Read_Permissions(position, directory) VALUES (18,81);
INSERT INTO Read_Permissions(position, directory) VALUES (19,81);
INSERT INTO Read_Permissions(position, directory) VALUES (20,81);
INSERT INTO Read_Permissions(position, directory) VALUES (21,81);
INSERT INTO Read_Permissions(position, directory) VALUES (22,81);
INSERT INTO Read_Permissions(position, directory) VALUES (23,81);
INSERT INTO Read_Permissions(position, directory) VALUES (24,81);
INSERT INTO Read_Permissions(position, directory) VALUES (25,81);
INSERT INTO Read_Permissions(position, directory) VALUES (26,81);
INSERT INTO Read_Permissions(position, directory) VALUES (27,81);
INSERT INTO Read_Permissions(position, directory) VALUES (28,81);
INSERT INTO Read_Permissions(position, directory) VALUES (29,81);
INSERT INTO Read_Permissions(position, directory) VALUES (30,81);
INSERT INTO Read_Permissions(position, directory) VALUES (31,81);
INSERT INTO Read_Permissions(position, directory) VALUES (32,81);
INSERT INTO Read_Permissions(position, directory) VALUES (33,81);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (7,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (8,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (9,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (10,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (11,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (12,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (13,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (14,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (15,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (16,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (17,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (18,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (19,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (20,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (21,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (22,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (23,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (24,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (25,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (26,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (27,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (28,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (29,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (30,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,81);
INSERT INTO Edit_Permissions(position, directory) VALUES (33,81);
--   Fusion
--     Director of Student Development
INSERT INTO Read_Permissions(position, directory) VALUES (38,82);
INSERT INTO Read_Permissions(position, directory) VALUES (51,82);
INSERT INTO Read_Permissions(position, directory) VALUES (64,82);
INSERT INTO Read_Permissions(position, directory) VALUES (77,82);
INSERT INTO Read_Permissions(position, directory) VALUES (90,82);
INSERT INTO Read_Permissions(position, directory) VALUES (103,82);
INSERT INTO Read_Permissions(position, directory) VALUES (116,82);
INSERT INTO Read_Permissions(position, directory) VALUES (129,82);
INSERT INTO Read_Permissions(position, directory) VALUES (142,82);
INSERT INTO Read_Permissions(position, directory) VALUES (155,82);
INSERT INTO Read_Permissions(position, directory) VALUES (168,82);
INSERT INTO Read_Permissions(position, directory) VALUES (181,82);
INSERT INTO Read_Permissions(position, directory) VALUES (194,82);
INSERT INTO Read_Permissions(position, directory) VALUES (207,82);
INSERT INTO Read_Permissions(position, directory) VALUES (220,82);
--     Director of Tutoring
INSERT INTO Read_Permissions(position, directory) VALUES (39,82);
INSERT INTO Read_Permissions(position, directory) VALUES (52,82);
INSERT INTO Read_Permissions(position, directory) VALUES (65,82);
INSERT INTO Read_Permissions(position, directory) VALUES (78,82);
INSERT INTO Read_Permissions(position, directory) VALUES (91,82);
INSERT INTO Read_Permissions(position, directory) VALUES (104,82);
INSERT INTO Read_Permissions(position, directory) VALUES (117,82);
INSERT INTO Read_Permissions(position, directory) VALUES (130,82);
INSERT INTO Read_Permissions(position, directory) VALUES (143,82);
INSERT INTO Read_Permissions(position, directory) VALUES (156,82);
INSERT INTO Read_Permissions(position, directory) VALUES (169,82);
INSERT INTO Read_Permissions(position, directory) VALUES (182,82);
INSERT INTO Read_Permissions(position, directory) VALUES (195,82);
INSERT INTO Read_Permissions(position, directory) VALUES (208,82);
INSERT INTO Read_Permissions(position, directory) VALUES (221,82);
--     Fusionologist
INSERT INTO Read_Permissions(position, directory) VALUES (40,82);
INSERT INTO Read_Permissions(position, directory) VALUES (53,82);
INSERT INTO Read_Permissions(position, directory) VALUES (66,82);
INSERT INTO Read_Permissions(position, directory) VALUES (79,82);
INSERT INTO Read_Permissions(position, directory) VALUES (92,82);
INSERT INTO Read_Permissions(position, directory) VALUES (105,82);
INSERT INTO Read_Permissions(position, directory) VALUES (118,82);
INSERT INTO Read_Permissions(position, directory) VALUES (131,82);
INSERT INTO Read_Permissions(position, directory) VALUES (144,82);
INSERT INTO Read_Permissions(position, directory) VALUES (157,82);
INSERT INTO Read_Permissions(position, directory) VALUES (170,82);
INSERT INTO Read_Permissions(position, directory) VALUES (183,82);
INSERT INTO Read_Permissions(position, directory) VALUES (196,82);
INSERT INTO Read_Permissions(position, directory) VALUES (209,82);
INSERT INTO Read_Permissions(position, directory) VALUES (222,82);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,82);
INSERT INTO Read_Permissions(position, directory) VALUES (54,82);
INSERT INTO Read_Permissions(position, directory) VALUES (67,82);
INSERT INTO Read_Permissions(position, directory) VALUES (80,82);
INSERT INTO Read_Permissions(position, directory) VALUES (93,82);
INSERT INTO Read_Permissions(position, directory) VALUES (106,82);
INSERT INTO Read_Permissions(position, directory) VALUES (119,82);
INSERT INTO Read_Permissions(position, directory) VALUES (132,82);
INSERT INTO Read_Permissions(position, directory) VALUES (145,82);
INSERT INTO Read_Permissions(position, directory) VALUES (158,82);
INSERT INTO Read_Permissions(position, directory) VALUES (171,82);
INSERT INTO Read_Permissions(position, directory) VALUES (184,82);
INSERT INTO Read_Permissions(position, directory) VALUES (197,82);
INSERT INTO Read_Permissions(position, directory) VALUES (210,82);
INSERT INTO Read_Permissions(position, directory) VALUES (223,82);
--     Master Teacher
INSERT INTO Read_Permissions(position, directory) VALUES (43,82);
INSERT INTO Read_Permissions(position, directory) VALUES (56,82);
INSERT INTO Read_Permissions(position, directory) VALUES (69,82);
INSERT INTO Read_Permissions(position, directory) VALUES (82,82);
INSERT INTO Read_Permissions(position, directory) VALUES (95,82);
INSERT INTO Read_Permissions(position, directory) VALUES (108,82);
INSERT INTO Read_Permissions(position, directory) VALUES (120,82);
INSERT INTO Read_Permissions(position, directory) VALUES (134,82);
INSERT INTO Read_Permissions(position, directory) VALUES (147,82);
INSERT INTO Read_Permissions(position, directory) VALUES (160,82);
INSERT INTO Read_Permissions(position, directory) VALUES (173,82);
INSERT INTO Read_Permissions(position, directory) VALUES (186,82);
INSERT INTO Read_Permissions(position, directory) VALUES (199,82);
INSERT INTO Read_Permissions(position, directory) VALUES (212,82);
INSERT INTO Read_Permissions(position, directory) VALUES (225,82);
--     Fusion Regional
INSERT INTO Read_Permissions(position, directory) VALUES (229,82);
INSERT INTO Read_Permissions(position, directory) VALUES (230,82);
INSERT INTO Read_Permissions(position, directory) VALUES (231,82);
INSERT INTO Read_Permissions(position, directory) VALUES (232,82);
INSERT INTO Read_Permissions(position, directory) VALUES (295,82);
INSERT INTO Read_Permissions(position, directory) VALUES (296,82);

--     Director of Student Development
INSERT INTO Edit_Permissions(position, directory) VALUES (38,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (51,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (64,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (77,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (90,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (103,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (116,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (129,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (142,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (155,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (168,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (181,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (194,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (207,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (220,82);
--     Director of Tutoring
INSERT INTO Edit_Permissions(position, directory) VALUES (39,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (52,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (65,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (78,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (91,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (104,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (117,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (130,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (143,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (156,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (169,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (182,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (195,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (208,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (221,82);
--     Fusionologist
INSERT INTO Edit_Permissions(position, directory) VALUES (40,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (53,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (66,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (79,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (92,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (105,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (118,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (131,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (144,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (157,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (170,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (183,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (196,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (209,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (222,82);
--     Head of School
INSERT INTO Edit_Permissions(position, directory) VALUES (41,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (54,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (67,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (80,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (93,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (106,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (119,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (132,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (145,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (158,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (171,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (184,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (197,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (210,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (223,82);
--     Master Teacher
INSERT INTO Edit_Permissions(position, directory) VALUES (43,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (56,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (69,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (82,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (95,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (108,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (120,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (134,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (147,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (160,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (173,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (186,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (199,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (212,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (225,82);
--     Fusion Regional
INSERT INTO Edit_Permissions(position, directory) VALUES (229,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (230,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (231,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (232,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (295,82);
INSERT INTO Edit_Permissions(position, directory) VALUES (296,82);


--   Little Sprouts
INSERT INTO Read_Permissions(position, directory) VALUES (252,83);
INSERT INTO Read_Permissions(position, directory) VALUES (253,83);
INSERT INTO Read_Permissions(position, directory) VALUES (254,83);
INSERT INTO Read_Permissions(position, directory) VALUES (255,83);
INSERT INTO Read_Permissions(position, directory) VALUES (256,83);
INSERT INTO Read_Permissions(position, directory) VALUES (257,83);
INSERT INTO Read_Permissions(position, directory) VALUES (258,83);
INSERT INTO Read_Permissions(position, directory) VALUES (259,83);
INSERT INTO Read_Permissions(position, directory) VALUES (260,83);
INSERT INTO Read_Permissions(position, directory) VALUES (261,83);
INSERT INTO Read_Permissions(position, directory) VALUES (262,83);
INSERT INTO Read_Permissions(position, directory) VALUES (263,83);
INSERT INTO Read_Permissions(position, directory) VALUES (264,83);
INSERT INTO Read_Permissions(position, directory) VALUES (265,83);
INSERT INTO Read_Permissions(position, directory) VALUES (266,83);
INSERT INTO Read_Permissions(position, directory) VALUES (267,83);
INSERT INTO Read_Permissions(position, directory) VALUES (268,83);
INSERT INTO Read_Permissions(position, directory) VALUES (269,83);
INSERT INTO Read_Permissions(position, directory) VALUES (270,83);
INSERT INTO Read_Permissions(position, directory) VALUES (271,83);
INSERT INTO Read_Permissions(position, directory) VALUES (272,83);
INSERT INTO Read_Permissions(position, directory) VALUES (273,83);
INSERT INTO Read_Permissions(position, directory) VALUES (274,83);
INSERT INTO Read_Permissions(position, directory) VALUES (275,83);
INSERT INTO Read_Permissions(position, directory) VALUES (276,83);
INSERT INTO Read_Permissions(position, directory) VALUES (277,83);
INSERT INTO Read_Permissions(position, directory) VALUES (278,83);
INSERT INTO Read_Permissions(position, directory) VALUES (279,83);
INSERT INTO Read_Permissions(position, directory) VALUES (280,83);
INSERT INTO Read_Permissions(position, directory) VALUES (281,83);
INSERT INTO Read_Permissions(position, directory) VALUES (282,83);
INSERT INTO Read_Permissions(position, directory) VALUES (283,83);
INSERT INTO Read_Permissions(position, directory) VALUES (284,83);
INSERT INTO Read_Permissions(position, directory) VALUES (285,83);
INSERT INTO Read_Permissions(position, directory) VALUES (286,83);
INSERT INTO Read_Permissions(position, directory) VALUES (287,83);
INSERT INTO Read_Permissions(position, directory) VALUES (288,83);
INSERT INTO Read_Permissions(position, directory) VALUES (289,83);
INSERT INTO Read_Permissions(position, directory) VALUES (290,83);
INSERT INTO Read_Permissions(position, directory) VALUES (291,83);
INSERT INTO Read_Permissions(position, directory) VALUES (292,83);
INSERT INTO Read_Permissions(position, directory) VALUES (293,83);
INSERT INTO Read_Permissions(position, directory) VALUES (294,83);

INSERT INTO Edit_Permissions(position, directory) VALUES (252,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (253,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (254,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (255,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (256,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (257,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (258,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (259,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (260,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (261,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (262,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (263,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (264,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (265,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (266,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (267,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (268,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (269,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (270,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (271,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (272,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (273,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (274,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (275,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (276,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (277,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (278,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (279,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (280,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (281,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (282,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (283,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (284,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,83);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,83);

-- American Education Group/Team Site/NSO/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (1,84);
INSERT INTO Read_Permissions(position, directory) VALUES (2,84);
INSERT INTO Read_Permissions(position, directory) VALUES (3,84);
INSERT INTO Read_Permissions(position, directory) VALUES (4,84);
INSERT INTO Read_Permissions(position, directory) VALUES (5,84);
INSERT INTO Read_Permissions(position, directory) VALUES (6,84);
INSERT INTO Read_Permissions(position, directory) VALUES (31,84);
INSERT INTO Read_Permissions(position, directory) VALUES (32,84);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,84);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,84);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (1,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,85);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,85);

--   New Business Development
INSERT INTO Read_Permissions(position, directory) VALUES (31,86);
INSERT INTO Read_Permissions(position, directory) VALUES (32,86);

INSERT INTO Edit_Permissions(position, directory) VALUES (31,86);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,86);

--   Construction Folder
INSERT INTO Read_Permissions(position, directory) VALUES (1,87);
INSERT INTO Read_Permissions(position, directory) VALUES (2,87);
INSERT INTO Read_Permissions(position, directory) VALUES (3,87);
INSERT INTO Read_Permissions(position, directory) VALUES (4,87);
INSERT INTO Read_Permissions(position, directory) VALUES (5,87);
INSERT INTO Read_Permissions(position, directory) VALUES (6,87);
INSERT INTO Read_Permissions(position, directory) VALUES (31,87);
INSERT INTO Read_Permissions(position, directory) VALUES (32,87);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,87);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,87);

--   Real Estate Folder
INSERT INTO Read_Permissions(position, directory) VALUES (1,88);
INSERT INTO Read_Permissions(position, directory) VALUES (2,88);
INSERT INTO Read_Permissions(position, directory) VALUES (3,88);
INSERT INTO Read_Permissions(position, directory) VALUES (4,88);
INSERT INTO Read_Permissions(position, directory) VALUES (5,88);
INSERT INTO Read_Permissions(position, directory) VALUES (6,88);
INSERT INTO Read_Permissions(position, directory) VALUES (31,88);
INSERT INTO Read_Permissions(position, directory) VALUES (32,88);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,88);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,88);

--   Project Tasks
INSERT INTO Read_Permissions(position, directory) VALUES (1,89);
INSERT INTO Read_Permissions(position, directory) VALUES (2,89);
INSERT INTO Read_Permissions(position, directory) VALUES (3,89);
INSERT INTO Read_Permissions(position, directory) VALUES (4,89);
INSERT INTO Read_Permissions(position, directory) VALUES (5,89);
INSERT INTO Read_Permissions(position, directory) VALUES (6,89);
INSERT INTO Read_Permissions(position, directory) VALUES (7,89);
INSERT INTO Read_Permissions(position, directory) VALUES (8,89);
INSERT INTO Read_Permissions(position, directory) VALUES (9,89);
INSERT INTO Read_Permissions(position, directory) VALUES (10,89);
INSERT INTO Read_Permissions(position, directory) VALUES (11,89);
INSERT INTO Read_Permissions(position, directory) VALUES (12,89);
INSERT INTO Read_Permissions(position, directory) VALUES (13,89);
INSERT INTO Read_Permissions(position, directory) VALUES (14,89);
INSERT INTO Read_Permissions(position, directory) VALUES (15,89);
INSERT INTO Read_Permissions(position, directory) VALUES (16,89);
INSERT INTO Read_Permissions(position, directory) VALUES (17,89);
INSERT INTO Read_Permissions(position, directory) VALUES (18,89);
INSERT INTO Read_Permissions(position, directory) VALUES (19,89);
INSERT INTO Read_Permissions(position, directory) VALUES (20,89);
INSERT INTO Read_Permissions(position, directory) VALUES (21,89);
INSERT INTO Read_Permissions(position, directory) VALUES (22,89);
INSERT INTO Read_Permissions(position, directory) VALUES (23,89);
INSERT INTO Read_Permissions(position, directory) VALUES (24,89);
INSERT INTO Read_Permissions(position, directory) VALUES (25,89);
INSERT INTO Read_Permissions(position, directory) VALUES (26,89);
INSERT INTO Read_Permissions(position, directory) VALUES (27,89);
INSERT INTO Read_Permissions(position, directory) VALUES (28,89);
INSERT INTO Read_Permissions(position, directory) VALUES (29,89);
INSERT INTO Read_Permissions(position, directory) VALUES (30,89);
INSERT INTO Read_Permissions(position, directory) VALUES (31,89);
INSERT INTO Read_Permissions(position, directory) VALUES (32,89);
INSERT INTO Read_Permissions(position, directory) VALUES (33,89);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,89);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,89);

--   Project Calendar
INSERT INTO Read_Permissions(position, directory) VALUES (1,90);
INSERT INTO Read_Permissions(position, directory) VALUES (2,90);
INSERT INTO Read_Permissions(position, directory) VALUES (3,90);
INSERT INTO Read_Permissions(position, directory) VALUES (4,90);
INSERT INTO Read_Permissions(position, directory) VALUES (5,90);
INSERT INTO Read_Permissions(position, directory) VALUES (6,90);
INSERT INTO Read_Permissions(position, directory) VALUES (7,90);
INSERT INTO Read_Permissions(position, directory) VALUES (8,90);
INSERT INTO Read_Permissions(position, directory) VALUES (9,90);
INSERT INTO Read_Permissions(position, directory) VALUES (10,90);
INSERT INTO Read_Permissions(position, directory) VALUES (11,90);
INSERT INTO Read_Permissions(position, directory) VALUES (12,90);
INSERT INTO Read_Permissions(position, directory) VALUES (13,90);
INSERT INTO Read_Permissions(position, directory) VALUES (14,90);
INSERT INTO Read_Permissions(position, directory) VALUES (15,90);
INSERT INTO Read_Permissions(position, directory) VALUES (16,90);
INSERT INTO Read_Permissions(position, directory) VALUES (17,90);
INSERT INTO Read_Permissions(position, directory) VALUES (18,90);
INSERT INTO Read_Permissions(position, directory) VALUES (19,90);
INSERT INTO Read_Permissions(position, directory) VALUES (20,90);
INSERT INTO Read_Permissions(position, directory) VALUES (21,90);
INSERT INTO Read_Permissions(position, directory) VALUES (22,90);
INSERT INTO Read_Permissions(position, directory) VALUES (23,90);
INSERT INTO Read_Permissions(position, directory) VALUES (24,90);
INSERT INTO Read_Permissions(position, directory) VALUES (25,90);
INSERT INTO Read_Permissions(position, directory) VALUES (26,90);
INSERT INTO Read_Permissions(position, directory) VALUES (27,90);
INSERT INTO Read_Permissions(position, directory) VALUES (28,90);
INSERT INTO Read_Permissions(position, directory) VALUES (29,90);
INSERT INTO Read_Permissions(position, directory) VALUES (30,90);
INSERT INTO Read_Permissions(position, directory) VALUES (31,90);
INSERT INTO Read_Permissions(position, directory) VALUES (32,90);
INSERT INTO Read_Permissions(position, directory) VALUES (33,90);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (31,90);
INSERT INTO Edit_Permissions(position, directory) VALUES (32,90);

-- American Education Group/Team Sites/MPOPs/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,91);

INSERT INTO Edit_Permissions(position, directory) VALUES (,91);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,92);

--   Little Sprouts
INSERT INTO Read_Permissions(position, directory) VALUES (253,93);
INSERT INTO Read_Permissions(position, directory) VALUES (255,93);
INSERT INTO Read_Permissions(position, directory) VALUES (257,93);
INSERT INTO Read_Permissions(position, directory) VALUES (259,93);
INSERT INTO Read_Permissions(position, directory) VALUES (261,93);
INSERT INTO Read_Permissions(position, directory) VALUES (263,93);
INSERT INTO Read_Permissions(position, directory) VALUES (265,93);
INSERT INTO Read_Permissions(position, directory) VALUES (267,93);
INSERT INTO Read_Permissions(position, directory) VALUES (269,93);
INSERT INTO Read_Permissions(position, directory) VALUES (271,93);
INSERT INTO Read_Permissions(position, directory) VALUES (273,93);
INSERT INTO Read_Permissions(position, directory) VALUES (275,93);
INSERT INTO Read_Permissions(position, directory) VALUES (277,93);
INSERT INTO Read_Permissions(position, directory) VALUES (279,93);
INSERT INTO Read_Permissions(position, directory) VALUES (281,93);
INSERT INTO Read_Permissions(position, directory) VALUES (283,93);
INSERT INTO Read_Permissions(position, directory) VALUES (284,93);
INSERT INTO Read_Permissions(position, directory) VALUES (285,93);
INSERT INTO Read_Permissions(position, directory) VALUES (286,93);
INSERT INTO Read_Permissions(position, directory) VALUES (287,93);
INSERT INTO Read_Permissions(position, directory) VALUES (288,93);
INSERT INTO Read_Permissions(position, directory) VALUES (289,93);
INSERT INTO Read_Permissions(position, directory) VALUES (290,93);
INSERT INTO Read_Permissions(position, directory) VALUES (291,93);
INSERT INTO Read_Permissions(position, directory) VALUES (292,93);
INSERT INTO Read_Permissions(position, directory) VALUES (293,93);
INSERT INTO Read_Permissions(position, directory) VALUES (294,93);

INSERT INTO Edit_Permissions(position, directory) VALUES (253,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (255,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (257,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (259,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (261,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (263,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (265,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (267,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (269,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (271,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (273,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (275,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (277,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (279,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (281,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (283,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (284,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (285,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (286,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (287,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (288,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (289,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (290,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (291,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (292,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (293,93);
INSERT INTO Edit_Permissions(position, directory) VALUES (294,93);

--   Fusion Division
--     Director of Student Development
INSERT INTO Read_Permissions(position, directory) VALUES (38,94);
INSERT INTO Read_Permissions(position, directory) VALUES (51,94);
INSERT INTO Read_Permissions(position, directory) VALUES (64,94);
INSERT INTO Read_Permissions(position, directory) VALUES (77,94);
INSERT INTO Read_Permissions(position, directory) VALUES (90,94);
INSERT INTO Read_Permissions(position, directory) VALUES (103,94);
INSERT INTO Read_Permissions(position, directory) VALUES (116,94);
INSERT INTO Read_Permissions(position, directory) VALUES (129,94);
INSERT INTO Read_Permissions(position, directory) VALUES (142,94);
INSERT INTO Read_Permissions(position, directory) VALUES (155,94);
INSERT INTO Read_Permissions(position, directory) VALUES (168,94);
INSERT INTO Read_Permissions(position, directory) VALUES (181,94);
INSERT INTO Read_Permissions(position, directory) VALUES (194,94);
INSERT INTO Read_Permissions(position, directory) VALUES (207,94);
INSERT INTO Read_Permissions(position, directory) VALUES (220,94);
--     Director of Tutoring
INSERT INTO Read_Permissions(position, directory) VALUES (39,94);
INSERT INTO Read_Permissions(position, directory) VALUES (52,94);
INSERT INTO Read_Permissions(position, directory) VALUES (65,94);
INSERT INTO Read_Permissions(position, directory) VALUES (78,94);
INSERT INTO Read_Permissions(position, directory) VALUES (91,94);
INSERT INTO Read_Permissions(position, directory) VALUES (104,94);
INSERT INTO Read_Permissions(position, directory) VALUES (117,94);
INSERT INTO Read_Permissions(position, directory) VALUES (130,94);
INSERT INTO Read_Permissions(position, directory) VALUES (143,94);
INSERT INTO Read_Permissions(position, directory) VALUES (156,94);
INSERT INTO Read_Permissions(position, directory) VALUES (169,94);
INSERT INTO Read_Permissions(position, directory) VALUES (194,94);
INSERT INTO Read_Permissions(position, directory) VALUES (195,94);
INSERT INTO Read_Permissions(position, directory) VALUES (208,94);
INSERT INTO Read_Permissions(position, directory) VALUES (221,94);
--     Fusionologist
INSERT INTO Read_Permissions(position, directory) VALUES (40,94);
INSERT INTO Read_Permissions(position, directory) VALUES (53,94);
INSERT INTO Read_Permissions(position, directory) VALUES (66,94);
INSERT INTO Read_Permissions(position, directory) VALUES (79,94);
INSERT INTO Read_Permissions(position, directory) VALUES (92,94);
INSERT INTO Read_Permissions(position, directory) VALUES (105,94);
INSERT INTO Read_Permissions(position, directory) VALUES (118,94);
INSERT INTO Read_Permissions(position, directory) VALUES (131,94);
INSERT INTO Read_Permissions(position, directory) VALUES (144,94);
INSERT INTO Read_Permissions(position, directory) VALUES (157,94);
INSERT INTO Read_Permissions(position, directory) VALUES (170,94);
INSERT INTO Read_Permissions(position, directory) VALUES (183,94);
INSERT INTO Read_Permissions(position, directory) VALUES (196,94);
INSERT INTO Read_Permissions(position, directory) VALUES (209,94);
INSERT INTO Read_Permissions(position, directory) VALUES (222,94);
--     Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (41,94);
INSERT INTO Read_Permissions(position, directory) VALUES (54,94);
INSERT INTO Read_Permissions(position, directory) VALUES (67,94);
INSERT INTO Read_Permissions(position, directory) VALUES (80,94);
INSERT INTO Read_Permissions(position, directory) VALUES (93,94);
INSERT INTO Read_Permissions(position, directory) VALUES (106,94);
INSERT INTO Read_Permissions(position, directory) VALUES (119,94);
INSERT INTO Read_Permissions(position, directory) VALUES (132,94);
INSERT INTO Read_Permissions(position, directory) VALUES (145,94);
INSERT INTO Read_Permissions(position, directory) VALUES (158,94);
INSERT INTO Read_Permissions(position, directory) VALUES (171,94);
INSERT INTO Read_Permissions(position, directory) VALUES (184,94);
INSERT INTO Read_Permissions(position, directory) VALUES (197,94);
INSERT INTO Read_Permissions(position, directory) VALUES (210,94);
INSERT INTO Read_Permissions(position, directory) VALUES (223,94);
--     Master Teacher
INSERT INTO Read_Permissions(position, directory) VALUES (43,94);
INSERT INTO Read_Permissions(position, directory) VALUES (56,94);
INSERT INTO Read_Permissions(position, directory) VALUES (69,94);
INSERT INTO Read_Permissions(position, directory) VALUES (94,94);
INSERT INTO Read_Permissions(position, directory) VALUES (95,94);
INSERT INTO Read_Permissions(position, directory) VALUES (108,94);
INSERT INTO Read_Permissions(position, directory) VALUES (120,94);
INSERT INTO Read_Permissions(position, directory) VALUES (134,94);
INSERT INTO Read_Permissions(position, directory) VALUES (147,94);
INSERT INTO Read_Permissions(position, directory) VALUES (160,94);
INSERT INTO Read_Permissions(position, directory) VALUES (173,94);
INSERT INTO Read_Permissions(position, directory) VALUES (186,94);
INSERT INTO Read_Permissions(position, directory) VALUES (199,94);
INSERT INTO Read_Permissions(position, directory) VALUES (212,94);
INSERT INTO Read_Permissions(position, directory) VALUES (225,94);
--     Fusion Regional
INSERT INTO Read_Permissions(position, directory) VALUES (229,94);
INSERT INTO Read_Permissions(position, directory) VALUES (230,94);
INSERT INTO Read_Permissions(position, directory) VALUES (231,94);
INSERT INTO Read_Permissions(position, directory) VALUES (232,94);
INSERT INTO Read_Permissions(position, directory) VALUES (295,94);
INSERT INTO Read_Permissions(position, directory) VALUES (296,94);

--     Director of Student Development
INSERT INTO Edit_Permissions(position, directory) VALUES (38,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (51,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (64,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (77,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (90,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (103,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (116,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (129,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (142,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (155,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (168,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (181,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (194,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (207,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (220,94);
--     Director of Tutoring
INSERT INTO Edit_Permissions(position, directory) VALUES (39,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (52,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (65,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (78,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (91,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (104,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (117,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (130,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (143,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (156,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (169,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (194,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (195,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (208,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (221,94);
--     Fusionologist
INSERT INTO Edit_Permissions(position, directory) VALUES (40,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (53,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (66,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (79,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (92,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (105,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (118,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (131,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (144,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (157,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (170,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (183,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (196,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (209,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (222,94);
--     Head of School
INSERT INTO Edit_Permissions(position, directory) VALUES (41,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (54,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (67,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (80,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (93,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (106,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (119,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (132,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (145,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (158,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (171,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (184,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (197,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (210,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (223,94);
--     Master Teacher
INSERT INTO Edit_Permissions(position, directory) VALUES (43,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (56,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (69,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (94,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (95,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (108,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (120,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (134,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (147,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (160,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (173,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (186,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (199,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (212,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (225,94);
--     Fusion Regional
INSERT INTO Edit_Permissions(position, directory) VALUES (229,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (230,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (231,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (232,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (295,94);
INSERT INTO Edit_Permissions(position, directory) VALUES (296,94);

--   Tampa Day School
INSERT INTO Read_Permissions(position, directory) VALUES (244,95);
INSERT INTO Read_Permissions(position, directory) VALUES (245,95);
INSERT INTO Read_Permissions(position, directory) VALUES (246,95);
INSERT INTO Read_Permissions(position, directory) VALUES (247,95);
INSERT INTO Read_Permissions(position, directory) VALUES (248,95);
INSERT INTO Read_Permissions(position, directory) VALUES (249,95);

INSERT INTO Edit_Permissions(position, directory) VALUES (244,95);
INSERT INTO Edit_Permissions(position, directory) VALUES (245,95);
INSERT INTO Edit_Permissions(position, directory) VALUES (246,95);
INSERT INTO Edit_Permissions(position, directory) VALUES (247,95);
INSERT INTO Edit_Permissions(position, directory) VALUES (248,95);
INSERT INTO Edit_Permissions(position, directory) VALUES (249,95);

--   Barnstable Academy
INSERT INTO Read_Permissions(position, directory) VALUES (233,96);
INSERT INTO Read_Permissions(position, directory) VALUES (234,96);
INSERT INTO Read_Permissions(position, directory) VALUES (235,96);
INSERT INTO Read_Permissions(position, directory) VALUES (236,96);

INSERT INTO Edit_Permissions(position, directory) VALUES (233,96);
INSERT INTO Edit_Permissions(position, directory) VALUES (234,96);
INSERT INTO Edit_Permissions(position, directory) VALUES (235,96);
INSERT INTO Edit_Permissions(position, directory) VALUES (236,96);

--   Shreiner Academy
INSERT INTO Read_Permissions(position, directory) VALUES (239,97);
INSERT INTO Read_Permissions(position, directory) VALUES (240,97);
INSERT INTO Read_Permissions(position, directory) VALUES (241,97);

INSERT INTO Edit_Permissions(position, directory) VALUES (239,97);
INSERT INTO Edit_Permissions(position, directory) VALUES (240,97);
INSERT INTO Edit_Permissions(position, directory) VALUES (241,97);

-- American Education Group/Team Sites/EPIC! Portal/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (1,98);
INSERT INTO Read_Permissions(position, directory) VALUES (2,98);
INSERT INTO Read_Permissions(position, directory) VALUES (3,98);
INSERT INTO Read_Permissions(position, directory) VALUES (4,98);
INSERT INTO Read_Permissions(position, directory) VALUES (5,98);
INSERT INTO Read_Permissions(position, directory) VALUES (6,98);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,98);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,98);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,98);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,98);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,98);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,98);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (1,99);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,99);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,99);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,99);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,99);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,99);

--   EPIC! Summits
INSERT INTO Read_Permissions(position, directory) VALUES (1,100);
INSERT INTO Read_Permissions(position, directory) VALUES (2,100);
INSERT INTO Read_Permissions(position, directory) VALUES (3,100);
INSERT INTO Read_Permissions(position, directory) VALUES (4,100);
INSERT INTO Read_Permissions(position, directory) VALUES (5,100);
INSERT INTO Read_Permissions(position, directory) VALUES (6,100);
INSERT INTO Read_Permissions(position, directory) VALUES (7,100);
INSERT INTO Read_Permissions(position, directory) VALUES (8,100);
INSERT INTO Read_Permissions(position, directory) VALUES (9,100);
INSERT INTO Read_Permissions(position, directory) VALUES (10,100);
INSERT INTO Read_Permissions(position, directory) VALUES (11,100);
INSERT INTO Read_Permissions(position, directory) VALUES (12,100);
INSERT INTO Read_Permissions(position, directory) VALUES (13,100);
INSERT INTO Read_Permissions(position, directory) VALUES (14,100);
INSERT INTO Read_Permissions(position, directory) VALUES (15,100);
INSERT INTO Read_Permissions(position, directory) VALUES (16,100);
INSERT INTO Read_Permissions(position, directory) VALUES (17,100);
INSERT INTO Read_Permissions(position, directory) VALUES (18,100);
INSERT INTO Read_Permissions(position, directory) VALUES (19,100);
INSERT INTO Read_Permissions(position, directory) VALUES (20,100);
INSERT INTO Read_Permissions(position, directory) VALUES (21,100);
INSERT INTO Read_Permissions(position, directory) VALUES (22,100);
INSERT INTO Read_Permissions(position, directory) VALUES (23,100);
INSERT INTO Read_Permissions(position, directory) VALUES (24,100);
INSERT INTO Read_Permissions(position, directory) VALUES (25,100);
INSERT INTO Read_Permissions(position, directory) VALUES (26,100);
INSERT INTO Read_Permissions(position, directory) VALUES (27,100);
INSERT INTO Read_Permissions(position, directory) VALUES (28,100);
INSERT INTO Read_Permissions(position, directory) VALUES (29,100);
INSERT INTO Read_Permissions(position, directory) VALUES (30,100);
INSERT INTO Read_Permissions(position, directory) VALUES (31,100);
INSERT INTO Read_Permissions(position, directory) VALUES (32,100);
INSERT INTO Read_Permissions(position, directory) VALUES (33,100);
INSERT INTO Read_Permissions(position, directory) VALUES (34,100);
INSERT INTO Read_Permissions(position, directory) VALUES (35,100);
INSERT INTO Read_Permissions(position, directory) VALUES (36,100);
INSERT INTO Read_Permissions(position, directory) VALUES (37,100);
INSERT INTO Read_Permissions(position, directory) VALUES (38,100);
INSERT INTO Read_Permissions(position, directory) VALUES (39,100);
INSERT INTO Read_Permissions(position, directory) VALUES (40,100);
INSERT INTO Read_Permissions(position, directory) VALUES (41,100);
INSERT INTO Read_Permissions(position, directory) VALUES (42,100);
INSERT INTO Read_Permissions(position, directory) VALUES (43,100);
INSERT INTO Read_Permissions(position, directory) VALUES (44,100);
INSERT INTO Read_Permissions(position, directory) VALUES (45,100);
INSERT INTO Read_Permissions(position, directory) VALUES (46,100);
INSERT INTO Read_Permissions(position, directory) VALUES (47,100);
INSERT INTO Read_Permissions(position, directory) VALUES (48,100);
INSERT INTO Read_Permissions(position, directory) VALUES (49,100);
INSERT INTO Read_Permissions(position, directory) VALUES (50,100);
INSERT INTO Read_Permissions(position, directory) VALUES (51,100);
INSERT INTO Read_Permissions(position, directory) VALUES (52,100);
INSERT INTO Read_Permissions(position, directory) VALUES (53,100);
INSERT INTO Read_Permissions(position, directory) VALUES (54,100);
INSERT INTO Read_Permissions(position, directory) VALUES (55,100);
INSERT INTO Read_Permissions(position, directory) VALUES (56,100);
INSERT INTO Read_Permissions(position, directory) VALUES (57,100);
INSERT INTO Read_Permissions(position, directory) VALUES (58,100);
INSERT INTO Read_Permissions(position, directory) VALUES (59,100);
INSERT INTO Read_Permissions(position, directory) VALUES (60,100);
INSERT INTO Read_Permissions(position, directory) VALUES (61,100);
INSERT INTO Read_Permissions(position, directory) VALUES (62,100);
INSERT INTO Read_Permissions(position, directory) VALUES (63,100);
INSERT INTO Read_Permissions(position, directory) VALUES (64,100);
INSERT INTO Read_Permissions(position, directory) VALUES (65,100);
INSERT INTO Read_Permissions(position, directory) VALUES (66,100);
INSERT INTO Read_Permissions(position, directory) VALUES (67,100);
INSERT INTO Read_Permissions(position, directory) VALUES (68,100);
INSERT INTO Read_Permissions(position, directory) VALUES (69,100);
INSERT INTO Read_Permissions(position, directory) VALUES (70,100);
INSERT INTO Read_Permissions(position, directory) VALUES (71,100);
INSERT INTO Read_Permissions(position, directory) VALUES (72,100);
INSERT INTO Read_Permissions(position, directory) VALUES (73,100);
INSERT INTO Read_Permissions(position, directory) VALUES (74,100);
INSERT INTO Read_Permissions(position, directory) VALUES (75,100);
INSERT INTO Read_Permissions(position, directory) VALUES (76,100);
INSERT INTO Read_Permissions(position, directory) VALUES (77,100);
INSERT INTO Read_Permissions(position, directory) VALUES (78,100);
INSERT INTO Read_Permissions(position, directory) VALUES (79,100);
INSERT INTO Read_Permissions(position, directory) VALUES (80,100);
INSERT INTO Read_Permissions(position, directory) VALUES (81,100);
INSERT INTO Read_Permissions(position, directory) VALUES (82,100);
INSERT INTO Read_Permissions(position, directory) VALUES (83,100);
INSERT INTO Read_Permissions(position, directory) VALUES (84,100);
INSERT INTO Read_Permissions(position, directory) VALUES (85,100);
INSERT INTO Read_Permissions(position, directory) VALUES (86,100);
INSERT INTO Read_Permissions(position, directory) VALUES (87,100);
INSERT INTO Read_Permissions(position, directory) VALUES (88,100);
INSERT INTO Read_Permissions(position, directory) VALUES (89,100);
INSERT INTO Read_Permissions(position, directory) VALUES (90,100);
INSERT INTO Read_Permissions(position, directory) VALUES (91,100);
INSERT INTO Read_Permissions(position, directory) VALUES (92,100);
INSERT INTO Read_Permissions(position, directory) VALUES (93,100);
INSERT INTO Read_Permissions(position, directory) VALUES (94,100);
INSERT INTO Read_Permissions(position, directory) VALUES (95,100);
INSERT INTO Read_Permissions(position, directory) VALUES (96,100);
INSERT INTO Read_Permissions(position, directory) VALUES (97,100);
INSERT INTO Read_Permissions(position, directory) VALUES (98,100);
INSERT INTO Read_Permissions(position, directory) VALUES (99,100);
INSERT INTO Read_Permissions(position, directory) VALUES (100,100);
INSERT INTO Read_Permissions(position, directory) VALUES (101,100);
INSERT INTO Read_Permissions(position, directory) VALUES (102,100);
INSERT INTO Read_Permissions(position, directory) VALUES (103,100);
INSERT INTO Read_Permissions(position, directory) VALUES (104,100);
INSERT INTO Read_Permissions(position, directory) VALUES (105,100);
INSERT INTO Read_Permissions(position, directory) VALUES (106,100);
INSERT INTO Read_Permissions(position, directory) VALUES (107,100);
INSERT INTO Read_Permissions(position, directory) VALUES (108,100);
INSERT INTO Read_Permissions(position, directory) VALUES (109,100);
INSERT INTO Read_Permissions(position, directory) VALUES (110,100);
INSERT INTO Read_Permissions(position, directory) VALUES (111,100);
INSERT INTO Read_Permissions(position, directory) VALUES (112,100);
INSERT INTO Read_Permissions(position, directory) VALUES (113,100);
INSERT INTO Read_Permissions(position, directory) VALUES (114,100);
INSERT INTO Read_Permissions(position, directory) VALUES (115,100);
INSERT INTO Read_Permissions(position, directory) VALUES (116,100);
INSERT INTO Read_Permissions(position, directory) VALUES (117,100);
INSERT INTO Read_Permissions(position, directory) VALUES (118,100);
INSERT INTO Read_Permissions(position, directory) VALUES (119,100);
INSERT INTO Read_Permissions(position, directory) VALUES (120,100);
INSERT INTO Read_Permissions(position, directory) VALUES (121,100);
INSERT INTO Read_Permissions(position, directory) VALUES (122,100);
INSERT INTO Read_Permissions(position, directory) VALUES (123,100);
INSERT INTO Read_Permissions(position, directory) VALUES (124,100);
INSERT INTO Read_Permissions(position, directory) VALUES (125,100);
INSERT INTO Read_Permissions(position, directory) VALUES (126,100);
INSERT INTO Read_Permissions(position, directory) VALUES (127,100);
INSERT INTO Read_Permissions(position, directory) VALUES (128,100);
INSERT INTO Read_Permissions(position, directory) VALUES (129,100);
INSERT INTO Read_Permissions(position, directory) VALUES (130,100);
INSERT INTO Read_Permissions(position, directory) VALUES (131,100);
INSERT INTO Read_Permissions(position, directory) VALUES (132,100);
INSERT INTO Read_Permissions(position, directory) VALUES (133,100);
INSERT INTO Read_Permissions(position, directory) VALUES (134,100);
INSERT INTO Read_Permissions(position, directory) VALUES (135,100);
INSERT INTO Read_Permissions(position, directory) VALUES (136,100);
INSERT INTO Read_Permissions(position, directory) VALUES (137,100);
INSERT INTO Read_Permissions(position, directory) VALUES (138,100);
INSERT INTO Read_Permissions(position, directory) VALUES (139,100);
INSERT INTO Read_Permissions(position, directory) VALUES (140,100);
INSERT INTO Read_Permissions(position, directory) VALUES (141,100);
INSERT INTO Read_Permissions(position, directory) VALUES (142,100);
INSERT INTO Read_Permissions(position, directory) VALUES (143,100);
INSERT INTO Read_Permissions(position, directory) VALUES (144,100);
INSERT INTO Read_Permissions(position, directory) VALUES (145,100);
INSERT INTO Read_Permissions(position, directory) VALUES (146,100);
INSERT INTO Read_Permissions(position, directory) VALUES (147,100);
INSERT INTO Read_Permissions(position, directory) VALUES (148,100);
INSERT INTO Read_Permissions(position, directory) VALUES (149,100);
INSERT INTO Read_Permissions(position, directory) VALUES (150,100);
INSERT INTO Read_Permissions(position, directory) VALUES (151,100);
INSERT INTO Read_Permissions(position, directory) VALUES (152,100);
INSERT INTO Read_Permissions(position, directory) VALUES (153,100);
INSERT INTO Read_Permissions(position, directory) VALUES (154,100);
INSERT INTO Read_Permissions(position, directory) VALUES (155,100);
INSERT INTO Read_Permissions(position, directory) VALUES (156,100);
INSERT INTO Read_Permissions(position, directory) VALUES (157,100);
INSERT INTO Read_Permissions(position, directory) VALUES (158,100);
INSERT INTO Read_Permissions(position, directory) VALUES (159,100);
INSERT INTO Read_Permissions(position, directory) VALUES (160,100);
INSERT INTO Read_Permissions(position, directory) VALUES (161,100);
INSERT INTO Read_Permissions(position, directory) VALUES (162,100);
INSERT INTO Read_Permissions(position, directory) VALUES (163,100);
INSERT INTO Read_Permissions(position, directory) VALUES (164,100);
INSERT INTO Read_Permissions(position, directory) VALUES (165,100);
INSERT INTO Read_Permissions(position, directory) VALUES (166,100);
INSERT INTO Read_Permissions(position, directory) VALUES (167,100);
INSERT INTO Read_Permissions(position, directory) VALUES (168,100);
INSERT INTO Read_Permissions(position, directory) VALUES (169,100);
INSERT INTO Read_Permissions(position, directory) VALUES (170,100);
INSERT INTO Read_Permissions(position, directory) VALUES (171,100);
INSERT INTO Read_Permissions(position, directory) VALUES (172,100);
INSERT INTO Read_Permissions(position, directory) VALUES (173,100);
INSERT INTO Read_Permissions(position, directory) VALUES (174,100);
INSERT INTO Read_Permissions(position, directory) VALUES (175,100);
INSERT INTO Read_Permissions(position, directory) VALUES (176,100);
INSERT INTO Read_Permissions(position, directory) VALUES (177,100);
INSERT INTO Read_Permissions(position, directory) VALUES (178,100);
INSERT INTO Read_Permissions(position, directory) VALUES (179,100);
INSERT INTO Read_Permissions(position, directory) VALUES (180,100);
INSERT INTO Read_Permissions(position, directory) VALUES (181,100);
INSERT INTO Read_Permissions(position, directory) VALUES (182,100);
INSERT INTO Read_Permissions(position, directory) VALUES (183,100);
INSERT INTO Read_Permissions(position, directory) VALUES (184,100);
INSERT INTO Read_Permissions(position, directory) VALUES (185,100);
INSERT INTO Read_Permissions(position, directory) VALUES (186,100);
INSERT INTO Read_Permissions(position, directory) VALUES (187,100);
INSERT INTO Read_Permissions(position, directory) VALUES (188,100);
INSERT INTO Read_Permissions(position, directory) VALUES (189,100);
INSERT INTO Read_Permissions(position, directory) VALUES (190,100);
INSERT INTO Read_Permissions(position, directory) VALUES (191,100);
INSERT INTO Read_Permissions(position, directory) VALUES (192,100);
INSERT INTO Read_Permissions(position, directory) VALUES (193,100);
INSERT INTO Read_Permissions(position, directory) VALUES (194,100);
INSERT INTO Read_Permissions(position, directory) VALUES (195,100);
INSERT INTO Read_Permissions(position, directory) VALUES (196,100);
INSERT INTO Read_Permissions(position, directory) VALUES (197,100);
INSERT INTO Read_Permissions(position, directory) VALUES (198,100);
INSERT INTO Read_Permissions(position, directory) VALUES (199,100);
INSERT INTO Read_Permissions(position, directory) VALUES (200,100);
INSERT INTO Read_Permissions(position, directory) VALUES (201,100);
INSERT INTO Read_Permissions(position, directory) VALUES (202,100);
INSERT INTO Read_Permissions(position, directory) VALUES (203,100);
INSERT INTO Read_Permissions(position, directory) VALUES (204,100);
INSERT INTO Read_Permissions(position, directory) VALUES (205,100);
INSERT INTO Read_Permissions(position, directory) VALUES (206,100);
INSERT INTO Read_Permissions(position, directory) VALUES (207,100);
INSERT INTO Read_Permissions(position, directory) VALUES (208,100);
INSERT INTO Read_Permissions(position, directory) VALUES (209,100);
INSERT INTO Read_Permissions(position, directory) VALUES (210,100);
INSERT INTO Read_Permissions(position, directory) VALUES (211,100);
INSERT INTO Read_Permissions(position, directory) VALUES (212,100);
INSERT INTO Read_Permissions(position, directory) VALUES (213,100);
INSERT INTO Read_Permissions(position, directory) VALUES (214,100);
INSERT INTO Read_Permissions(position, directory) VALUES (215,100);
INSERT INTO Read_Permissions(position, directory) VALUES (216,100);
INSERT INTO Read_Permissions(position, directory) VALUES (217,100);
INSERT INTO Read_Permissions(position, directory) VALUES (218,100);
INSERT INTO Read_Permissions(position, directory) VALUES (219,100);
INSERT INTO Read_Permissions(position, directory) VALUES (220,100);
INSERT INTO Read_Permissions(position, directory) VALUES (221,100);
INSERT INTO Read_Permissions(position, directory) VALUES (222,100);
INSERT INTO Read_Permissions(position, directory) VALUES (223,100);
INSERT INTO Read_Permissions(position, directory) VALUES (224,100);
INSERT INTO Read_Permissions(position, directory) VALUES (225,100);
INSERT INTO Read_Permissions(position, directory) VALUES (226,100);
INSERT INTO Read_Permissions(position, directory) VALUES (227,100);
INSERT INTO Read_Permissions(position, directory) VALUES (228,100);
INSERT INTO Read_Permissions(position, directory) VALUES (229,100);
INSERT INTO Read_Permissions(position, directory) VALUES (230,100);
INSERT INTO Read_Permissions(position, directory) VALUES (231,100);
INSERT INTO Read_Permissions(position, directory) VALUES (232,100);
INSERT INTO Read_Permissions(position, directory) VALUES (233,100);
INSERT INTO Read_Permissions(position, directory) VALUES (234,100);
INSERT INTO Read_Permissions(position, directory) VALUES (235,100);
INSERT INTO Read_Permissions(position, directory) VALUES (236,100);
INSERT INTO Read_Permissions(position, directory) VALUES (237,100);
INSERT INTO Read_Permissions(position, directory) VALUES (238,100);
INSERT INTO Read_Permissions(position, directory) VALUES (239,100);
INSERT INTO Read_Permissions(position, directory) VALUES (240,100);
INSERT INTO Read_Permissions(position, directory) VALUES (241,100);
INSERT INTO Read_Permissions(position, directory) VALUES (242,100);
INSERT INTO Read_Permissions(position, directory) VALUES (243,100);
INSERT INTO Read_Permissions(position, directory) VALUES (244,100);
INSERT INTO Read_Permissions(position, directory) VALUES (245,100);
INSERT INTO Read_Permissions(position, directory) VALUES (246,100);
INSERT INTO Read_Permissions(position, directory) VALUES (247,100);
INSERT INTO Read_Permissions(position, directory) VALUES (248,100);
INSERT INTO Read_Permissions(position, directory) VALUES (249,100);
INSERT INTO Read_Permissions(position, directory) VALUES (250,100);
INSERT INTO Read_Permissions(position, directory) VALUES (251,100);
INSERT INTO Read_Permissions(position, directory) VALUES (252,100);
INSERT INTO Read_Permissions(position, directory) VALUES (253,100);
INSERT INTO Read_Permissions(position, directory) VALUES (254,100);
INSERT INTO Read_Permissions(position, directory) VALUES (255,100);
INSERT INTO Read_Permissions(position, directory) VALUES (256,100);
INSERT INTO Read_Permissions(position, directory) VALUES (257,100);
INSERT INTO Read_Permissions(position, directory) VALUES (258,100);
INSERT INTO Read_Permissions(position, directory) VALUES (259,100);
INSERT INTO Read_Permissions(position, directory) VALUES (260,100);
INSERT INTO Read_Permissions(position, directory) VALUES (261,100);
INSERT INTO Read_Permissions(position, directory) VALUES (262,100);
INSERT INTO Read_Permissions(position, directory) VALUES (263,100);
INSERT INTO Read_Permissions(position, directory) VALUES (264,100);
INSERT INTO Read_Permissions(position, directory) VALUES (265,100);
INSERT INTO Read_Permissions(position, directory) VALUES (266,100);
INSERT INTO Read_Permissions(position, directory) VALUES (267,100);
INSERT INTO Read_Permissions(position, directory) VALUES (268,100);
INSERT INTO Read_Permissions(position, directory) VALUES (269,100);
INSERT INTO Read_Permissions(position, directory) VALUES (270,100);
INSERT INTO Read_Permissions(position, directory) VALUES (271,100);
INSERT INTO Read_Permissions(position, directory) VALUES (272,100);
INSERT INTO Read_Permissions(position, directory) VALUES (273,100);
INSERT INTO Read_Permissions(position, directory) VALUES (274,100);
INSERT INTO Read_Permissions(position, directory) VALUES (275,100);
INSERT INTO Read_Permissions(position, directory) VALUES (276,100);
INSERT INTO Read_Permissions(position, directory) VALUES (277,100);
INSERT INTO Read_Permissions(position, directory) VALUES (278,100);
INSERT INTO Read_Permissions(position, directory) VALUES (279,100);
INSERT INTO Read_Permissions(position, directory) VALUES (280,100);
INSERT INTO Read_Permissions(position, directory) VALUES (281,100);
INSERT INTO Read_Permissions(position, directory) VALUES (282,100);
INSERT INTO Read_Permissions(position, directory) VALUES (283,100);
INSERT INTO Read_Permissions(position, directory) VALUES (284,100);
INSERT INTO Read_Permissions(position, directory) VALUES (285,100);
INSERT INTO Read_Permissions(position, directory) VALUES (286,100);
INSERT INTO Read_Permissions(position, directory) VALUES (287,100);
INSERT INTO Read_Permissions(position, directory) VALUES (288,100);
INSERT INTO Read_Permissions(position, directory) VALUES (289,100);
INSERT INTO Read_Permissions(position, directory) VALUES (290,100);
INSERT INTO Read_Permissions(position, directory) VALUES (291,100);
INSERT INTO Read_Permissions(position, directory) VALUES (292,100);
INSERT INTO Read_Permissions(position, directory) VALUES (293,100);
INSERT INTO Read_Permissions(position, directory) VALUES (294,100);
INSERT INTO Read_Permissions(position, directory) VALUES (295,100);
INSERT INTO Read_Permissions(position, directory) VALUES (296,100);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,100);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,100);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,100);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,100);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,100);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,100);

--   Reinventing School News
INSERT INTO Read_Permissions(position, directory) VALUES (1,101);
INSERT INTO Read_Permissions(position, directory) VALUES (2,101);
INSERT INTO Read_Permissions(position, directory) VALUES (3,101);
INSERT INTO Read_Permissions(position, directory) VALUES (4,101);
INSERT INTO Read_Permissions(position, directory) VALUES (5,101);
INSERT INTO Read_Permissions(position, directory) VALUES (6,101);
INSERT INTO Read_Permissions(position, directory) VALUES (7,101);
INSERT INTO Read_Permissions(position, directory) VALUES (8,101);
INSERT INTO Read_Permissions(position, directory) VALUES (9,101);
INSERT INTO Read_Permissions(position, directory) VALUES (10,101);
INSERT INTO Read_Permissions(position, directory) VALUES (11,101);
INSERT INTO Read_Permissions(position, directory) VALUES (12,101);
INSERT INTO Read_Permissions(position, directory) VALUES (13,101);
INSERT INTO Read_Permissions(position, directory) VALUES (14,101);
INSERT INTO Read_Permissions(position, directory) VALUES (15,101);
INSERT INTO Read_Permissions(position, directory) VALUES (16,101);
INSERT INTO Read_Permissions(position, directory) VALUES (17,101);
INSERT INTO Read_Permissions(position, directory) VALUES (18,101);
INSERT INTO Read_Permissions(position, directory) VALUES (19,101);
INSERT INTO Read_Permissions(position, directory) VALUES (20,101);
INSERT INTO Read_Permissions(position, directory) VALUES (21,101);
INSERT INTO Read_Permissions(position, directory) VALUES (22,101);
INSERT INTO Read_Permissions(position, directory) VALUES (23,101);
INSERT INTO Read_Permissions(position, directory) VALUES (24,101);
INSERT INTO Read_Permissions(position, directory) VALUES (25,101);
INSERT INTO Read_Permissions(position, directory) VALUES (26,101);
INSERT INTO Read_Permissions(position, directory) VALUES (27,101);
INSERT INTO Read_Permissions(position, directory) VALUES (28,101);
INSERT INTO Read_Permissions(position, directory) VALUES (29,101);
INSERT INTO Read_Permissions(position, directory) VALUES (30,101);
INSERT INTO Read_Permissions(position, directory) VALUES (31,101);
INSERT INTO Read_Permissions(position, directory) VALUES (32,101);
INSERT INTO Read_Permissions(position, directory) VALUES (33,101);
INSERT INTO Read_Permissions(position, directory) VALUES (34,101);
INSERT INTO Read_Permissions(position, directory) VALUES (35,101);
INSERT INTO Read_Permissions(position, directory) VALUES (36,101);
INSERT INTO Read_Permissions(position, directory) VALUES (37,101);
INSERT INTO Read_Permissions(position, directory) VALUES (38,101);
INSERT INTO Read_Permissions(position, directory) VALUES (39,101);
INSERT INTO Read_Permissions(position, directory) VALUES (40,101);
INSERT INTO Read_Permissions(position, directory) VALUES (41,101);
INSERT INTO Read_Permissions(position, directory) VALUES (42,101);
INSERT INTO Read_Permissions(position, directory) VALUES (43,101);
INSERT INTO Read_Permissions(position, directory) VALUES (44,101);
INSERT INTO Read_Permissions(position, directory) VALUES (45,101);
INSERT INTO Read_Permissions(position, directory) VALUES (46,101);
INSERT INTO Read_Permissions(position, directory) VALUES (47,101);
INSERT INTO Read_Permissions(position, directory) VALUES (48,101);
INSERT INTO Read_Permissions(position, directory) VALUES (49,101);
INSERT INTO Read_Permissions(position, directory) VALUES (50,101);
INSERT INTO Read_Permissions(position, directory) VALUES (51,101);
INSERT INTO Read_Permissions(position, directory) VALUES (52,101);
INSERT INTO Read_Permissions(position, directory) VALUES (53,101);
INSERT INTO Read_Permissions(position, directory) VALUES (54,101);
INSERT INTO Read_Permissions(position, directory) VALUES (55,101);
INSERT INTO Read_Permissions(position, directory) VALUES (56,101);
INSERT INTO Read_Permissions(position, directory) VALUES (57,101);
INSERT INTO Read_Permissions(position, directory) VALUES (58,101);
INSERT INTO Read_Permissions(position, directory) VALUES (59,101);
INSERT INTO Read_Permissions(position, directory) VALUES (60,101);
INSERT INTO Read_Permissions(position, directory) VALUES (61,101);
INSERT INTO Read_Permissions(position, directory) VALUES (62,101);
INSERT INTO Read_Permissions(position, directory) VALUES (63,101);
INSERT INTO Read_Permissions(position, directory) VALUES (64,101);
INSERT INTO Read_Permissions(position, directory) VALUES (65,101);
INSERT INTO Read_Permissions(position, directory) VALUES (66,101);
INSERT INTO Read_Permissions(position, directory) VALUES (67,101);
INSERT INTO Read_Permissions(position, directory) VALUES (68,101);
INSERT INTO Read_Permissions(position, directory) VALUES (69,101);
INSERT INTO Read_Permissions(position, directory) VALUES (70,101);
INSERT INTO Read_Permissions(position, directory) VALUES (71,101);
INSERT INTO Read_Permissions(position, directory) VALUES (72,101);
INSERT INTO Read_Permissions(position, directory) VALUES (73,101);
INSERT INTO Read_Permissions(position, directory) VALUES (74,101);
INSERT INTO Read_Permissions(position, directory) VALUES (75,101);
INSERT INTO Read_Permissions(position, directory) VALUES (76,101);
INSERT INTO Read_Permissions(position, directory) VALUES (77,101);
INSERT INTO Read_Permissions(position, directory) VALUES (78,101);
INSERT INTO Read_Permissions(position, directory) VALUES (79,101);
INSERT INTO Read_Permissions(position, directory) VALUES (80,101);
INSERT INTO Read_Permissions(position, directory) VALUES (81,101);
INSERT INTO Read_Permissions(position, directory) VALUES (82,101);
INSERT INTO Read_Permissions(position, directory) VALUES (83,101);
INSERT INTO Read_Permissions(position, directory) VALUES (84,101);
INSERT INTO Read_Permissions(position, directory) VALUES (85,101);
INSERT INTO Read_Permissions(position, directory) VALUES (86,101);
INSERT INTO Read_Permissions(position, directory) VALUES (87,101);
INSERT INTO Read_Permissions(position, directory) VALUES (88,101);
INSERT INTO Read_Permissions(position, directory) VALUES (89,101);
INSERT INTO Read_Permissions(position, directory) VALUES (90,101);
INSERT INTO Read_Permissions(position, directory) VALUES (91,101);
INSERT INTO Read_Permissions(position, directory) VALUES (92,101);
INSERT INTO Read_Permissions(position, directory) VALUES (93,101);
INSERT INTO Read_Permissions(position, directory) VALUES (94,101);
INSERT INTO Read_Permissions(position, directory) VALUES (95,101);
INSERT INTO Read_Permissions(position, directory) VALUES (96,101);
INSERT INTO Read_Permissions(position, directory) VALUES (97,101);
INSERT INTO Read_Permissions(position, directory) VALUES (98,101);
INSERT INTO Read_Permissions(position, directory) VALUES (99,101);
INSERT INTO Read_Permissions(position, directory) VALUES (100,101);
INSERT INTO Read_Permissions(position, directory) VALUES (101,101);
INSERT INTO Read_Permissions(position, directory) VALUES (102,101);
INSERT INTO Read_Permissions(position, directory) VALUES (103,101);
INSERT INTO Read_Permissions(position, directory) VALUES (104,101);
INSERT INTO Read_Permissions(position, directory) VALUES (105,101);
INSERT INTO Read_Permissions(position, directory) VALUES (106,101);
INSERT INTO Read_Permissions(position, directory) VALUES (107,101);
INSERT INTO Read_Permissions(position, directory) VALUES (108,101);
INSERT INTO Read_Permissions(position, directory) VALUES (109,101);
INSERT INTO Read_Permissions(position, directory) VALUES (110,101);
INSERT INTO Read_Permissions(position, directory) VALUES (111,101);
INSERT INTO Read_Permissions(position, directory) VALUES (112,101);
INSERT INTO Read_Permissions(position, directory) VALUES (113,101);
INSERT INTO Read_Permissions(position, directory) VALUES (114,101);
INSERT INTO Read_Permissions(position, directory) VALUES (115,101);
INSERT INTO Read_Permissions(position, directory) VALUES (116,101);
INSERT INTO Read_Permissions(position, directory) VALUES (117,101);
INSERT INTO Read_Permissions(position, directory) VALUES (118,101);
INSERT INTO Read_Permissions(position, directory) VALUES (119,101);
INSERT INTO Read_Permissions(position, directory) VALUES (120,101);
INSERT INTO Read_Permissions(position, directory) VALUES (121,101);
INSERT INTO Read_Permissions(position, directory) VALUES (122,101);
INSERT INTO Read_Permissions(position, directory) VALUES (123,101);
INSERT INTO Read_Permissions(position, directory) VALUES (124,101);
INSERT INTO Read_Permissions(position, directory) VALUES (125,101);
INSERT INTO Read_Permissions(position, directory) VALUES (126,101);
INSERT INTO Read_Permissions(position, directory) VALUES (127,101);
INSERT INTO Read_Permissions(position, directory) VALUES (128,101);
INSERT INTO Read_Permissions(position, directory) VALUES (129,101);
INSERT INTO Read_Permissions(position, directory) VALUES (130,101);
INSERT INTO Read_Permissions(position, directory) VALUES (131,101);
INSERT INTO Read_Permissions(position, directory) VALUES (132,101);
INSERT INTO Read_Permissions(position, directory) VALUES (133,101);
INSERT INTO Read_Permissions(position, directory) VALUES (134,101);
INSERT INTO Read_Permissions(position, directory) VALUES (135,101);
INSERT INTO Read_Permissions(position, directory) VALUES (136,101);
INSERT INTO Read_Permissions(position, directory) VALUES (137,101);
INSERT INTO Read_Permissions(position, directory) VALUES (138,101);
INSERT INTO Read_Permissions(position, directory) VALUES (139,101);
INSERT INTO Read_Permissions(position, directory) VALUES (140,101);
INSERT INTO Read_Permissions(position, directory) VALUES (141,101);
INSERT INTO Read_Permissions(position, directory) VALUES (142,101);
INSERT INTO Read_Permissions(position, directory) VALUES (143,101);
INSERT INTO Read_Permissions(position, directory) VALUES (144,101);
INSERT INTO Read_Permissions(position, directory) VALUES (145,101);
INSERT INTO Read_Permissions(position, directory) VALUES (146,101);
INSERT INTO Read_Permissions(position, directory) VALUES (147,101);
INSERT INTO Read_Permissions(position, directory) VALUES (148,101);
INSERT INTO Read_Permissions(position, directory) VALUES (149,101);
INSERT INTO Read_Permissions(position, directory) VALUES (150,101);
INSERT INTO Read_Permissions(position, directory) VALUES (151,101);
INSERT INTO Read_Permissions(position, directory) VALUES (152,101);
INSERT INTO Read_Permissions(position, directory) VALUES (153,101);
INSERT INTO Read_Permissions(position, directory) VALUES (154,101);
INSERT INTO Read_Permissions(position, directory) VALUES (155,101);
INSERT INTO Read_Permissions(position, directory) VALUES (156,101);
INSERT INTO Read_Permissions(position, directory) VALUES (157,101);
INSERT INTO Read_Permissions(position, directory) VALUES (158,101);
INSERT INTO Read_Permissions(position, directory) VALUES (159,101);
INSERT INTO Read_Permissions(position, directory) VALUES (160,101);
INSERT INTO Read_Permissions(position, directory) VALUES (161,101);
INSERT INTO Read_Permissions(position, directory) VALUES (162,101);
INSERT INTO Read_Permissions(position, directory) VALUES (163,101);
INSERT INTO Read_Permissions(position, directory) VALUES (164,101);
INSERT INTO Read_Permissions(position, directory) VALUES (165,101);
INSERT INTO Read_Permissions(position, directory) VALUES (166,101);
INSERT INTO Read_Permissions(position, directory) VALUES (167,101);
INSERT INTO Read_Permissions(position, directory) VALUES (168,101);
INSERT INTO Read_Permissions(position, directory) VALUES (169,101);
INSERT INTO Read_Permissions(position, directory) VALUES (170,101);
INSERT INTO Read_Permissions(position, directory) VALUES (171,101);
INSERT INTO Read_Permissions(position, directory) VALUES (172,101);
INSERT INTO Read_Permissions(position, directory) VALUES (173,101);
INSERT INTO Read_Permissions(position, directory) VALUES (174,101);
INSERT INTO Read_Permissions(position, directory) VALUES (175,101);
INSERT INTO Read_Permissions(position, directory) VALUES (176,101);
INSERT INTO Read_Permissions(position, directory) VALUES (177,101);
INSERT INTO Read_Permissions(position, directory) VALUES (178,101);
INSERT INTO Read_Permissions(position, directory) VALUES (179,101);
INSERT INTO Read_Permissions(position, directory) VALUES (180,101);
INSERT INTO Read_Permissions(position, directory) VALUES (181,101);
INSERT INTO Read_Permissions(position, directory) VALUES (182,101);
INSERT INTO Read_Permissions(position, directory) VALUES (183,101);
INSERT INTO Read_Permissions(position, directory) VALUES (184,101);
INSERT INTO Read_Permissions(position, directory) VALUES (185,101);
INSERT INTO Read_Permissions(position, directory) VALUES (186,101);
INSERT INTO Read_Permissions(position, directory) VALUES (187,101);
INSERT INTO Read_Permissions(position, directory) VALUES (188,101);
INSERT INTO Read_Permissions(position, directory) VALUES (189,101);
INSERT INTO Read_Permissions(position, directory) VALUES (190,101);
INSERT INTO Read_Permissions(position, directory) VALUES (191,101);
INSERT INTO Read_Permissions(position, directory) VALUES (192,101);
INSERT INTO Read_Permissions(position, directory) VALUES (193,101);
INSERT INTO Read_Permissions(position, directory) VALUES (194,101);
INSERT INTO Read_Permissions(position, directory) VALUES (195,101);
INSERT INTO Read_Permissions(position, directory) VALUES (196,101);
INSERT INTO Read_Permissions(position, directory) VALUES (197,101);
INSERT INTO Read_Permissions(position, directory) VALUES (198,101);
INSERT INTO Read_Permissions(position, directory) VALUES (199,101);
INSERT INTO Read_Permissions(position, directory) VALUES (200,101);
INSERT INTO Read_Permissions(position, directory) VALUES (201,101);
INSERT INTO Read_Permissions(position, directory) VALUES (202,101);
INSERT INTO Read_Permissions(position, directory) VALUES (203,101);
INSERT INTO Read_Permissions(position, directory) VALUES (204,101);
INSERT INTO Read_Permissions(position, directory) VALUES (205,101);
INSERT INTO Read_Permissions(position, directory) VALUES (206,101);
INSERT INTO Read_Permissions(position, directory) VALUES (207,101);
INSERT INTO Read_Permissions(position, directory) VALUES (208,101);
INSERT INTO Read_Permissions(position, directory) VALUES (209,101);
INSERT INTO Read_Permissions(position, directory) VALUES (210,101);
INSERT INTO Read_Permissions(position, directory) VALUES (211,101);
INSERT INTO Read_Permissions(position, directory) VALUES (212,101);
INSERT INTO Read_Permissions(position, directory) VALUES (213,101);
INSERT INTO Read_Permissions(position, directory) VALUES (214,101);
INSERT INTO Read_Permissions(position, directory) VALUES (215,101);
INSERT INTO Read_Permissions(position, directory) VALUES (216,101);
INSERT INTO Read_Permissions(position, directory) VALUES (217,101);
INSERT INTO Read_Permissions(position, directory) VALUES (218,101);
INSERT INTO Read_Permissions(position, directory) VALUES (219,101);
INSERT INTO Read_Permissions(position, directory) VALUES (220,101);
INSERT INTO Read_Permissions(position, directory) VALUES (221,101);
INSERT INTO Read_Permissions(position, directory) VALUES (222,101);
INSERT INTO Read_Permissions(position, directory) VALUES (223,101);
INSERT INTO Read_Permissions(position, directory) VALUES (224,101);
INSERT INTO Read_Permissions(position, directory) VALUES (225,101);
INSERT INTO Read_Permissions(position, directory) VALUES (226,101);
INSERT INTO Read_Permissions(position, directory) VALUES (227,101);
INSERT INTO Read_Permissions(position, directory) VALUES (228,101);
INSERT INTO Read_Permissions(position, directory) VALUES (229,101);
INSERT INTO Read_Permissions(position, directory) VALUES (230,101);
INSERT INTO Read_Permissions(position, directory) VALUES (231,101);
INSERT INTO Read_Permissions(position, directory) VALUES (232,101);
INSERT INTO Read_Permissions(position, directory) VALUES (233,101);
INSERT INTO Read_Permissions(position, directory) VALUES (234,101);
INSERT INTO Read_Permissions(position, directory) VALUES (235,101);
INSERT INTO Read_Permissions(position, directory) VALUES (236,101);
INSERT INTO Read_Permissions(position, directory) VALUES (237,101);
INSERT INTO Read_Permissions(position, directory) VALUES (238,101);
INSERT INTO Read_Permissions(position, directory) VALUES (239,101);
INSERT INTO Read_Permissions(position, directory) VALUES (240,101);
INSERT INTO Read_Permissions(position, directory) VALUES (241,101);
INSERT INTO Read_Permissions(position, directory) VALUES (242,101);
INSERT INTO Read_Permissions(position, directory) VALUES (243,101);
INSERT INTO Read_Permissions(position, directory) VALUES (244,101);
INSERT INTO Read_Permissions(position, directory) VALUES (245,101);
INSERT INTO Read_Permissions(position, directory) VALUES (246,101);
INSERT INTO Read_Permissions(position, directory) VALUES (247,101);
INSERT INTO Read_Permissions(position, directory) VALUES (248,101);
INSERT INTO Read_Permissions(position, directory) VALUES (249,101);
INSERT INTO Read_Permissions(position, directory) VALUES (250,101);
INSERT INTO Read_Permissions(position, directory) VALUES (251,101);
INSERT INTO Read_Permissions(position, directory) VALUES (252,101);
INSERT INTO Read_Permissions(position, directory) VALUES (253,101);
INSERT INTO Read_Permissions(position, directory) VALUES (254,101);
INSERT INTO Read_Permissions(position, directory) VALUES (255,101);
INSERT INTO Read_Permissions(position, directory) VALUES (256,101);
INSERT INTO Read_Permissions(position, directory) VALUES (257,101);
INSERT INTO Read_Permissions(position, directory) VALUES (258,101);
INSERT INTO Read_Permissions(position, directory) VALUES (259,101);
INSERT INTO Read_Permissions(position, directory) VALUES (260,101);
INSERT INTO Read_Permissions(position, directory) VALUES (261,101);
INSERT INTO Read_Permissions(position, directory) VALUES (262,101);
INSERT INTO Read_Permissions(position, directory) VALUES (263,101);
INSERT INTO Read_Permissions(position, directory) VALUES (264,101);
INSERT INTO Read_Permissions(position, directory) VALUES (265,101);
INSERT INTO Read_Permissions(position, directory) VALUES (266,101);
INSERT INTO Read_Permissions(position, directory) VALUES (267,101);
INSERT INTO Read_Permissions(position, directory) VALUES (268,101);
INSERT INTO Read_Permissions(position, directory) VALUES (269,101);
INSERT INTO Read_Permissions(position, directory) VALUES (270,101);
INSERT INTO Read_Permissions(position, directory) VALUES (271,101);
INSERT INTO Read_Permissions(position, directory) VALUES (272,101);
INSERT INTO Read_Permissions(position, directory) VALUES (273,101);
INSERT INTO Read_Permissions(position, directory) VALUES (274,101);
INSERT INTO Read_Permissions(position, directory) VALUES (275,101);
INSERT INTO Read_Permissions(position, directory) VALUES (276,101);
INSERT INTO Read_Permissions(position, directory) VALUES (277,101);
INSERT INTO Read_Permissions(position, directory) VALUES (278,101);
INSERT INTO Read_Permissions(position, directory) VALUES (279,101);
INSERT INTO Read_Permissions(position, directory) VALUES (280,101);
INSERT INTO Read_Permissions(position, directory) VALUES (281,101);
INSERT INTO Read_Permissions(position, directory) VALUES (282,101);
INSERT INTO Read_Permissions(position, directory) VALUES (283,101);
INSERT INTO Read_Permissions(position, directory) VALUES (284,101);
INSERT INTO Read_Permissions(position, directory) VALUES (285,101);
INSERT INTO Read_Permissions(position, directory) VALUES (286,101);
INSERT INTO Read_Permissions(position, directory) VALUES (287,101);
INSERT INTO Read_Permissions(position, directory) VALUES (288,101);
INSERT INTO Read_Permissions(position, directory) VALUES (289,101);
INSERT INTO Read_Permissions(position, directory) VALUES (290,101);
INSERT INTO Read_Permissions(position, directory) VALUES (291,101);
INSERT INTO Read_Permissions(position, directory) VALUES (292,101);
INSERT INTO Read_Permissions(position, directory) VALUES (293,101);
INSERT INTO Read_Permissions(position, directory) VALUES (294,101);
INSERT INTO Read_Permissions(position, directory) VALUES (295,101);
INSERT INTO Read_Permissions(position, directory) VALUES (296,101);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,101);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,101);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,101);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,101);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,101);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,101);

--   Rock 'N' CulturRoll Awareness
INSERT INTO Read_Permissions(position, directory) VALUES (1,102);
INSERT INTO Read_Permissions(position, directory) VALUES (2,102);
INSERT INTO Read_Permissions(position, directory) VALUES (3,102);
INSERT INTO Read_Permissions(position, directory) VALUES (4,102);
INSERT INTO Read_Permissions(position, directory) VALUES (5,102);
INSERT INTO Read_Permissions(position, directory) VALUES (6,102);
INSERT INTO Read_Permissions(position, directory) VALUES (7,102);
INSERT INTO Read_Permissions(position, directory) VALUES (8,102);
INSERT INTO Read_Permissions(position, directory) VALUES (9,102);
INSERT INTO Read_Permissions(position, directory) VALUES (10,102);
INSERT INTO Read_Permissions(position, directory) VALUES (11,102);
INSERT INTO Read_Permissions(position, directory) VALUES (12,102);
INSERT INTO Read_Permissions(position, directory) VALUES (13,102);
INSERT INTO Read_Permissions(position, directory) VALUES (14,102);
INSERT INTO Read_Permissions(position, directory) VALUES (15,102);
INSERT INTO Read_Permissions(position, directory) VALUES (16,102);
INSERT INTO Read_Permissions(position, directory) VALUES (17,102);
INSERT INTO Read_Permissions(position, directory) VALUES (18,102);
INSERT INTO Read_Permissions(position, directory) VALUES (19,102);
INSERT INTO Read_Permissions(position, directory) VALUES (20,102);
INSERT INTO Read_Permissions(position, directory) VALUES (21,102);
INSERT INTO Read_Permissions(position, directory) VALUES (22,102);
INSERT INTO Read_Permissions(position, directory) VALUES (23,102);
INSERT INTO Read_Permissions(position, directory) VALUES (24,102);
INSERT INTO Read_Permissions(position, directory) VALUES (25,102);
INSERT INTO Read_Permissions(position, directory) VALUES (26,102);
INSERT INTO Read_Permissions(position, directory) VALUES (27,102);
INSERT INTO Read_Permissions(position, directory) VALUES (28,102);
INSERT INTO Read_Permissions(position, directory) VALUES (29,102);
INSERT INTO Read_Permissions(position, directory) VALUES (30,102);
INSERT INTO Read_Permissions(position, directory) VALUES (31,102);
INSERT INTO Read_Permissions(position, directory) VALUES (32,102);
INSERT INTO Read_Permissions(position, directory) VALUES (33,102);
INSERT INTO Read_Permissions(position, directory) VALUES (34,102);
INSERT INTO Read_Permissions(position, directory) VALUES (35,102);
INSERT INTO Read_Permissions(position, directory) VALUES (36,102);
INSERT INTO Read_Permissions(position, directory) VALUES (37,102);
INSERT INTO Read_Permissions(position, directory) VALUES (38,102);
INSERT INTO Read_Permissions(position, directory) VALUES (39,102);
INSERT INTO Read_Permissions(position, directory) VALUES (40,102);
INSERT INTO Read_Permissions(position, directory) VALUES (41,102);
INSERT INTO Read_Permissions(position, directory) VALUES (42,102);
INSERT INTO Read_Permissions(position, directory) VALUES (43,102);
INSERT INTO Read_Permissions(position, directory) VALUES (44,102);
INSERT INTO Read_Permissions(position, directory) VALUES (45,102);
INSERT INTO Read_Permissions(position, directory) VALUES (46,102);
INSERT INTO Read_Permissions(position, directory) VALUES (47,102);
INSERT INTO Read_Permissions(position, directory) VALUES (48,102);
INSERT INTO Read_Permissions(position, directory) VALUES (49,102);
INSERT INTO Read_Permissions(position, directory) VALUES (50,102);
INSERT INTO Read_Permissions(position, directory) VALUES (51,102);
INSERT INTO Read_Permissions(position, directory) VALUES (52,102);
INSERT INTO Read_Permissions(position, directory) VALUES (53,102);
INSERT INTO Read_Permissions(position, directory) VALUES (54,102);
INSERT INTO Read_Permissions(position, directory) VALUES (55,102);
INSERT INTO Read_Permissions(position, directory) VALUES (56,102);
INSERT INTO Read_Permissions(position, directory) VALUES (57,102);
INSERT INTO Read_Permissions(position, directory) VALUES (58,102);
INSERT INTO Read_Permissions(position, directory) VALUES (59,102);
INSERT INTO Read_Permissions(position, directory) VALUES (60,102);
INSERT INTO Read_Permissions(position, directory) VALUES (61,102);
INSERT INTO Read_Permissions(position, directory) VALUES (62,102);
INSERT INTO Read_Permissions(position, directory) VALUES (63,102);
INSERT INTO Read_Permissions(position, directory) VALUES (64,102);
INSERT INTO Read_Permissions(position, directory) VALUES (65,102);
INSERT INTO Read_Permissions(position, directory) VALUES (66,102);
INSERT INTO Read_Permissions(position, directory) VALUES (67,102);
INSERT INTO Read_Permissions(position, directory) VALUES (68,102);
INSERT INTO Read_Permissions(position, directory) VALUES (69,102);
INSERT INTO Read_Permissions(position, directory) VALUES (70,102);
INSERT INTO Read_Permissions(position, directory) VALUES (71,102);
INSERT INTO Read_Permissions(position, directory) VALUES (72,102);
INSERT INTO Read_Permissions(position, directory) VALUES (73,102);
INSERT INTO Read_Permissions(position, directory) VALUES (74,102);
INSERT INTO Read_Permissions(position, directory) VALUES (75,102);
INSERT INTO Read_Permissions(position, directory) VALUES (76,102);
INSERT INTO Read_Permissions(position, directory) VALUES (77,102);
INSERT INTO Read_Permissions(position, directory) VALUES (78,102);
INSERT INTO Read_Permissions(position, directory) VALUES (79,102);
INSERT INTO Read_Permissions(position, directory) VALUES (80,102);
INSERT INTO Read_Permissions(position, directory) VALUES (81,102);
INSERT INTO Read_Permissions(position, directory) VALUES (82,102);
INSERT INTO Read_Permissions(position, directory) VALUES (83,102);
INSERT INTO Read_Permissions(position, directory) VALUES (84,102);
INSERT INTO Read_Permissions(position, directory) VALUES (85,102);
INSERT INTO Read_Permissions(position, directory) VALUES (86,102);
INSERT INTO Read_Permissions(position, directory) VALUES (87,102);
INSERT INTO Read_Permissions(position, directory) VALUES (88,102);
INSERT INTO Read_Permissions(position, directory) VALUES (89,102);
INSERT INTO Read_Permissions(position, directory) VALUES (90,102);
INSERT INTO Read_Permissions(position, directory) VALUES (91,102);
INSERT INTO Read_Permissions(position, directory) VALUES (92,102);
INSERT INTO Read_Permissions(position, directory) VALUES (93,102);
INSERT INTO Read_Permissions(position, directory) VALUES (94,102);
INSERT INTO Read_Permissions(position, directory) VALUES (95,102);
INSERT INTO Read_Permissions(position, directory) VALUES (96,102);
INSERT INTO Read_Permissions(position, directory) VALUES (97,102);
INSERT INTO Read_Permissions(position, directory) VALUES (98,102);
INSERT INTO Read_Permissions(position, directory) VALUES (99,102);
INSERT INTO Read_Permissions(position, directory) VALUES (100,102);
INSERT INTO Read_Permissions(position, directory) VALUES (101,102);
INSERT INTO Read_Permissions(position, directory) VALUES (102,102);
INSERT INTO Read_Permissions(position, directory) VALUES (103,102);
INSERT INTO Read_Permissions(position, directory) VALUES (104,102);
INSERT INTO Read_Permissions(position, directory) VALUES (105,102);
INSERT INTO Read_Permissions(position, directory) VALUES (106,102);
INSERT INTO Read_Permissions(position, directory) VALUES (107,102);
INSERT INTO Read_Permissions(position, directory) VALUES (108,102);
INSERT INTO Read_Permissions(position, directory) VALUES (109,102);
INSERT INTO Read_Permissions(position, directory) VALUES (110,102);
INSERT INTO Read_Permissions(position, directory) VALUES (111,102);
INSERT INTO Read_Permissions(position, directory) VALUES (112,102);
INSERT INTO Read_Permissions(position, directory) VALUES (113,102);
INSERT INTO Read_Permissions(position, directory) VALUES (114,102);
INSERT INTO Read_Permissions(position, directory) VALUES (115,102);
INSERT INTO Read_Permissions(position, directory) VALUES (116,102);
INSERT INTO Read_Permissions(position, directory) VALUES (117,102);
INSERT INTO Read_Permissions(position, directory) VALUES (118,102);
INSERT INTO Read_Permissions(position, directory) VALUES (119,102);
INSERT INTO Read_Permissions(position, directory) VALUES (120,102);
INSERT INTO Read_Permissions(position, directory) VALUES (121,102);
INSERT INTO Read_Permissions(position, directory) VALUES (122,102);
INSERT INTO Read_Permissions(position, directory) VALUES (123,102);
INSERT INTO Read_Permissions(position, directory) VALUES (124,102);
INSERT INTO Read_Permissions(position, directory) VALUES (125,102);
INSERT INTO Read_Permissions(position, directory) VALUES (126,102);
INSERT INTO Read_Permissions(position, directory) VALUES (127,102);
INSERT INTO Read_Permissions(position, directory) VALUES (128,102);
INSERT INTO Read_Permissions(position, directory) VALUES (129,102);
INSERT INTO Read_Permissions(position, directory) VALUES (130,102);
INSERT INTO Read_Permissions(position, directory) VALUES (131,102);
INSERT INTO Read_Permissions(position, directory) VALUES (132,102);
INSERT INTO Read_Permissions(position, directory) VALUES (133,102);
INSERT INTO Read_Permissions(position, directory) VALUES (134,102);
INSERT INTO Read_Permissions(position, directory) VALUES (135,102);
INSERT INTO Read_Permissions(position, directory) VALUES (136,102);
INSERT INTO Read_Permissions(position, directory) VALUES (137,102);
INSERT INTO Read_Permissions(position, directory) VALUES (138,102);
INSERT INTO Read_Permissions(position, directory) VALUES (139,102);
INSERT INTO Read_Permissions(position, directory) VALUES (140,102);
INSERT INTO Read_Permissions(position, directory) VALUES (141,102);
INSERT INTO Read_Permissions(position, directory) VALUES (142,102);
INSERT INTO Read_Permissions(position, directory) VALUES (143,102);
INSERT INTO Read_Permissions(position, directory) VALUES (144,102);
INSERT INTO Read_Permissions(position, directory) VALUES (145,102);
INSERT INTO Read_Permissions(position, directory) VALUES (146,102);
INSERT INTO Read_Permissions(position, directory) VALUES (147,102);
INSERT INTO Read_Permissions(position, directory) VALUES (148,102);
INSERT INTO Read_Permissions(position, directory) VALUES (149,102);
INSERT INTO Read_Permissions(position, directory) VALUES (150,102);
INSERT INTO Read_Permissions(position, directory) VALUES (151,102);
INSERT INTO Read_Permissions(position, directory) VALUES (152,102);
INSERT INTO Read_Permissions(position, directory) VALUES (153,102);
INSERT INTO Read_Permissions(position, directory) VALUES (154,102);
INSERT INTO Read_Permissions(position, directory) VALUES (155,102);
INSERT INTO Read_Permissions(position, directory) VALUES (156,102);
INSERT INTO Read_Permissions(position, directory) VALUES (157,102);
INSERT INTO Read_Permissions(position, directory) VALUES (158,102);
INSERT INTO Read_Permissions(position, directory) VALUES (159,102);
INSERT INTO Read_Permissions(position, directory) VALUES (160,102);
INSERT INTO Read_Permissions(position, directory) VALUES (161,102);
INSERT INTO Read_Permissions(position, directory) VALUES (162,102);
INSERT INTO Read_Permissions(position, directory) VALUES (163,102);
INSERT INTO Read_Permissions(position, directory) VALUES (164,102);
INSERT INTO Read_Permissions(position, directory) VALUES (165,102);
INSERT INTO Read_Permissions(position, directory) VALUES (166,102);
INSERT INTO Read_Permissions(position, directory) VALUES (167,102);
INSERT INTO Read_Permissions(position, directory) VALUES (168,102);
INSERT INTO Read_Permissions(position, directory) VALUES (169,102);
INSERT INTO Read_Permissions(position, directory) VALUES (170,102);
INSERT INTO Read_Permissions(position, directory) VALUES (171,102);
INSERT INTO Read_Permissions(position, directory) VALUES (172,102);
INSERT INTO Read_Permissions(position, directory) VALUES (173,102);
INSERT INTO Read_Permissions(position, directory) VALUES (174,102);
INSERT INTO Read_Permissions(position, directory) VALUES (175,102);
INSERT INTO Read_Permissions(position, directory) VALUES (176,102);
INSERT INTO Read_Permissions(position, directory) VALUES (177,102);
INSERT INTO Read_Permissions(position, directory) VALUES (178,102);
INSERT INTO Read_Permissions(position, directory) VALUES (179,102);
INSERT INTO Read_Permissions(position, directory) VALUES (180,102);
INSERT INTO Read_Permissions(position, directory) VALUES (181,102);
INSERT INTO Read_Permissions(position, directory) VALUES (182,102);
INSERT INTO Read_Permissions(position, directory) VALUES (183,102);
INSERT INTO Read_Permissions(position, directory) VALUES (184,102);
INSERT INTO Read_Permissions(position, directory) VALUES (185,102);
INSERT INTO Read_Permissions(position, directory) VALUES (186,102);
INSERT INTO Read_Permissions(position, directory) VALUES (187,102);
INSERT INTO Read_Permissions(position, directory) VALUES (188,102);
INSERT INTO Read_Permissions(position, directory) VALUES (189,102);
INSERT INTO Read_Permissions(position, directory) VALUES (190,102);
INSERT INTO Read_Permissions(position, directory) VALUES (191,102);
INSERT INTO Read_Permissions(position, directory) VALUES (192,102);
INSERT INTO Read_Permissions(position, directory) VALUES (193,102);
INSERT INTO Read_Permissions(position, directory) VALUES (194,102);
INSERT INTO Read_Permissions(position, directory) VALUES (195,102);
INSERT INTO Read_Permissions(position, directory) VALUES (196,102);
INSERT INTO Read_Permissions(position, directory) VALUES (197,102);
INSERT INTO Read_Permissions(position, directory) VALUES (198,102);
INSERT INTO Read_Permissions(position, directory) VALUES (199,102);
INSERT INTO Read_Permissions(position, directory) VALUES (200,102);
INSERT INTO Read_Permissions(position, directory) VALUES (201,102);
INSERT INTO Read_Permissions(position, directory) VALUES (202,102);
INSERT INTO Read_Permissions(position, directory) VALUES (203,102);
INSERT INTO Read_Permissions(position, directory) VALUES (204,102);
INSERT INTO Read_Permissions(position, directory) VALUES (205,102);
INSERT INTO Read_Permissions(position, directory) VALUES (206,102);
INSERT INTO Read_Permissions(position, directory) VALUES (207,102);
INSERT INTO Read_Permissions(position, directory) VALUES (208,102);
INSERT INTO Read_Permissions(position, directory) VALUES (209,102);
INSERT INTO Read_Permissions(position, directory) VALUES (210,102);
INSERT INTO Read_Permissions(position, directory) VALUES (211,102);
INSERT INTO Read_Permissions(position, directory) VALUES (212,102);
INSERT INTO Read_Permissions(position, directory) VALUES (213,102);
INSERT INTO Read_Permissions(position, directory) VALUES (214,102);
INSERT INTO Read_Permissions(position, directory) VALUES (215,102);
INSERT INTO Read_Permissions(position, directory) VALUES (216,102);
INSERT INTO Read_Permissions(position, directory) VALUES (217,102);
INSERT INTO Read_Permissions(position, directory) VALUES (218,102);
INSERT INTO Read_Permissions(position, directory) VALUES (219,102);
INSERT INTO Read_Permissions(position, directory) VALUES (220,102);
INSERT INTO Read_Permissions(position, directory) VALUES (221,102);
INSERT INTO Read_Permissions(position, directory) VALUES (222,102);
INSERT INTO Read_Permissions(position, directory) VALUES (223,102);
INSERT INTO Read_Permissions(position, directory) VALUES (224,102);
INSERT INTO Read_Permissions(position, directory) VALUES (225,102);
INSERT INTO Read_Permissions(position, directory) VALUES (226,102);
INSERT INTO Read_Permissions(position, directory) VALUES (227,102);
INSERT INTO Read_Permissions(position, directory) VALUES (228,102);
INSERT INTO Read_Permissions(position, directory) VALUES (229,102);
INSERT INTO Read_Permissions(position, directory) VALUES (230,102);
INSERT INTO Read_Permissions(position, directory) VALUES (231,102);
INSERT INTO Read_Permissions(position, directory) VALUES (232,102);
INSERT INTO Read_Permissions(position, directory) VALUES (233,102);
INSERT INTO Read_Permissions(position, directory) VALUES (234,102);
INSERT INTO Read_Permissions(position, directory) VALUES (235,102);
INSERT INTO Read_Permissions(position, directory) VALUES (236,102);
INSERT INTO Read_Permissions(position, directory) VALUES (237,102);
INSERT INTO Read_Permissions(position, directory) VALUES (238,102);
INSERT INTO Read_Permissions(position, directory) VALUES (239,102);
INSERT INTO Read_Permissions(position, directory) VALUES (240,102);
INSERT INTO Read_Permissions(position, directory) VALUES (241,102);
INSERT INTO Read_Permissions(position, directory) VALUES (242,102);
INSERT INTO Read_Permissions(position, directory) VALUES (243,102);
INSERT INTO Read_Permissions(position, directory) VALUES (244,102);
INSERT INTO Read_Permissions(position, directory) VALUES (245,102);
INSERT INTO Read_Permissions(position, directory) VALUES (246,102);
INSERT INTO Read_Permissions(position, directory) VALUES (247,102);
INSERT INTO Read_Permissions(position, directory) VALUES (248,102);
INSERT INTO Read_Permissions(position, directory) VALUES (249,102);
INSERT INTO Read_Permissions(position, directory) VALUES (250,102);
INSERT INTO Read_Permissions(position, directory) VALUES (251,102);
INSERT INTO Read_Permissions(position, directory) VALUES (252,102);
INSERT INTO Read_Permissions(position, directory) VALUES (253,102);
INSERT INTO Read_Permissions(position, directory) VALUES (254,102);
INSERT INTO Read_Permissions(position, directory) VALUES (255,102);
INSERT INTO Read_Permissions(position, directory) VALUES (256,102);
INSERT INTO Read_Permissions(position, directory) VALUES (257,102);
INSERT INTO Read_Permissions(position, directory) VALUES (258,102);
INSERT INTO Read_Permissions(position, directory) VALUES (259,102);
INSERT INTO Read_Permissions(position, directory) VALUES (260,102);
INSERT INTO Read_Permissions(position, directory) VALUES (261,102);
INSERT INTO Read_Permissions(position, directory) VALUES (262,102);
INSERT INTO Read_Permissions(position, directory) VALUES (263,102);
INSERT INTO Read_Permissions(position, directory) VALUES (264,102);
INSERT INTO Read_Permissions(position, directory) VALUES (265,102);
INSERT INTO Read_Permissions(position, directory) VALUES (266,102);
INSERT INTO Read_Permissions(position, directory) VALUES (267,102);
INSERT INTO Read_Permissions(position, directory) VALUES (268,102);
INSERT INTO Read_Permissions(position, directory) VALUES (269,102);
INSERT INTO Read_Permissions(position, directory) VALUES (270,102);
INSERT INTO Read_Permissions(position, directory) VALUES (271,102);
INSERT INTO Read_Permissions(position, directory) VALUES (272,102);
INSERT INTO Read_Permissions(position, directory) VALUES (273,102);
INSERT INTO Read_Permissions(position, directory) VALUES (274,102);
INSERT INTO Read_Permissions(position, directory) VALUES (275,102);
INSERT INTO Read_Permissions(position, directory) VALUES (276,102);
INSERT INTO Read_Permissions(position, directory) VALUES (277,102);
INSERT INTO Read_Permissions(position, directory) VALUES (278,102);
INSERT INTO Read_Permissions(position, directory) VALUES (279,102);
INSERT INTO Read_Permissions(position, directory) VALUES (280,102);
INSERT INTO Read_Permissions(position, directory) VALUES (281,102);
INSERT INTO Read_Permissions(position, directory) VALUES (282,102);
INSERT INTO Read_Permissions(position, directory) VALUES (283,102);
INSERT INTO Read_Permissions(position, directory) VALUES (284,102);
INSERT INTO Read_Permissions(position, directory) VALUES (285,102);
INSERT INTO Read_Permissions(position, directory) VALUES (286,102);
INSERT INTO Read_Permissions(position, directory) VALUES (287,102);
INSERT INTO Read_Permissions(position, directory) VALUES (288,102);
INSERT INTO Read_Permissions(position, directory) VALUES (289,102);
INSERT INTO Read_Permissions(position, directory) VALUES (290,102);
INSERT INTO Read_Permissions(position, directory) VALUES (291,102);
INSERT INTO Read_Permissions(position, directory) VALUES (292,102);
INSERT INTO Read_Permissions(position, directory) VALUES (293,102);
INSERT INTO Read_Permissions(position, directory) VALUES (294,102);
INSERT INTO Read_Permissions(position, directory) VALUES (295,102);
INSERT INTO Read_Permissions(position, directory) VALUES (296,102);

INSERT INTO Edit_Permissions(position, directory) VALUES (1,102);
INSERT INTO Edit_Permissions(position, directory) VALUES (2,102);
INSERT INTO Edit_Permissions(position, directory) VALUES (3,102);
INSERT INTO Edit_Permissions(position, directory) VALUES (4,102);
INSERT INTO Edit_Permissions(position, directory) VALUES (5,102);
INSERT INTO Edit_Permissions(position, directory) VALUES (6,102);

-- American Education Group/Schools/Fusion Division/Huntington Beach/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,103);

INSERT INTO Edit_Permissions(position, directory) VALUES (,103);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,104);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,105);

INSERT INTO Edit_Permissions(position, directory) VALUES (,105);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,106);

INSERT INTO Edit_Permissions(position, directory) VALUES (,106);

-- American Education Group/Schools/Fusion Division/Long Island/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,107);

INSERT INTO Edit_Permissions(position, directory) VALUES (,107);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,108);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,109);

INSERT INTO Edit_Permissions(position, directory) VALUES (,109);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,110);

INSERT INTO Edit_Permissions(position, directory) VALUES (,110);

-- American Education Group/Schools/Fusion Division/Los Angeles/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,111);

INSERT INTO Edit_Permissions(position, directory) VALUES (,111);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,112);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,113);

INSERT INTO Edit_Permissions(position, directory) VALUES (,113);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,114);

INSERT INTO Edit_Permissions(position, directory) VALUES (,114);

-- American Education Group/Schools/Fusion Division/Los Gatos/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,115);

INSERT INTO Edit_Permissions(position, directory) VALUES (,115);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,116);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,117);

INSERT INTO Edit_Permissions(position, directory) VALUES (,117);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,118);

INSERT INTO Edit_Permissions(position, directory) VALUES (,118);

-- American Education Group/Schools/Fusion Division/Manhattan/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,119);

INSERT INTO Edit_Permissions(position, directory) VALUES (,119);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,120);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,121);

INSERT INTO Edit_Permissions(position, directory) VALUES (,121);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,122);

INSERT INTO Edit_Permissions(position, directory) VALUES (,122);

-- American Education Group/Schools/Fusion Division/Mission Viejo/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,123);

INSERT INTO Edit_Permissions(position, directory) VALUES (,123);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,124);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,125);

INSERT INTO Edit_Permissions(position, directory) VALUES (,125);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,126);

INSERT INTO Edit_Permissions(position, directory) VALUES (,126);

-- American Education Group/Schools/Fusion Division/Pasadena/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,128);

INSERT INTO Edit_Permissions(position, directory) VALUES (,127);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,128);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,129);

INSERT INTO Edit_Permissions(position, directory) VALUES (,129);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,130);

INSERT INTO Edit_Permissions(position, directory) VALUES (,130);

-- American Education Group/Schools/Fusion Division/Regional/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,131);

INSERT INTO Edit_Permissions(position, directory) VALUES (,131);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,132);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,133);

INSERT INTO Edit_Permissions(position, directory) VALUES (,133);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,134);

INSERT INTO Edit_Permissions(position, directory) VALUES (,134);

-- American Education Group/Schools/Fusion Division/San Francisco/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,135);

INSERT INTO Edit_Permissions(position, directory) VALUES (,135);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,136);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,137);

INSERT INTO Edit_Permissions(position, directory) VALUES (,137);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,138);

INSERT INTO Edit_Permissions(position, directory) VALUES (,138);

-- American Education Group/Schools/Fusion Division/San Mateo/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,139);

INSERT INTO Edit_Permissions(position, directory) VALUES (,139);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,140);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,141);

INSERT INTO Edit_Permissions(position, directory) VALUES (,141);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,142);

INSERT INTO Edit_Permissions(position, directory) VALUES (,142);

-- American Education Group/Schools/Fusion Division/Solana Beach/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,143);

INSERT INTO Edit_Permissions(position, directory) VALUES (,143);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,144);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,145);

INSERT INTO Edit_Permissions(position, directory) VALUES (,145);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,146);

INSERT INTO Edit_Permissions(position, directory) VALUES (,146);

-- American Education Group/Schools/Fusion Division/South Bay/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,147);

INSERT INTO Edit_Permissions(position, directory) VALUES (,147);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,148);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,149);

INSERT INTO Edit_Permissions(position, directory) VALUES (,149);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,150);

INSERT INTO Edit_Permissions(position, directory) VALUES (,150);

-- American Education Group/Schools/Fusion Division/Walnut Creek/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,151);

INSERT INTO Edit_Permissions(position, directory) VALUES (,151);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,152);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,153);

INSERT INTO Edit_Permissions(position, directory) VALUES (,153);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,154);

INSERT INTO Edit_Permissions(position, directory) VALUES (,154);

-- American Education Group/Schools/Fusion Division/Warner Center/
--   Staff
INSERT INTO Read_Permissions(position, directory) VALUES (,155);

INSERT INTO Edit_Permissions(position, directory) VALUES (,155);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,156);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,157);

INSERT INTO Edit_Permissions(position, directory) VALUES (,157);

--   Head of School
INSERT INTO Read_Permissions(position, directory) VALUES (,158);

INSERT INTO Edit_Permissions(position, directory) VALUES (,158);

-- American Education Group/Schools/Fusion Division/Fusionology/
--   Fusionology Content
INSERT INTO Read_Permissions(position, directory) VALUES (,159);

INSERT INTO Edit_Permissions(position, directory) VALUES (,159);

--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,160);

INSERT INTO Edit_Permissions(position, directory) VALUES (,160);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,161);

--   Collaboration
INSERT INTO Read_Permissions(position, directory) VALUES (,162);

INSERT INTO Edit_Permissions(position, directory) VALUES (,162);

-- American Education Group/Schools/Fusion Division/Discussion Board/
--   Marketing
INSERT INTO Read_Permissions(position, directory) VALUES (,163);

INSERT INTO Edit_Permissions(position, directory) VALUES (,163);

-- American Education Group/Schools/Fusion Division/Outreach/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,164);

INSERT INTO Edit_Permissions(position, directory) VALUES (,164);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,165);

--   Outreach Discussions
INSERT INTO Read_Permissions(position, directory) VALUES (,166);

INSERT INTO Edit_Permissions(position, directory) VALUES (,166);

-- American Education Group/Schools/Fusion Division/Accounting/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,167);

INSERT INTO Edit_Permissions(position, directory) VALUES (,167);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,168);

--   Billing
INSERT INTO Read_Permissions(position, directory) VALUES (,169);

INSERT INTO Edit_Permissions(position, directory) VALUES (,169);

--   Budget
INSERT INTO Read_Permissions(position, directory) VALUES (,170);

INSERT INTO Edit_Permissions(position, directory) VALUES (,170);

-- American Education Group/Schools/Fusion Division/Leadership/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,171);

INSERT INTO Edit_Permissions(position, directory) VALUES (,171);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,172);

-- American Education Group/Schools/Fusion Division/Registrar/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,173);

INSERT INTO Edit_Permissions(position, directory) VALUES (,173);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,174);

--   Site Pages
INSERT INTO Read_Permissions(position, directory) VALUES (,175);

INSERT INTO Edit_Permissions(position, directory) VALUES (,175);

--   Transcript Requests
INSERT INTO Read_Permissions(position, directory) VALUES (,176);

INSERT INTO Edit_Permissions(position, directory) VALUES (,176);

--   POC
INSERT INTO Read_Permissions(position, directory) VALUES (,177);

INSERT INTO Edit_Permissions(position, directory) VALUES (,177);

-- Americane Education Group/Schools/Fusion Division/Curriculum/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,178);

INSERT INTO Edit_Permissions(position, directory) VALUES (,178);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,179);

--   EPICenter!
INSERT INTO Read_Permissions(position, directory) VALUES (,180);

INSERT INTO Edit_Permissions(position, directory) VALUES (,180);

-- American Education Group/Schools/Fusion Division/Training/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,181);

INSERT INTO Edit_Permissions(position, directory) VALUES (,181);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,182);

-- American Education Group/Schools/Lexis/Barnstable/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,183);

INSERT INTO Edit_Permissions(position, directory) VALUES (,183);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,184);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,185);

INSERT INTO Edit_Permissions(position, directory) VALUES (,185);

--   School
INSERT INTO Read_Permissions(position, directory) VALUES (,186);

INSERT INTO Edit_Permissions(position, directory) VALUES (,186);

--   Sick or Coverage
INSERT INTO Read_Permissions(position, directory) VALUES (,187);

INSERT INTO Edit_Permissions(position, directory) VALUES (,187);

-- American Education Group/Schools/Lexis/Shreiner/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,188);

INSERT INTO Edit_Permissions(position, directory) VALUES (,188);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,189);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,190);

INSERT INTO Edit_Permissions(position, directory) VALUES (,190);

--   School
INSERT INTO Read_Permissions(position, directory) VALUES (,191);

INSERT INTO Edit_Permissions(position, directory) VALUES (,191);

--   Sick or Coverage
INSERT INTO Read_Permissions(position, directory) VALUES (,192);

INSERT INTO Edit_Permissions(position, directory) VALUES (,192);

-- American Education Group/Schools/Lexis/Tampa Day/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,193);

INSERT INTO Edit_Permissions(position, directory) VALUES (,193);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,194);

--   Administrators
INSERT INTO Read_Permissions(position, directory) VALUES (,195);

INSERT INTO Edit_Permissions(position, directory) VALUES (,195);

--   School
INSERT INTO Read_Permissions(position, directory) VALUES (,196);

INSERT INTO Edit_Permissions(position, directory) VALUES (,196);

--   Sick or Coverage
INSERT INTO Read_Permissions(position, directory) VALUES (,197);

INSERT INTO Edit_Permissions(position, directory) VALUES (,197);

-- American Education Group/Schools/Lexis/Talking Heads/
--   Leadership
INSERT INTO Read_Permissions(position, directory) VALUES (,198);

INSERT INTO Edit_Permissions(position, directory) VALUES (,198);

--   EPIC! Customer Service
INSERT INTO Read_Permissions(position, directory) VALUES (,199);

INSERT INTO Edit_Permissions(position, directory) VALUES (,199);

-- American Education Group/Schools/Lexis/Curriculum/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,200);

INSERT INTO Edit_Permissions(position, directory) VALUES (,200);

--   Public
INSERT INTO Edit_Permissions(position, directory) VALUES (,201);

-- American Education Group/Schools/Lexis/Scholarship/
--   Private
INSERT INTO Read_Permissions(position, directory) VALUES (,202);

INSERT INTO Edit_Permissions(position, directory) VALUES (,202);
