-- CREATE DATABASE  IF NOT EXISTS ecn_it_db
-- USE ecn_it_db;

-- Drop Tables

DROP TABLE IF EXISTS receive_dg;
DROP TABLE IF EXISTS send_to_dg;
DROP TABLE IF EXISTS edit_permissions;
DROP TABLE IF EXISTS read_permissions;
DROP TABLE IF EXISTS directory_owner;
DROP TABLE IF EXISTS source_directories;
DROP TABLE IF EXISTS positions;
DROP TABLE IF EXISTS schools_departments;
DROP TABLE IF EXISTS divisions;
DROP TABLE IF EXISTS distribution_groups;


-- Create Tables
CREATE TABLE divisions(
	divisionID INT AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
	PRIMARY KEY (divisionID),
	UNIQUE KEY (name)
);

CREATE TABLE schools_departments(
	schoolDepartmentID INT AUTO_INCREMENT,
	name VARCHAR(64) NOT NULL,
  	abbreviation VARCHAR(3),
	division INT NOT NULL,
	emailDomain VARCHAR(64) NOT NULL,
	phoneNumber VARCHAR(15),
	PRIMARY KEY (schoolDepartmentID),
	UNIQUE KEY (name),
	UNIQUE KEY (abbreviation),
	FOREIGN KEY (division) REFERENCES divisions(divisionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE positions(
	positionID INT AUTO_INCREMENT,
	title VARCHAR(64) NOT NULL,
	division INT NOT NULL,
	school_department INT NOT NULL,
	PRIMARY KEY (positionID),
	UNIQUE KEY (title, division, school_department),
	FOREIGN KEY (division) REFERENCES divisions(divisionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(school_department) REFERENCES schools_departments(schoolDepartmentID) ON UPDATE CASCADE ON DELETE CASCADE 
) ENGINE=InnoDB;

CREATE TABLE source_directories(
	sourceDirectoryID INT AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	parent INT NOT NULL,
	UNIQUE KEY (name, parent),
	PRIMARY KEY (sourceDirectoryID),
	FOREIGN KEY (parent) REFERENCES source_directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE directory_owner(
	directoryOwnerID INT AUTO_INCREMENT,
	directory INT NOT NULL,
	owner_position INT NOT NULL,
	PRIMARY KEY (directoryOwnerID),
	UNIQUE KEY (directory, owner_position),
	FOREIGN KEY (directory) REFERENCES source_directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (owner_position) REFERENCES positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE read_permissions(
	readPermissionID INT AUTO_INCREMENT,
	position INT NOT NULL,
	directory INT NOT NULL,
	PRIMARY KEY (readPermissionID),
	UNIQUE KEY (position, directory),
	FOREIGN KEY (position) REFERENCES positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (directory) REFERENCES source_directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE edit_permissions(
	editPermissionID INT AUTO_INCREMENT,
	position INT NOT NULL,
	directory INT NOT NULL,
	PRIMARY KEY (editPermissionID),
	UNIQUE KEY (position, directory),
	FOREIGN KEY (position) REFERENCES positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (directory) REFERENCES source_directories(sourceDirectoryID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE distribution_groups(
	distributionGroupID INT AUTO_INCREMENT,
  dgName VARCHAR(64) NOT NULL,
	PRIMARY KEY (distributionGroupID),
  UNIQUE KEY (dgName)
) ENGINE=InnoDB;

CREATE TABLE send_to_dg(
	sendToDGID INT AUTO_INCREMENT,
	distributionGroup INT NOT NULL,
	position INT NOT NULL,
	PRIMARY KEY (sendToDGID),
	UNIQUE KEY (distributionGroup, position),
	FOREIGN KEY (distributionGroup) REFERENCES distribution_groups(distributionGroupID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (position) REFERENCES positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE receive_dg(
	receiveDGID INT AUTO_INCREMENT,
	distributionGroup INT NOT NULL,
	position INT NOT NULL,
	PRIMARY KEY (receiveDGID),
	UNIQUE KEY (distributionGroup, position),
	FOREIGN KEY (distributionGroup) REFERENCES distribution_groups(distributionGroupID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (position) REFERENCES positions(positionID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Add data
-- divisions
INSERT INTO divisions (name) VALUES ("Corporate");      -- 1
INSERT INTO divisions (name) VALUES ("Fusion");         -- 2
INSERT INTO divisions (name) VALUES ("Lexis");          -- 3
INSERT INTO divisions (name) VALUES ("Little Sprouts"); -- 4

-- schools_departments
--  Corporate
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Administration", 1, "americanedgroup.com", "616-301-1221");					 					-- 1
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Coaching and Learning", 1, "americanedgroup.com", "616-301-1221");                           	-- 2
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Human Resources", 1, "americanedgroup.com", "616-301-1221");                                 	-- 3
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Information Technology", 1, "americanedgroup.com", "616-301-1221");                          	-- 4
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Finance", 1, "americanedgroup.com", "616-301-1221");                                         	-- 5
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Marketing", 1, "americanedgroup.com", "616-301-1221");                                       	-- 6
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("New Business Development", 1, "americanedgroup.com", "616-301-1221");                        	-- 7
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Procurement", 1, "americanedgroup.com", "616-301-1221");                                     	-- 8
--  Fusion
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Huntington Beach", "HB", 2, "fusionacademy.com", "657-200-2300");     		-- 9
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Los Angeles", "LA", 2, "fusionacademy.com", "310-445-2516");          		-- 10
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Los Gatos", "LG", 2, "fusionacademy.com", "408-354-0802");            		-- 11
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Mission Viejo", "MV", 2, "fusionacademy.com", "949-716-7384");        		-- 12
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Pasadena", "PA", 2, "fusionacademy.com", "323-258-2012");             		-- 13
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion San Diego", "SD", 2, "fusionacademy.com", "866-670-9296");            		-- 14
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion San Francisco", "SF", 2, "fusionacademy.com", "415-765-9078");        		-- 15
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion San Mateo", "SM", 2, "fusionacademy.com", "650-312-8305");            		-- 16
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion South Bay", "SB", 2, "fusionacademy.com", "310-376-5139");            		-- 17
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Solana Beach", "SLB", 2, "fusionacademy.com", "858-792-2300");        		-- 18
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Walnut Creek", "WCR", 2, "fusionacademy.com", "925-296-0053");        		-- 19
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Warner Center", "WC", 2, "fusionacademy.com", "818-712-9521");        		-- 20
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Manhattan", "MN", 2, "fusionacademy.com", "646-290-5203");            		-- 21
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Long Island", "LI", 2, "fusionacademy.com", "631-390-8366");          		-- 22
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Westchester", "WE", 2, "fusionacademy.com", "866-622-7853");          		-- 23
INSERT INTO schools_departments (name, abbreviation, division, emailDomain, phoneNumber) VALUES ("Fusion Regional", "REG", 2, "fusionacademy.com", "626-616-2060");             	-- 24
--  Lexis
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Barnstable Academy", 3, "barnstableacademy.com", "201-651-0200");                            	-- 25
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Shreiner Academy", 3, "shreineracademy.com", "770-953-1340");                                	-- 26
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Tampa Day School", 3, "tampadayschool.com", "813-269-2100");                                	-- 27
--  Little Sprouts
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Amesbury", 4, "littlesprouts.com", "978-388-1299");                                        		-- 28
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Andover", 4, "littlesprouts.com", "978-691-1178");                                         		-- 29
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Andover Industrial", 4, "littlesprouts.com", "978-688-4270");                              		-- 30
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Brighton", 4, "littlesprouts.com", "617-254-1283");                                        		-- 31
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Dedham", 4, "littlesprouts.com", "781-329-8603");                                          		-- 32
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Haverhill", 4, "littlesprouts.com", "978-269-0044");                                       		-- 33
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Haverhill NECC", 4, "littlesprouts.com", "978-374-7260");                                  		-- 34
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Lawrence", 4, "littlesprouts.com", "978-291-0342");                                        		-- 35
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Lowell", 4, "littlesprouts.com", "978-453-6614");                                          		-- 36
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Methuen", 4, "littlesprouts.com", "978-683-1567");                                         		-- 37
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("North Andover", 4, "littlesprouts.com", "978-208-4796");                                   		-- 38
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Roxbury RCC", 4, "littlesprouts.com", "617-933-7492");                                     		-- 39
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Wilmington", 4, "littlesprouts.com", "978-658-2680");                                      		-- 40
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Woburn", 4, "littlesprouts.com", "782-569-1410");                                          		-- 41
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Boston", 4, "littlesprouts.com", "877-977-7688");                                          		-- 42
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Nashua", 4, "littlesprouts.com", "877-977-7688");                                          		-- 43
INSERT INTO schools_departments (name, division, emailDomain, phoneNumber) VALUES ("Little Sprouts Corporate", 4, "littlesprouts.com", "978-291-0256");                        		-- 44

-- positions
--  Corporate
--    Administration
INSERT INTO positions (title, division, school_department) VALUES ("President", 1, 1);                                  -- 1
INSERT INTO positions (title, division, school_department) VALUES ("CEO", 1, 1);                                        -- 2
INSERT INTO positions (title, division, school_department) VALUES ("Senior Vice President", 1, 1);                      -- 3
INSERT INTO positions (title, division, school_department) VALUES ("COO of Fusion", 1, 1);                              -- 4
INSERT INTO positions (title, division, school_department) VALUES ("Executive Assistant", 1, 1);                        -- 5
INSERT INTO positions (title, division, school_department) VALUES ("DePauw Intern", 1, 1);                              -- 6
--    Coaching and Learning
INSERT INTO positions (title, division, school_department) VALUES ("VP of Education", 1, 2);                            -- 7
INSERT INTO positions (title, division, school_department) VALUES ("General Manager of Lexis", 1, 2);                   -- 8
INSERT INTO positions (title, division, school_department) VALUES ("Education Manager", 1, 2);                          -- 9
INSERT INTO positions (title, division, school_department) VALUES ("New Talent Coordinator", 1, 2);                     -- 10
--    Human Resources
INSERT INTO positions (title, division, school_department) VALUES ("VP of Human Resources", 1, 3);                      -- 11
INSERT INTO positions (title, division, school_department) VALUES ("Human Resources Manager", 1, 3);                    -- 12
INSERT INTO positions (title, division, school_department) VALUES ("Human Resources Associate", 1, 3);                  -- 13
--    Information Technology
INSERT INTO positions (title, division, school_department) VALUES ("IT Manager", 1, 4);                                 -- 14
INSERT INTO positions (title, division, school_department) VALUES ("IT Intern", 1, 4);                                  -- 15
--    Finance
INSERT INTO positions (title, division, school_department) VALUES ("Vice President of Finance", 1, 5);                  -- 16
INSERT INTO positions (title, division, school_department) VALUES ("CFO", 1, 5);                                        -- 17
INSERT INTO positions (title, division, school_department) VALUES ("Corporate Controller", 1, 5);                       -- 18
INSERT INTO positions (title, division, school_department) VALUES ("Accounting Associate", 1, 5);                       -- 19
INSERT INTO positions (title, division, school_department) VALUES ("Accounts Payable Specialist", 1, 5);                -- 20
INSERT INTO positions (title, division, school_department) VALUES ("Accounting Temp", 1, 5);                            -- 21
INSERT INTO positions (title, division, school_department) VALUES ("Accounting Intern", 1, 5);                          -- 22
--    Marketing
INSERT INTO positions (title, division, school_department) VALUES ("Director of Marketing", 1, 6);                      -- 23
INSERT INTO positions (title, division, school_department) VALUES ("Marketing Manager", 1, 6);                          -- 24
INSERT INTO positions (title, division, school_department) VALUES ("Marketing Specialist", 1, 6);                       -- 25
INSERT INTO positions (title, division, school_department) VALUES ("SEM Marketing Analyst", 1, 6);                      -- 26
INSERT INTO positions (title, division, school_department) VALUES ("Marketing PPC", 1, 6);                              -- 27
INSERT INTO positions (title, division, school_department) VALUES ("Marketing Intern", 1, 6);                           -- 28
INSERT INTO positions (title, division, school_department) VALUES ("Social Media Intern", 1, 6);                        -- 29
INSERT INTO positions (title, division, school_department) VALUES ("Marketing Consultant", 1, 6);                       -- 30
--    New Business Development
INSERT INTO positions (title, division, school_department) VALUES ("Vice President of New Business Development", 1, 7); -- 31
INSERT INTO positions (title, division, school_department) VALUES ("School Launch Manager", 1, 7);                      -- 32
--    Procurement
INSERT INTO positions (title, division, school_department) VALUES ("Administrative Assistant", 1, 8);                   -- 33
--  Fusion
--    Fusion Huntington Beach
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 9);                         -- 34
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 9);                                  -- 35
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 9);      -- 36
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 9);              -- 37
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 9);            -- 38
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 9);                       -- 39
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 9);                              -- 40
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 9);                             -- 41
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 9);                     -- 42
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 9);                             -- 43
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 9);                                  -- 44
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 9);                         -- 45
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 9);                                    -- 46
--    Fusion Los Angeles
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 10);                        -- 47
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 10);                                 -- 48
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 10);     -- 49
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 10);             -- 50
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 10);           -- 51
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 10);                      -- 52
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 10);                             -- 53
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 10);                            -- 54
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 10);                    -- 55
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 10);                            -- 56
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 10);                                 -- 57
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 10);                        -- 58
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 10);                                   -- 59
--    Fusion Los Gatos
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 11);                        -- 60
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 11);                                 -- 61
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 11);     -- 62
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 11);             -- 63
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 11);           -- 64
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 11);                      -- 65
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 11);                             -- 66
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 11);                            -- 67
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 11);                    -- 68
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 11);                            -- 69
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 11);                                 -- 70
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 11);                        -- 71
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 11);                                   -- 72
--    Fusion Mission Viejo
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 12);                        -- 73
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 12);                                 -- 74
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 12);     -- 75
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 12);             -- 76
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 12);           -- 77
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 12);                      -- 78
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 12);                             -- 79
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 12);                            -- 80
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 12);                    -- 81
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 12);                            -- 82
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 12);                                 -- 83
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 12);                        -- 84
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 12);                                   -- 85
--    Fusion Pasadena
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 13);                        -- 86
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 13);                                 -- 87
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 13);     -- 88
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 13);             -- 89
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 13);           -- 90
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 13);                      -- 91
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 13);                             -- 92
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 13);                            -- 93
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 13);                    -- 94
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 13);                            -- 95
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 13);                                 -- 96
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 13);                        -- 97
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 13);                                   -- 98
--    Fusion San Diego
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 14);                        -- 99
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 14);                                 -- 100
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 14);     -- 101
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 14);             -- 102
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 14);           -- 103
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 14);                      -- 104
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 14);                             -- 105
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 14);                            -- 106
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 14);                    -- 107
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 14);                            -- 108
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 14);                                 -- 109
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 14);                        -- 110
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 14);                                   -- 111
--    Fusion San Francisco
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 15);                        -- 112
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 15);                                 -- 113
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 15);     -- 114
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 15);             -- 115
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 15);           -- 116
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 15);                      -- 117
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 15);                             -- 118
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 15);                            -- 119
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 15);                    -- 120
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 15);                            -- 121
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 15);                                 -- 122
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 15);                        -- 123
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 15);                                   -- 124
--    Fusion San Mateo
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 16);                        -- 125
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 16);                                 -- 126
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 16);     -- 127
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 16);             -- 128
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 16);           -- 129
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 16);                      -- 130
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 16);                             -- 131
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 16);                            -- 132
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 16);                    -- 133
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 16);                            -- 134
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 16);                                 -- 135
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 16);                        -- 136
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 16);                                   -- 137
--    Fusion South Bay
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 17);                        -- 138
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 17);                                 -- 139
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 17);     -- 140
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 17);             -- 141
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 17);           -- 142
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 17);                      -- 143
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 17);                             -- 144
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 17);                            -- 145
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 17);                    -- 146
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 17);                            -- 147
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 17);                                 -- 148
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 17);                        -- 149
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 17);                                   -- 150
--    Fusion Solana Beach
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 18);                        -- 151
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 18);                                 -- 152
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 18);     -- 153
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 18);             -- 154
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 18);           -- 155
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 18);                      -- 156
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 18);                             -- 157
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 18);                            -- 158
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 18);                    -- 159
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 18);                            -- 160
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 18);                                 -- 161
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 18);                        -- 162
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 18);                                   -- 163
--    Fusion Walnut Creek
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 19);                        -- 164
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 19);                                 -- 165
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 19);     -- 166
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 19);             -- 167
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 19);           -- 168
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 19);                      -- 169
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 19);                             -- 170
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 19);                            -- 171
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 19);                    -- 172
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 19);                            -- 173
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 19);                                 -- 174
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 19);                        -- 175
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 19);                                   -- 176
--    Fusion Warner Center
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 20);                        -- 177
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 20);                                 -- 178
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 20);     -- 179
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 20);             -- 180
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 20);           -- 181
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 20);                      -- 182
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 20);                             -- 183
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 20);                            -- 184
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 20);                    -- 185
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 20);                            -- 186
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 20);                                 -- 187
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 20);                        -- 188
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 20);                                   -- 189
--    Fusion Manhattan
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 21);                        -- 190
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 21);                                 -- 191
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 21);     -- 192
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 21);             -- 193
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 21);           -- 194
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 21);                      -- 195
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 21);                             -- 196
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 21);                            -- 197
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 21);                    -- 198
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 21);                            -- 199
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 21);                                 -- 200
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 21);                        -- 201
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 21);                                   -- 202
--    Fusion Long Island
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 22);                        -- 203
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 22);                                 -- 204
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 22);     -- 205
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 22);             -- 206
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 22);           -- 207
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 22);                      -- 208
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 22);                             -- 209
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 22);                            -- 210
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 22);                    -- 211
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 22);                            -- 212
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 22);                                 -- 213
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 22);                        -- 214
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 22);                                   -- 215
--    Fusion Westchester
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Director", 2, 23);                        -- 216
INSERT INTO positions (title, division, school_department) VALUES ("Counselor", 2, 23);                                 -- 217
INSERT INTO positions (title, division, school_department) VALUES ("Director of Communications & Outreach", 2, 23);     -- 218
INSERT INTO positions (title, division, school_department) VALUES ("Director of First Impressions", 2, 23);             -- 219
INSERT INTO positions (title, division, school_department) VALUES ("Director of Student Development", 2, 23);           -- 220
INSERT INTO positions (title, division, school_department) VALUES ("Director of Tutoring", 2, 23);                      -- 221
INSERT INTO positions (title, division, school_department) VALUES ("Fusionologist", 2, 23);                             -- 222
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 2, 23);                            -- 223
INSERT INTO positions (title, division, school_department) VALUES ("Information Specialist", 2, 23);                    -- 224
INSERT INTO positions (title, division, school_department) VALUES ("Master Teacher", 2, 23);                            -- 225
INSERT INTO positions (title, division, school_department) VALUES ("Registrar", 2, 23);                                 -- 226
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 2, 23);                        -- 227
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 2, 23);                                   -- 228
--    Fusion Regional
INSERT INTO positions (title, division, school_department) VALUES ("Regional Assistant", 2, 24);                        -- 229
INSERT INTO positions (title, division, school_department) VALUES ("Regional Director of Community Outreach", 2, 24);   -- 230
INSERT INTO positions (title, division, school_department) VALUES ("Director of Operations", 2, 24);                    -- 231
INSERT INTO positions (title, division, school_department) VALUES ("New Talent Coordinator", 2, 24);                    -- 232
--  Lexis
--    Barnstable Academy
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 3, 25);                            -- 233
INSERT INTO positions (title, division, school_department) VALUES ("Assistant Head of School", 3, 25);                  -- 234
INSERT INTO positions (title, division, school_department) VALUES ("Director of Admissions", 3, 25);                    -- 235
INSERT INTO positions (title, division, school_department) VALUES ("Business Manager", 3, 25);                          -- 236
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 3, 25);                                   -- 237
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 25);                        -- 238
--    Shreiner Academy
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 3, 26);                            -- 239
INSERT INTO positions (title, division, school_department) VALUES ("Admissions Coordinator", 3, 26);                    -- 240
INSERT INTO positions (title, division, school_department) VALUES ("MS Director", 3, 26);                               -- 241
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 3, 26);                                   -- 242
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 26);                        -- 243
--    Tampa Day School
INSERT INTO positions (title, division, school_department) VALUES ("Head of School", 3, 27);                            -- 244
INSERT INTO positions (title, division, school_department) VALUES ("Psychologist", 3, 27);                              -- 245
INSERT INTO positions (title, division, school_department) VALUES ("Outreach", 3, 27);                                  -- 246
INSERT INTO positions (title, division, school_department) VALUES ("Principal", 3, 27);                                 -- 247
INSERT INTO positions (title, division, school_department) VALUES ("Admin/Admissions Coordinator", 3, 27);              -- 248
INSERT INTO positions (title, division, school_department) VALUES ("Office Manager", 3, 27);                            -- 249
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 3, 27);                                   -- 250
INSERT INTO positions (title, division, school_department) VALUES ("Substitute Teacher", 3, 27);                        -- 251
--  Little Sprouts
--    Amesbury
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 28);                        -- 252
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 28);                                   -- 253
--    Andover
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 29);                        -- 254
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 29);                                   -- 255
--    Andover Industrial
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 30);                        -- 256
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 30);                                   -- 257
--    Brighton
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 31);                        -- 258
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 31);                                   -- 259
--    Dedham
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 32);                        -- 260
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 32);                                   -- 261
--    Haverhill
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 33);                        -- 262
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 33);                                   -- 263
--    Haverhill NECC
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 34);                        -- 264
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 34);                                   -- 265
--    Lawrence
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 35);                        -- 266
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 35);                                   -- 267
--    Lowell
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 36);                        -- 268
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 36);                                   -- 269
--    Methuen
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 37);                        -- 270
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 37);                                   -- 271
--    North Andover
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 38);                        -- 272
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 38);                                   -- 273
--    Roxbury RCC
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 39);                        -- 274
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 39);                                   -- 275
--    Wilmington
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 40);                        -- 276
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 40);                                   -- 277
--    Woburn
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 41);                        -- 278
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 41);                                   -- 279
--    Boston
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 42);                        -- 280
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 42);                                   -- 281
--    Nashua
INSERT INTO positions (title, division, school_department) VALUES ("Executive Director", 4, 43);                        -- 282
INSERT INTO positions (title, division, school_department) VALUES ("Teacher", 4, 43);                                   -- 283
--    Little Sprouts Corporate
INSERT INTO positions (title, division, school_department) VALUES ("President", 4, 44);                                 -- 284
INSERT INTO positions (title, division, school_department) VALUES ("VP of Finance", 4, 44);                             -- 285
INSERT INTO positions (title, division, school_department) VALUES ("Director of Operations", 4, 44);                    -- 286
INSERT INTO positions (title, division, school_department) VALUES ("Regional Director", 4, 44);                         -- 287
INSERT INTO positions (title, division, school_department) VALUES ("Director of Research & Development", 4, 44);        -- 288
INSERT INTO positions (title, division, school_department) VALUES ("Director of Human Resources", 4, 44);               -- 289
INSERT INTO positions (title, division, school_department) VALUES ("Director of Operations & Facilities", 4, 44);       -- 290
INSERT INTO positions (title, division, school_department) VALUES ("Director of Curriculum", 4, 44);                    -- 291
INSERT INTO positions (title, division, school_department) VALUES ("Director of Talent", 4, 44);                        -- 292
INSERT INTO positions (title, division, school_department) VALUES ("Executive Assistant to the President", 4, 44);      -- 293
INSERT INTO positions (title, division, school_department) VALUES ("Executive Assistant to Finance", 4, 44);            -- 294

-- Added positions
INSERT INTO positions (title, division, school_department) VALUES ("Regional Fusionologist", 2, 24);                    -- 295
INSERT INTO positions (title, division, school_department) VALUES ("Regional Director", 2, 24);                         -- 296

-- source_directories
INSERT INTO source_directories (name, parent) VALUES ("American Education Group", 1);           -- 1
-- American Education Group/
INSERT INTO source_directories (name, parent) VALUES ("AEG", 1);                                -- 2
INSERT INTO source_directories (name, parent) VALUES ("Schools", 1);                            -- 3
INSERT INTO source_directories (name, parent) VALUES ("Team Sites", 1);                         -- 4
-- American Education Group/AEG/
INSERT INTO source_directories (name, parent) VALUES ("Administration", 2);                     -- 5
INSERT INTO source_directories (name, parent) VALUES ("Information Technology", 2);             -- 6
INSERT INTO source_directories (name, parent) VALUES ("Marketing", 2);                          -- 7
INSERT INTO source_directories (name, parent) VALUES ("Human Resources", 2);                    -- 8
INSERT INTO source_directories (name, parent) VALUES ("Finance", 2);                            -- 9
INSERT INTO source_directories (name, parent) VALUES ("Coaching and Learning", 2);              -- 10
INSERT INTO source_directories (name, parent) VALUES ("New Business Development", 2);           -- 11
INSERT INTO source_directories (name, parent) VALUES ("Procurement", 2);                        -- 12
-- American Education Group/Schools/
INSERT INTO source_directories (name, parent) VALUES ("Fusion Division", 3);                    -- 13
INSERT INTO source_directories (name, parent) VALUES ("Lexis", 3);                              -- 14
INSERT INTO source_directories (name, parent) VALUES ("Little Sprouts", 3);                     -- 15
-- American Education Group/Team Sites/
INSERT INTO source_directories (name, parent) VALUES ("AEG R.O.C.K.S!", 4);                     -- 16
INSERT INTO source_directories (name, parent) VALUES ("NSO", 4);                                -- 17
INSERT INTO source_directories (name, parent) VALUES ("MPOPs", 4);                              -- 18
INSERT INTO source_directories (name, parent) VALUES ("EPIC! Portal", 4);                       -- 19
INSERT INTO source_directories (name, parent) VALUES ("1:1 Digital Curriculum", 4);             -- 20
-- American Education Group/AEG/Administration/
INSERT INTO source_directories (name, parent) VALUES ("Private", 5);                            -- 21
INSERT INTO source_directories (name, parent) VALUES ("Public", 5);                             -- 22
-- American Education Group/AEG/Information Technology/
INSERT INTO source_directories (name, parent) VALUES ("Private", 6);                            -- 23
INSERT INTO source_directories (name, parent) VALUES ("Public", 6);                             -- 24
INSERT INTO source_directories (name, parent) VALUES ("IT Planning", 6);                        -- 25
INSERT INTO source_directories (name, parent) VALUES ("Corporate Email Migration", 6);          -- 26
-- American Education Group/AEG/Marketing/
INSERT INTO source_directories (name, parent) VALUES ("Test Marketing", 7);                     -- 27
INSERT INTO source_directories (name, parent) VALUES ("Private", 7);                            -- 28
INSERT INTO source_directories (name, parent) VALUES ("Public", 7);                             -- 29
INSERT INTO source_directories (name, parent) VALUES ("Task List", 7);                          -- 30
INSERT INTO source_directories (name, parent) VALUES ("Project Tasks", 7);                      -- 31
-- American Education Group/AEG/Human Resources/
INSERT INTO source_directories (name, parent) VALUES ("Private", 8);                            -- 32
INSERT INTO source_directories (name, parent) VALUES ("Public", 8);                             -- 33
INSERT INTO source_directories (name, parent) VALUES ("New Hire Paperwork", 8);                 -- 34
INSERT INTO source_directories (name, parent) VALUES ("Benefits", 8);                           -- 35
INSERT INTO source_directories (name, parent) VALUES ("Observation", 8);                        -- 36
INSERT INTO source_directories (name, parent) VALUES ("Fusionology", 8);                        -- 37
INSERT INTO source_directories (name, parent) VALUES ("HR Resources", 8);                       -- 38
-- American Education Group/AEG/Finance/
INSERT INTO source_directories (name, parent) VALUES ("Private", 9);                            -- 39
INSERT INTO source_directories (name, parent) VALUES ("Public", 9);                             -- 40
INSERT INTO source_directories (name, parent) VALUES ("Administrator", 9);                      -- 41
-- American Education Group/AEG/New Business Development/
INSERT INTO source_directories (name, parent) VALUES ("Private", 11);                           -- 42
INSERT INTO source_directories (name, parent) VALUES ("Public", 11);                            -- 43
-- American Education Group/AEG/Procurement/
INSERT INTO source_directories (name, parent) VALUES ("Private", 12);                           -- 44
INSERT INTO source_directories (name, parent) VALUES ("Public", 12);                            -- 45
INSERT INTO source_directories (name, parent) VALUES ("Master Task List", 12);                  -- 46
INSERT INTO source_directories (name, parent) VALUES ("Master Calendar", 12);                   -- 47
-- American Education Group/Schools/Fusion Division/
INSERT INTO source_directories (name, parent) VALUES ("Huntington Beach", 13);                  -- 48
INSERT INTO source_directories (name, parent) VALUES ("Long Island", 13);                       -- 49
INSERT INTO source_directories (name, parent) VALUES ("Los Angeles", 13);                       -- 50
INSERT INTO source_directories (name, parent) VALUES ("Los Gatos", 13);                         -- 51
INSERT INTO source_directories (name, parent) VALUES ("Manhattan", 13);                         -- 52
INSERT INTO source_directories (name, parent) VALUES ("Mission Viejo", 13);                     -- 53
INSERT INTO source_directories (name, parent) VALUES ("Pasadena", 13);                          -- 54
INSERT INTO source_directories (name, parent) VALUES ("Regional", 13);                          -- 55
INSERT INTO source_directories (name, parent) VALUES ("San Francisco", 13);                     -- 56
INSERT INTO source_directories (name, parent) VALUES ("San Mateo", 13);                         -- 57
INSERT INTO source_directories (name, parent) VALUES ("Solana Beach", 13);                      -- 58
INSERT INTO source_directories (name, parent) VALUES ("South Bay", 13);                         -- 59
INSERT INTO source_directories (name, parent) VALUES ("Walnut Creek", 13);                      -- 60
INSERT INTO source_directories (name, parent) VALUES ("Warner Center", 13);                     -- 61
INSERT INTO source_directories (name, parent) VALUES ("Fusionology", 13);                       -- 62
INSERT INTO source_directories (name, parent) VALUES ("Discussion Board", 13);                  -- 63
INSERT INTO source_directories (name, parent) VALUES ("Outreach", 13);                          -- 64
INSERT INTO source_directories (name, parent) VALUES ("Accounting", 13);                        -- 65
INSERT INTO source_directories (name, parent) VALUES ("Leadership", 13);                        -- 66
INSERT INTO source_directories (name, parent) VALUES ("Registrar", 13);                         -- 67
INSERT INTO source_directories (name, parent) VALUES ("Curriculum", 13);                        -- 68
INSERT INTO source_directories (name, parent) VALUES ("Training", 13);                          -- 69
-- American Education Group/Schools/Lexis/
INSERT INTO source_directories (name, parent) VALUES ("Barnstable", 14);                        -- 70
INSERT INTO source_directories (name, parent) VALUES ("Shreiner", 14);                          -- 71
INSERT INTO source_directories (name, parent) VALUES ("Tampa Day", 14);                         -- 72
INSERT INTO source_directories (name, parent) VALUES ("Talking Heads", 14);                     -- 73
INSERT INTO source_directories (name, parent) VALUES ("Curriculum", 14);                        -- 74
INSERT INTO source_directories (name, parent) VALUES ("Scholarship", 14);                       -- 75
-- American Education Group/Schools/Little Sprouts/
INSERT INTO source_directories (name, parent) VALUES ("Private", 15);                           -- 76
INSERT INTO source_directories (name, parent) VALUES ("Public", 15);                            -- 77
INSERT INTO source_directories (name, parent) VALUES ("SMK", 15);                               -- 78
INSERT INTO source_directories (name, parent) VALUES ("Financials", 15);                        -- 79
INSERT INTO source_directories (name, parent) VALUES ("Data Centralization", 15);               -- 80
-- American Education Group/Team Sites/AEG R.O.C.K.S!/
INSERT INTO source_directories (name, parent) VALUES ("Corporate", 16);                         -- 81
INSERT INTO source_directories (name, parent) VALUES ("Fusion", 16);                            -- 82
INSERT INTO source_directories (name, parent) VALUES ("Little Sprouts", 16);                    -- 83
-- American Education Group/Team Sites/NSO/
INSERT INTO source_directories (name, parent) VALUES ("Private", 17);                           -- 84
INSERT INTO source_directories (name, parent) VALUES ("Public", 17);                            -- 85
INSERT INTO source_directories (name, parent) VALUES ("New Business Development", 17);          -- 86
INSERT INTO source_directories (name, parent) VALUES ("Construction Folder", 17);               -- 87
INSERT INTO source_directories (name, parent) VALUES ("Real Estate Folder", 17);                -- 88
INSERT INTO source_directories (name, parent) VALUES ("Project Tasks", 17);                     -- 89
INSERT INTO source_directories (name, parent) VALUES ("Project Calendar", 17);                  -- 90
-- American Education Group/Team Sites/MPOPs/
INSERT INTO source_directories (name, parent) VALUES ("Private", 18);                           -- 91
INSERT INTO source_directories (name, parent) VALUES ("Public", 18);                            -- 92
INSERT INTO source_directories (name, parent) VALUES ("Little Sprouts", 18);                    -- 93
INSERT INTO source_directories (name, parent) VALUES ("Fusion Division", 18);                   -- 94
INSERT INTO source_directories (name, parent) VALUES ("Tampa Day School", 18);                  -- 95
INSERT INTO source_directories (name, parent) VALUES ("Barnstable Academy", 18);                -- 96
INSERT INTO source_directories (name, parent) VALUES ("Shreiner Academy", 18);                  -- 97
-- American Education Group/Team Sites/EPIC! Portal/
INSERT INTO source_directories (name, parent) VALUES ("Private", 19);                           -- 98
INSERT INTO source_directories (name, parent) VALUES ("Public", 19);                            -- 99
INSERT INTO source_directories (name, parent) VALUES ("EPIC! Summits", 19);                     -- 100
INSERT INTO source_directories (name, parent) VALUES ("Reinventing School News", 19);           -- 101
INSERT INTO source_directories (name, parent) VALUES ("Rock 'N' CultuRoll Awareness", 19);      -- 102
-- American Education Group/Schools/Fusion Division/Huntington Beach/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 48);                             -- 103
INSERT INTO source_directories (name, parent) VALUES ("Public", 48);                            -- 104
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 48);                    -- 105
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 48);                    -- 106
-- American Education Group/Schools/Fusion Division/Los Angeles
INSERT INTO source_directories (name, parent) VALUES ("Staff", 50);                             -- 107
INSERT INTO source_directories (name, parent) VALUES ("Public", 50);                            -- 108
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 50);                    -- 109
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 50);                    -- 110
-- American Education Group/Schools/Fusion Division/Los Gatos
INSERT INTO source_directories (name, parent) VALUES ("Staff", 51);                             -- 111
INSERT INTO source_directories (name, parent) VALUES ("Public", 51);                            -- 112
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 51);                    -- 113
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 51);                    -- 114
-- American Education Group/Schools/Fusion Division/Mission Viejo/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 53);                             -- 115
INSERT INTO source_directories (name, parent) VALUES ("Public", 53);                            -- 116
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 53);                    -- 117
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 53);                    -- 118
-- American Education Group/Schools/Fusion Division/Pasadena/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 54);                             -- 119
INSERT INTO source_directories (name, parent) VALUES ("Public", 54);                            -- 120
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 54);                    -- 121
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 54);                    -- 122
-- American Education Group/Schools/Fusion Division/San Diego/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 203);                             -- 123
INSERT INTO source_directories (name, parent) VALUES ("Public", 203);                            -- 124
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 203);                    -- 125
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 203);                    -- 126
-- American Education Group/Schools/Fusion Division/San Francisco/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 56);                             -- 127
INSERT INTO source_directories (name, parent) VALUES ("Public", 56);                            -- 128
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 56);                    -- 129
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 56);                    -- 130
-- American Education Group/Schools/Fusion Division/San Mateo/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 57);                             -- 131
INSERT INTO source_directories (name, parent) VALUES ("Public", 57);                            -- 132
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 57);                    -- 133
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 57);                    -- 134
-- American Education Group/Schools/Fusion Division/South Bay/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 59);                             -- 135
INSERT INTO source_directories (name, parent) VALUES ("Public", 59);                            -- 136
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 59);                    -- 137
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 59);                    -- 138
-- American Education Group/Schools/Fusion Division/Solana Beach/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 58);                             -- 139
INSERT INTO source_directories (name, parent) VALUES ("Public", 58);                            -- 140
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 58);                    -- 141
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 58);                    -- 142
-- American Education Group/Schools/Fusion Division/Walnut Creek/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 60);                             -- 143
INSERT INTO source_directories (name, parent) VALUES ("Public", 60);                            -- 144
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 60);                    -- 145
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 60);                    -- 146
-- American Education Group/Schools/Fusion Division/Warner Center/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 61);                             -- 147
INSERT INTO source_directories (name, parent) VALUES ("Public", 61);                            -- 148
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 61);                    -- 149
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 61);                    -- 150
-- American Education Group/Schools/Fusion Division/Manhattan/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 52);                             -- 151
INSERT INTO source_directories (name, parent) VALUES ("Public", 52);                            -- 152
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 52);                    -- 153
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 52);                    -- 154
-- American Education Group/Schools/Fusion Division/Long Island/
INSERT INTO source_directories (name, parent) VALUES ("Staff", 49);                             -- 155
INSERT INTO source_directories (name, parent) VALUES ("Public", 49);                            -- 156
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 49);                    -- 157
INSERT INTO source_directories (name, parent) VALUES ("Head of School", 49);                    -- 158
-- American Education Group/Schools/Fusion Division/Fusionology/
INSERT INTO source_directories (name, parent) VALUES ("Fusionology Content", 62);               -- 159
INSERT INTO source_directories (name, parent) VALUES ("Private", 62);                           -- 160
INSERT INTO source_directories (name, parent) VALUES ("Public", 62);                            -- 161
INSERT INTO source_directories (name, parent) VALUES ("Collaboration", 62);                     -- 162
-- American Education Group/Schools/Fusion Division/Discussion Board/
INSERT INTO source_directories (name, parent) VALUES ("Marketing", 63);                         -- 163
-- American Education Group/Schools/Fusion Division/Outreach/
INSERT INTO source_directories (name, parent) VALUES ("Private", 64);                           -- 164
INSERT INTO source_directories (name, parent) VALUES ("Public", 64);                            -- 165
INSERT INTO source_directories (name, parent) VALUES ("Outreach Discussions", 64);              -- 166
-- American Education Group/Schools/Fusion Division/Accounting/
INSERT INTO source_directories (name, parent) VALUES ("Private", 65);                           -- 167
INSERT INTO source_directories (name, parent) VALUES ("Public", 65);                            -- 168
INSERT INTO source_directories (name, parent) VALUES ("Billing", 65);                           -- 169
INSERT INTO source_directories (name, parent) VALUES ("Budget", 65);                            -- 170
-- American Education Group/Schools/Fusion Division/Leadership/
INSERT INTO source_directories (name, parent) VALUES ("Private", 66);                           -- 171
INSERT INTO source_directories (name, parent) VALUES ("Public", 66);                            -- 172
-- American Education Group/Schools/Fusion Division/Registrar/
INSERT INTO source_directories (name, parent) VALUES ("Private", 67);                           -- 173
INSERT INTO source_directories (name, parent) VALUES ("Public", 67);                            -- 174
INSERT INTO source_directories (name, parent) VALUES ("Site Pages", 67);                        -- 175
INSERT INTO source_directories (name, parent) VALUES ("Transcript Requests", 67);               -- 176
INSERT INTO source_directories (name, parent) VALUES ("POC", 67);                               -- 177
-- American Education Group/Schools/Fusion Division/Curriculum/
INSERT INTO source_directories (name, parent) VALUES ("Private", 68);                           -- 178
INSERT INTO source_directories (name, parent) VALUES ("Public", 68);                            -- 179
INSERT INTO source_directories (name, parent) VALUES ("EPICenter!", 68);                        -- 180
-- American Education Group/Schools/Fusion Division/Training/
INSERT INTO source_directories (name, parent) VALUES ("Private", 69);                           -- 181
INSERT INTO source_directories (name, parent) VALUES ("Public", 69);                            -- 182
-- American Education Group/Schools/Lexis/Barnstable/
INSERT INTO source_directories (name, parent) VALUES ("Private", 70);                           -- 183
INSERT INTO source_directories (name, parent) VALUES ("Public", 70);                            -- 184
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 70);                    -- 185
INSERT INTO source_directories (name, parent) VALUES ("School", 70);                            -- 186
INSERT INTO source_directories (name, parent) VALUES ("Sick or Coverage", 70);                  -- 187
-- American Education Group/Schools/Lexis/Shreiner/
INSERT INTO source_directories (name, parent) VALUES ("Private", 71);                           -- 188
INSERT INTO source_directories (name, parent) VALUES ("Public", 71);                            -- 189
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 71);                    -- 190
INSERT INTO source_directories (name, parent) VALUES ("School", 71);                            -- 191
INSERT INTO source_directories (name, parent) VALUES ("Sick or Coverage", 71);                  -- 192
-- American Education Group/Schools/Lexis/Tampa Day/
INSERT INTO source_directories (name, parent) VALUES ("Private", 72);                           -- 193
INSERT INTO source_directories (name, parent) VALUES ("Public", 72);                            -- 194
INSERT INTO source_directories (name, parent) VALUES ("Administrators", 72);                    -- 195
INSERT INTO source_directories (name, parent) VALUES ("School", 72);                            -- 196
INSERT INTO source_directories (name, parent) VALUES ("Sick or Coverage", 72);                  -- 197
-- American Education Group/Schools/Lexis/Talking Heads/
INSERT INTO source_directories (name, parent) VALUES ("Leadership", 73);                        -- 198
INSERT INTO source_directories (name, parent) VALUES ("EPIC! Customer Service", 73);            -- 199
-- American Education Group/Schools/Lexis/Curriculum/
INSERT INTO source_directories (name, parent) VALUES ("Private", 74);                           -- 200
INSERT INTO source_directories (name, parent) VALUES ("Public", 74);                            -- 201
-- American Education Group/Schools/Lexis/Scholarship/
INSERT INTO source_directories (name, parent) VALUES ("Private", 75);                           -- 202
INSERT INTO source_directories (name, parent) VALUES ("San Diego", 13); 					-- 203

-- directory_owner
-- American Ed Group/
INSERT INTO directory_owner (directory, owner_position) VALUES (1, 1);
INSERT INTO directory_owner (directory, owner_position) VALUES (1, 2);

--   AEG
INSERT INTO directory_owner (directory, owner_position) VALUES (2, 1);
INSERT INTO directory_owner (directory, owner_position) VALUES (2, 2);

--   Schools
INSERT INTO directory_owner (directory, owner_position) VALUES (3, 7);

--   Team Sites
INSERT INTO directory_owner (directory, owner_position) VALUES (4, 3);

-- American Education Group/AEG/
--   Administration
INSERT INTO directory_owner (directory, owner_position) VALUES (5, 1);
INSERT INTO directory_owner (directory, owner_position) VALUES (5, 2);

--   Information Technology
INSERT INTO directory_owner (directory, owner_position) VALUES (6, 14);

--   Marketing
INSERT INTO directory_owner (directory, owner_position) VALUES (7, 23);

--   Human Resources
INSERT INTO directory_owner (directory, owner_position) VALUES (8, 11);

--   Finance
INSERT INTO directory_owner (directory, owner_position) VALUES (9, 16);

--   Coaching and Learning
INSERT INTO directory_owner (directory, owner_position) VALUES (10, 7);

--   New Business Development
INSERT INTO directory_owner (directory, owner_position) VALUES (11, 31);

--   Procurement
INSERT INTO directory_owner (directory, owner_position) VALUES (12, 33);

-- American Education Group/Schools/
--   Fusion Division
INSERT INTO directory_owner (directory, owner_position) VALUES (13, 7);

--   Lexis
INSERT INTO directory_owner (directory, owner_position) VALUES (14, 7);

--   Little Sprouts
INSERT INTO directory_owner (directory, owner_position) VALUES (15, 7);

-- American Education Group/Team Sites/
--   AEG R.O.C.K.S!
INSERT INTO directory_owner (directory, owner_position) VALUES (16, 33);

--   NSO
INSERT INTO directory_owner (directory, owner_position) VALUES (17, 11);

--   MPOPs
INSERT INTO directory_owner (directory, owner_position) VALUES (18, 33);

--   EPIC! Portal
INSERT INTO directory_owner (directory, owner_position) VALUES (19, 33);

--   1:1 Digital Curriculum
INSERT INTO directory_owner (directory, owner_position) VALUES (20, 9);

-- American Education Group/AEG/Administration/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (21, 1);
INSERT INTO directory_owner (directory, owner_position) VALUES (21, 2);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (22, 1);
INSERT INTO directory_owner (directory, owner_position) VALUES (22, 2);


-- American Education Group/AEG/Information Technology/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (23, 14);

--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (24, 14);

--   IT Planning
INSERT INTO directory_owner (directory, owner_position) VALUES (25, 14);

--   Corporate Email Migration
INSERT INTO directory_owner (directory, owner_position) VALUES (26, 14);

-- American Education Group/AEG/Marketing/
--   Test Marketing
INSERT INTO directory_owner (directory, owner_position) VALUES (27, 23);

--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (28, 23);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (29, 23);

--   Task List
INSERT INTO directory_owner (directory, owner_position) VALUES (30, 23);

--   Project Tasks
INSERT INTO directory_owner (directory, owner_position) VALUES (31, 23);

-- American Education Group/AEG/Human Resources/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (32, 11);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (33, 11);

--   New Hire Paperwork
INSERT INTO directory_owner (directory, owner_position) VALUES (34, 11);

--   Benefits
INSERT INTO directory_owner (directory, owner_position) VALUES (35, 11);

--   Observation
INSERT INTO directory_owner (directory, owner_position) VALUES (36, 11);

--   Fusionology
INSERT INTO directory_owner (directory, owner_position) VALUES (37, 11);

--   HR Resources
INSERT INTO directory_owner (directory, owner_position) VALUES (38, 11);

-- American Education Group/AEG/Finance/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (39, 16);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (40, 16);

--   Administrator
INSERT INTO directory_owner (directory, owner_position) VALUES (41, 16);

-- American Education Group/AEG/New Business Development/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (42, 31);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (43, 31);

-- American education Groupo/AEG/Procurement/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (44, 33);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (45, 33);

--   Master Task List
INSERT INTO directory_owner (directory, owner_position) VALUES (46, 33);

--   Master Calendar
INSERT INTO directory_owner (directory, owner_position) VALUES (47, 33);

-- American Education Group/Schools/Fusion Division/
--   Huntington Beach
INSERT INTO directory_owner (directory, owner_position) VALUES (48, 41);

--   Long Island
INSERT INTO directory_owner (directory, owner_position) VALUES (49, 210);

--   Los Angeles
INSERT INTO directory_owner (directory, owner_position) VALUES (50, 54);

--   Los Gatos
INSERT INTO directory_owner (directory, owner_position) VALUES (51, 67);

--   Manhattan
INSERT INTO directory_owner (directory, owner_position) VALUES (52, 197);

--   Mission Viejo
INSERT INTO directory_owner (directory, owner_position) VALUES (53, 80);

--   Pasadena
INSERT INTO directory_owner (directory, owner_position) VALUES (54, 93);

--   Regional
INSERT INTO directory_owner (directory, owner_position) VALUES (55, 231);

--   San Francisco
INSERT INTO directory_owner (directory, owner_position) VALUES (56, 106);

--   San Mateo
INSERT INTO directory_owner (directory, owner_position) VALUES (57, 132);

--   Solana Beach
INSERT INTO directory_owner (directory, owner_position) VALUES (58, 158);

--   South Bay
INSERT INTO directory_owner (directory, owner_position) VALUES (59, 145);

--   Walnut Creek
INSERT INTO directory_owner (directory, owner_position) VALUES (60, 171);

--   Warner Center
INSERT INTO directory_owner (directory, owner_position) VALUES (61, 184);

--   Fusionology
INSERT INTO directory_owner (directory, owner_position) VALUES (62, 195);

--   Discussion Board
INSERT INTO directory_owner (directory, owner_position) VALUES (63, 26);

--   Outreach
INSERT INTO directory_owner (directory, owner_position) VALUES (64, 25);

--   Accounting
INSERT INTO directory_owner (directory, owner_position) VALUES (65, 18);
INSERT INTO directory_owner (directory, owner_position) VALUES (65, 16);
INSERT INTO directory_owner (directory, owner_position) VALUES (65, 17);
INSERT INTO directory_owner (directory, owner_position) VALUES (65, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (65, 287);

--   Leadership
INSERT INTO directory_owner (directory, owner_position) VALUES (66, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (66, 287);

--   Registrar
INSERT INTO directory_owner (directory, owner_position) VALUES (67, 161);

--   Curriculum
INSERT INTO directory_owner (directory, owner_position) VALUES (68, 231);

--   Training
INSERT INTO directory_owner (directory, owner_position) VALUES (69, 231);

-- American Education Group/Schools/Lexis/
--   Barnstable
INSERT INTO directory_owner (directory, owner_position) VALUES (70, 233);

--   Shreiner
INSERT INTO directory_owner (directory, owner_position) VALUES (71, 239);

--   Tampa Day
INSERT INTO directory_owner (directory, owner_position) VALUES (72, 244);

--   Talking Heads
INSERT INTO directory_owner (directory, owner_position) VALUES (73, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (73, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (73, 244);

--   Curriculum
INSERT INTO directory_owner (directory, owner_position) VALUES (74, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (74, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (74, 244);

--   Scholarship
INSERT INTO directory_owner (directory, owner_position) VALUES (75, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (75, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (75, 244);

-- American Education Group/Schools/Little Sprouts/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (76, 284);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (77, 284);

--   SMK
INSERT INTO directory_owner (directory, owner_position) VALUES (78, 284);

--   Financials
INSERT INTO directory_owner (directory, owner_position) VALUES (79, 285);

--   Data Centralization
INSERT INTO directory_owner (directory, owner_position) VALUES (80, 286);

-- American Education Group/Team Sites/AEG R.O.C.K.S/
--   Corporate
INSERT INTO directory_owner (directory, owner_position) VALUES (81, 33);

--   Fusion
INSERT INTO directory_owner (directory, owner_position) VALUES (82, 33);

--   Little Sprouts
INSERT INTO directory_owner (directory, owner_position) VALUES (83, 33);

-- American Education Group/Team Site/NSO/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (84, 11);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (85, 11);

--   New Business Development
INSERT INTO directory_owner (directory, owner_position) VALUES (86, 11);

--   Construction Folder
INSERT INTO directory_owner (directory, owner_position) VALUES (87, 11);

--   Real Estate Folder
INSERT INTO directory_owner (directory, owner_position) VALUES (88, 11);

--   Project Tasks
INSERT INTO directory_owner (directory, owner_position) VALUES (89, 11);

--   Project Calendar
INSERT INTO directory_owner (directory, owner_position) VALUES (90, 11);

-- American Education Group/Team Sites/MPOPs/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (91, 11);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (92, 11);

--   Little Sprouts
INSERT INTO directory_owner (directory, owner_position) VALUES (93, 11);

--   Fusion Division
INSERT INTO directory_owner (directory, owner_position) VALUES (94, 11);

--   Tampa Day School
INSERT INTO directory_owner (directory, owner_position) VALUES (95, 11);

--   Barnstable Academy
INSERT INTO directory_owner (directory, owner_position) VALUES (96, 11);

--   Shreiner Academy
INSERT INTO directory_owner (directory, owner_position) VALUES (97, 11);

-- American Education Group/Team Sites/EPIC! Portal/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (98, 11);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (99, 11);

--   EPIC! Summits
INSERT INTO directory_owner (directory, owner_position) VALUES (100, 11);

--   Reinventing School News
INSERT INTO directory_owner (directory, owner_position) VALUES (101, 11);

--   Rock 'N' CulturRoll Awareness
INSERT INTO directory_owner (directory, owner_position) VALUES (102, 11);

-- American Education Group/Schools/Fusion Division/Huntington Beach/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (103, 41);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (104, 41);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (105, 41);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (106, 41);

-- American Education Group/Schools/Fusion Division/Long Island/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (107, 210);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (108, 210);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (109, 210);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (110, 210);

-- American Education Group/Schools/Fusion Division/Los Angeles/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (111, 54);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (112, 54);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (113, 54);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (114, 54);

-- American Education Group/Schools/Fusion Division/Los Gatos/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (115, 67);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (116, 67);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (117, 67);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (118, 67);

-- American Education Group/Schools/Fusion Division/Manhattan/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (119, 197);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (120, 197);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (121, 197);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (122, 197);

-- American Education Group/Schools/Fusion Division/Mission Viejo/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (123, 80);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (124, 80);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (125, 80);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (126, 80);

-- American Education Group/Schools/Fusion Division/Pasadena/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (127, 93);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (128, 93);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (129, 93);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (130, 93);

-- American Education Group/Schools/Fusion Division/Regional/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (131, 231);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (132, 231);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (133, 231);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (134, 231);

-- American Education Group/Schools/Fusion Division/San Francisco/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (135, 119);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (136, 119);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (137, 119);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (138, 119);

-- American Education Group/Schools/Fusion Division/San Mateo/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (139, 132);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (140, 132);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (141, 132);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (142, 132);

-- American Education Group/Schools/Fusion Division/Solana Beach/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (143, 158);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (144, 158);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (145, 158);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (146, 158);

-- American Education Group/Schools/Fusion Division/South Bay/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (147, 145);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (148, 145);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (149, 145);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (150, 145);

-- American Education Group/Schools/Fusion Division/Walnut Creek/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (151, 171);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (152, 171);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (153, 171);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (154, 171);

-- American Education Group/Schools/Fusion Division/Warner Center/
--   Staff
INSERT INTO directory_owner (directory, owner_position) VALUES (155, 184);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (156, 184);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (157, 184);

--   Head of School
INSERT INTO directory_owner (directory, owner_position) VALUES (158, 184);

-- American Education Group/Schools/Fusion Division/Fusionology/
--   Fusionology Content
INSERT INTO directory_owner (directory, owner_position) VALUES (159, 295);

--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (160, 295);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (161, 295);

--   Collaboration
INSERT INTO directory_owner (directory, owner_position) VALUES (162, 295);

-- American Education Group/Schools/Fusion Division/Discussion Board/
--   Marketing
INSERT INTO directory_owner (directory, owner_position) VALUES (163, 26);

-- American Education Group/Schools/Fusion Division/Outreach/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (164, 25);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (165, 25);

--   Outreach Discussions
INSERT INTO directory_owner (directory, owner_position) VALUES (166, 25);

-- American Education Group/Schools/Fusion Division/Accounting/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (167, 18);
INSERT INTO directory_owner (directory, owner_position) VALUES (167, 16);
INSERT INTO directory_owner (directory, owner_position) VALUES (167, 17);
INSERT INTO directory_owner (directory, owner_position) VALUES (167, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (167, 287);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (168, 16);
INSERT INTO directory_owner (directory, owner_position) VALUES (168, 17);
INSERT INTO directory_owner (directory, owner_position) VALUES (168, 18);
INSERT INTO directory_owner (directory, owner_position) VALUES (168, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (168, 287);

--   Billing
INSERT INTO directory_owner (directory, owner_position) VALUES (169, 16);
INSERT INTO directory_owner (directory, owner_position) VALUES (169, 17);
INSERT INTO directory_owner (directory, owner_position) VALUES (169, 18);
INSERT INTO directory_owner (directory, owner_position) VALUES (169, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (169, 287);

--   Budget
INSERT INTO directory_owner (directory, owner_position) VALUES (170, 16);
INSERT INTO directory_owner (directory, owner_position) VALUES (170, 17);
INSERT INTO directory_owner (directory, owner_position) VALUES (170, 18);
INSERT INTO directory_owner (directory, owner_position) VALUES (170, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (170, 287);

-- American Education Group/Schools/Fusion Division/Leadership/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (171, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (171, 287);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (172, 286);
INSERT INTO directory_owner (directory, owner_position) VALUES (172, 287);

-- American Education Group/Schools/Fusion Division/Registrar/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (173, 161);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (174, 161);

--   Site Pages
INSERT INTO directory_owner (directory, owner_position) VALUES (175, 161);

--   Transcript Requests
INSERT INTO directory_owner (directory, owner_position) VALUES (176, 161);

--   POC
INSERT INTO directory_owner (directory, owner_position) VALUES (177, 161);

-- Americane Education Group/Schools/Fusion Division/Curriculum/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (178, 231);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (179, 231);

--   EPICenter!
INSERT INTO directory_owner (directory, owner_position) VALUES (180, 231);

-- American Education Group/Schools/Fusion Division/Training/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (181, 231);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (182, 231);

-- American Education Group/Schools/Lexis/Barnstable/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (183, 233);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (184, 233);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (185, 233);

--   School
INSERT INTO directory_owner (directory, owner_position) VALUES (186, 233);

--   Sick or Coverage
INSERT INTO directory_owner (directory, owner_position) VALUES (187, 233);

-- American Education Group/Schools/Lexis/Shreiner/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (188, 239);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (189, 239);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (190, 239);

--   School
INSERT INTO directory_owner (directory, owner_position) VALUES (191, 239);

--   Sick or Coverage
INSERT INTO directory_owner (directory, owner_position) VALUES (192, 239);


-- American Education Group/Schools/Lexis/Tampa Day/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (193, 244);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (194, 244);

--   Administrators
INSERT INTO directory_owner (directory, owner_position) VALUES (195, 244);

--   School
INSERT INTO directory_owner (directory, owner_position) VALUES (196, 244);

--   Sick or Coverage
INSERT INTO directory_owner (directory, owner_position) VALUES (197, 244);

-- American Education Group/Schools/Lexis/Talking Heads/
--   Leadership
INSERT INTO directory_owner (directory, owner_position) VALUES (198, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (198, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (198, 244);

--   EPIC! Customer Service
INSERT INTO directory_owner (directory, owner_position) VALUES (199, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (199, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (199, 244);

-- American Education Group/Schools/Lexis/Curriculum/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (200, 7);
INSERT INTO directory_owner (directory, owner_position) VALUES (200, 8);
INSERT INTO directory_owner (directory, owner_position) VALUES (200, 9);

--   Public
INSERT INTO directory_owner (directory, owner_position) VALUES (201, 7);
INSERT INTO directory_owner (directory, owner_position) VALUES (201, 8);
INSERT INTO directory_owner (directory, owner_position) VALUES (201, 9);


-- American Education Group/Schools/Lexis/Scholarship/
--   Private
INSERT INTO directory_owner (directory, owner_position) VALUES (202, 233);
INSERT INTO directory_owner (directory, owner_position) VALUES (202, 239);
INSERT INTO directory_owner (directory, owner_position) VALUES (202, 244);






-- read_permissions & Edit Permissions
-- directory_owner
-- American Ed Group/
--   AEG
--   Schools
--   Team Sites

-- American Education Group/AEG/
--   Administration
-- INSERT INTO read_permissions(position, directory) VALUES (1,5);---------------------------------------------------------------------------------------------------------
-- INSERT INTO read_permissions(position, directory) VALUES (2,5);
-- INSERT INTO read_permissions(position, directory) VALUES (3,5);
-- INSERT INTO read_permissions(position, directory) VALUES (4,5);
-- INSERT INTO read_permissions(position, directory) VALUES (5,5);
-- INSERT INTO read_permissions(position, directory) VALUES (6,5);

-- INSERT INTO edit_permissions(position, directory) VALUES (1,5);
-- INSERT INTO edit_permissions(position, directory) VALUES (2,5);
-- INSERT INTO edit_permissions(position, directory) VALUES (3,5);
-- INSERT INTO edit_permissions(position, directory) VALUES (4,5);
-- INSERT INTO edit_permissions(position, directory) VALUES (5,5);
-- INSERT INTO edit_permissions(position, directory) VALUES (6,5);

--   Information Technology
-- INSERT INTO read_permissions(position, directory) VALUES (14,6);
-- INSERT INTO read_permissions(position, directory) VALUES (15,6);

-- INSERT INTO edit_permissions(position, directory) VALUES (14,6);
-- INSERT INTO edit_permissions(position, directory) VALUES (15,6);

--   Marketing
-- INSERT INTO read_permissions(position, directory) VALUES (23,7);
-- INSERT INTO read_permissions(position, directory) VALUES (24,7);
-- INSERT INTO read_permissions(position, directory) VALUES (25,7);
-- INSERT INTO read_permissions(position, directory) VALUES (26,7);
-- INSERT INTO read_permissions(position, directory) VALUES (27,7);
-- INSERT INTO read_permissions(position, directory) VALUES (28,7);
-- INSERT INTO read_permissions(position, directory) VALUES (29,7);
-- INSERT INTO read_permissions(position, directory) VALUES (30,7);

-- INSERT INTO edit_permissions(position, directory) VALUES (23,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (24,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (25,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (26,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (27,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (28,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (29,7);
-- INSERT INTO edit_permissions(position, directory) VALUES (30,7);

--   Human Resources
-- INSERT INTO read_permissions(position, directory) VALUES (11,8);
-- INSERT INTO read_permissions(position, directory) VALUES (12,8);
-- INSERT INTO read_permissions(position, directory) VALUES (13,8);

-- INSERT INTO edit_permissions(position, directory) VALUES (11,8);
-- INSERT INTO edit_permissions(position, directory) VALUES (12,8);
-- INSERT INTO edit_permissions(position, directory) VALUES (13,8);

--   Finance
-- INSERT INTO read_permissions(position, directory) VALUES (,9);

-- INSERT INTO edit_permissions(position, directory) VALUES (,9);

--   Coaching and Learning
-- INSERT INTO read_permissions(position, directory) VALUES (,10);

-- INSERT INTO edit_permissions(position, directory) VALUES (,10);
--   New Business Development
-- INSERT INTO read_permissions(position, directory) VALUES (,11);

-- INSERT INTO edit_permissions(position, directory) VALUES (,11);
--   Procurement
-- INSERT INTO read_permissions(position, directory) VALUES (,12);

-- INSERT INTO edit_permissions(position, directory) VALUES (,12);

-- American Education Group/Schools/
--   Fusion Division
-- INSERT INTO read_permissions(position, directory) VALUES (,13);

-- INSERT INTO edit_permissions(position, directory) VALUES (,13);
--   Lexis
-- INSERT INTO read_permissions(position, directory) VALUES (,14);

-- INSERT INTO edit_permissions(position, directory) VALUES (,14);
--   Little Sprouts
-- INSERT INTO read_permissions(position, directory) VALUES (,15);

-- INSERT INTO edit_permissions(position, directory) VALUES (,15);

-- American Education Group/Team Sites/
--   AEG R.O.C.K.S!
-- INSERT INTO read_permissions(position, directory) VALUES (,16);

-- INSERT INTO edit_permissions(position, directory) VALUES (,16);
--   NSO
-- INSERT INTO read_permissions(position, directory) VALUES (,17);

-- INSERT INTO edit_permissions(position, directory) VALUES (,17);
--   MPOPs
-- INSERT INTO read_permissions(position, directory) VALUES (,18);

-- INSERT INTO edit_permissions(position, directory) VALUES (,18);
--   EPIC! Portal
-- INSERT INTO read_permissions(position, directory) VALUES (,19);

-- INSERT INTO edit_permissions(position, directory) VALUES (,19);
--   1:1 Digital Curriculum
-- INSERT INTO read_permissions(position, directory) VALUES (,20);

-- INSERT INTO edit_permissions(position, directory) VALUES (,20);

-- American Education Group/AEG/Administration/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (1,21);
INSERT INTO read_permissions(position, directory) VALUES (2,21);
INSERT INTO read_permissions(position, directory) VALUES (3,21);
INSERT INTO read_permissions(position, directory) VALUES (4,21);
INSERT INTO read_permissions(position, directory) VALUES (5,21);
INSERT INTO read_permissions(position, directory) VALUES (6,21);

INSERT INTO edit_permissions(position, directory) VALUES (1,21);
INSERT INTO edit_permissions(position, directory) VALUES (2,21);
INSERT INTO edit_permissions(position, directory) VALUES (3,21);
INSERT INTO edit_permissions(position, directory) VALUES (4,21);
INSERT INTO edit_permissions(position, directory) VALUES (5,21);
INSERT INTO edit_permissions(position, directory) VALUES (6,21);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (1,22);
INSERT INTO edit_permissions(position, directory) VALUES (2,22);
INSERT INTO edit_permissions(position, directory) VALUES (3,22);
INSERT INTO edit_permissions(position, directory) VALUES (4,22);
INSERT INTO edit_permissions(position, directory) VALUES (5,22);
INSERT INTO edit_permissions(position, directory) VALUES (6,22);

-- American Education Group/AEG/Information Technology/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (14,23);
INSERT INTO read_permissions(position, directory) VALUES (15,23);

INSERT INTO edit_permissions(position, directory) VALUES (14,23);
INSERT INTO edit_permissions(position, directory) VALUES (15,23);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (14,24);
INSERT INTO edit_permissions(position, directory) VALUES (15,24);

--   IT Planning
INSERT INTO read_permissions(position, directory) VALUES (14,25);
INSERT INTO read_permissions(position, directory) VALUES (15,25);

INSERT INTO edit_permissions(position, directory) VALUES (14,25);
INSERT INTO edit_permissions(position, directory) VALUES (15,25);

--   Corporate Email Migration
INSERT INTO read_permissions(position, directory) VALUES (14,26);
INSERT INTO read_permissions(position, directory) VALUES (15,26);

INSERT INTO edit_permissions(position, directory) VALUES (14,26);
INSERT INTO edit_permissions(position, directory) VALUES (15,26);

-- American Education Group/AEG/Marketing/
--   Test Marketing
INSERT INTO read_permissions(position, directory) VALUES (23,27);
INSERT INTO read_permissions(position, directory) VALUES (24,27);
INSERT INTO read_permissions(position, directory) VALUES (25,27);
INSERT INTO read_permissions(position, directory) VALUES (26,27);
INSERT INTO read_permissions(position, directory) VALUES (27,27);
INSERT INTO read_permissions(position, directory) VALUES (28,27);
INSERT INTO read_permissions(position, directory) VALUES (29,27);
INSERT INTO read_permissions(position, directory) VALUES (30,27);

INSERT INTO edit_permissions(position, directory) VALUES (23,27);
INSERT INTO edit_permissions(position, directory) VALUES (24,27);
INSERT INTO edit_permissions(position, directory) VALUES (25,27);
INSERT INTO edit_permissions(position, directory) VALUES (26,27);
INSERT INTO edit_permissions(position, directory) VALUES (27,27);
INSERT INTO edit_permissions(position, directory) VALUES (28,27);
INSERT INTO edit_permissions(position, directory) VALUES (29,27);
INSERT INTO edit_permissions(position, directory) VALUES (30,27);

--   Private
INSERT INTO read_permissions(position, directory) VALUES (23,28);
INSERT INTO read_permissions(position, directory) VALUES (24,28);
INSERT INTO read_permissions(position, directory) VALUES (25,28);
INSERT INTO read_permissions(position, directory) VALUES (26,28);
INSERT INTO read_permissions(position, directory) VALUES (27,28);

INSERT INTO read_permissions(position, directory) VALUES (28,28);
INSERT INTO read_permissions(position, directory) VALUES (29,28);
INSERT INTO read_permissions(position, directory) VALUES (30,28);

INSERT INTO edit_permissions(position, directory) VALUES (23,28);
INSERT INTO edit_permissions(position, directory) VALUES (24,28);
INSERT INTO edit_permissions(position, directory) VALUES (25,28);
INSERT INTO edit_permissions(position, directory) VALUES (26,28);
INSERT INTO edit_permissions(position, directory) VALUES (27,28);
INSERT INTO edit_permissions(position, directory) VALUES (28,28);
INSERT INTO edit_permissions(position, directory) VALUES (29,28);
INSERT INTO edit_permissions(position, directory) VALUES (30,28);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (23,29);
INSERT INTO edit_permissions(position, directory) VALUES (24,29);
INSERT INTO edit_permissions(position, directory) VALUES (25,29);
INSERT INTO edit_permissions(position, directory) VALUES (26,29);
INSERT INTO edit_permissions(position, directory) VALUES (27,29);
INSERT INTO edit_permissions(position, directory) VALUES (28,29);
INSERT INTO edit_permissions(position, directory) VALUES (29,29);
INSERT INTO edit_permissions(position, directory) VALUES (30,29);

--   Task List
INSERT INTO read_permissions(position, directory) VALUES (23,30);
INSERT INTO read_permissions(position, directory) VALUES (24,30);
INSERT INTO read_permissions(position, directory) VALUES (25,30);
INSERT INTO read_permissions(position, directory) VALUES (26,30);
INSERT INTO read_permissions(position, directory) VALUES (27,30);
INSERT INTO read_permissions(position, directory) VALUES (28,30);
INSERT INTO read_permissions(position, directory) VALUES (29,30);
INSERT INTO read_permissions(position, directory) VALUES (30,30);

INSERT INTO edit_permissions(position, directory) VALUES (23,30);
INSERT INTO edit_permissions(position, directory) VALUES (24,30);
INSERT INTO edit_permissions(position, directory) VALUES (25,30);
INSERT INTO edit_permissions(position, directory) VALUES (26,30);
INSERT INTO edit_permissions(position, directory) VALUES (27,30);
INSERT INTO edit_permissions(position, directory) VALUES (28,30);
INSERT INTO edit_permissions(position, directory) VALUES (29,30);
INSERT INTO edit_permissions(position, directory) VALUES (30,30);

--   Project Tasks
INSERT INTO read_permissions(position, directory) VALUES (23,31);
INSERT INTO read_permissions(position, directory) VALUES (24,31);
INSERT INTO read_permissions(position, directory) VALUES (25,31);
INSERT INTO read_permissions(position, directory) VALUES (26,31);
INSERT INTO read_permissions(position, directory) VALUES (27,31);
INSERT INTO read_permissions(position, directory) VALUES (28,31);
INSERT INTO read_permissions(position, directory) VALUES (29,31);
INSERT INTO read_permissions(position, directory) VALUES (30,31);

INSERT INTO edit_permissions(position, directory) VALUES (23,31);
INSERT INTO edit_permissions(position, directory) VALUES (24,31);
INSERT INTO edit_permissions(position, directory) VALUES (25,31);
INSERT INTO edit_permissions(position, directory) VALUES (26,31);
INSERT INTO edit_permissions(position, directory) VALUES (27,31);
INSERT INTO edit_permissions(position, directory) VALUES (28,31);
INSERT INTO edit_permissions(position, directory) VALUES (29,31);
INSERT INTO edit_permissions(position, directory) VALUES (30,31);

-- American Education Group/AEG/Human Resources/

--   Private
INSERT INTO read_permissions(position, directory) VALUES (11,32);
INSERT INTO read_permissions(position, directory) VALUES (12,32);
INSERT INTO read_permissions(position, directory) VALUES (13,32);

INSERT INTO edit_permissions(position, directory) VALUES (11,32);
INSERT INTO edit_permissions(position, directory) VALUES (12,32);
INSERT INTO edit_permissions(position, directory) VALUES (13,32);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (11,33);
INSERT INTO edit_permissions(position, directory) VALUES (12,33);
INSERT INTO edit_permissions(position, directory) VALUES (13,33);

--   New Hire Paperwork
INSERT INTO read_permissions(position, directory) VALUES (11,34);
INSERT INTO read_permissions(position, directory) VALUES (12,34);
INSERT INTO read_permissions(position, directory) VALUES (13,34);
--     DFI
INSERT INTO read_permissions(position, directory) VALUES (37,34);
INSERT INTO read_permissions(position, directory) VALUES (50,34);
INSERT INTO read_permissions(position, directory) VALUES (63,34);
INSERT INTO read_permissions(position, directory) VALUES (76,34);
INSERT INTO read_permissions(position, directory) VALUES (89,34);
INSERT INTO read_permissions(position, directory) VALUES (102,34);
INSERT INTO read_permissions(position, directory) VALUES (115,34);
INSERT INTO read_permissions(position, directory) VALUES (128,34);
INSERT INTO read_permissions(position, directory) VALUES (121,34);
INSERT INTO read_permissions(position, directory) VALUES (154,34);
INSERT INTO read_permissions(position, directory) VALUES (167,34);
INSERT INTO read_permissions(position, directory) VALUES (180,34);
INSERT INTO read_permissions(position, directory) VALUES (193,34);
INSERT INTO read_permissions(position, directory) VALUES (206,34);
INSERT INTO read_permissions(position, directory) VALUES (219,34);
--     Assistant Director
INSERT INTO read_permissions(position, directory) VALUES (34,34);
INSERT INTO read_permissions(position, directory) VALUES (47,34);
INSERT INTO read_permissions(position, directory) VALUES (60,34);
INSERT INTO read_permissions(position, directory) VALUES (73,34);
INSERT INTO read_permissions(position, directory) VALUES (86,34);
INSERT INTO read_permissions(position, directory) VALUES (99,34);
INSERT INTO read_permissions(position, directory) VALUES (112,34);
INSERT INTO read_permissions(position, directory) VALUES (125,34);
INSERT INTO read_permissions(position, directory) VALUES (138,34);
INSERT INTO read_permissions(position, directory) VALUES (151,34);
INSERT INTO read_permissions(position, directory) VALUES (164,34);
INSERT INTO read_permissions(position, directory) VALUES (177,34);
INSERT INTO read_permissions(position, directory) VALUES (190,34);
INSERT INTO read_permissions(position, directory) VALUES (203,34);
INSERT INTO read_permissions(position, directory) VALUES (216,34);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,34);
INSERT INTO read_permissions(position, directory) VALUES (54,34);
INSERT INTO read_permissions(position, directory) VALUES (67,34);
INSERT INTO read_permissions(position, directory) VALUES (80,34);
INSERT INTO read_permissions(position, directory) VALUES (93,34);
INSERT INTO read_permissions(position, directory) VALUES (106,34);
INSERT INTO read_permissions(position, directory) VALUES (119,34);
INSERT INTO read_permissions(position, directory) VALUES (132,34);
INSERT INTO read_permissions(position, directory) VALUES (145,34);
INSERT INTO read_permissions(position, directory) VALUES (158,34);
INSERT INTO read_permissions(position, directory) VALUES (171,34);
INSERT INTO read_permissions(position, directory) VALUES (184,34);
INSERT INTO read_permissions(position, directory) VALUES (197,34);
INSERT INTO read_permissions(position, directory) VALUES (210,34);
INSERT INTO read_permissions(position, directory) VALUES (223,34);
INSERT INTO read_permissions(position, directory) VALUES (233,34);
INSERT INTO read_permissions(position, directory) VALUES (239,34);
INSERT INTO read_permissions(position, directory) VALUES (244,34);


INSERT INTO edit_permissions(position, directory) VALUES (11,34);
INSERT INTO edit_permissions(position, directory) VALUES (12,34);
INSERT INTO edit_permissions(position, directory) VALUES (13,34);

--   Benefits
INSERT INTO read_permissions(position, directory) VALUES (11,35);
INSERT INTO read_permissions(position, directory) VALUES (12,35);
INSERT INTO read_permissions(position, directory) VALUES (13,35);
--     DFI
INSERT INTO read_permissions(position, directory) VALUES (37,35);
INSERT INTO read_permissions(position, directory) VALUES (50,35);
INSERT INTO read_permissions(position, directory) VALUES (63,35);
INSERT INTO read_permissions(position, directory) VALUES (76,35);
INSERT INTO read_permissions(position, directory) VALUES (89,35);
INSERT INTO read_permissions(position, directory) VALUES (102,35);
INSERT INTO read_permissions(position, directory) VALUES (115,35);
INSERT INTO read_permissions(position, directory) VALUES (128,35);
INSERT INTO read_permissions(position, directory) VALUES (121,35);
INSERT INTO read_permissions(position, directory) VALUES (154,35);
INSERT INTO read_permissions(position, directory) VALUES (167,35);
INSERT INTO read_permissions(position, directory) VALUES (180,35);
INSERT INTO read_permissions(position, directory) VALUES (193,35);
INSERT INTO read_permissions(position, directory) VALUES (206,35);
INSERT INTO read_permissions(position, directory) VALUES (219,35);
--     Assistant Director
INSERT INTO read_permissions(position, directory) VALUES (35,35);
INSERT INTO read_permissions(position, directory) VALUES (47,35);
INSERT INTO read_permissions(position, directory) VALUES (60,35);
INSERT INTO read_permissions(position, directory) VALUES (73,35);
INSERT INTO read_permissions(position, directory) VALUES (86,35);
INSERT INTO read_permissions(position, directory) VALUES (99,35);
INSERT INTO read_permissions(position, directory) VALUES (112,35);
INSERT INTO read_permissions(position, directory) VALUES (125,35);
INSERT INTO read_permissions(position, directory) VALUES (138,35);
INSERT INTO read_permissions(position, directory) VALUES (151,35);
INSERT INTO read_permissions(position, directory) VALUES (164,35);
INSERT INTO read_permissions(position, directory) VALUES (177,35);
INSERT INTO read_permissions(position, directory) VALUES (190,35);
INSERT INTO read_permissions(position, directory) VALUES (203,35);
INSERT INTO read_permissions(position, directory) VALUES (216,35);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,35);
INSERT INTO read_permissions(position, directory) VALUES (54,35);
INSERT INTO read_permissions(position, directory) VALUES (67,35);
INSERT INTO read_permissions(position, directory) VALUES (80,35);
INSERT INTO read_permissions(position, directory) VALUES (93,35);
INSERT INTO read_permissions(position, directory) VALUES (106,35);
INSERT INTO read_permissions(position, directory) VALUES (119,35);
INSERT INTO read_permissions(position, directory) VALUES (132,35);
INSERT INTO read_permissions(position, directory) VALUES (145,35);
INSERT INTO read_permissions(position, directory) VALUES (158,35);
INSERT INTO read_permissions(position, directory) VALUES (171,35);
INSERT INTO read_permissions(position, directory) VALUES (184,35);
INSERT INTO read_permissions(position, directory) VALUES (197,35);
INSERT INTO read_permissions(position, directory) VALUES (210,35);
INSERT INTO read_permissions(position, directory) VALUES (223,35);
INSERT INTO read_permissions(position, directory) VALUES (233,35);
INSERT INTO read_permissions(position, directory) VALUES (239,35);
INSERT INTO read_permissions(position, directory) VALUES (244,35);


INSERT INTO edit_permissions(position, directory) VALUES (11,35);
INSERT INTO edit_permissions(position, directory) VALUES (12,35);
INSERT INTO edit_permissions(position, directory) VALUES (13,35);

--   Observation
INSERT INTO read_permissions(position, directory) VALUES (11,36);
INSERT INTO read_permissions(position, directory) VALUES (12,36);
INSERT INTO read_permissions(position, directory) VALUES (13,36);
--     DFI
INSERT INTO read_permissions(position, directory) VALUES (37,36);
INSERT INTO read_permissions(position, directory) VALUES (50,36);
INSERT INTO read_permissions(position, directory) VALUES (63,36);
INSERT INTO read_permissions(position, directory) VALUES (76,36);
INSERT INTO read_permissions(position, directory) VALUES (89,36);
INSERT INTO read_permissions(position, directory) VALUES (102,36);
INSERT INTO read_permissions(position, directory) VALUES (115,36);
INSERT INTO read_permissions(position, directory) VALUES (128,36);
INSERT INTO read_permissions(position, directory) VALUES (121,36);
INSERT INTO read_permissions(position, directory) VALUES (154,36);
INSERT INTO read_permissions(position, directory) VALUES (167,36);
INSERT INTO read_permissions(position, directory) VALUES (180,36);
INSERT INTO read_permissions(position, directory) VALUES (193,36);
INSERT INTO read_permissions(position, directory) VALUES (206,36);
INSERT INTO read_permissions(position, directory) VALUES (219,36);
--     Assistant Director
INSERT INTO read_permissions(position, directory) VALUES (36,36);
INSERT INTO read_permissions(position, directory) VALUES (47,36);
INSERT INTO read_permissions(position, directory) VALUES (60,36);
INSERT INTO read_permissions(position, directory) VALUES (73,36);
INSERT INTO read_permissions(position, directory) VALUES (86,36);
INSERT INTO read_permissions(position, directory) VALUES (99,36);
INSERT INTO read_permissions(position, directory) VALUES (112,36);
INSERT INTO read_permissions(position, directory) VALUES (125,36);
INSERT INTO read_permissions(position, directory) VALUES (138,36);
INSERT INTO read_permissions(position, directory) VALUES (151,36);
INSERT INTO read_permissions(position, directory) VALUES (164,36);
INSERT INTO read_permissions(position, directory) VALUES (177,36);
INSERT INTO read_permissions(position, directory) VALUES (190,36);
INSERT INTO read_permissions(position, directory) VALUES (203,36);
INSERT INTO read_permissions(position, directory) VALUES (216,36);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,36);
INSERT INTO read_permissions(position, directory) VALUES (54,36);
INSERT INTO read_permissions(position, directory) VALUES (67,36);
INSERT INTO read_permissions(position, directory) VALUES (80,36);
INSERT INTO read_permissions(position, directory) VALUES (93,36);
INSERT INTO read_permissions(position, directory) VALUES (106,36);
INSERT INTO read_permissions(position, directory) VALUES (119,36);
INSERT INTO read_permissions(position, directory) VALUES (132,36);
INSERT INTO read_permissions(position, directory) VALUES (145,36);
INSERT INTO read_permissions(position, directory) VALUES (158,36);
INSERT INTO read_permissions(position, directory) VALUES (171,36);
INSERT INTO read_permissions(position, directory) VALUES (184,36);
INSERT INTO read_permissions(position, directory) VALUES (197,36);
INSERT INTO read_permissions(position, directory) VALUES (210,36);
INSERT INTO read_permissions(position, directory) VALUES (223,36);
INSERT INTO read_permissions(position, directory) VALUES (233,36);
INSERT INTO read_permissions(position, directory) VALUES (239,36);
INSERT INTO read_permissions(position, directory) VALUES (244,36);


INSERT INTO edit_permissions(position, directory) VALUES (11,36);
INSERT INTO edit_permissions(position, directory) VALUES (12,36);
INSERT INTO edit_permissions(position, directory) VALUES (13,36);

--   Fusionology
INSERT INTO read_permissions(position, directory) VALUES (11,37);
INSERT INTO read_permissions(position, directory) VALUES (12,37);
INSERT INTO read_permissions(position, directory) VALUES (13,37);
--     Director of Operations
INSERT INTO read_permissions(position, directory) VALUES (231,37);

INSERT INTO edit_permissions(position, directory) VALUES (11,37);
INSERT INTO edit_permissions(position, directory) VALUES (12,37);
INSERT INTO edit_permissions(position, directory) VALUES (13,37);
--     Director of Operations
INSERT INTO edit_permissions(position, directory) VALUES (231,37);

--   HR Resources
INSERT INTO read_permissions(position, directory) VALUES (11,38);
INSERT INTO read_permissions(position, directory) VALUES (12,38);
INSERT INTO read_permissions(position, directory) VALUES (13,38);
--     DFI
INSERT INTO read_permissions(position, directory) VALUES (37,38);
INSERT INTO read_permissions(position, directory) VALUES (50,38);
INSERT INTO read_permissions(position, directory) VALUES (63,38);
INSERT INTO read_permissions(position, directory) VALUES (76,38);
INSERT INTO read_permissions(position, directory) VALUES (89,38);
INSERT INTO read_permissions(position, directory) VALUES (102,38);
INSERT INTO read_permissions(position, directory) VALUES (115,38);
INSERT INTO read_permissions(position, directory) VALUES (128,38);
INSERT INTO read_permissions(position, directory) VALUES (121,38);
INSERT INTO read_permissions(position, directory) VALUES (154,38);
INSERT INTO read_permissions(position, directory) VALUES (167,38);
INSERT INTO read_permissions(position, directory) VALUES (180,38);
INSERT INTO read_permissions(position, directory) VALUES (193,38);
INSERT INTO read_permissions(position, directory) VALUES (206,38);
INSERT INTO read_permissions(position, directory) VALUES (219,38);
--     Assistant Director
INSERT INTO read_permissions(position, directory) VALUES (38,38);
INSERT INTO read_permissions(position, directory) VALUES (47,38);
INSERT INTO read_permissions(position, directory) VALUES (60,38);
INSERT INTO read_permissions(position, directory) VALUES (73,38);
INSERT INTO read_permissions(position, directory) VALUES (86,38);
INSERT INTO read_permissions(position, directory) VALUES (99,38);
INSERT INTO read_permissions(position, directory) VALUES (112,38);
INSERT INTO read_permissions(position, directory) VALUES (125,38);
INSERT INTO read_permissions(position, directory) VALUES (138,38);
INSERT INTO read_permissions(position, directory) VALUES (151,38);
INSERT INTO read_permissions(position, directory) VALUES (164,38);
INSERT INTO read_permissions(position, directory) VALUES (177,38);
INSERT INTO read_permissions(position, directory) VALUES (190,38);
INSERT INTO read_permissions(position, directory) VALUES (203,38);
INSERT INTO read_permissions(position, directory) VALUES (216,38);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,38);
INSERT INTO read_permissions(position, directory) VALUES (54,38);
INSERT INTO read_permissions(position, directory) VALUES (67,38);
INSERT INTO read_permissions(position, directory) VALUES (80,38);
INSERT INTO read_permissions(position, directory) VALUES (93,38);
INSERT INTO read_permissions(position, directory) VALUES (106,38);
INSERT INTO read_permissions(position, directory) VALUES (119,38);
INSERT INTO read_permissions(position, directory) VALUES (132,38);
INSERT INTO read_permissions(position, directory) VALUES (145,38);
INSERT INTO read_permissions(position, directory) VALUES (158,38);
INSERT INTO read_permissions(position, directory) VALUES (171,38);
INSERT INTO read_permissions(position, directory) VALUES (184,38);
INSERT INTO read_permissions(position, directory) VALUES (197,38);
INSERT INTO read_permissions(position, directory) VALUES (210,38);
INSERT INTO read_permissions(position, directory) VALUES (223,38);
INSERT INTO read_permissions(position, directory) VALUES (233,38);
INSERT INTO read_permissions(position, directory) VALUES (239,38);
INSERT INTO read_permissions(position, directory) VALUES (244,38);


INSERT INTO edit_permissions(position, directory) VALUES (11,38);
INSERT INTO edit_permissions(position, directory) VALUES (12,38);
INSERT INTO edit_permissions(position, directory) VALUES (13,38);

-- American Education Group/AEG/Finance/
--   Private

INSERT INTO read_permissions(position, directory) VALUES (16,39);
INSERT INTO read_permissions(position, directory) VALUES (17,39);
INSERT INTO read_permissions(position, directory) VALUES (18,39);
INSERT INTO read_permissions(position, directory) VALUES (19,39);
INSERT INTO read_permissions(position, directory) VALUES (20,39);
INSERT INTO read_permissions(position, directory) VALUES (21,39);
INSERT INTO read_permissions(position, directory) VALUES (22,39);

INSERT INTO edit_permissions(position, directory) VALUES (16,39);
INSERT INTO edit_permissions(position, directory) VALUES (17,39);
INSERT INTO edit_permissions(position, directory) VALUES (18,39);
INSERT INTO edit_permissions(position, directory) VALUES (19,39);
INSERT INTO edit_permissions(position, directory) VALUES (20,39);
INSERT INTO edit_permissions(position, directory) VALUES (21,39);
INSERT INTO edit_permissions(position, directory) VALUES (22,39);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (16,40);
INSERT INTO edit_permissions(position, directory) VALUES (17,40);
INSERT INTO edit_permissions(position, directory) VALUES (18,40);
INSERT INTO edit_permissions(position, directory) VALUES (19,40);
INSERT INTO edit_permissions(position, directory) VALUES (20,40);
INSERT INTO edit_permissions(position, directory) VALUES (21,40);
INSERT INTO edit_permissions(position, directory) VALUES (22,40);

--   Administrator
INSERT INTO read_permissions(position, directory) VALUES (16,41);
INSERT INTO read_permissions(position, directory) VALUES (17,41);
INSERT INTO read_permissions(position, directory) VALUES (18,41);
INSERT INTO read_permissions(position, directory) VALUES (19,41);
INSERT INTO read_permissions(position, directory) VALUES (20,41);
INSERT INTO read_permissions(position, directory) VALUES (21,41);
INSERT INTO read_permissions(position, directory) VALUES (22,41);

INSERT INTO edit_permissions(position, directory) VALUES (16,41);
INSERT INTO edit_permissions(position, directory) VALUES (17,41);
INSERT INTO edit_permissions(position, directory) VALUES (18,41);
INSERT INTO edit_permissions(position, directory) VALUES (19,41);
INSERT INTO edit_permissions(position, directory) VALUES (20,41);
INSERT INTO edit_permissions(position, directory) VALUES (21,41);
INSERT INTO edit_permissions(position, directory) VALUES (22,41);

-- American Education Group/AEG/New Business Development/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (31,42);
INSERT INTO read_permissions(position, directory) VALUES (32,42);

INSERT INTO edit_permissions(position, directory) VALUES (31,42);
INSERT INTO edit_permissions(position, directory) VALUES (32,42);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (31,43);
INSERT INTO edit_permissions(position, directory) VALUES (32,43);

-- American education Groupo/AEG/Procurement/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (33,44);

INSERT INTO edit_permissions(position, directory) VALUES (33,44);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (33,45);

--   Master Task List
INSERT INTO read_permissions(position, directory) VALUES (33,46);

INSERT INTO edit_permissions(position, directory) VALUES (33,46);

--   Master Calendar
INSERT INTO read_permissions(position, directory) VALUES (33,47);

INSERT INTO edit_permissions(position, directory) VALUES (33,47);

-- American Education Group/Schools/Fusion Division/------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   Huntington Beach
-- INSERT INTO read_permissions(position, directory) VALUES (,48);

-- INSERT INTO edit_permissions(position, directory) VALUES (,48);

--   Long Island
-- INSERT INTO read_permissions(position, directory) VALUES (,49);

-- INSERT INTO edit_permissions(position, directory) VALUES (,49);

--   Los Angeles
-- INSERT INTO read_permissions(position, directory) VALUES (,50);

-- INSERT INTO edit_permissions(position, directory) VALUES (,50);

--   Los Gatos
-- INSERT INTO read_permissions(position, directory) VALUES (,51);

-- INSERT INTO edit_permissions(position, directory) VALUES (,51);

--   Manhattan
-- INSERT INTO read_permissions(position, directory) VALUES (,52);

-- INSERT INTO edit_permissions(position, directory) VALUES (,52);

--   Mission Viejo
-- INSERT INTO read_permissions(position, directory) VALUES (,53);

-- INSERT INTO edit_permissions(position, directory) VALUES (,53);

--   Pasadena
-- INSERT INTO read_permissions(position, directory) VALUES (,54);

-- INSERT INTO edit_permissions(position, directory) VALUES (,54);

--   Regional
-- INSERT INTO read_permissions(position, directory) VALUES (,55);

-- INSERT INTO edit_permissions(position, directory) VALUES (,55);

--   San Francisco
-- INSERT INTO read_permissions(position, directory) VALUES (,56);

-- INSERT INTO edit_permissions(position, directory) VALUES (,56);

--   San Mateo
-- INSERT INTO read_permissions(position, directory) VALUES (,57);

-- INSERT INTO edit_permissions(position, directory) VALUES (,57);

--   Solana Beach
-- INSERT INTO read_permissions(position, directory) VALUES (,58);

-- INSERT INTO edit_permissions(position, directory) VALUES (,58);

--   South Bay
-- INSERT INTO read_permissions(position, directory) VALUES (,59);

-- INSERT INTO edit_permissions(position, directory) VALUES (,59);

--   Walnut Creek
-- INSERT INTO read_permissions(position, directory) VALUES (,60);

-- INSERT INTO edit_permissions(position, directory) VALUES (,60);

--   Warner Center
-- INSERT INTO read_permissions(position, directory) VALUES (,61);

-- INSERT INTO edit_permissions(position, directory) VALUES (,61);

--   Fusionology
-- INSERT INTO read_permissions(position, directory) VALUES (,62);

-- INSERT INTO edit_permissions(position, directory) VALUES (,62);

--   Discussion Board
-- INSERT INTO read_permissions(position, directory) VALUES (,63);

-- INSERT INTO edit_permissions(position, directory) VALUES (,63);

--   Outreach
-- INSERT INTO read_permissions(position, directory) VALUES (,64);

-- INSERT INTO edit_permissions(position, directory) VALUES (,64);

--   Accounting
-- INSERT INTO read_permissions(position, directory) VALUES (,65);

-- INSERT INTO edit_permissions(position, directory) VALUES (,65);

--   Leadership
-- INSERT INTO read_permissions(position, directory) VALUES (,66);

-- INSERT INTO edit_permissions(position, directory) VALUES (,66);

--   Registrar
-- INSERT INTO read_permissions(position, directory) VALUES (,67);

-- INSERT INTO edit_permissions(position, directory) VALUES (,67);

--   Curriculum
-- INSERT INTO read_permissions(position, directory) VALUES (,68);

-- INSERT INTO edit_permissions(position, directory) VALUES (,68);

--   Training
-- INSERT INTO read_permissions(position, directory) VALUES (,69);

-- INSERT INTO edit_permissions(position, directory) VALUES (,69);

-- American Education Group/Schools/Lexis/
--   Barnstable
-- INSERT INTO read_permissions(position, directory) VALUES (,70);

-- INSERT INTO edit_permissions(position, directory) VALUES (,70);

--   Shreiner
-- INSERT INTO read_permissions(position, directory) VALUES (,71);

-- INSERT INTO edit_permissions(position, directory) VALUES (,71);

--   Tampa Day
-- INSERT INTO read_permissions(position, directory) VALUES (,72);

-- INSERT INTO edit_permissions(position, directory) VALUES (,72);

--   Talking Heads
-- INSERT INTO read_permissions(position, directory) VALUES (,73);

-- INSERT INTO edit_permissions(position, directory) VALUES (,73);

--   Curriculum
-- INSERT INTO read_permissions(position, directory) VALUES (,74);

-- INSERT INTO edit_permissions(position, directory) VALUES (,74);

--   Scholarship
-- INSERT INTO read_permissions(position, directory) VALUES (,75);

-- INSERT INTO edit_permissions(position, directory) VALUES (,75);

-- American Education Group/Schools/Little Sprouts/
--   Private

INSERT INTO read_permissions(position, directory) VALUES (252,76);
INSERT INTO read_permissions(position, directory) VALUES (253,76);
INSERT INTO read_permissions(position, directory) VALUES (254,76);
INSERT INTO read_permissions(position, directory) VALUES (255,76);
INSERT INTO read_permissions(position, directory) VALUES (256,76);
INSERT INTO read_permissions(position, directory) VALUES (257,76);
INSERT INTO read_permissions(position, directory) VALUES (258,76);
INSERT INTO read_permissions(position, directory) VALUES (259,76);
INSERT INTO read_permissions(position, directory) VALUES (260,76);
INSERT INTO read_permissions(position, directory) VALUES (261,76);
INSERT INTO read_permissions(position, directory) VALUES (262,76);
INSERT INTO read_permissions(position, directory) VALUES (263,76);
INSERT INTO read_permissions(position, directory) VALUES (264,76);
INSERT INTO read_permissions(position, directory) VALUES (265,76);
INSERT INTO read_permissions(position, directory) VALUES (266,76);
INSERT INTO read_permissions(position, directory) VALUES (267,76);
INSERT INTO read_permissions(position, directory) VALUES (268,76);
INSERT INTO read_permissions(position, directory) VALUES (269,76);
INSERT INTO read_permissions(position, directory) VALUES (270,76);
INSERT INTO read_permissions(position, directory) VALUES (271,76);
INSERT INTO read_permissions(position, directory) VALUES (272,76);
INSERT INTO read_permissions(position, directory) VALUES (273,76);
INSERT INTO read_permissions(position, directory) VALUES (274,76);
INSERT INTO read_permissions(position, directory) VALUES (275,76);
INSERT INTO read_permissions(position, directory) VALUES (276,76);
INSERT INTO read_permissions(position, directory) VALUES (277,76);
INSERT INTO read_permissions(position, directory) VALUES (278,76);
INSERT INTO read_permissions(position, directory) VALUES (279,76);
INSERT INTO read_permissions(position, directory) VALUES (280,76);
INSERT INTO read_permissions(position, directory) VALUES (281,76);
INSERT INTO read_permissions(position, directory) VALUES (282,76);
INSERT INTO read_permissions(position, directory) VALUES (283,76);
INSERT INTO read_permissions(position, directory) VALUES (284,76);
INSERT INTO read_permissions(position, directory) VALUES (285,76);
INSERT INTO read_permissions(position, directory) VALUES (286,76);
INSERT INTO read_permissions(position, directory) VALUES (287,76);
INSERT INTO read_permissions(position, directory) VALUES (288,76);
INSERT INTO read_permissions(position, directory) VALUES (289,76);
INSERT INTO read_permissions(position, directory) VALUES (290,76);
INSERT INTO read_permissions(position, directory) VALUES (291,76);
INSERT INTO read_permissions(position, directory) VALUES (292,76);
INSERT INTO read_permissions(position, directory) VALUES (293,76);
INSERT INTO read_permissions(position, directory) VALUES (294,76);

INSERT INTO edit_permissions(position, directory) VALUES (252,76);
INSERT INTO edit_permissions(position, directory) VALUES (253,76);
INSERT INTO edit_permissions(position, directory) VALUES (254,76);
INSERT INTO edit_permissions(position, directory) VALUES (255,76);
INSERT INTO edit_permissions(position, directory) VALUES (256,76);
INSERT INTO edit_permissions(position, directory) VALUES (257,76);
INSERT INTO edit_permissions(position, directory) VALUES (258,76);
INSERT INTO edit_permissions(position, directory) VALUES (259,76);
INSERT INTO edit_permissions(position, directory) VALUES (260,76);
INSERT INTO edit_permissions(position, directory) VALUES (261,76);
INSERT INTO edit_permissions(position, directory) VALUES (262,76);
INSERT INTO edit_permissions(position, directory) VALUES (263,76);
INSERT INTO edit_permissions(position, directory) VALUES (264,76);
INSERT INTO edit_permissions(position, directory) VALUES (265,76);
INSERT INTO edit_permissions(position, directory) VALUES (266,76);
INSERT INTO edit_permissions(position, directory) VALUES (267,76);
INSERT INTO edit_permissions(position, directory) VALUES (268,76);
INSERT INTO edit_permissions(position, directory) VALUES (269,76);
INSERT INTO edit_permissions(position, directory) VALUES (270,76);
INSERT INTO edit_permissions(position, directory) VALUES (271,76);
INSERT INTO edit_permissions(position, directory) VALUES (272,76);
INSERT INTO edit_permissions(position, directory) VALUES (273,76);
INSERT INTO edit_permissions(position, directory) VALUES (274,76);
INSERT INTO edit_permissions(position, directory) VALUES (275,76);
INSERT INTO edit_permissions(position, directory) VALUES (276,76);
INSERT INTO edit_permissions(position, directory) VALUES (277,76);
INSERT INTO edit_permissions(position, directory) VALUES (278,76);
INSERT INTO edit_permissions(position, directory) VALUES (279,76);
INSERT INTO edit_permissions(position, directory) VALUES (280,76);
INSERT INTO edit_permissions(position, directory) VALUES (281,76);
INSERT INTO edit_permissions(position, directory) VALUES (282,76);
INSERT INTO edit_permissions(position, directory) VALUES (283,76);
INSERT INTO edit_permissions(position, directory) VALUES (284,76);
INSERT INTO edit_permissions(position, directory) VALUES (285,76);
INSERT INTO edit_permissions(position, directory) VALUES (286,76);
INSERT INTO edit_permissions(position, directory) VALUES (287,76);
INSERT INTO edit_permissions(position, directory) VALUES (288,76);
INSERT INTO edit_permissions(position, directory) VALUES (289,76);
INSERT INTO edit_permissions(position, directory) VALUES (290,76);
INSERT INTO edit_permissions(position, directory) VALUES (291,76);
INSERT INTO edit_permissions(position, directory) VALUES (292,76);
INSERT INTO edit_permissions(position, directory) VALUES (293,76);
INSERT INTO edit_permissions(position, directory) VALUES (294,76);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (252,77);
INSERT INTO edit_permissions(position, directory) VALUES (253,77);
INSERT INTO edit_permissions(position, directory) VALUES (254,77);
INSERT INTO edit_permissions(position, directory) VALUES (255,77);
INSERT INTO edit_permissions(position, directory) VALUES (256,77);
INSERT INTO edit_permissions(position, directory) VALUES (257,77);
INSERT INTO edit_permissions(position, directory) VALUES (258,77);
INSERT INTO edit_permissions(position, directory) VALUES (259,77);
INSERT INTO edit_permissions(position, directory) VALUES (260,77);
INSERT INTO edit_permissions(position, directory) VALUES (261,77);
INSERT INTO edit_permissions(position, directory) VALUES (262,77);
INSERT INTO edit_permissions(position, directory) VALUES (263,77);
INSERT INTO edit_permissions(position, directory) VALUES (264,77);
INSERT INTO edit_permissions(position, directory) VALUES (265,77);
INSERT INTO edit_permissions(position, directory) VALUES (266,77);
INSERT INTO edit_permissions(position, directory) VALUES (267,77);
INSERT INTO edit_permissions(position, directory) VALUES (268,77);
INSERT INTO edit_permissions(position, directory) VALUES (269,77);
INSERT INTO edit_permissions(position, directory) VALUES (270,77);
INSERT INTO edit_permissions(position, directory) VALUES (271,77);
INSERT INTO edit_permissions(position, directory) VALUES (272,77);
INSERT INTO edit_permissions(position, directory) VALUES (273,77);
INSERT INTO edit_permissions(position, directory) VALUES (274,77);
INSERT INTO edit_permissions(position, directory) VALUES (275,77);
INSERT INTO edit_permissions(position, directory) VALUES (276,77);
INSERT INTO edit_permissions(position, directory) VALUES (277,77);
INSERT INTO edit_permissions(position, directory) VALUES (278,77);
INSERT INTO edit_permissions(position, directory) VALUES (279,77);
INSERT INTO edit_permissions(position, directory) VALUES (280,77);
INSERT INTO edit_permissions(position, directory) VALUES (281,77);
INSERT INTO edit_permissions(position, directory) VALUES (282,77);
INSERT INTO edit_permissions(position, directory) VALUES (283,77);
INSERT INTO edit_permissions(position, directory) VALUES (284,77);
INSERT INTO edit_permissions(position, directory) VALUES (285,77);
INSERT INTO edit_permissions(position, directory) VALUES (286,77);
INSERT INTO edit_permissions(position, directory) VALUES (287,77);
INSERT INTO edit_permissions(position, directory) VALUES (288,77);
INSERT INTO edit_permissions(position, directory) VALUES (289,77);
INSERT INTO edit_permissions(position, directory) VALUES (290,77);
INSERT INTO edit_permissions(position, directory) VALUES (291,77);
INSERT INTO edit_permissions(position, directory) VALUES (292,77);
INSERT INTO edit_permissions(position, directory) VALUES (293,77);
INSERT INTO edit_permissions(position, directory) VALUES (294,77);

--   SMK
INSERT INTO read_permissions(position, directory) VALUES (284,78);
INSERT INTO read_permissions(position, directory) VALUES (285,78);
INSERT INTO read_permissions(position, directory) VALUES (286,78);
INSERT INTO read_permissions(position, directory) VALUES (287,78);
INSERT INTO read_permissions(position, directory) VALUES (288,78);
INSERT INTO read_permissions(position, directory) VALUES (289,78);
INSERT INTO read_permissions(position, directory) VALUES (290,78);
INSERT INTO read_permissions(position, directory) VALUES (291,78);
INSERT INTO read_permissions(position, directory) VALUES (292,78);
INSERT INTO read_permissions(position, directory) VALUES (293,78);
INSERT INTO read_permissions(position, directory) VALUES (294,78);

INSERT INTO edit_permissions(position, directory) VALUES (284,78);
INSERT INTO edit_permissions(position, directory) VALUES (285,78);
INSERT INTO edit_permissions(position, directory) VALUES (286,78);
INSERT INTO edit_permissions(position, directory) VALUES (287,78);
INSERT INTO edit_permissions(position, directory) VALUES (288,78);
INSERT INTO edit_permissions(position, directory) VALUES (289,78);
INSERT INTO edit_permissions(position, directory) VALUES (290,78);
INSERT INTO edit_permissions(position, directory) VALUES (291,78);
INSERT INTO edit_permissions(position, directory) VALUES (292,78);
INSERT INTO edit_permissions(position, directory) VALUES (293,78);
INSERT INTO edit_permissions(position, directory) VALUES (294,78);


--   Financials
INSERT INTO read_permissions(position, directory) VALUES (285,79);
INSERT INTO read_permissions(position, directory) VALUES (294,79);

INSERT INTO edit_permissions(position, directory) VALUES (285,79);
INSERT INTO edit_permissions(position, directory) VALUES (294,79);

--   Data Centralization
INSERT INTO read_permissions(position, directory) VALUES (284,80);
INSERT INTO read_permissions(position, directory) VALUES (285,80);
INSERT INTO read_permissions(position, directory) VALUES (286,80);
INSERT INTO read_permissions(position, directory) VALUES (287,80);
INSERT INTO read_permissions(position, directory) VALUES (288,80);
INSERT INTO read_permissions(position, directory) VALUES (289,80);
INSERT INTO read_permissions(position, directory) VALUES (290,80);
INSERT INTO read_permissions(position, directory) VALUES (291,80);
INSERT INTO read_permissions(position, directory) VALUES (292,80);
INSERT INTO read_permissions(position, directory) VALUES (293,80);
INSERT INTO read_permissions(position, directory) VALUES (294,80);

INSERT INTO edit_permissions(position, directory) VALUES (284,80);
INSERT INTO edit_permissions(position, directory) VALUES (285,80);
INSERT INTO edit_permissions(position, directory) VALUES (286,80);
INSERT INTO edit_permissions(position, directory) VALUES (287,80);
INSERT INTO edit_permissions(position, directory) VALUES (288,80);
INSERT INTO edit_permissions(position, directory) VALUES (289,80);
INSERT INTO edit_permissions(position, directory) VALUES (290,80);
INSERT INTO edit_permissions(position, directory) VALUES (291,80);
INSERT INTO edit_permissions(position, directory) VALUES (292,80);
INSERT INTO edit_permissions(position, directory) VALUES (293,80);
INSERT INTO edit_permissions(position, directory) VALUES (294,80);

-- American Education Group/Team Sites/AEG R.O.C.K.S/
--   Corporate
INSERT INTO read_permissions(position, directory) VALUES (1,81);
INSERT INTO read_permissions(position, directory) VALUES (2,81);
INSERT INTO read_permissions(position, directory) VALUES (3,81);
INSERT INTO read_permissions(position, directory) VALUES (4,81);
INSERT INTO read_permissions(position, directory) VALUES (5,81);
INSERT INTO read_permissions(position, directory) VALUES (6,81);
INSERT INTO read_permissions(position, directory) VALUES (7,81);
INSERT INTO read_permissions(position, directory) VALUES (8,81);
INSERT INTO read_permissions(position, directory) VALUES (9,81);
INSERT INTO read_permissions(position, directory) VALUES (10,81);
INSERT INTO read_permissions(position, directory) VALUES (11,81);
INSERT INTO read_permissions(position, directory) VALUES (12,81);
INSERT INTO read_permissions(position, directory) VALUES (13,81);
INSERT INTO read_permissions(position, directory) VALUES (14,81);
INSERT INTO read_permissions(position, directory) VALUES (15,81);
INSERT INTO read_permissions(position, directory) VALUES (16,81);
INSERT INTO read_permissions(position, directory) VALUES (17,81);
INSERT INTO read_permissions(position, directory) VALUES (18,81);
INSERT INTO read_permissions(position, directory) VALUES (19,81);
INSERT INTO read_permissions(position, directory) VALUES (20,81);
INSERT INTO read_permissions(position, directory) VALUES (21,81);
INSERT INTO read_permissions(position, directory) VALUES (22,81);
INSERT INTO read_permissions(position, directory) VALUES (23,81);
INSERT INTO read_permissions(position, directory) VALUES (24,81);
INSERT INTO read_permissions(position, directory) VALUES (25,81);
INSERT INTO read_permissions(position, directory) VALUES (26,81);
INSERT INTO read_permissions(position, directory) VALUES (27,81);
INSERT INTO read_permissions(position, directory) VALUES (28,81);
INSERT INTO read_permissions(position, directory) VALUES (29,81);
INSERT INTO read_permissions(position, directory) VALUES (30,81);
INSERT INTO read_permissions(position, directory) VALUES (31,81);
INSERT INTO read_permissions(position, directory) VALUES (32,81);
INSERT INTO read_permissions(position, directory) VALUES (33,81);

INSERT INTO edit_permissions(position, directory) VALUES (1,81);
INSERT INTO edit_permissions(position, directory) VALUES (2,81);
INSERT INTO edit_permissions(position, directory) VALUES (3,81);
INSERT INTO edit_permissions(position, directory) VALUES (4,81);
INSERT INTO edit_permissions(position, directory) VALUES (5,81);
INSERT INTO edit_permissions(position, directory) VALUES (6,81);
INSERT INTO edit_permissions(position, directory) VALUES (7,81);
INSERT INTO edit_permissions(position, directory) VALUES (8,81);
INSERT INTO edit_permissions(position, directory) VALUES (9,81);
INSERT INTO edit_permissions(position, directory) VALUES (10,81);
INSERT INTO edit_permissions(position, directory) VALUES (11,81);
INSERT INTO edit_permissions(position, directory) VALUES (12,81);
INSERT INTO edit_permissions(position, directory) VALUES (13,81);
INSERT INTO edit_permissions(position, directory) VALUES (14,81);
INSERT INTO edit_permissions(position, directory) VALUES (15,81);
INSERT INTO edit_permissions(position, directory) VALUES (16,81);
INSERT INTO edit_permissions(position, directory) VALUES (17,81);
INSERT INTO edit_permissions(position, directory) VALUES (18,81);
INSERT INTO edit_permissions(position, directory) VALUES (19,81);
INSERT INTO edit_permissions(position, directory) VALUES (20,81);
INSERT INTO edit_permissions(position, directory) VALUES (21,81);
INSERT INTO edit_permissions(position, directory) VALUES (22,81);
INSERT INTO edit_permissions(position, directory) VALUES (23,81);
INSERT INTO edit_permissions(position, directory) VALUES (24,81);
INSERT INTO edit_permissions(position, directory) VALUES (25,81);
INSERT INTO edit_permissions(position, directory) VALUES (26,81);
INSERT INTO edit_permissions(position, directory) VALUES (27,81);
INSERT INTO edit_permissions(position, directory) VALUES (28,81);
INSERT INTO edit_permissions(position, directory) VALUES (29,81);
INSERT INTO edit_permissions(position, directory) VALUES (30,81);
INSERT INTO edit_permissions(position, directory) VALUES (31,81);
INSERT INTO edit_permissions(position, directory) VALUES (32,81);
INSERT INTO edit_permissions(position, directory) VALUES (33,81);
--   Fusion
--     Director of Student Development
INSERT INTO read_permissions(position, directory) VALUES (38,82);
INSERT INTO read_permissions(position, directory) VALUES (51,82);
INSERT INTO read_permissions(position, directory) VALUES (64,82);
INSERT INTO read_permissions(position, directory) VALUES (77,82);
INSERT INTO read_permissions(position, directory) VALUES (90,82);
INSERT INTO read_permissions(position, directory) VALUES (103,82);
INSERT INTO read_permissions(position, directory) VALUES (116,82);
INSERT INTO read_permissions(position, directory) VALUES (129,82);
INSERT INTO read_permissions(position, directory) VALUES (142,82);
INSERT INTO read_permissions(position, directory) VALUES (155,82);
INSERT INTO read_permissions(position, directory) VALUES (168,82);
INSERT INTO read_permissions(position, directory) VALUES (181,82);
INSERT INTO read_permissions(position, directory) VALUES (194,82);
INSERT INTO read_permissions(position, directory) VALUES (207,82);
INSERT INTO read_permissions(position, directory) VALUES (220,82);
--     Director of Tutoring
INSERT INTO read_permissions(position, directory) VALUES (39,82);
INSERT INTO read_permissions(position, directory) VALUES (52,82);
INSERT INTO read_permissions(position, directory) VALUES (65,82);
INSERT INTO read_permissions(position, directory) VALUES (78,82);
INSERT INTO read_permissions(position, directory) VALUES (91,82);
INSERT INTO read_permissions(position, directory) VALUES (104,82);
INSERT INTO read_permissions(position, directory) VALUES (117,82);
INSERT INTO read_permissions(position, directory) VALUES (130,82);
INSERT INTO read_permissions(position, directory) VALUES (143,82);
INSERT INTO read_permissions(position, directory) VALUES (156,82);
INSERT INTO read_permissions(position, directory) VALUES (169,82);
INSERT INTO read_permissions(position, directory) VALUES (182,82);
INSERT INTO read_permissions(position, directory) VALUES (195,82);
INSERT INTO read_permissions(position, directory) VALUES (208,82);
INSERT INTO read_permissions(position, directory) VALUES (221,82);
--     Fusionologist
INSERT INTO read_permissions(position, directory) VALUES (40,82);
INSERT INTO read_permissions(position, directory) VALUES (53,82);
INSERT INTO read_permissions(position, directory) VALUES (66,82);
INSERT INTO read_permissions(position, directory) VALUES (79,82);
INSERT INTO read_permissions(position, directory) VALUES (92,82);
INSERT INTO read_permissions(position, directory) VALUES (105,82);
INSERT INTO read_permissions(position, directory) VALUES (118,82);
INSERT INTO read_permissions(position, directory) VALUES (131,82);
INSERT INTO read_permissions(position, directory) VALUES (144,82);
INSERT INTO read_permissions(position, directory) VALUES (157,82);
INSERT INTO read_permissions(position, directory) VALUES (170,82);
INSERT INTO read_permissions(position, directory) VALUES (183,82);
INSERT INTO read_permissions(position, directory) VALUES (196,82);
INSERT INTO read_permissions(position, directory) VALUES (209,82);
INSERT INTO read_permissions(position, directory) VALUES (222,82);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,82);
INSERT INTO read_permissions(position, directory) VALUES (54,82);
INSERT INTO read_permissions(position, directory) VALUES (67,82);
INSERT INTO read_permissions(position, directory) VALUES (80,82);
INSERT INTO read_permissions(position, directory) VALUES (93,82);
INSERT INTO read_permissions(position, directory) VALUES (106,82);
INSERT INTO read_permissions(position, directory) VALUES (119,82);
INSERT INTO read_permissions(position, directory) VALUES (132,82);
INSERT INTO read_permissions(position, directory) VALUES (145,82);
INSERT INTO read_permissions(position, directory) VALUES (158,82);
INSERT INTO read_permissions(position, directory) VALUES (171,82);
INSERT INTO read_permissions(position, directory) VALUES (184,82);
INSERT INTO read_permissions(position, directory) VALUES (197,82);
INSERT INTO read_permissions(position, directory) VALUES (210,82);
INSERT INTO read_permissions(position, directory) VALUES (223,82);
--     Master Teacher
INSERT INTO read_permissions(position, directory) VALUES (43,82);
INSERT INTO read_permissions(position, directory) VALUES (56,82);
INSERT INTO read_permissions(position, directory) VALUES (69,82);
INSERT INTO read_permissions(position, directory) VALUES (82,82);
INSERT INTO read_permissions(position, directory) VALUES (95,82);
INSERT INTO read_permissions(position, directory) VALUES (108,82);
INSERT INTO read_permissions(position, directory) VALUES (120,82);
INSERT INTO read_permissions(position, directory) VALUES (134,82);
INSERT INTO read_permissions(position, directory) VALUES (147,82);
INSERT INTO read_permissions(position, directory) VALUES (160,82);
INSERT INTO read_permissions(position, directory) VALUES (173,82);
INSERT INTO read_permissions(position, directory) VALUES (186,82);
INSERT INTO read_permissions(position, directory) VALUES (199,82);
INSERT INTO read_permissions(position, directory) VALUES (212,82);
INSERT INTO read_permissions(position, directory) VALUES (225,82);
--     Fusion Regional
INSERT INTO read_permissions(position, directory) VALUES (229,82);
INSERT INTO read_permissions(position, directory) VALUES (230,82);
INSERT INTO read_permissions(position, directory) VALUES (231,82);
INSERT INTO read_permissions(position, directory) VALUES (232,82);
INSERT INTO read_permissions(position, directory) VALUES (295,82);
INSERT INTO read_permissions(position, directory) VALUES (296,82);

--     Director of Student Development
INSERT INTO edit_permissions(position, directory) VALUES (38,82);
INSERT INTO edit_permissions(position, directory) VALUES (51,82);
INSERT INTO edit_permissions(position, directory) VALUES (64,82);
INSERT INTO edit_permissions(position, directory) VALUES (77,82);
INSERT INTO edit_permissions(position, directory) VALUES (90,82);
INSERT INTO edit_permissions(position, directory) VALUES (103,82);
INSERT INTO edit_permissions(position, directory) VALUES (116,82);
INSERT INTO edit_permissions(position, directory) VALUES (129,82);
INSERT INTO edit_permissions(position, directory) VALUES (142,82);
INSERT INTO edit_permissions(position, directory) VALUES (155,82);
INSERT INTO edit_permissions(position, directory) VALUES (168,82);
INSERT INTO edit_permissions(position, directory) VALUES (181,82);
INSERT INTO edit_permissions(position, directory) VALUES (194,82);
INSERT INTO edit_permissions(position, directory) VALUES (207,82);
INSERT INTO edit_permissions(position, directory) VALUES (220,82);
--     Director of Tutoring
INSERT INTO edit_permissions(position, directory) VALUES (39,82);
INSERT INTO edit_permissions(position, directory) VALUES (52,82);
INSERT INTO edit_permissions(position, directory) VALUES (65,82);
INSERT INTO edit_permissions(position, directory) VALUES (78,82);
INSERT INTO edit_permissions(position, directory) VALUES (91,82);
INSERT INTO edit_permissions(position, directory) VALUES (104,82);
INSERT INTO edit_permissions(position, directory) VALUES (117,82);
INSERT INTO edit_permissions(position, directory) VALUES (130,82);
INSERT INTO edit_permissions(position, directory) VALUES (143,82);
INSERT INTO edit_permissions(position, directory) VALUES (156,82);
INSERT INTO edit_permissions(position, directory) VALUES (169,82);
INSERT INTO edit_permissions(position, directory) VALUES (182,82);
INSERT INTO edit_permissions(position, directory) VALUES (195,82);
INSERT INTO edit_permissions(position, directory) VALUES (208,82);
INSERT INTO edit_permissions(position, directory) VALUES (221,82);
--     Fusionologist
INSERT INTO edit_permissions(position, directory) VALUES (40,82);
INSERT INTO edit_permissions(position, directory) VALUES (53,82);
INSERT INTO edit_permissions(position, directory) VALUES (66,82);
INSERT INTO edit_permissions(position, directory) VALUES (79,82);
INSERT INTO edit_permissions(position, directory) VALUES (92,82);
INSERT INTO edit_permissions(position, directory) VALUES (105,82);
INSERT INTO edit_permissions(position, directory) VALUES (118,82);
INSERT INTO edit_permissions(position, directory) VALUES (131,82);
INSERT INTO edit_permissions(position, directory) VALUES (144,82);
INSERT INTO edit_permissions(position, directory) VALUES (157,82);
INSERT INTO edit_permissions(position, directory) VALUES (170,82);
INSERT INTO edit_permissions(position, directory) VALUES (183,82);
INSERT INTO edit_permissions(position, directory) VALUES (196,82);
INSERT INTO edit_permissions(position, directory) VALUES (209,82);
INSERT INTO edit_permissions(position, directory) VALUES (222,82);
--     Head of School
INSERT INTO edit_permissions(position, directory) VALUES (41,82);
INSERT INTO edit_permissions(position, directory) VALUES (54,82);
INSERT INTO edit_permissions(position, directory) VALUES (67,82);
INSERT INTO edit_permissions(position, directory) VALUES (80,82);
INSERT INTO edit_permissions(position, directory) VALUES (93,82);
INSERT INTO edit_permissions(position, directory) VALUES (106,82);
INSERT INTO edit_permissions(position, directory) VALUES (119,82);
INSERT INTO edit_permissions(position, directory) VALUES (132,82);
INSERT INTO edit_permissions(position, directory) VALUES (145,82);
INSERT INTO edit_permissions(position, directory) VALUES (158,82);
INSERT INTO edit_permissions(position, directory) VALUES (171,82);
INSERT INTO edit_permissions(position, directory) VALUES (184,82);
INSERT INTO edit_permissions(position, directory) VALUES (197,82);
INSERT INTO edit_permissions(position, directory) VALUES (210,82);
INSERT INTO edit_permissions(position, directory) VALUES (223,82);
--     Master Teacher
INSERT INTO edit_permissions(position, directory) VALUES (43,82);
INSERT INTO edit_permissions(position, directory) VALUES (56,82);
INSERT INTO edit_permissions(position, directory) VALUES (69,82);
INSERT INTO edit_permissions(position, directory) VALUES (82,82);
INSERT INTO edit_permissions(position, directory) VALUES (95,82);
INSERT INTO edit_permissions(position, directory) VALUES (108,82);
INSERT INTO edit_permissions(position, directory) VALUES (120,82);
INSERT INTO edit_permissions(position, directory) VALUES (134,82);
INSERT INTO edit_permissions(position, directory) VALUES (147,82);
INSERT INTO edit_permissions(position, directory) VALUES (160,82);
INSERT INTO edit_permissions(position, directory) VALUES (173,82);
INSERT INTO edit_permissions(position, directory) VALUES (186,82);
INSERT INTO edit_permissions(position, directory) VALUES (199,82);
INSERT INTO edit_permissions(position, directory) VALUES (212,82);
INSERT INTO edit_permissions(position, directory) VALUES (225,82);
--     Fusion Regional
INSERT INTO edit_permissions(position, directory) VALUES (229,82);
INSERT INTO edit_permissions(position, directory) VALUES (230,82);
INSERT INTO edit_permissions(position, directory) VALUES (231,82);
INSERT INTO edit_permissions(position, directory) VALUES (232,82);
INSERT INTO edit_permissions(position, directory) VALUES (295,82);
INSERT INTO edit_permissions(position, directory) VALUES (296,82);


--   Little Sprouts
INSERT INTO read_permissions(position, directory) VALUES (252,83);
INSERT INTO read_permissions(position, directory) VALUES (253,83);
INSERT INTO read_permissions(position, directory) VALUES (254,83);
INSERT INTO read_permissions(position, directory) VALUES (255,83);
INSERT INTO read_permissions(position, directory) VALUES (256,83);
INSERT INTO read_permissions(position, directory) VALUES (257,83);
INSERT INTO read_permissions(position, directory) VALUES (258,83);
INSERT INTO read_permissions(position, directory) VALUES (259,83);
INSERT INTO read_permissions(position, directory) VALUES (260,83);
INSERT INTO read_permissions(position, directory) VALUES (261,83);
INSERT INTO read_permissions(position, directory) VALUES (262,83);
INSERT INTO read_permissions(position, directory) VALUES (263,83);
INSERT INTO read_permissions(position, directory) VALUES (264,83);
INSERT INTO read_permissions(position, directory) VALUES (265,83);
INSERT INTO read_permissions(position, directory) VALUES (266,83);
INSERT INTO read_permissions(position, directory) VALUES (267,83);
INSERT INTO read_permissions(position, directory) VALUES (268,83);
INSERT INTO read_permissions(position, directory) VALUES (269,83);
INSERT INTO read_permissions(position, directory) VALUES (270,83);
INSERT INTO read_permissions(position, directory) VALUES (271,83);
INSERT INTO read_permissions(position, directory) VALUES (272,83);
INSERT INTO read_permissions(position, directory) VALUES (273,83);
INSERT INTO read_permissions(position, directory) VALUES (274,83);
INSERT INTO read_permissions(position, directory) VALUES (275,83);
INSERT INTO read_permissions(position, directory) VALUES (276,83);
INSERT INTO read_permissions(position, directory) VALUES (277,83);
INSERT INTO read_permissions(position, directory) VALUES (278,83);
INSERT INTO read_permissions(position, directory) VALUES (279,83);
INSERT INTO read_permissions(position, directory) VALUES (280,83);
INSERT INTO read_permissions(position, directory) VALUES (281,83);
INSERT INTO read_permissions(position, directory) VALUES (282,83);
INSERT INTO read_permissions(position, directory) VALUES (283,83);
INSERT INTO read_permissions(position, directory) VALUES (284,83);
INSERT INTO read_permissions(position, directory) VALUES (285,83);
INSERT INTO read_permissions(position, directory) VALUES (286,83);
INSERT INTO read_permissions(position, directory) VALUES (287,83);
INSERT INTO read_permissions(position, directory) VALUES (288,83);
INSERT INTO read_permissions(position, directory) VALUES (289,83);
INSERT INTO read_permissions(position, directory) VALUES (290,83);
INSERT INTO read_permissions(position, directory) VALUES (291,83);
INSERT INTO read_permissions(position, directory) VALUES (292,83);
INSERT INTO read_permissions(position, directory) VALUES (293,83);
INSERT INTO read_permissions(position, directory) VALUES (294,83);

INSERT INTO edit_permissions(position, directory) VALUES (252,83);
INSERT INTO edit_permissions(position, directory) VALUES (253,83);
INSERT INTO edit_permissions(position, directory) VALUES (254,83);
INSERT INTO edit_permissions(position, directory) VALUES (255,83);
INSERT INTO edit_permissions(position, directory) VALUES (256,83);
INSERT INTO edit_permissions(position, directory) VALUES (257,83);
INSERT INTO edit_permissions(position, directory) VALUES (258,83);
INSERT INTO edit_permissions(position, directory) VALUES (259,83);
INSERT INTO edit_permissions(position, directory) VALUES (260,83);
INSERT INTO edit_permissions(position, directory) VALUES (261,83);
INSERT INTO edit_permissions(position, directory) VALUES (262,83);
INSERT INTO edit_permissions(position, directory) VALUES (263,83);
INSERT INTO edit_permissions(position, directory) VALUES (264,83);
INSERT INTO edit_permissions(position, directory) VALUES (265,83);
INSERT INTO edit_permissions(position, directory) VALUES (266,83);
INSERT INTO edit_permissions(position, directory) VALUES (267,83);
INSERT INTO edit_permissions(position, directory) VALUES (268,83);
INSERT INTO edit_permissions(position, directory) VALUES (269,83);
INSERT INTO edit_permissions(position, directory) VALUES (270,83);
INSERT INTO edit_permissions(position, directory) VALUES (271,83);
INSERT INTO edit_permissions(position, directory) VALUES (272,83);
INSERT INTO edit_permissions(position, directory) VALUES (273,83);
INSERT INTO edit_permissions(position, directory) VALUES (274,83);
INSERT INTO edit_permissions(position, directory) VALUES (275,83);
INSERT INTO edit_permissions(position, directory) VALUES (276,83);
INSERT INTO edit_permissions(position, directory) VALUES (277,83);
INSERT INTO edit_permissions(position, directory) VALUES (278,83);
INSERT INTO edit_permissions(position, directory) VALUES (279,83);
INSERT INTO edit_permissions(position, directory) VALUES (280,83);
INSERT INTO edit_permissions(position, directory) VALUES (281,83);
INSERT INTO edit_permissions(position, directory) VALUES (282,83);
INSERT INTO edit_permissions(position, directory) VALUES (283,83);
INSERT INTO edit_permissions(position, directory) VALUES (284,83);
INSERT INTO edit_permissions(position, directory) VALUES (285,83);
INSERT INTO edit_permissions(position, directory) VALUES (286,83);
INSERT INTO edit_permissions(position, directory) VALUES (287,83);
INSERT INTO edit_permissions(position, directory) VALUES (288,83);
INSERT INTO edit_permissions(position, directory) VALUES (289,83);
INSERT INTO edit_permissions(position, directory) VALUES (290,83);
INSERT INTO edit_permissions(position, directory) VALUES (291,83);
INSERT INTO edit_permissions(position, directory) VALUES (292,83);
INSERT INTO edit_permissions(position, directory) VALUES (293,83);
INSERT INTO edit_permissions(position, directory) VALUES (294,83);

-- American Education Group/Team Site/NSO/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (1,84);
INSERT INTO read_permissions(position, directory) VALUES (2,84);
INSERT INTO read_permissions(position, directory) VALUES (3,84);
INSERT INTO read_permissions(position, directory) VALUES (4,84);
INSERT INTO read_permissions(position, directory) VALUES (5,84);
INSERT INTO read_permissions(position, directory) VALUES (6,84);
INSERT INTO read_permissions(position, directory) VALUES (31,84);
INSERT INTO read_permissions(position, directory) VALUES (32,84);

INSERT INTO edit_permissions(position, directory) VALUES (1,84);
INSERT INTO edit_permissions(position, directory) VALUES (2,84);
INSERT INTO edit_permissions(position, directory) VALUES (3,84);
INSERT INTO edit_permissions(position, directory) VALUES (4,84);
INSERT INTO edit_permissions(position, directory) VALUES (5,84);
INSERT INTO edit_permissions(position, directory) VALUES (6,84);
INSERT INTO edit_permissions(position, directory) VALUES (31,84);
INSERT INTO edit_permissions(position, directory) VALUES (32,84);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (1,85);
INSERT INTO edit_permissions(position, directory) VALUES (2,85);
INSERT INTO edit_permissions(position, directory) VALUES (3,85);
INSERT INTO edit_permissions(position, directory) VALUES (4,85);
INSERT INTO edit_permissions(position, directory) VALUES (5,85);
INSERT INTO edit_permissions(position, directory) VALUES (6,85);
INSERT INTO edit_permissions(position, directory) VALUES (31,85);
INSERT INTO edit_permissions(position, directory) VALUES (32,85);

--   New Business Development
INSERT INTO read_permissions(position, directory) VALUES (31,86);
INSERT INTO read_permissions(position, directory) VALUES (32,86);

INSERT INTO edit_permissions(position, directory) VALUES (31,86);
INSERT INTO edit_permissions(position, directory) VALUES (32,86);

--   Construction Folder
INSERT INTO read_permissions(position, directory) VALUES (1,87);
INSERT INTO read_permissions(position, directory) VALUES (2,87);
INSERT INTO read_permissions(position, directory) VALUES (3,87);
INSERT INTO read_permissions(position, directory) VALUES (4,87);
INSERT INTO read_permissions(position, directory) VALUES (5,87);
INSERT INTO read_permissions(position, directory) VALUES (6,87);
INSERT INTO read_permissions(position, directory) VALUES (31,87);
INSERT INTO read_permissions(position, directory) VALUES (32,87);

INSERT INTO edit_permissions(position, directory) VALUES (1,87);
INSERT INTO edit_permissions(position, directory) VALUES (2,87);
INSERT INTO edit_permissions(position, directory) VALUES (3,87);
INSERT INTO edit_permissions(position, directory) VALUES (4,87);
INSERT INTO edit_permissions(position, directory) VALUES (5,87);
INSERT INTO edit_permissions(position, directory) VALUES (6,87);
INSERT INTO edit_permissions(position, directory) VALUES (31,87);
INSERT INTO edit_permissions(position, directory) VALUES (32,87);

--   Real Estate Folder
INSERT INTO read_permissions(position, directory) VALUES (1,88);
INSERT INTO read_permissions(position, directory) VALUES (2,88);
INSERT INTO read_permissions(position, directory) VALUES (3,88);
INSERT INTO read_permissions(position, directory) VALUES (4,88);
INSERT INTO read_permissions(position, directory) VALUES (5,88);
INSERT INTO read_permissions(position, directory) VALUES (6,88);
INSERT INTO read_permissions(position, directory) VALUES (31,88);
INSERT INTO read_permissions(position, directory) VALUES (32,88);

INSERT INTO edit_permissions(position, directory) VALUES (1,88);
INSERT INTO edit_permissions(position, directory) VALUES (2,88);
INSERT INTO edit_permissions(position, directory) VALUES (3,88);
INSERT INTO edit_permissions(position, directory) VALUES (4,88);
INSERT INTO edit_permissions(position, directory) VALUES (5,88);
INSERT INTO edit_permissions(position, directory) VALUES (6,88);
INSERT INTO edit_permissions(position, directory) VALUES (31,88);
INSERT INTO edit_permissions(position, directory) VALUES (32,88);

--   Project Tasks
INSERT INTO read_permissions(position, directory) VALUES (1,89);
INSERT INTO read_permissions(position, directory) VALUES (2,89);
INSERT INTO read_permissions(position, directory) VALUES (3,89);
INSERT INTO read_permissions(position, directory) VALUES (4,89);
INSERT INTO read_permissions(position, directory) VALUES (5,89);
INSERT INTO read_permissions(position, directory) VALUES (6,89);
INSERT INTO read_permissions(position, directory) VALUES (7,89);
INSERT INTO read_permissions(position, directory) VALUES (8,89);
INSERT INTO read_permissions(position, directory) VALUES (9,89);
INSERT INTO read_permissions(position, directory) VALUES (10,89);
INSERT INTO read_permissions(position, directory) VALUES (11,89);
INSERT INTO read_permissions(position, directory) VALUES (12,89);
INSERT INTO read_permissions(position, directory) VALUES (13,89);
INSERT INTO read_permissions(position, directory) VALUES (14,89);
INSERT INTO read_permissions(position, directory) VALUES (15,89);
INSERT INTO read_permissions(position, directory) VALUES (16,89);
INSERT INTO read_permissions(position, directory) VALUES (17,89);
INSERT INTO read_permissions(position, directory) VALUES (18,89);
INSERT INTO read_permissions(position, directory) VALUES (19,89);
INSERT INTO read_permissions(position, directory) VALUES (20,89);
INSERT INTO read_permissions(position, directory) VALUES (21,89);
INSERT INTO read_permissions(position, directory) VALUES (22,89);
INSERT INTO read_permissions(position, directory) VALUES (23,89);
INSERT INTO read_permissions(position, directory) VALUES (24,89);
INSERT INTO read_permissions(position, directory) VALUES (25,89);
INSERT INTO read_permissions(position, directory) VALUES (26,89);
INSERT INTO read_permissions(position, directory) VALUES (27,89);
INSERT INTO read_permissions(position, directory) VALUES (28,89);
INSERT INTO read_permissions(position, directory) VALUES (29,89);
INSERT INTO read_permissions(position, directory) VALUES (30,89);
INSERT INTO read_permissions(position, directory) VALUES (31,89);
INSERT INTO read_permissions(position, directory) VALUES (32,89);
INSERT INTO read_permissions(position, directory) VALUES (33,89);

INSERT INTO edit_permissions(position, directory) VALUES (1,89);
INSERT INTO edit_permissions(position, directory) VALUES (2,89);
INSERT INTO edit_permissions(position, directory) VALUES (3,89);
INSERT INTO edit_permissions(position, directory) VALUES (4,89);
INSERT INTO edit_permissions(position, directory) VALUES (5,89);
INSERT INTO edit_permissions(position, directory) VALUES (6,89);
INSERT INTO edit_permissions(position, directory) VALUES (31,89);
INSERT INTO edit_permissions(position, directory) VALUES (32,89);

--   Project Calendar
INSERT INTO read_permissions(position, directory) VALUES (1,90);
INSERT INTO read_permissions(position, directory) VALUES (2,90);
INSERT INTO read_permissions(position, directory) VALUES (3,90);
INSERT INTO read_permissions(position, directory) VALUES (4,90);
INSERT INTO read_permissions(position, directory) VALUES (5,90);
INSERT INTO read_permissions(position, directory) VALUES (6,90);
INSERT INTO read_permissions(position, directory) VALUES (7,90);
INSERT INTO read_permissions(position, directory) VALUES (8,90);
INSERT INTO read_permissions(position, directory) VALUES (9,90);
INSERT INTO read_permissions(position, directory) VALUES (10,90);
INSERT INTO read_permissions(position, directory) VALUES (11,90);
INSERT INTO read_permissions(position, directory) VALUES (12,90);
INSERT INTO read_permissions(position, directory) VALUES (13,90);
INSERT INTO read_permissions(position, directory) VALUES (14,90);
INSERT INTO read_permissions(position, directory) VALUES (15,90);
INSERT INTO read_permissions(position, directory) VALUES (16,90);
INSERT INTO read_permissions(position, directory) VALUES (17,90);
INSERT INTO read_permissions(position, directory) VALUES (18,90);
INSERT INTO read_permissions(position, directory) VALUES (19,90);
INSERT INTO read_permissions(position, directory) VALUES (20,90);
INSERT INTO read_permissions(position, directory) VALUES (21,90);
INSERT INTO read_permissions(position, directory) VALUES (22,90);
INSERT INTO read_permissions(position, directory) VALUES (23,90);
INSERT INTO read_permissions(position, directory) VALUES (24,90);
INSERT INTO read_permissions(position, directory) VALUES (25,90);
INSERT INTO read_permissions(position, directory) VALUES (26,90);
INSERT INTO read_permissions(position, directory) VALUES (27,90);
INSERT INTO read_permissions(position, directory) VALUES (28,90);
INSERT INTO read_permissions(position, directory) VALUES (29,90);
INSERT INTO read_permissions(position, directory) VALUES (30,90);
INSERT INTO read_permissions(position, directory) VALUES (31,90);
INSERT INTO read_permissions(position, directory) VALUES (32,90);
INSERT INTO read_permissions(position, directory) VALUES (33,90);

INSERT INTO edit_permissions(position, directory) VALUES (1,90);
INSERT INTO edit_permissions(position, directory) VALUES (2,90);
INSERT INTO edit_permissions(position, directory) VALUES (3,90);
INSERT INTO edit_permissions(position, directory) VALUES (4,90);
INSERT INTO edit_permissions(position, directory) VALUES (5,90);
INSERT INTO edit_permissions(position, directory) VALUES (6,90);
INSERT INTO edit_permissions(position, directory) VALUES (31,90);
INSERT INTO edit_permissions(position, directory) VALUES (32,90);

-- American Education Group/Team Sites/MPOPs/
--   Private
-- INSERT INTO read_permissions(position, directory) VALUES (,91);

-- INSERT INTO edit_permissions(position, directory) VALUES (,91);

--   Public
-- INSERT INTO edit_permissions(position, directory) VALUES (,92);

--   Little Sprouts
INSERT INTO read_permissions(position, directory) VALUES (253,93);
INSERT INTO read_permissions(position, directory) VALUES (255,93);
INSERT INTO read_permissions(position, directory) VALUES (257,93);
INSERT INTO read_permissions(position, directory) VALUES (259,93);
INSERT INTO read_permissions(position, directory) VALUES (261,93);
INSERT INTO read_permissions(position, directory) VALUES (263,93);
INSERT INTO read_permissions(position, directory) VALUES (265,93);
INSERT INTO read_permissions(position, directory) VALUES (267,93);
INSERT INTO read_permissions(position, directory) VALUES (269,93);
INSERT INTO read_permissions(position, directory) VALUES (271,93);
INSERT INTO read_permissions(position, directory) VALUES (273,93);
INSERT INTO read_permissions(position, directory) VALUES (275,93);
INSERT INTO read_permissions(position, directory) VALUES (277,93);
INSERT INTO read_permissions(position, directory) VALUES (279,93);
INSERT INTO read_permissions(position, directory) VALUES (281,93);
INSERT INTO read_permissions(position, directory) VALUES (283,93);
INSERT INTO read_permissions(position, directory) VALUES (284,93);
INSERT INTO read_permissions(position, directory) VALUES (285,93);
INSERT INTO read_permissions(position, directory) VALUES (286,93);
INSERT INTO read_permissions(position, directory) VALUES (287,93);
INSERT INTO read_permissions(position, directory) VALUES (288,93);
INSERT INTO read_permissions(position, directory) VALUES (289,93);
INSERT INTO read_permissions(position, directory) VALUES (290,93);
INSERT INTO read_permissions(position, directory) VALUES (291,93);
INSERT INTO read_permissions(position, directory) VALUES (292,93);
INSERT INTO read_permissions(position, directory) VALUES (293,93);
INSERT INTO read_permissions(position, directory) VALUES (294,93);

INSERT INTO edit_permissions(position, directory) VALUES (253,93);
INSERT INTO edit_permissions(position, directory) VALUES (255,93);
INSERT INTO edit_permissions(position, directory) VALUES (257,93);
INSERT INTO edit_permissions(position, directory) VALUES (259,93);
INSERT INTO edit_permissions(position, directory) VALUES (261,93);
INSERT INTO edit_permissions(position, directory) VALUES (263,93);
INSERT INTO edit_permissions(position, directory) VALUES (265,93);
INSERT INTO edit_permissions(position, directory) VALUES (267,93);
INSERT INTO edit_permissions(position, directory) VALUES (269,93);
INSERT INTO edit_permissions(position, directory) VALUES (271,93);
INSERT INTO edit_permissions(position, directory) VALUES (273,93);
INSERT INTO edit_permissions(position, directory) VALUES (275,93);
INSERT INTO edit_permissions(position, directory) VALUES (277,93);
INSERT INTO edit_permissions(position, directory) VALUES (279,93);
INSERT INTO edit_permissions(position, directory) VALUES (281,93);
INSERT INTO edit_permissions(position, directory) VALUES (283,93);
INSERT INTO edit_permissions(position, directory) VALUES (284,93);
INSERT INTO edit_permissions(position, directory) VALUES (285,93);
INSERT INTO edit_permissions(position, directory) VALUES (286,93);
INSERT INTO edit_permissions(position, directory) VALUES (287,93);
INSERT INTO edit_permissions(position, directory) VALUES (288,93);
INSERT INTO edit_permissions(position, directory) VALUES (289,93);
INSERT INTO edit_permissions(position, directory) VALUES (290,93);
INSERT INTO edit_permissions(position, directory) VALUES (291,93);
INSERT INTO edit_permissions(position, directory) VALUES (292,93);
INSERT INTO edit_permissions(position, directory) VALUES (293,93);
INSERT INTO edit_permissions(position, directory) VALUES (294,93);

--   Fusion Division
--     Director of Student Development
INSERT INTO read_permissions(position, directory) VALUES (38,94);
INSERT INTO read_permissions(position, directory) VALUES (51,94);
INSERT INTO read_permissions(position, directory) VALUES (64,94);
INSERT INTO read_permissions(position, directory) VALUES (77,94);
INSERT INTO read_permissions(position, directory) VALUES (90,94);
INSERT INTO read_permissions(position, directory) VALUES (103,94);
INSERT INTO read_permissions(position, directory) VALUES (116,94);
INSERT INTO read_permissions(position, directory) VALUES (129,94);
INSERT INTO read_permissions(position, directory) VALUES (142,94);
INSERT INTO read_permissions(position, directory) VALUES (155,94);
INSERT INTO read_permissions(position, directory) VALUES (168,94);
INSERT INTO read_permissions(position, directory) VALUES (181,94);
INSERT INTO read_permissions(position, directory) VALUES (194,94);
INSERT INTO read_permissions(position, directory) VALUES (207,94);
INSERT INTO read_permissions(position, directory) VALUES (220,94);
--     Director of Tutoring
INSERT INTO read_permissions(position, directory) VALUES (39,94);
INSERT INTO read_permissions(position, directory) VALUES (52,94);
INSERT INTO read_permissions(position, directory) VALUES (65,94);
INSERT INTO read_permissions(position, directory) VALUES (78,94);
INSERT INTO read_permissions(position, directory) VALUES (91,94);
INSERT INTO read_permissions(position, directory) VALUES (104,94);
INSERT INTO read_permissions(position, directory) VALUES (117,94);
INSERT INTO read_permissions(position, directory) VALUES (130,94);
INSERT INTO read_permissions(position, directory) VALUES (143,94);
INSERT INTO read_permissions(position, directory) VALUES (156,94);
INSERT INTO read_permissions(position, directory) VALUES (169,94);
INSERT INTO read_permissions(position, directory) VALUES (182,94);
INSERT INTO read_permissions(position, directory) VALUES (195,94);
INSERT INTO read_permissions(position, directory) VALUES (208,94);
INSERT INTO read_permissions(position, directory) VALUES (221,94);
--     Fusionologist
INSERT INTO read_permissions(position, directory) VALUES (40,94);
INSERT INTO read_permissions(position, directory) VALUES (53,94);
INSERT INTO read_permissions(position, directory) VALUES (66,94);
INSERT INTO read_permissions(position, directory) VALUES (79,94);
INSERT INTO read_permissions(position, directory) VALUES (92,94);
INSERT INTO read_permissions(position, directory) VALUES (105,94);
INSERT INTO read_permissions(position, directory) VALUES (118,94);
INSERT INTO read_permissions(position, directory) VALUES (131,94);
INSERT INTO read_permissions(position, directory) VALUES (144,94);
INSERT INTO read_permissions(position, directory) VALUES (157,94);
INSERT INTO read_permissions(position, directory) VALUES (170,94);
INSERT INTO read_permissions(position, directory) VALUES (183,94);
INSERT INTO read_permissions(position, directory) VALUES (196,94);
INSERT INTO read_permissions(position, directory) VALUES (209,94);
INSERT INTO read_permissions(position, directory) VALUES (222,94);
--     Head of School
INSERT INTO read_permissions(position, directory) VALUES (41,94);
INSERT INTO read_permissions(position, directory) VALUES (54,94);
INSERT INTO read_permissions(position, directory) VALUES (67,94);
INSERT INTO read_permissions(position, directory) VALUES (80,94);
INSERT INTO read_permissions(position, directory) VALUES (93,94);
INSERT INTO read_permissions(position, directory) VALUES (106,94);
INSERT INTO read_permissions(position, directory) VALUES (119,94);
INSERT INTO read_permissions(position, directory) VALUES (132,94);
INSERT INTO read_permissions(position, directory) VALUES (145,94);
INSERT INTO read_permissions(position, directory) VALUES (158,94);
INSERT INTO read_permissions(position, directory) VALUES (171,94);
INSERT INTO read_permissions(position, directory) VALUES (184,94);
INSERT INTO read_permissions(position, directory) VALUES (197,94);
INSERT INTO read_permissions(position, directory) VALUES (210,94);
INSERT INTO read_permissions(position, directory) VALUES (223,94);
--     Master Teacher
INSERT INTO read_permissions(position, directory) VALUES (43,94);
INSERT INTO read_permissions(position, directory) VALUES (56,94);
INSERT INTO read_permissions(position, directory) VALUES (69,94);
INSERT INTO read_permissions(position, directory) VALUES (94,94);
INSERT INTO read_permissions(position, directory) VALUES (95,94);
INSERT INTO read_permissions(position, directory) VALUES (108,94);
INSERT INTO read_permissions(position, directory) VALUES (120,94);
INSERT INTO read_permissions(position, directory) VALUES (134,94);
INSERT INTO read_permissions(position, directory) VALUES (147,94);
INSERT INTO read_permissions(position, directory) VALUES (160,94);
INSERT INTO read_permissions(position, directory) VALUES (173,94);
INSERT INTO read_permissions(position, directory) VALUES (186,94);
INSERT INTO read_permissions(position, directory) VALUES (199,94);
INSERT INTO read_permissions(position, directory) VALUES (212,94);
INSERT INTO read_permissions(position, directory) VALUES (225,94);
--     Fusion Regional
INSERT INTO read_permissions(position, directory) VALUES (229,94);
INSERT INTO read_permissions(position, directory) VALUES (230,94);
INSERT INTO read_permissions(position, directory) VALUES (231,94);
INSERT INTO read_permissions(position, directory) VALUES (232,94);
INSERT INTO read_permissions(position, directory) VALUES (295,94);
INSERT INTO read_permissions(position, directory) VALUES (296,94);

--     Director of Student Development
INSERT INTO edit_permissions(position, directory) VALUES (38,94);
INSERT INTO edit_permissions(position, directory) VALUES (51,94);
INSERT INTO edit_permissions(position, directory) VALUES (64,94);
INSERT INTO edit_permissions(position, directory) VALUES (77,94);
INSERT INTO edit_permissions(position, directory) VALUES (90,94);
INSERT INTO edit_permissions(position, directory) VALUES (103,94);
INSERT INTO edit_permissions(position, directory) VALUES (116,94);
INSERT INTO edit_permissions(position, directory) VALUES (129,94);
INSERT INTO edit_permissions(position, directory) VALUES (142,94);
INSERT INTO edit_permissions(position, directory) VALUES (155,94);
INSERT INTO edit_permissions(position, directory) VALUES (168,94);
INSERT INTO edit_permissions(position, directory) VALUES (181,94);
INSERT INTO edit_permissions(position, directory) VALUES (194,94);
INSERT INTO edit_permissions(position, directory) VALUES (207,94);
INSERT INTO edit_permissions(position, directory) VALUES (220,94);
--     Director of Tutoring
INSERT INTO edit_permissions(position, directory) VALUES (39,94);
INSERT INTO edit_permissions(position, directory) VALUES (52,94);
INSERT INTO edit_permissions(position, directory) VALUES (65,94);
INSERT INTO edit_permissions(position, directory) VALUES (78,94);
INSERT INTO edit_permissions(position, directory) VALUES (91,94);
INSERT INTO edit_permissions(position, directory) VALUES (104,94);
INSERT INTO edit_permissions(position, directory) VALUES (117,94);
INSERT INTO edit_permissions(position, directory) VALUES (130,94);
INSERT INTO edit_permissions(position, directory) VALUES (143,94);
INSERT INTO edit_permissions(position, directory) VALUES (156,94);
INSERT INTO edit_permissions(position, directory) VALUES (169,94);
INSERT INTO edit_permissions(position, directory) VALUES (182,94);
INSERT INTO edit_permissions(position, directory) VALUES (195,94);
INSERT INTO edit_permissions(position, directory) VALUES (208,94);
INSERT INTO edit_permissions(position, directory) VALUES (221,94);
--     Fusionologist
INSERT INTO edit_permissions(position, directory) VALUES (40,94);
INSERT INTO edit_permissions(position, directory) VALUES (53,94);
INSERT INTO edit_permissions(position, directory) VALUES (66,94);
INSERT INTO edit_permissions(position, directory) VALUES (79,94);
INSERT INTO edit_permissions(position, directory) VALUES (92,94);
INSERT INTO edit_permissions(position, directory) VALUES (105,94);
INSERT INTO edit_permissions(position, directory) VALUES (118,94);
INSERT INTO edit_permissions(position, directory) VALUES (131,94);
INSERT INTO edit_permissions(position, directory) VALUES (144,94);
INSERT INTO edit_permissions(position, directory) VALUES (157,94);
INSERT INTO edit_permissions(position, directory) VALUES (170,94);
INSERT INTO edit_permissions(position, directory) VALUES (183,94);
INSERT INTO edit_permissions(position, directory) VALUES (196,94);
INSERT INTO edit_permissions(position, directory) VALUES (209,94);
INSERT INTO edit_permissions(position, directory) VALUES (222,94);
--     Head of School
INSERT INTO edit_permissions(position, directory) VALUES (41,94);
INSERT INTO edit_permissions(position, directory) VALUES (54,94);
INSERT INTO edit_permissions(position, directory) VALUES (67,94);
INSERT INTO edit_permissions(position, directory) VALUES (80,94);
INSERT INTO edit_permissions(position, directory) VALUES (93,94);
INSERT INTO edit_permissions(position, directory) VALUES (106,94);
INSERT INTO edit_permissions(position, directory) VALUES (119,94);
INSERT INTO edit_permissions(position, directory) VALUES (132,94);
INSERT INTO edit_permissions(position, directory) VALUES (145,94);
INSERT INTO edit_permissions(position, directory) VALUES (158,94);
INSERT INTO edit_permissions(position, directory) VALUES (171,94);
INSERT INTO edit_permissions(position, directory) VALUES (184,94);
INSERT INTO edit_permissions(position, directory) VALUES (197,94);
INSERT INTO edit_permissions(position, directory) VALUES (210,94);
INSERT INTO edit_permissions(position, directory) VALUES (223,94);
--     Master Teacher
INSERT INTO edit_permissions(position, directory) VALUES (43,94);
INSERT INTO edit_permissions(position, directory) VALUES (56,94);
INSERT INTO edit_permissions(position, directory) VALUES (69,94);
INSERT INTO edit_permissions(position, directory) VALUES (94,94);
INSERT INTO edit_permissions(position, directory) VALUES (95,94);
INSERT INTO edit_permissions(position, directory) VALUES (108,94);
INSERT INTO edit_permissions(position, directory) VALUES (120,94);
INSERT INTO edit_permissions(position, directory) VALUES (134,94);
INSERT INTO edit_permissions(position, directory) VALUES (147,94);
INSERT INTO edit_permissions(position, directory) VALUES (160,94);
INSERT INTO edit_permissions(position, directory) VALUES (173,94);
INSERT INTO edit_permissions(position, directory) VALUES (186,94);
INSERT INTO edit_permissions(position, directory) VALUES (199,94);
INSERT INTO edit_permissions(position, directory) VALUES (212,94);
INSERT INTO edit_permissions(position, directory) VALUES (225,94);
--     Fusion Regional
INSERT INTO edit_permissions(position, directory) VALUES (229,94);
INSERT INTO edit_permissions(position, directory) VALUES (230,94);
INSERT INTO edit_permissions(position, directory) VALUES (231,94);
INSERT INTO edit_permissions(position, directory) VALUES (232,94);
INSERT INTO edit_permissions(position, directory) VALUES (295,94);
INSERT INTO edit_permissions(position, directory) VALUES (296,94);

--   Tampa Day School
INSERT INTO read_permissions(position, directory) VALUES (244,95);
INSERT INTO read_permissions(position, directory) VALUES (245,95);
INSERT INTO read_permissions(position, directory) VALUES (246,95);
INSERT INTO read_permissions(position, directory) VALUES (247,95);
INSERT INTO read_permissions(position, directory) VALUES (248,95);
INSERT INTO read_permissions(position, directory) VALUES (249,95);

INSERT INTO edit_permissions(position, directory) VALUES (244,95);
INSERT INTO edit_permissions(position, directory) VALUES (245,95);
INSERT INTO edit_permissions(position, directory) VALUES (246,95);
INSERT INTO edit_permissions(position, directory) VALUES (247,95);
INSERT INTO edit_permissions(position, directory) VALUES (248,95);
INSERT INTO edit_permissions(position, directory) VALUES (249,95);

--   Barnstable Academy
INSERT INTO read_permissions(position, directory) VALUES (233,96);

INSERT INTO read_permissions(position, directory) VALUES (234,96);
INSERT INTO read_permissions(position, directory) VALUES (235,96);
INSERT INTO read_permissions(position, directory) VALUES (236,96);

INSERT INTO edit_permissions(position, directory) VALUES (233,96);
INSERT INTO edit_permissions(position, directory) VALUES (234,96);
INSERT INTO edit_permissions(position, directory) VALUES (235,96);
INSERT INTO edit_permissions(position, directory) VALUES (236,96);

--   Shreiner Academy
INSERT INTO read_permissions(position, directory) VALUES (239,97);
INSERT INTO read_permissions(position, directory) VALUES (240,97);
INSERT INTO read_permissions(position, directory) VALUES (241,97);

INSERT INTO edit_permissions(position, directory) VALUES (239,97);
INSERT INTO edit_permissions(position, directory) VALUES (240,97);
INSERT INTO edit_permissions(position, directory) VALUES (241,97);

-- American Education Group/Team Sites/EPIC! Portal/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (1,98);
INSERT INTO read_permissions(position, directory) VALUES (2,98);
INSERT INTO read_permissions(position, directory) VALUES (3,98);
INSERT INTO read_permissions(position, directory) VALUES (4,98);
INSERT INTO read_permissions(position, directory) VALUES (5,98);
INSERT INTO read_permissions(position, directory) VALUES (6,98);

INSERT INTO edit_permissions(position, directory) VALUES (1,98);
INSERT INTO edit_permissions(position, directory) VALUES (2,98);
INSERT INTO edit_permissions(position, directory) VALUES (3,98);
INSERT INTO edit_permissions(position, directory) VALUES (4,98);
INSERT INTO edit_permissions(position, directory) VALUES (5,98);
INSERT INTO edit_permissions(position, directory) VALUES (6,98);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (1,99);
INSERT INTO edit_permissions(position, directory) VALUES (2,99);
INSERT INTO edit_permissions(position, directory) VALUES (3,99);
INSERT INTO edit_permissions(position, directory) VALUES (4,99);
INSERT INTO edit_permissions(position, directory) VALUES (5,99);
INSERT INTO edit_permissions(position, directory) VALUES (6,99);

--   EPIC! Summits
INSERT INTO read_permissions(position, directory) VALUES (1,100);
INSERT INTO read_permissions(position, directory) VALUES (2,100);
INSERT INTO read_permissions(position, directory) VALUES (3,100);
INSERT INTO read_permissions(position, directory) VALUES (4,100);
INSERT INTO read_permissions(position, directory) VALUES (5,100);
INSERT INTO read_permissions(position, directory) VALUES (6,100);
INSERT INTO read_permissions(position, directory) VALUES (7,100);
INSERT INTO read_permissions(position, directory) VALUES (8,100);
INSERT INTO read_permissions(position, directory) VALUES (9,100);
INSERT INTO read_permissions(position, directory) VALUES (10,100);
INSERT INTO read_permissions(position, directory) VALUES (11,100);
INSERT INTO read_permissions(position, directory) VALUES (12,100);
INSERT INTO read_permissions(position, directory) VALUES (13,100);
INSERT INTO read_permissions(position, directory) VALUES (14,100);
INSERT INTO read_permissions(position, directory) VALUES (15,100);
INSERT INTO read_permissions(position, directory) VALUES (16,100);
INSERT INTO read_permissions(position, directory) VALUES (17,100);
INSERT INTO read_permissions(position, directory) VALUES (18,100);
INSERT INTO read_permissions(position, directory) VALUES (19,100);
INSERT INTO read_permissions(position, directory) VALUES (20,100);
INSERT INTO read_permissions(position, directory) VALUES (21,100);
INSERT INTO read_permissions(position, directory) VALUES (22,100);
INSERT INTO read_permissions(position, directory) VALUES (23,100);
INSERT INTO read_permissions(position, directory) VALUES (24,100);
INSERT INTO read_permissions(position, directory) VALUES (25,100);
INSERT INTO read_permissions(position, directory) VALUES (26,100);
INSERT INTO read_permissions(position, directory) VALUES (27,100);
INSERT INTO read_permissions(position, directory) VALUES (28,100);
INSERT INTO read_permissions(position, directory) VALUES (29,100);
INSERT INTO read_permissions(position, directory) VALUES (30,100);
INSERT INTO read_permissions(position, directory) VALUES (31,100);
INSERT INTO read_permissions(position, directory) VALUES (32,100);
INSERT INTO read_permissions(position, directory) VALUES (33,100);
INSERT INTO read_permissions(position, directory) VALUES (34,100);
INSERT INTO read_permissions(position, directory) VALUES (35,100);
INSERT INTO read_permissions(position, directory) VALUES (36,100);
INSERT INTO read_permissions(position, directory) VALUES (37,100);
INSERT INTO read_permissions(position, directory) VALUES (38,100);
INSERT INTO read_permissions(position, directory) VALUES (39,100);
INSERT INTO read_permissions(position, directory) VALUES (40,100);
INSERT INTO read_permissions(position, directory) VALUES (41,100);
INSERT INTO read_permissions(position, directory) VALUES (42,100);
INSERT INTO read_permissions(position, directory) VALUES (43,100);
INSERT INTO read_permissions(position, directory) VALUES (44,100);
INSERT INTO read_permissions(position, directory) VALUES (45,100);
INSERT INTO read_permissions(position, directory) VALUES (46,100);
INSERT INTO read_permissions(position, directory) VALUES (47,100);
INSERT INTO read_permissions(position, directory) VALUES (48,100);
INSERT INTO read_permissions(position, directory) VALUES (49,100);
INSERT INTO read_permissions(position, directory) VALUES (50,100);
INSERT INTO read_permissions(position, directory) VALUES (51,100);
INSERT INTO read_permissions(position, directory) VALUES (52,100);
INSERT INTO read_permissions(position, directory) VALUES (53,100);
INSERT INTO read_permissions(position, directory) VALUES (54,100);
INSERT INTO read_permissions(position, directory) VALUES (55,100);
INSERT INTO read_permissions(position, directory) VALUES (56,100);
INSERT INTO read_permissions(position, directory) VALUES (57,100);
INSERT INTO read_permissions(position, directory) VALUES (58,100);
INSERT INTO read_permissions(position, directory) VALUES (59,100);
INSERT INTO read_permissions(position, directory) VALUES (60,100);
INSERT INTO read_permissions(position, directory) VALUES (61,100);
INSERT INTO read_permissions(position, directory) VALUES (62,100);
INSERT INTO read_permissions(position, directory) VALUES (63,100);
INSERT INTO read_permissions(position, directory) VALUES (64,100);
INSERT INTO read_permissions(position, directory) VALUES (65,100);
INSERT INTO read_permissions(position, directory) VALUES (66,100);
INSERT INTO read_permissions(position, directory) VALUES (67,100);
INSERT INTO read_permissions(position, directory) VALUES (68,100);
INSERT INTO read_permissions(position, directory) VALUES (69,100);
INSERT INTO read_permissions(position, directory) VALUES (70,100);
INSERT INTO read_permissions(position, directory) VALUES (71,100);
INSERT INTO read_permissions(position, directory) VALUES (72,100);
INSERT INTO read_permissions(position, directory) VALUES (73,100);
INSERT INTO read_permissions(position, directory) VALUES (74,100);
INSERT INTO read_permissions(position, directory) VALUES (75,100);
INSERT INTO read_permissions(position, directory) VALUES (76,100);
INSERT INTO read_permissions(position, directory) VALUES (77,100);
INSERT INTO read_permissions(position, directory) VALUES (78,100);
INSERT INTO read_permissions(position, directory) VALUES (79,100);
INSERT INTO read_permissions(position, directory) VALUES (80,100);
INSERT INTO read_permissions(position, directory) VALUES (81,100);
INSERT INTO read_permissions(position, directory) VALUES (82,100);
INSERT INTO read_permissions(position, directory) VALUES (83,100);
INSERT INTO read_permissions(position, directory) VALUES (84,100);
INSERT INTO read_permissions(position, directory) VALUES (85,100);
INSERT INTO read_permissions(position, directory) VALUES (86,100);
INSERT INTO read_permissions(position, directory) VALUES (87,100);
INSERT INTO read_permissions(position, directory) VALUES (88,100);
INSERT INTO read_permissions(position, directory) VALUES (89,100);
INSERT INTO read_permissions(position, directory) VALUES (90,100);
INSERT INTO read_permissions(position, directory) VALUES (91,100);
INSERT INTO read_permissions(position, directory) VALUES (92,100);
INSERT INTO read_permissions(position, directory) VALUES (93,100);
INSERT INTO read_permissions(position, directory) VALUES (94,100);
INSERT INTO read_permissions(position, directory) VALUES (95,100);
INSERT INTO read_permissions(position, directory) VALUES (96,100);
INSERT INTO read_permissions(position, directory) VALUES (97,100);
INSERT INTO read_permissions(position, directory) VALUES (98,100);
INSERT INTO read_permissions(position, directory) VALUES (99,100);
INSERT INTO read_permissions(position, directory) VALUES (100,100);
INSERT INTO read_permissions(position, directory) VALUES (101,100);
INSERT INTO read_permissions(position, directory) VALUES (102,100);
INSERT INTO read_permissions(position, directory) VALUES (103,100);
INSERT INTO read_permissions(position, directory) VALUES (104,100);
INSERT INTO read_permissions(position, directory) VALUES (105,100);
INSERT INTO read_permissions(position, directory) VALUES (106,100);
INSERT INTO read_permissions(position, directory) VALUES (107,100);
INSERT INTO read_permissions(position, directory) VALUES (108,100);
INSERT INTO read_permissions(position, directory) VALUES (109,100);
INSERT INTO read_permissions(position, directory) VALUES (110,100);
INSERT INTO read_permissions(position, directory) VALUES (111,100);
INSERT INTO read_permissions(position, directory) VALUES (112,100);
INSERT INTO read_permissions(position, directory) VALUES (113,100);
INSERT INTO read_permissions(position, directory) VALUES (114,100);
INSERT INTO read_permissions(position, directory) VALUES (115,100);
INSERT INTO read_permissions(position, directory) VALUES (116,100);
INSERT INTO read_permissions(position, directory) VALUES (117,100);
INSERT INTO read_permissions(position, directory) VALUES (118,100);
INSERT INTO read_permissions(position, directory) VALUES (119,100);
INSERT INTO read_permissions(position, directory) VALUES (120,100);
INSERT INTO read_permissions(position, directory) VALUES (121,100);
INSERT INTO read_permissions(position, directory) VALUES (122,100);
INSERT INTO read_permissions(position, directory) VALUES (123,100);
INSERT INTO read_permissions(position, directory) VALUES (124,100);
INSERT INTO read_permissions(position, directory) VALUES (125,100);
INSERT INTO read_permissions(position, directory) VALUES (126,100);
INSERT INTO read_permissions(position, directory) VALUES (127,100);
INSERT INTO read_permissions(position, directory) VALUES (128,100);
INSERT INTO read_permissions(position, directory) VALUES (129,100);
INSERT INTO read_permissions(position, directory) VALUES (130,100);
INSERT INTO read_permissions(position, directory) VALUES (131,100);
INSERT INTO read_permissions(position, directory) VALUES (132,100);


INSERT INTO read_permissions(position, directory) VALUES (133,100);
INSERT INTO read_permissions(position, directory) VALUES (134,100);
INSERT INTO read_permissions(position, directory) VALUES (135,100);
INSERT INTO read_permissions(position, directory) VALUES (136,100);
INSERT INTO read_permissions(position, directory) VALUES (137,100);
INSERT INTO read_permissions(position, directory) VALUES (138,100);
INSERT INTO read_permissions(position, directory) VALUES (139,100);
INSERT INTO read_permissions(position, directory) VALUES (140,100);
INSERT INTO read_permissions(position, directory) VALUES (141,100);
INSERT INTO read_permissions(position, directory) VALUES (142,100);
INSERT INTO read_permissions(position, directory) VALUES (143,100);
INSERT INTO read_permissions(position, directory) VALUES (144,100);
INSERT INTO read_permissions(position, directory) VALUES (145,100);
INSERT INTO read_permissions(position, directory) VALUES (146,100);
INSERT INTO read_permissions(position, directory) VALUES (147,100);
INSERT INTO read_permissions(position, directory) VALUES (148,100);
INSERT INTO read_permissions(position, directory) VALUES (149,100);
INSERT INTO read_permissions(position, directory) VALUES (150,100);
INSERT INTO read_permissions(position, directory) VALUES (151,100);
INSERT INTO read_permissions(position, directory) VALUES (152,100);
INSERT INTO read_permissions(position, directory) VALUES (153,100);
INSERT INTO read_permissions(position, directory) VALUES (154,100);
INSERT INTO read_permissions(position, directory) VALUES (155,100);
INSERT INTO read_permissions(position, directory) VALUES (156,100);
INSERT INTO read_permissions(position, directory) VALUES (157,100);
INSERT INTO read_permissions(position, directory) VALUES (158,100);
INSERT INTO read_permissions(position, directory) VALUES (159,100);
INSERT INTO read_permissions(position, directory) VALUES (160,100);
INSERT INTO read_permissions(position, directory) VALUES (161,100);
INSERT INTO read_permissions(position, directory) VALUES (162,100);
INSERT INTO read_permissions(position, directory) VALUES (163,100);
INSERT INTO read_permissions(position, directory) VALUES (164,100);
INSERT INTO read_permissions(position, directory) VALUES (165,100);
INSERT INTO read_permissions(position, directory) VALUES (166,100);
INSERT INTO read_permissions(position, directory) VALUES (167,100);
INSERT INTO read_permissions(position, directory) VALUES (168,100);
INSERT INTO read_permissions(position, directory) VALUES (169,100);
INSERT INTO read_permissions(position, directory) VALUES (170,100);
INSERT INTO read_permissions(position, directory) VALUES (171,100);
INSERT INTO read_permissions(position, directory) VALUES (172,100);
INSERT INTO read_permissions(position, directory) VALUES (173,100);
INSERT INTO read_permissions(position, directory) VALUES (174,100);
INSERT INTO read_permissions(position, directory) VALUES (175,100);
INSERT INTO read_permissions(position, directory) VALUES (176,100);
INSERT INTO read_permissions(position, directory) VALUES (177,100);
INSERT INTO read_permissions(position, directory) VALUES (178,100);
INSERT INTO read_permissions(position, directory) VALUES (179,100);
INSERT INTO read_permissions(position, directory) VALUES (180,100);
INSERT INTO read_permissions(position, directory) VALUES (181,100);
INSERT INTO read_permissions(position, directory) VALUES (182,100);
INSERT INTO read_permissions(position, directory) VALUES (183,100);
INSERT INTO read_permissions(position, directory) VALUES (184,100);
INSERT INTO read_permissions(position, directory) VALUES (185,100);
INSERT INTO read_permissions(position, directory) VALUES (186,100);
INSERT INTO read_permissions(position, directory) VALUES (187,100);
INSERT INTO read_permissions(position, directory) VALUES (188,100);
INSERT INTO read_permissions(position, directory) VALUES (189,100);
INSERT INTO read_permissions(position, directory) VALUES (190,100);
INSERT INTO read_permissions(position, directory) VALUES (191,100);
INSERT INTO read_permissions(position, directory) VALUES (192,100);
INSERT INTO read_permissions(position, directory) VALUES (193,100);
INSERT INTO read_permissions(position, directory) VALUES (194,100);
INSERT INTO read_permissions(position, directory) VALUES (195,100);
INSERT INTO read_permissions(position, directory) VALUES (196,100);
INSERT INTO read_permissions(position, directory) VALUES (197,100);
INSERT INTO read_permissions(position, directory) VALUES (198,100);
INSERT INTO read_permissions(position, directory) VALUES (199,100);
INSERT INTO read_permissions(position, directory) VALUES (200,100);
INSERT INTO read_permissions(position, directory) VALUES (201,100);
INSERT INTO read_permissions(position, directory) VALUES (202,100);
INSERT INTO read_permissions(position, directory) VALUES (203,100);
INSERT INTO read_permissions(position, directory) VALUES (204,100);
INSERT INTO read_permissions(position, directory) VALUES (205,100);
INSERT INTO read_permissions(position, directory) VALUES (206,100);
INSERT INTO read_permissions(position, directory) VALUES (207,100);
INSERT INTO read_permissions(position, directory) VALUES (208,100);
INSERT INTO read_permissions(position, directory) VALUES (209,100);
INSERT INTO read_permissions(position, directory) VALUES (210,100);
INSERT INTO read_permissions(position, directory) VALUES (211,100);
INSERT INTO read_permissions(position, directory) VALUES (212,100);
INSERT INTO read_permissions(position, directory) VALUES (213,100);
INSERT INTO read_permissions(position, directory) VALUES (214,100);
INSERT INTO read_permissions(position, directory) VALUES (215,100);
INSERT INTO read_permissions(position, directory) VALUES (216,100);
INSERT INTO read_permissions(position, directory) VALUES (217,100);
INSERT INTO read_permissions(position, directory) VALUES (218,100);
INSERT INTO read_permissions(position, directory) VALUES (219,100);
INSERT INTO read_permissions(position, directory) VALUES (220,100);
INSERT INTO read_permissions(position, directory) VALUES (221,100);
INSERT INTO read_permissions(position, directory) VALUES (222,100);
INSERT INTO read_permissions(position, directory) VALUES (223,100);
INSERT INTO read_permissions(position, directory) VALUES (224,100);
INSERT INTO read_permissions(position, directory) VALUES (225,100);
INSERT INTO read_permissions(position, directory) VALUES (226,100);
INSERT INTO read_permissions(position, directory) VALUES (227,100);
INSERT INTO read_permissions(position, directory) VALUES (228,100);
INSERT INTO read_permissions(position, directory) VALUES (229,100);
INSERT INTO read_permissions(position, directory) VALUES (230,100);
INSERT INTO read_permissions(position, directory) VALUES (231,100);
INSERT INTO read_permissions(position, directory) VALUES (232,100);
INSERT INTO read_permissions(position, directory) VALUES (233,100);
INSERT INTO read_permissions(position, directory) VALUES (234,100);
INSERT INTO read_permissions(position, directory) VALUES (235,100);
INSERT INTO read_permissions(position, directory) VALUES (236,100);
INSERT INTO read_permissions(position, directory) VALUES (237,100);
INSERT INTO read_permissions(position, directory) VALUES (238,100);
INSERT INTO read_permissions(position, directory) VALUES (239,100);
INSERT INTO read_permissions(position, directory) VALUES (240,100);
INSERT INTO read_permissions(position, directory) VALUES (241,100);
INSERT INTO read_permissions(position, directory) VALUES (242,100);
INSERT INTO read_permissions(position, directory) VALUES (243,100);
INSERT INTO read_permissions(position, directory) VALUES (244,100);
INSERT INTO read_permissions(position, directory) VALUES (245,100);
INSERT INTO read_permissions(position, directory) VALUES (246,100);
INSERT INTO read_permissions(position, directory) VALUES (247,100);
INSERT INTO read_permissions(position, directory) VALUES (248,100);
INSERT INTO read_permissions(position, directory) VALUES (249,100);
INSERT INTO read_permissions(position, directory) VALUES (250,100);
INSERT INTO read_permissions(position, directory) VALUES (251,100);
INSERT INTO read_permissions(position, directory) VALUES (252,100);
INSERT INTO read_permissions(position, directory) VALUES (253,100);
INSERT INTO read_permissions(position, directory) VALUES (254,100);
INSERT INTO read_permissions(position, directory) VALUES (255,100);
INSERT INTO read_permissions(position, directory) VALUES (256,100);
INSERT INTO read_permissions(position, directory) VALUES (257,100);
INSERT INTO read_permissions(position, directory) VALUES (258,100);
INSERT INTO read_permissions(position, directory) VALUES (259,100);
INSERT INTO read_permissions(position, directory) VALUES (260,100);
INSERT INTO read_permissions(position, directory) VALUES (261,100);
INSERT INTO read_permissions(position, directory) VALUES (262,100);
INSERT INTO read_permissions(position, directory) VALUES (263,100);
INSERT INTO read_permissions(position, directory) VALUES (264,100);
INSERT INTO read_permissions(position, directory) VALUES (265,100);
INSERT INTO read_permissions(position, directory) VALUES (266,100);
INSERT INTO read_permissions(position, directory) VALUES (267,100);
INSERT INTO read_permissions(position, directory) VALUES (268,100);
INSERT INTO read_permissions(position, directory) VALUES (269,100);
INSERT INTO read_permissions(position, directory) VALUES (270,100);
INSERT INTO read_permissions(position, directory) VALUES (271,100);
INSERT INTO read_permissions(position, directory) VALUES (272,100);
INSERT INTO read_permissions(position, directory) VALUES (273,100);
INSERT INTO read_permissions(position, directory) VALUES (274,100);
INSERT INTO read_permissions(position, directory) VALUES (275,100);
INSERT INTO read_permissions(position, directory) VALUES (276,100);
INSERT INTO read_permissions(position, directory) VALUES (277,100);
INSERT INTO read_permissions(position, directory) VALUES (278,100);
INSERT INTO read_permissions(position, directory) VALUES (279,100);
INSERT INTO read_permissions(position, directory) VALUES (280,100);
INSERT INTO read_permissions(position, directory) VALUES (281,100);
INSERT INTO read_permissions(position, directory) VALUES (282,100);
INSERT INTO read_permissions(position, directory) VALUES (283,100);
INSERT INTO read_permissions(position, directory) VALUES (284,100);
INSERT INTO read_permissions(position, directory) VALUES (285,100);
INSERT INTO read_permissions(position, directory) VALUES (286,100);
INSERT INTO read_permissions(position, directory) VALUES (287,100);
INSERT INTO read_permissions(position, directory) VALUES (288,100);
INSERT INTO read_permissions(position, directory) VALUES (289,100);
INSERT INTO read_permissions(position, directory) VALUES (290,100);
INSERT INTO read_permissions(position, directory) VALUES (291,100);
INSERT INTO read_permissions(position, directory) VALUES (292,100);
INSERT INTO read_permissions(position, directory) VALUES (293,100);
INSERT INTO read_permissions(position, directory) VALUES (294,100);
INSERT INTO read_permissions(position, directory) VALUES (295,100);
INSERT INTO read_permissions(position, directory) VALUES (296,100);

INSERT INTO edit_permissions(position, directory) VALUES (1,100);
INSERT INTO edit_permissions(position, directory) VALUES (2,100);
INSERT INTO edit_permissions(position, directory) VALUES (3,100);
INSERT INTO edit_permissions(position, directory) VALUES (4,100);
INSERT INTO edit_permissions(position, directory) VALUES (5,100);
INSERT INTO edit_permissions(position, directory) VALUES (6,100);

--   Reinventing School News
INSERT INTO read_permissions(position, directory) VALUES (1,101);
INSERT INTO read_permissions(position, directory) VALUES (2,101);
INSERT INTO read_permissions(position, directory) VALUES (3,101);
INSERT INTO read_permissions(position, directory) VALUES (4,101);
INSERT INTO read_permissions(position, directory) VALUES (5,101);
INSERT INTO read_permissions(position, directory) VALUES (6,101);
INSERT INTO read_permissions(position, directory) VALUES (7,101);
INSERT INTO read_permissions(position, directory) VALUES (8,101);
INSERT INTO read_permissions(position, directory) VALUES (9,101);
INSERT INTO read_permissions(position, directory) VALUES (10,101);
INSERT INTO read_permissions(position, directory) VALUES (11,101);
INSERT INTO read_permissions(position, directory) VALUES (12,101);
INSERT INTO read_permissions(position, directory) VALUES (13,101);
INSERT INTO read_permissions(position, directory) VALUES (14,101);
INSERT INTO read_permissions(position, directory) VALUES (15,101);
INSERT INTO read_permissions(position, directory) VALUES (16,101);
INSERT INTO read_permissions(position, directory) VALUES (17,101);
INSERT INTO read_permissions(position, directory) VALUES (18,101);
INSERT INTO read_permissions(position, directory) VALUES (19,101);
INSERT INTO read_permissions(position, directory) VALUES (20,101);
INSERT INTO read_permissions(position, directory) VALUES (21,101);
INSERT INTO read_permissions(position, directory) VALUES (22,101);
INSERT INTO read_permissions(position, directory) VALUES (23,101);
INSERT INTO read_permissions(position, directory) VALUES (24,101);
INSERT INTO read_permissions(position, directory) VALUES (25,101);
INSERT INTO read_permissions(position, directory) VALUES (26,101);
INSERT INTO read_permissions(position, directory) VALUES (27,101);
INSERT INTO read_permissions(position, directory) VALUES (28,101);
INSERT INTO read_permissions(position, directory) VALUES (29,101);
INSERT INTO read_permissions(position, directory) VALUES (30,101);
INSERT INTO read_permissions(position, directory) VALUES (31,101);
INSERT INTO read_permissions(position, directory) VALUES (32,101);
INSERT INTO read_permissions(position, directory) VALUES (33,101);
INSERT INTO read_permissions(position, directory) VALUES (34,101);
INSERT INTO read_permissions(position, directory) VALUES (35,101);
INSERT INTO read_permissions(position, directory) VALUES (36,101);
INSERT INTO read_permissions(position, directory) VALUES (37,101);
INSERT INTO read_permissions(position, directory) VALUES (38,101);
INSERT INTO read_permissions(position, directory) VALUES (39,101);
INSERT INTO read_permissions(position, directory) VALUES (40,101);
INSERT INTO read_permissions(position, directory) VALUES (41,101);
INSERT INTO read_permissions(position, directory) VALUES (42,101);
INSERT INTO read_permissions(position, directory) VALUES (43,101);
INSERT INTO read_permissions(position, directory) VALUES (44,101);
INSERT INTO read_permissions(position, directory) VALUES (45,101);
INSERT INTO read_permissions(position, directory) VALUES (46,101);
INSERT INTO read_permissions(position, directory) VALUES (47,101);
INSERT INTO read_permissions(position, directory) VALUES (48,101);
INSERT INTO read_permissions(position, directory) VALUES (49,101);
INSERT INTO read_permissions(position, directory) VALUES (50,101);
INSERT INTO read_permissions(position, directory) VALUES (51,101);
INSERT INTO read_permissions(position, directory) VALUES (52,101);
INSERT INTO read_permissions(position, directory) VALUES (53,101);
INSERT INTO read_permissions(position, directory) VALUES (54,101);
INSERT INTO read_permissions(position, directory) VALUES (55,101);
INSERT INTO read_permissions(position, directory) VALUES (56,101);
INSERT INTO read_permissions(position, directory) VALUES (57,101);
INSERT INTO read_permissions(position, directory) VALUES (58,101);
INSERT INTO read_permissions(position, directory) VALUES (59,101);
INSERT INTO read_permissions(position, directory) VALUES (60,101);
INSERT INTO read_permissions(position, directory) VALUES (61,101);
INSERT INTO read_permissions(position, directory) VALUES (62,101);
INSERT INTO read_permissions(position, directory) VALUES (63,101);
INSERT INTO read_permissions(position, directory) VALUES (64,101);
INSERT INTO read_permissions(position, directory) VALUES (65,101);
INSERT INTO read_permissions(position, directory) VALUES (66,101);
INSERT INTO read_permissions(position, directory) VALUES (67,101);
INSERT INTO read_permissions(position, directory) VALUES (68,101);
INSERT INTO read_permissions(position, directory) VALUES (69,101);
INSERT INTO read_permissions(position, directory) VALUES (70,101);
INSERT INTO read_permissions(position, directory) VALUES (71,101);
INSERT INTO read_permissions(position, directory) VALUES (72,101);
INSERT INTO read_permissions(position, directory) VALUES (73,101);
INSERT INTO read_permissions(position, directory) VALUES (74,101);
INSERT INTO read_permissions(position, directory) VALUES (75,101);
INSERT INTO read_permissions(position, directory) VALUES (76,101);
INSERT INTO read_permissions(position, directory) VALUES (77,101);
INSERT INTO read_permissions(position, directory) VALUES (78,101);
INSERT INTO read_permissions(position, directory) VALUES (79,101);
INSERT INTO read_permissions(position, directory) VALUES (80,101);
INSERT INTO read_permissions(position, directory) VALUES (81,101);
INSERT INTO read_permissions(position, directory) VALUES (82,101);
INSERT INTO read_permissions(position, directory) VALUES (83,101);
INSERT INTO read_permissions(position, directory) VALUES (84,101);
INSERT INTO read_permissions(position, directory) VALUES (85,101);
INSERT INTO read_permissions(position, directory) VALUES (86,101);
INSERT INTO read_permissions(position, directory) VALUES (87,101);
INSERT INTO read_permissions(position, directory) VALUES (88,101);
INSERT INTO read_permissions(position, directory) VALUES (89,101);
INSERT INTO read_permissions(position, directory) VALUES (90,101);
INSERT INTO read_permissions(position, directory) VALUES (91,101);
INSERT INTO read_permissions(position, directory) VALUES (92,101);
INSERT INTO read_permissions(position, directory) VALUES (93,101);
INSERT INTO read_permissions(position, directory) VALUES (94,101);
INSERT INTO read_permissions(position, directory) VALUES (95,101);
INSERT INTO read_permissions(position, directory) VALUES (96,101);
INSERT INTO read_permissions(position, directory) VALUES (97,101);
INSERT INTO read_permissions(position, directory) VALUES (98,101);
INSERT INTO read_permissions(position, directory) VALUES (99,101);
INSERT INTO read_permissions(position, directory) VALUES (100,101);
INSERT INTO read_permissions(position, directory) VALUES (101,101);
INSERT INTO read_permissions(position, directory) VALUES (102,101);
INSERT INTO read_permissions(position, directory) VALUES (103,101);
INSERT INTO read_permissions(position, directory) VALUES (104,101);
INSERT INTO read_permissions(position, directory) VALUES (105,101);
INSERT INTO read_permissions(position, directory) VALUES (106,101);
INSERT INTO read_permissions(position, directory) VALUES (107,101);
INSERT INTO read_permissions(position, directory) VALUES (108,101);
INSERT INTO read_permissions(position, directory) VALUES (109,101);
INSERT INTO read_permissions(position, directory) VALUES (110,101);
INSERT INTO read_permissions(position, directory) VALUES (111,101);
INSERT INTO read_permissions(position, directory) VALUES (112,101);
INSERT INTO read_permissions(position, directory) VALUES (113,101);
INSERT INTO read_permissions(position, directory) VALUES (114,101);
INSERT INTO read_permissions(position, directory) VALUES (115,101);
INSERT INTO read_permissions(position, directory) VALUES (116,101);
INSERT INTO read_permissions(position, directory) VALUES (117,101);
INSERT INTO read_permissions(position, directory) VALUES (118,101);
INSERT INTO read_permissions(position, directory) VALUES (119,101);
INSERT INTO read_permissions(position, directory) VALUES (120,101);
INSERT INTO read_permissions(position, directory) VALUES (121,101);
INSERT INTO read_permissions(position, directory) VALUES (122,101);
INSERT INTO read_permissions(position, directory) VALUES (123,101);
INSERT INTO read_permissions(position, directory) VALUES (124,101);
INSERT INTO read_permissions(position, directory) VALUES (125,101);
INSERT INTO read_permissions(position, directory) VALUES (126,101);
INSERT INTO read_permissions(position, directory) VALUES (127,101);
INSERT INTO read_permissions(position, directory) VALUES (128,101);
INSERT INTO read_permissions(position, directory) VALUES (129,101);
INSERT INTO read_permissions(position, directory) VALUES (130,101);
INSERT INTO read_permissions(position, directory) VALUES (131,101);
INSERT INTO read_permissions(position, directory) VALUES (132,101);
INSERT INTO read_permissions(position, directory) VALUES (133,101);
INSERT INTO read_permissions(position, directory) VALUES (134,101);
INSERT INTO read_permissions(position, directory) VALUES (135,101);
INSERT INTO read_permissions(position, directory) VALUES (136,101);
INSERT INTO read_permissions(position, directory) VALUES (137,101);
INSERT INTO read_permissions(position, directory) VALUES (138,101);
INSERT INTO read_permissions(position, directory) VALUES (139,101);
INSERT INTO read_permissions(position, directory) VALUES (140,101);
INSERT INTO read_permissions(position, directory) VALUES (141,101);
INSERT INTO read_permissions(position, directory) VALUES (142,101);
INSERT INTO read_permissions(position, directory) VALUES (143,101);
INSERT INTO read_permissions(position, directory) VALUES (144,101);
INSERT INTO read_permissions(position, directory) VALUES (145,101);
INSERT INTO read_permissions(position, directory) VALUES (146,101);
INSERT INTO read_permissions(position, directory) VALUES (147,101);
INSERT INTO read_permissions(position, directory) VALUES (148,101);
INSERT INTO read_permissions(position, directory) VALUES (149,101);
INSERT INTO read_permissions(position, directory) VALUES (150,101);
INSERT INTO read_permissions(position, directory) VALUES (151,101);
INSERT INTO read_permissions(position, directory) VALUES (152,101);
INSERT INTO read_permissions(position, directory) VALUES (153,101);
INSERT INTO read_permissions(position, directory) VALUES (154,101);
INSERT INTO read_permissions(position, directory) VALUES (155,101);
INSERT INTO read_permissions(position, directory) VALUES (156,101);
INSERT INTO read_permissions(position, directory) VALUES (157,101);
INSERT INTO read_permissions(position, directory) VALUES (158,101);
INSERT INTO read_permissions(position, directory) VALUES (159,101);
INSERT INTO read_permissions(position, directory) VALUES (160,101);
INSERT INTO read_permissions(position, directory) VALUES (161,101);
INSERT INTO read_permissions(position, directory) VALUES (162,101);
INSERT INTO read_permissions(position, directory) VALUES (163,101);
INSERT INTO read_permissions(position, directory) VALUES (164,101);
INSERT INTO read_permissions(position, directory) VALUES (165,101);
INSERT INTO read_permissions(position, directory) VALUES (166,101);
INSERT INTO read_permissions(position, directory) VALUES (167,101);
INSERT INTO read_permissions(position, directory) VALUES (168,101);
INSERT INTO read_permissions(position, directory) VALUES (169,101);
INSERT INTO read_permissions(position, directory) VALUES (170,101);
INSERT INTO read_permissions(position, directory) VALUES (171,101);
INSERT INTO read_permissions(position, directory) VALUES (172,101);
INSERT INTO read_permissions(position, directory) VALUES (173,101);
INSERT INTO read_permissions(position, directory) VALUES (174,101);
INSERT INTO read_permissions(position, directory) VALUES (175,101);
INSERT INTO read_permissions(position, directory) VALUES (176,101);
INSERT INTO read_permissions(position, directory) VALUES (177,101);
INSERT INTO read_permissions(position, directory) VALUES (178,101);
INSERT INTO read_permissions(position, directory) VALUES (179,101);
INSERT INTO read_permissions(position, directory) VALUES (180,101);
INSERT INTO read_permissions(position, directory) VALUES (181,101);
INSERT INTO read_permissions(position, directory) VALUES (182,101);
INSERT INTO read_permissions(position, directory) VALUES (183,101);
INSERT INTO read_permissions(position, directory) VALUES (184,101);
INSERT INTO read_permissions(position, directory) VALUES (185,101);
INSERT INTO read_permissions(position, directory) VALUES (186,101);
INSERT INTO read_permissions(position, directory) VALUES (187,101);
INSERT INTO read_permissions(position, directory) VALUES (188,101);
INSERT INTO read_permissions(position, directory) VALUES (189,101);
INSERT INTO read_permissions(position, directory) VALUES (190,101);
INSERT INTO read_permissions(position, directory) VALUES (191,101);
INSERT INTO read_permissions(position, directory) VALUES (192,101);
INSERT INTO read_permissions(position, directory) VALUES (193,101);
INSERT INTO read_permissions(position, directory) VALUES (194,101);
INSERT INTO read_permissions(position, directory) VALUES (195,101);
INSERT INTO read_permissions(position, directory) VALUES (196,101);
INSERT INTO read_permissions(position, directory) VALUES (197,101);
INSERT INTO read_permissions(position, directory) VALUES (198,101);
INSERT INTO read_permissions(position, directory) VALUES (199,101);
INSERT INTO read_permissions(position, directory) VALUES (200,101);
INSERT INTO read_permissions(position, directory) VALUES (201,101);
INSERT INTO read_permissions(position, directory) VALUES (202,101);
INSERT INTO read_permissions(position, directory) VALUES (203,101);
INSERT INTO read_permissions(position, directory) VALUES (204,101);
INSERT INTO read_permissions(position, directory) VALUES (205,101);
INSERT INTO read_permissions(position, directory) VALUES (206,101);
INSERT INTO read_permissions(position, directory) VALUES (207,101);
INSERT INTO read_permissions(position, directory) VALUES (208,101);
INSERT INTO read_permissions(position, directory) VALUES (209,101);
INSERT INTO read_permissions(position, directory) VALUES (210,101);
INSERT INTO read_permissions(position, directory) VALUES (211,101);
INSERT INTO read_permissions(position, directory) VALUES (212,101);
INSERT INTO read_permissions(position, directory) VALUES (213,101);
INSERT INTO read_permissions(position, directory) VALUES (214,101);
INSERT INTO read_permissions(position, directory) VALUES (215,101);
INSERT INTO read_permissions(position, directory) VALUES (216,101);
INSERT INTO read_permissions(position, directory) VALUES (217,101);
INSERT INTO read_permissions(position, directory) VALUES (218,101);
INSERT INTO read_permissions(position, directory) VALUES (219,101);
INSERT INTO read_permissions(position, directory) VALUES (220,101);
INSERT INTO read_permissions(position, directory) VALUES (221,101);
INSERT INTO read_permissions(position, directory) VALUES (222,101);
INSERT INTO read_permissions(position, directory) VALUES (223,101);
INSERT INTO read_permissions(position, directory) VALUES (224,101);
INSERT INTO read_permissions(position, directory) VALUES (225,101);
INSERT INTO read_permissions(position, directory) VALUES (226,101);
INSERT INTO read_permissions(position, directory) VALUES (227,101);
INSERT INTO read_permissions(position, directory) VALUES (228,101);
INSERT INTO read_permissions(position, directory) VALUES (229,101);
INSERT INTO read_permissions(position, directory) VALUES (230,101);
INSERT INTO read_permissions(position, directory) VALUES (231,101);
INSERT INTO read_permissions(position, directory) VALUES (232,101);
INSERT INTO read_permissions(position, directory) VALUES (233,101);
INSERT INTO read_permissions(position, directory) VALUES (234,101);
INSERT INTO read_permissions(position, directory) VALUES (235,101);
INSERT INTO read_permissions(position, directory) VALUES (236,101);
INSERT INTO read_permissions(position, directory) VALUES (237,101);
INSERT INTO read_permissions(position, directory) VALUES (238,101);
INSERT INTO read_permissions(position, directory) VALUES (239,101);
INSERT INTO read_permissions(position, directory) VALUES (240,101);
INSERT INTO read_permissions(position, directory) VALUES (241,101);
INSERT INTO read_permissions(position, directory) VALUES (242,101);
INSERT INTO read_permissions(position, directory) VALUES (243,101);
INSERT INTO read_permissions(position, directory) VALUES (244,101);
INSERT INTO read_permissions(position, directory) VALUES (245,101);
INSERT INTO read_permissions(position, directory) VALUES (246,101);
INSERT INTO read_permissions(position, directory) VALUES (247,101);
INSERT INTO read_permissions(position, directory) VALUES (248,101);
INSERT INTO read_permissions(position, directory) VALUES (249,101);
INSERT INTO read_permissions(position, directory) VALUES (250,101);
INSERT INTO read_permissions(position, directory) VALUES (251,101);
INSERT INTO read_permissions(position, directory) VALUES (252,101);
INSERT INTO read_permissions(position, directory) VALUES (253,101);
INSERT INTO read_permissions(position, directory) VALUES (254,101);
INSERT INTO read_permissions(position, directory) VALUES (255,101);
INSERT INTO read_permissions(position, directory) VALUES (256,101);
INSERT INTO read_permissions(position, directory) VALUES (257,101);
INSERT INTO read_permissions(position, directory) VALUES (258,101);
INSERT INTO read_permissions(position, directory) VALUES (259,101);
INSERT INTO read_permissions(position, directory) VALUES (260,101);
INSERT INTO read_permissions(position, directory) VALUES (261,101);
INSERT INTO read_permissions(position, directory) VALUES (262,101);
INSERT INTO read_permissions(position, directory) VALUES (263,101);
INSERT INTO read_permissions(position, directory) VALUES (264,101);
INSERT INTO read_permissions(position, directory) VALUES (265,101);
INSERT INTO read_permissions(position, directory) VALUES (266,101);
INSERT INTO read_permissions(position, directory) VALUES (267,101);
INSERT INTO read_permissions(position, directory) VALUES (268,101);
INSERT INTO read_permissions(position, directory) VALUES (269,101);
INSERT INTO read_permissions(position, directory) VALUES (270,101);
INSERT INTO read_permissions(position, directory) VALUES (271,101);
INSERT INTO read_permissions(position, directory) VALUES (272,101);
INSERT INTO read_permissions(position, directory) VALUES (273,101);
INSERT INTO read_permissions(position, directory) VALUES (274,101);
INSERT INTO read_permissions(position, directory) VALUES (275,101);
INSERT INTO read_permissions(position, directory) VALUES (276,101);
INSERT INTO read_permissions(position, directory) VALUES (277,101);
INSERT INTO read_permissions(position, directory) VALUES (278,101);
INSERT INTO read_permissions(position, directory) VALUES (279,101);
INSERT INTO read_permissions(position, directory) VALUES (280,101);
INSERT INTO read_permissions(position, directory) VALUES (281,101);
INSERT INTO read_permissions(position, directory) VALUES (282,101);
INSERT INTO read_permissions(position, directory) VALUES (283,101);
INSERT INTO read_permissions(position, directory) VALUES (284,101);
INSERT INTO read_permissions(position, directory) VALUES (285,101);
INSERT INTO read_permissions(position, directory) VALUES (286,101);
INSERT INTO read_permissions(position, directory) VALUES (287,101);
INSERT INTO read_permissions(position, directory) VALUES (288,101);
INSERT INTO read_permissions(position, directory) VALUES (289,101);
INSERT INTO read_permissions(position, directory) VALUES (290,101);
INSERT INTO read_permissions(position, directory) VALUES (291,101);
INSERT INTO read_permissions(position, directory) VALUES (292,101);
INSERT INTO read_permissions(position, directory) VALUES (293,101);
INSERT INTO read_permissions(position, directory) VALUES (294,101);
INSERT INTO read_permissions(position, directory) VALUES (295,101);
INSERT INTO read_permissions(position, directory) VALUES (296,101);

INSERT INTO edit_permissions(position, directory) VALUES (1,101);
INSERT INTO edit_permissions(position, directory) VALUES (2,101);
INSERT INTO edit_permissions(position, directory) VALUES (3,101);
INSERT INTO edit_permissions(position, directory) VALUES (4,101);
INSERT INTO edit_permissions(position, directory) VALUES (5,101);
INSERT INTO edit_permissions(position, directory) VALUES (6,101);

--   Rock 'N' CulturRoll Awareness
INSERT INTO read_permissions(position, directory) VALUES (1,102);
INSERT INTO read_permissions(position, directory) VALUES (2,102);
INSERT INTO read_permissions(position, directory) VALUES (3,102);
INSERT INTO read_permissions(position, directory) VALUES (4,102);
INSERT INTO read_permissions(position, directory) VALUES (5,102);
INSERT INTO read_permissions(position, directory) VALUES (6,102);
INSERT INTO read_permissions(position, directory) VALUES (7,102);
INSERT INTO read_permissions(position, directory) VALUES (8,102);
INSERT INTO read_permissions(position, directory) VALUES (9,102);
INSERT INTO read_permissions(position, directory) VALUES (10,102);
INSERT INTO read_permissions(position, directory) VALUES (11,102);
INSERT INTO read_permissions(position, directory) VALUES (12,102);
INSERT INTO read_permissions(position, directory) VALUES (13,102);
INSERT INTO read_permissions(position, directory) VALUES (14,102);
INSERT INTO read_permissions(position, directory) VALUES (15,102);
INSERT INTO read_permissions(position, directory) VALUES (16,102);
INSERT INTO read_permissions(position, directory) VALUES (17,102);
INSERT INTO read_permissions(position, directory) VALUES (18,102);
INSERT INTO read_permissions(position, directory) VALUES (19,102);
INSERT INTO read_permissions(position, directory) VALUES (20,102);
INSERT INTO read_permissions(position, directory) VALUES (21,102);
INSERT INTO read_permissions(position, directory) VALUES (22,102);
INSERT INTO read_permissions(position, directory) VALUES (23,102);
INSERT INTO read_permissions(position, directory) VALUES (24,102);
INSERT INTO read_permissions(position, directory) VALUES (25,102);
INSERT INTO read_permissions(position, directory) VALUES (26,102);
INSERT INTO read_permissions(position, directory) VALUES (27,102);
INSERT INTO read_permissions(position, directory) VALUES (28,102);
INSERT INTO read_permissions(position, directory) VALUES (29,102);
INSERT INTO read_permissions(position, directory) VALUES (30,102);
INSERT INTO read_permissions(position, directory) VALUES (31,102);
INSERT INTO read_permissions(position, directory) VALUES (32,102);
INSERT INTO read_permissions(position, directory) VALUES (33,102);
INSERT INTO read_permissions(position, directory) VALUES (34,102);
INSERT INTO read_permissions(position, directory) VALUES (35,102);
INSERT INTO read_permissions(position, directory) VALUES (36,102);
INSERT INTO read_permissions(position, directory) VALUES (37,102);
INSERT INTO read_permissions(position, directory) VALUES (38,102);
INSERT INTO read_permissions(position, directory) VALUES (39,102);
INSERT INTO read_permissions(position, directory) VALUES (40,102);
INSERT INTO read_permissions(position, directory) VALUES (41,102);
INSERT INTO read_permissions(position, directory) VALUES (42,102);
INSERT INTO read_permissions(position, directory) VALUES (43,102);
INSERT INTO read_permissions(position, directory) VALUES (44,102);
INSERT INTO read_permissions(position, directory) VALUES (45,102);
INSERT INTO read_permissions(position, directory) VALUES (46,102);
INSERT INTO read_permissions(position, directory) VALUES (47,102);
INSERT INTO read_permissions(position, directory) VALUES (48,102);
INSERT INTO read_permissions(position, directory) VALUES (49,102);
INSERT INTO read_permissions(position, directory) VALUES (50,102);
INSERT INTO read_permissions(position, directory) VALUES (51,102);
INSERT INTO read_permissions(position, directory) VALUES (52,102);
INSERT INTO read_permissions(position, directory) VALUES (53,102);
INSERT INTO read_permissions(position, directory) VALUES (54,102);
INSERT INTO read_permissions(position, directory) VALUES (55,102);
INSERT INTO read_permissions(position, directory) VALUES (56,102);
INSERT INTO read_permissions(position, directory) VALUES (57,102);
INSERT INTO read_permissions(position, directory) VALUES (58,102);
INSERT INTO read_permissions(position, directory) VALUES (59,102);
INSERT INTO read_permissions(position, directory) VALUES (60,102);
INSERT INTO read_permissions(position, directory) VALUES (61,102);
INSERT INTO read_permissions(position, directory) VALUES (62,102);
INSERT INTO read_permissions(position, directory) VALUES (63,102);
INSERT INTO read_permissions(position, directory) VALUES (64,102);
INSERT INTO read_permissions(position, directory) VALUES (65,102);
INSERT INTO read_permissions(position, directory) VALUES (66,102);
INSERT INTO read_permissions(position, directory) VALUES (67,102);
INSERT INTO read_permissions(position, directory) VALUES (68,102);
INSERT INTO read_permissions(position, directory) VALUES (69,102);
INSERT INTO read_permissions(position, directory) VALUES (70,102);
INSERT INTO read_permissions(position, directory) VALUES (71,102);
INSERT INTO read_permissions(position, directory) VALUES (72,102);
INSERT INTO read_permissions(position, directory) VALUES (73,102);
INSERT INTO read_permissions(position, directory) VALUES (74,102);
INSERT INTO read_permissions(position, directory) VALUES (75,102);
INSERT INTO read_permissions(position, directory) VALUES (76,102);
INSERT INTO read_permissions(position, directory) VALUES (77,102);
INSERT INTO read_permissions(position, directory) VALUES (78,102);
INSERT INTO read_permissions(position, directory) VALUES (79,102);
INSERT INTO read_permissions(position, directory) VALUES (80,102);
INSERT INTO read_permissions(position, directory) VALUES (81,102);
INSERT INTO read_permissions(position, directory) VALUES (82,102);
INSERT INTO read_permissions(position, directory) VALUES (83,102);
INSERT INTO read_permissions(position, directory) VALUES (84,102);
INSERT INTO read_permissions(position, directory) VALUES (85,102);
INSERT INTO read_permissions(position, directory) VALUES (86,102);
INSERT INTO read_permissions(position, directory) VALUES (87,102);
INSERT INTO read_permissions(position, directory) VALUES (88,102);
INSERT INTO read_permissions(position, directory) VALUES (89,102);
INSERT INTO read_permissions(position, directory) VALUES (90,102);
INSERT INTO read_permissions(position, directory) VALUES (91,102);
INSERT INTO read_permissions(position, directory) VALUES (92,102);
INSERT INTO read_permissions(position, directory) VALUES (93,102);
INSERT INTO read_permissions(position, directory) VALUES (94,102);
INSERT INTO read_permissions(position, directory) VALUES (95,102);
INSERT INTO read_permissions(position, directory) VALUES (96,102);
INSERT INTO read_permissions(position, directory) VALUES (97,102);
INSERT INTO read_permissions(position, directory) VALUES (98,102);
INSERT INTO read_permissions(position, directory) VALUES (99,102);
INSERT INTO read_permissions(position, directory) VALUES (100,102);
INSERT INTO read_permissions(position, directory) VALUES (101,102);
INSERT INTO read_permissions(position, directory) VALUES (102,102);
INSERT INTO read_permissions(position, directory) VALUES (103,102);
INSERT INTO read_permissions(position, directory) VALUES (104,102);
INSERT INTO read_permissions(position, directory) VALUES (105,102);
INSERT INTO read_permissions(position, directory) VALUES (106,102);
INSERT INTO read_permissions(position, directory) VALUES (107,102);
INSERT INTO read_permissions(position, directory) VALUES (108,102);
INSERT INTO read_permissions(position, directory) VALUES (109,102);
INSERT INTO read_permissions(position, directory) VALUES (110,102);
INSERT INTO read_permissions(position, directory) VALUES (111,102);
INSERT INTO read_permissions(position, directory) VALUES (112,102);
INSERT INTO read_permissions(position, directory) VALUES (113,102);
INSERT INTO read_permissions(position, directory) VALUES (114,102);
INSERT INTO read_permissions(position, directory) VALUES (115,102);
INSERT INTO read_permissions(position, directory) VALUES (116,102);
INSERT INTO read_permissions(position, directory) VALUES (117,102);
INSERT INTO read_permissions(position, directory) VALUES (118,102);
INSERT INTO read_permissions(position, directory) VALUES (119,102);
INSERT INTO read_permissions(position, directory) VALUES (120,102);
INSERT INTO read_permissions(position, directory) VALUES (121,102);
INSERT INTO read_permissions(position, directory) VALUES (122,102);
INSERT INTO read_permissions(position, directory) VALUES (123,102);
INSERT INTO read_permissions(position, directory) VALUES (124,102);

INSERT INTO read_permissions(position, directory) VALUES (125,102);
INSERT INTO read_permissions(position, directory) VALUES (126,102);
INSERT INTO read_permissions(position, directory) VALUES (127,102);
INSERT INTO read_permissions(position, directory) VALUES (128,102);
INSERT INTO read_permissions(position, directory) VALUES (129,102);
INSERT INTO read_permissions(position, directory) VALUES (130,102);
INSERT INTO read_permissions(position, directory) VALUES (131,102);
INSERT INTO read_permissions(position, directory) VALUES (132,102);
INSERT INTO read_permissions(position, directory) VALUES (133,102);
INSERT INTO read_permissions(position, directory) VALUES (134,102);
INSERT INTO read_permissions(position, directory) VALUES (135,102);
INSERT INTO read_permissions(position, directory) VALUES (136,102);
INSERT INTO read_permissions(position, directory) VALUES (137,102);
INSERT INTO read_permissions(position, directory) VALUES (138,102);
INSERT INTO read_permissions(position, directory) VALUES (139,102);
INSERT INTO read_permissions(position, directory) VALUES (140,102);
INSERT INTO read_permissions(position, directory) VALUES (141,102);
INSERT INTO read_permissions(position, directory) VALUES (142,102);
INSERT INTO read_permissions(position, directory) VALUES (143,102);
INSERT INTO read_permissions(position, directory) VALUES (144,102);
INSERT INTO read_permissions(position, directory) VALUES (145,102);
INSERT INTO read_permissions(position, directory) VALUES (146,102);
INSERT INTO read_permissions(position, directory) VALUES (147,102);
INSERT INTO read_permissions(position, directory) VALUES (148,102);
INSERT INTO read_permissions(position, directory) VALUES (149,102);
INSERT INTO read_permissions(position, directory) VALUES (150,102);
INSERT INTO read_permissions(position, directory) VALUES (151,102);
INSERT INTO read_permissions(position, directory) VALUES (152,102);
INSERT INTO read_permissions(position, directory) VALUES (153,102);
INSERT INTO read_permissions(position, directory) VALUES (154,102);
INSERT INTO read_permissions(position, directory) VALUES (155,102);
INSERT INTO read_permissions(position, directory) VALUES (156,102);
INSERT INTO read_permissions(position, directory) VALUES (157,102);
INSERT INTO read_permissions(position, directory) VALUES (158,102);
INSERT INTO read_permissions(position, directory) VALUES (159,102);
INSERT INTO read_permissions(position, directory) VALUES (160,102);
INSERT INTO read_permissions(position, directory) VALUES (161,102);
INSERT INTO read_permissions(position, directory) VALUES (162,102);
INSERT INTO read_permissions(position, directory) VALUES (163,102);
INSERT INTO read_permissions(position, directory) VALUES (164,102);
INSERT INTO read_permissions(position, directory) VALUES (165,102);
INSERT INTO read_permissions(position, directory) VALUES (166,102);
INSERT INTO read_permissions(position, directory) VALUES (167,102);
INSERT INTO read_permissions(position, directory) VALUES (168,102);
INSERT INTO read_permissions(position, directory) VALUES (169,102);
INSERT INTO read_permissions(position, directory) VALUES (170,102);
INSERT INTO read_permissions(position, directory) VALUES (171,102);
INSERT INTO read_permissions(position, directory) VALUES (172,102);
INSERT INTO read_permissions(position, directory) VALUES (173,102);
INSERT INTO read_permissions(position, directory) VALUES (174,102);
INSERT INTO read_permissions(position, directory) VALUES (175,102);
INSERT INTO read_permissions(position, directory) VALUES (176,102);

INSERT INTO read_permissions(position, directory) VALUES (177,102);
INSERT INTO read_permissions(position, directory) VALUES (178,102);
INSERT INTO read_permissions(position, directory) VALUES (179,102);
INSERT INTO read_permissions(position, directory) VALUES (180,102);
INSERT INTO read_permissions(position, directory) VALUES (181,102);
INSERT INTO read_permissions(position, directory) VALUES (182,102);
INSERT INTO read_permissions(position, directory) VALUES (183,102);
INSERT INTO read_permissions(position, directory) VALUES (184,102);
INSERT INTO read_permissions(position, directory) VALUES (185,102);
INSERT INTO read_permissions(position, directory) VALUES (186,102);
INSERT INTO read_permissions(position, directory) VALUES (187,102);
INSERT INTO read_permissions(position, directory) VALUES (188,102);
INSERT INTO read_permissions(position, directory) VALUES (189,102);
INSERT INTO read_permissions(position, directory) VALUES (190,102);
INSERT INTO read_permissions(position, directory) VALUES (191,102);
INSERT INTO read_permissions(position, directory) VALUES (192,102);
INSERT INTO read_permissions(position, directory) VALUES (193,102);
INSERT INTO read_permissions(position, directory) VALUES (194,102);
INSERT INTO read_permissions(position, directory) VALUES (195,102);
INSERT INTO read_permissions(position, directory) VALUES (196,102);
INSERT INTO read_permissions(position, directory) VALUES (197,102);
INSERT INTO read_permissions(position, directory) VALUES (198,102);
INSERT INTO read_permissions(position, directory) VALUES (199,102);
INSERT INTO read_permissions(position, directory) VALUES (200,102);
INSERT INTO read_permissions(position, directory) VALUES (201,102);
INSERT INTO read_permissions(position, directory) VALUES (202,102);
INSERT INTO read_permissions(position, directory) VALUES (203,102);
INSERT INTO read_permissions(position, directory) VALUES (204,102);
INSERT INTO read_permissions(position, directory) VALUES (205,102);
INSERT INTO read_permissions(position, directory) VALUES (206,102);
INSERT INTO read_permissions(position, directory) VALUES (207,102);
INSERT INTO read_permissions(position, directory) VALUES (208,102);
INSERT INTO read_permissions(position, directory) VALUES (209,102);
INSERT INTO read_permissions(position, directory) VALUES (210,102);
INSERT INTO read_permissions(position, directory) VALUES (211,102);
INSERT INTO read_permissions(position, directory) VALUES (212,102);
INSERT INTO read_permissions(position, directory) VALUES (213,102);
INSERT INTO read_permissions(position, directory) VALUES (214,102);
INSERT INTO read_permissions(position, directory) VALUES (215,102);
INSERT INTO read_permissions(position, directory) VALUES (216,102);
INSERT INTO read_permissions(position, directory) VALUES (217,102);
INSERT INTO read_permissions(position, directory) VALUES (218,102);
INSERT INTO read_permissions(position, directory) VALUES (219,102);
INSERT INTO read_permissions(position, directory) VALUES (220,102);
INSERT INTO read_permissions(position, directory) VALUES (221,102);
INSERT INTO read_permissions(position, directory) VALUES (222,102);
INSERT INTO read_permissions(position, directory) VALUES (223,102);
INSERT INTO read_permissions(position, directory) VALUES (224,102);
INSERT INTO read_permissions(position, directory) VALUES (225,102);
INSERT INTO read_permissions(position, directory) VALUES (226,102);
INSERT INTO read_permissions(position, directory) VALUES (227,102);
INSERT INTO read_permissions(position, directory) VALUES (228,102);
INSERT INTO read_permissions(position, directory) VALUES (229,102);
INSERT INTO read_permissions(position, directory) VALUES (230,102);
INSERT INTO read_permissions(position, directory) VALUES (231,102);
INSERT INTO read_permissions(position, directory) VALUES (232,102);
INSERT INTO read_permissions(position, directory) VALUES (233,102);
INSERT INTO read_permissions(position, directory) VALUES (234,102);
INSERT INTO read_permissions(position, directory) VALUES (235,102);
INSERT INTO read_permissions(position, directory) VALUES (236,102);
INSERT INTO read_permissions(position, directory) VALUES (237,102);
INSERT INTO read_permissions(position, directory) VALUES (238,102);
INSERT INTO read_permissions(position, directory) VALUES (239,102);
INSERT INTO read_permissions(position, directory) VALUES (240,102);
INSERT INTO read_permissions(position, directory) VALUES (241,102);
INSERT INTO read_permissions(position, directory) VALUES (242,102);
INSERT INTO read_permissions(position, directory) VALUES (243,102);
INSERT INTO read_permissions(position, directory) VALUES (244,102);
INSERT INTO read_permissions(position, directory) VALUES (245,102);
INSERT INTO read_permissions(position, directory) VALUES (246,102);
INSERT INTO read_permissions(position, directory) VALUES (247,102);
INSERT INTO read_permissions(position, directory) VALUES (248,102);
INSERT INTO read_permissions(position, directory) VALUES (249,102);
INSERT INTO read_permissions(position, directory) VALUES (250,102);
INSERT INTO read_permissions(position, directory) VALUES (251,102);
INSERT INTO read_permissions(position, directory) VALUES (252,102);
INSERT INTO read_permissions(position, directory) VALUES (253,102);
INSERT INTO read_permissions(position, directory) VALUES (254,102);
INSERT INTO read_permissions(position, directory) VALUES (255,102);
INSERT INTO read_permissions(position, directory) VALUES (256,102);
INSERT INTO read_permissions(position, directory) VALUES (257,102);
INSERT INTO read_permissions(position, directory) VALUES (258,102);
INSERT INTO read_permissions(position, directory) VALUES (259,102);
INSERT INTO read_permissions(position, directory) VALUES (260,102);
INSERT INTO read_permissions(position, directory) VALUES (261,102);
INSERT INTO read_permissions(position, directory) VALUES (262,102);
INSERT INTO read_permissions(position, directory) VALUES (263,102);
INSERT INTO read_permissions(position, directory) VALUES (264,102);
INSERT INTO read_permissions(position, directory) VALUES (265,102);
INSERT INTO read_permissions(position, directory) VALUES (266,102);
INSERT INTO read_permissions(position, directory) VALUES (267,102);
INSERT INTO read_permissions(position, directory) VALUES (268,102);
INSERT INTO read_permissions(position, directory) VALUES (269,102);
INSERT INTO read_permissions(position, directory) VALUES (270,102);
INSERT INTO read_permissions(position, directory) VALUES (271,102);
INSERT INTO read_permissions(position, directory) VALUES (272,102);
INSERT INTO read_permissions(position, directory) VALUES (273,102);
INSERT INTO read_permissions(position, directory) VALUES (274,102);
INSERT INTO read_permissions(position, directory) VALUES (275,102);
INSERT INTO read_permissions(position, directory) VALUES (276,102);
INSERT INTO read_permissions(position, directory) VALUES (277,102);
INSERT INTO read_permissions(position, directory) VALUES (278,102);
INSERT INTO read_permissions(position, directory) VALUES (279,102);
INSERT INTO read_permissions(position, directory) VALUES (280,102);
INSERT INTO read_permissions(position, directory) VALUES (281,102);
INSERT INTO read_permissions(position, directory) VALUES (282,102);
INSERT INTO read_permissions(position, directory) VALUES (283,102);
INSERT INTO read_permissions(position, directory) VALUES (284,102);
INSERT INTO read_permissions(position, directory) VALUES (285,102);
INSERT INTO read_permissions(position, directory) VALUES (286,102);
INSERT INTO read_permissions(position, directory) VALUES (287,102);
INSERT INTO read_permissions(position, directory) VALUES (288,102);
INSERT INTO read_permissions(position, directory) VALUES (289,102);
INSERT INTO read_permissions(position, directory) VALUES (290,102);
INSERT INTO read_permissions(position, directory) VALUES (291,102);
INSERT INTO read_permissions(position, directory) VALUES (292,102);
INSERT INTO read_permissions(position, directory) VALUES (293,102);
INSERT INTO read_permissions(position, directory) VALUES (294,102);
INSERT INTO read_permissions(position, directory) VALUES (295,102);
INSERT INTO read_permissions(position, directory) VALUES (296,102);

INSERT INTO edit_permissions(position, directory) VALUES (1,102);
INSERT INTO edit_permissions(position, directory) VALUES (2,102);
INSERT INTO edit_permissions(position, directory) VALUES (3,102);
INSERT INTO edit_permissions(position, directory) VALUES (4,102);
INSERT INTO edit_permissions(position, directory) VALUES (5,102);
INSERT INTO edit_permissions(position, directory) VALUES (6,102);

-- American Education Group/Schools/Fusion Division/Huntington Beach/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (34, 103);
INSERT INTO read_permissions(position, directory) VALUES (35, 103);
INSERT INTO read_permissions(position, directory) VALUES (36, 103);
INSERT INTO read_permissions(position, directory) VALUES (37, 103);
INSERT INTO read_permissions(position, directory) VALUES (38, 103);
INSERT INTO read_permissions(position, directory) VALUES (39, 103);
INSERT INTO read_permissions(position, directory) VALUES (40, 103);
INSERT INTO read_permissions(position, directory) VALUES (41, 103);
INSERT INTO read_permissions(position, directory) VALUES (42, 103);
INSERT INTO read_permissions(position, directory) VALUES (43, 103);
INSERT INTO read_permissions(position, directory) VALUES (44, 103);
INSERT INTO read_permissions(position, directory) VALUES (45, 103);
INSERT INTO read_permissions(position, directory) VALUES (46, 103);

INSERT INTO edit_permissions(position, directory) VALUES (34, 103);
INSERT INTO edit_permissions(position, directory) VALUES (35, 103);
INSERT INTO edit_permissions(position, directory) VALUES (36, 103);
INSERT INTO edit_permissions(position, directory) VALUES (37, 103);
INSERT INTO edit_permissions(position, directory) VALUES (38, 103);
INSERT INTO edit_permissions(position, directory) VALUES (39, 103);
INSERT INTO edit_permissions(position, directory) VALUES (40, 103);
INSERT INTO edit_permissions(position, directory) VALUES (41, 103);
INSERT INTO edit_permissions(position, directory) VALUES (42, 103);
INSERT INTO edit_permissions(position, directory) VALUES (43, 103);
INSERT INTO edit_permissions(position, directory) VALUES (44, 103);
INSERT INTO edit_permissions(position, directory) VALUES (45, 103);
INSERT INTO edit_permissions(position, directory) VALUES (46, 103);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (34, 104);
INSERT INTO edit_permissions(position, directory) VALUES (35, 104);
INSERT INTO edit_permissions(position, directory) VALUES (36, 104);
INSERT INTO edit_permissions(position, directory) VALUES (37, 104);
INSERT INTO edit_permissions(position, directory) VALUES (38, 104);
INSERT INTO edit_permissions(position, directory) VALUES (39, 104);
INSERT INTO edit_permissions(position, directory) VALUES (40, 104);
INSERT INTO edit_permissions(position, directory) VALUES (41, 104);
INSERT INTO edit_permissions(position, directory) VALUES (42, 104);
INSERT INTO edit_permissions(position, directory) VALUES (43, 104);
INSERT INTO edit_permissions(position, directory) VALUES (44, 104);
INSERT INTO edit_permissions(position, directory) VALUES (45, 104);
INSERT INTO edit_permissions(position, directory) VALUES (46, 104);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (34, 105);
INSERT INTO read_permissions(position, directory) VALUES (36, 105);
INSERT INTO read_permissions(position, directory) VALUES (37, 105);
INSERT INTO read_permissions(position, directory) VALUES (38, 105);
INSERT INTO read_permissions(position, directory) VALUES (39, 105);
INSERT INTO read_permissions(position, directory) VALUES (41, 105);
INSERT INTO read_permissions(position, directory) VALUES (43, 105);

INSERT INTO edit_permissions(position, directory) VALUES (34, 105);
INSERT INTO edit_permissions(position, directory) VALUES (36, 105);
INSERT INTO edit_permissions(position, directory) VALUES (37, 105);
INSERT INTO edit_permissions(position, directory) VALUES (38, 105);
INSERT INTO edit_permissions(position, directory) VALUES (39, 105);
INSERT INTO edit_permissions(position, directory) VALUES (41, 105);
INSERT INTO edit_permissions(position, directory) VALUES (43, 105);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (41, 106);

INSERT INTO edit_permissions(position, directory) VALUES (41, 106);

-- American Education Group/Schools/Fusion Division/Long Island/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (47, 107);
INSERT INTO read_permissions(position, directory) VALUES (48, 107);
INSERT INTO read_permissions(position, directory) VALUES (49, 107);
INSERT INTO read_permissions(position, directory) VALUES (50, 107);
INSERT INTO read_permissions(position, directory) VALUES (51, 107);
INSERT INTO read_permissions(position, directory) VALUES (52, 107);
INSERT INTO read_permissions(position, directory) VALUES (53, 107);
INSERT INTO read_permissions(position, directory) VALUES (54, 107);
INSERT INTO read_permissions(position, directory) VALUES (55, 107);
INSERT INTO read_permissions(position, directory) VALUES (56, 107);
INSERT INTO read_permissions(position, directory) VALUES (57, 107);
INSERT INTO read_permissions(position, directory) VALUES (58, 107);
INSERT INTO read_permissions(position, directory) VALUES (59, 107);

INSERT INTO edit_permissions(position, directory) VALUES (47, 107);
INSERT INTO edit_permissions(position, directory) VALUES (48, 107);
INSERT INTO edit_permissions(position, directory) VALUES (49, 107);
INSERT INTO edit_permissions(position, directory) VALUES (50, 107);
INSERT INTO edit_permissions(position, directory) VALUES (51, 107);
INSERT INTO edit_permissions(position, directory) VALUES (52, 107);
INSERT INTO edit_permissions(position, directory) VALUES (53, 107);
INSERT INTO edit_permissions(position, directory) VALUES (54, 107);
INSERT INTO edit_permissions(position, directory) VALUES (55, 107);
INSERT INTO edit_permissions(position, directory) VALUES (56, 107);
INSERT INTO edit_permissions(position, directory) VALUES (57, 107);
INSERT INTO edit_permissions(position, directory) VALUES (58, 107);
INSERT INTO edit_permissions(position, directory) VALUES (59, 107);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (47, 108);
INSERT INTO edit_permissions(position, directory) VALUES (48, 108);
INSERT INTO edit_permissions(position, directory) VALUES (49, 108);
INSERT INTO edit_permissions(position, directory) VALUES (50, 108);
INSERT INTO edit_permissions(position, directory) VALUES (51, 108);
INSERT INTO edit_permissions(position, directory) VALUES (52, 108);
INSERT INTO edit_permissions(position, directory) VALUES (53, 108);
INSERT INTO edit_permissions(position, directory) VALUES (54, 108);
INSERT INTO edit_permissions(position, directory) VALUES (55, 108);
INSERT INTO edit_permissions(position, directory) VALUES (56, 108);
INSERT INTO edit_permissions(position, directory) VALUES (57, 108);
INSERT INTO edit_permissions(position, directory) VALUES (58, 108);
INSERT INTO edit_permissions(position, directory) VALUES (59, 108);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (47, 109);
INSERT INTO read_permissions(position, directory) VALUES (49, 109);
INSERT INTO read_permissions(position, directory) VALUES (50, 109);
INSERT INTO read_permissions(position, directory) VALUES (51, 109);
INSERT INTO read_permissions(position, directory) VALUES (52, 109);
INSERT INTO read_permissions(position, directory) VALUES (54, 109);
INSERT INTO read_permissions(position, directory) VALUES (56, 109);

INSERT INTO edit_permissions(position, directory) VALUES (47, 109);
INSERT INTO edit_permissions(position, directory) VALUES (49, 109);
INSERT INTO edit_permissions(position, directory) VALUES (50, 109);
INSERT INTO edit_permissions(position, directory) VALUES (51, 109);
INSERT INTO edit_permissions(position, directory) VALUES (52, 109);
INSERT INTO edit_permissions(position, directory) VALUES (54, 109);
INSERT INTO edit_permissions(position, directory) VALUES (56, 109);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (54, 110);

INSERT INTO edit_permissions(position, directory) VALUES (54, 110);

-- American Education Group/Schools/Fusion Division/Los Angeles/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (60, 111);
INSERT INTO read_permissions(position, directory) VALUES (61, 111);
INSERT INTO read_permissions(position, directory) VALUES (62, 111);
INSERT INTO read_permissions(position, directory) VALUES (63, 111);
INSERT INTO read_permissions(position, directory) VALUES (64, 111);
INSERT INTO read_permissions(position, directory) VALUES (65, 111);
INSERT INTO read_permissions(position, directory) VALUES (66, 111);
INSERT INTO read_permissions(position, directory) VALUES (67, 111);
INSERT INTO read_permissions(position, directory) VALUES (68, 111);
INSERT INTO read_permissions(position, directory) VALUES (69, 111);
INSERT INTO read_permissions(position, directory) VALUES (70, 111);
INSERT INTO read_permissions(position, directory) VALUES (71, 111);
INSERT INTO read_permissions(position, directory) VALUES (72, 111);

INSERT INTO edit_permissions(position, directory) VALUES (60, 111);
INSERT INTO edit_permissions(position, directory) VALUES (61, 111);
INSERT INTO edit_permissions(position, directory) VALUES (62, 111);
INSERT INTO edit_permissions(position, directory) VALUES (63, 111);
INSERT INTO edit_permissions(position, directory) VALUES (64, 111);
INSERT INTO edit_permissions(position, directory) VALUES (65, 111);
INSERT INTO edit_permissions(position, directory) VALUES (66, 111);
INSERT INTO edit_permissions(position, directory) VALUES (67, 111);
INSERT INTO edit_permissions(position, directory) VALUES (68, 111);
INSERT INTO edit_permissions(position, directory) VALUES (69, 111);
INSERT INTO edit_permissions(position, directory) VALUES (70, 111);
INSERT INTO edit_permissions(position, directory) VALUES (71, 111);
INSERT INTO edit_permissions(position, directory) VALUES (72, 111);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (60, 112);
INSERT INTO edit_permissions(position, directory) VALUES (61, 112);
INSERT INTO edit_permissions(position, directory) VALUES (62, 112);
INSERT INTO edit_permissions(position, directory) VALUES (63, 112);
INSERT INTO edit_permissions(position, directory) VALUES (64, 112);
INSERT INTO edit_permissions(position, directory) VALUES (65, 112);
INSERT INTO edit_permissions(position, directory) VALUES (66, 112);
INSERT INTO edit_permissions(position, directory) VALUES (67, 112);
INSERT INTO edit_permissions(position, directory) VALUES (68, 112);
INSERT INTO edit_permissions(position, directory) VALUES (69, 112);
INSERT INTO edit_permissions(position, directory) VALUES (70, 112);
INSERT INTO edit_permissions(position, directory) VALUES (71, 112);
INSERT INTO edit_permissions(position, directory) VALUES (72, 112);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (60, 113);
INSERT INTO read_permissions(position, directory) VALUES (62, 113);
INSERT INTO read_permissions(position, directory) VALUES (63, 113);
INSERT INTO read_permissions(position, directory) VALUES (64, 113);
INSERT INTO read_permissions(position, directory) VALUES (65, 113);
INSERT INTO read_permissions(position, directory) VALUES (67, 113);
INSERT INTO read_permissions(position, directory) VALUES (69, 113);

INSERT INTO edit_permissions(position, directory) VALUES (60, 113);
INSERT INTO edit_permissions(position, directory) VALUES (62, 113);
INSERT INTO edit_permissions(position, directory) VALUES (63, 113);
INSERT INTO edit_permissions(position, directory) VALUES (64, 113);
INSERT INTO edit_permissions(position, directory) VALUES (65, 113);
INSERT INTO edit_permissions(position, directory) VALUES (67, 113);
INSERT INTO edit_permissions(position, directory) VALUES (69, 113);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (67, 114);

INSERT INTO edit_permissions(position, directory) VALUES (67, 114);

-- American Education Group/Schools/Fusion Division/Los Gatos/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (73, 115);
INSERT INTO read_permissions(position, directory) VALUES (74, 115);
INSERT INTO read_permissions(position, directory) VALUES (75, 115);
INSERT INTO read_permissions(position, directory) VALUES (76, 115);
INSERT INTO read_permissions(position, directory) VALUES (77, 115);
INSERT INTO read_permissions(position, directory) VALUES (78, 115);
INSERT INTO read_permissions(position, directory) VALUES (79, 115);
INSERT INTO read_permissions(position, directory) VALUES (80, 115);
INSERT INTO read_permissions(position, directory) VALUES (81, 115);
INSERT INTO read_permissions(position, directory) VALUES (82, 115);
INSERT INTO read_permissions(position, directory) VALUES (83, 115);
INSERT INTO read_permissions(position, directory) VALUES (84, 115);
INSERT INTO read_permissions(position, directory) VALUES (85, 115);

INSERT INTO edit_permissions(position, directory) VALUES (73, 115);
INSERT INTO edit_permissions(position, directory) VALUES (74, 115);
INSERT INTO edit_permissions(position, directory) VALUES (75, 115);
INSERT INTO edit_permissions(position, directory) VALUES (76, 115);
INSERT INTO edit_permissions(position, directory) VALUES (77, 115);
INSERT INTO edit_permissions(position, directory) VALUES (78, 115);
INSERT INTO edit_permissions(position, directory) VALUES (79, 115);
INSERT INTO edit_permissions(position, directory) VALUES (80, 115);
INSERT INTO edit_permissions(position, directory) VALUES (81, 115);
INSERT INTO edit_permissions(position, directory) VALUES (82, 115);
INSERT INTO edit_permissions(position, directory) VALUES (83, 115);
INSERT INTO edit_permissions(position, directory) VALUES (84, 115);
INSERT INTO edit_permissions(position, directory) VALUES (85, 115);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (73, 116);
INSERT INTO edit_permissions(position, directory) VALUES (74, 116);
INSERT INTO edit_permissions(position, directory) VALUES (75, 116);
INSERT INTO edit_permissions(position, directory) VALUES (76, 116);
INSERT INTO edit_permissions(position, directory) VALUES (77, 116);
INSERT INTO edit_permissions(position, directory) VALUES (78, 116);
INSERT INTO edit_permissions(position, directory) VALUES (79, 116);
INSERT INTO edit_permissions(position, directory) VALUES (80, 116);
INSERT INTO edit_permissions(position, directory) VALUES (81, 116);
INSERT INTO edit_permissions(position, directory) VALUES (82, 116);
INSERT INTO edit_permissions(position, directory) VALUES (83, 116);
INSERT INTO edit_permissions(position, directory) VALUES (84, 116);
INSERT INTO edit_permissions(position, directory) VALUES (85, 116);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (73, 117);
INSERT INTO read_permissions(position, directory) VALUES (75, 117);
INSERT INTO read_permissions(position, directory) VALUES (76, 117);
INSERT INTO read_permissions(position, directory) VALUES (77, 117);
INSERT INTO read_permissions(position, directory) VALUES (78, 117);
INSERT INTO read_permissions(position, directory) VALUES (80, 117);
INSERT INTO read_permissions(position, directory) VALUES (82, 117);

INSERT INTO edit_permissions(position, directory) VALUES (73, 117);
INSERT INTO edit_permissions(position, directory) VALUES (75, 117);
INSERT INTO edit_permissions(position, directory) VALUES (76, 117);
INSERT INTO edit_permissions(position, directory) VALUES (77, 117);
INSERT INTO edit_permissions(position, directory) VALUES (78, 117);
INSERT INTO edit_permissions(position, directory) VALUES (80, 117);
INSERT INTO edit_permissions(position, directory) VALUES (82, 117);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (80, 118);

INSERT INTO edit_permissions(position, directory) VALUES (80, 118);

-- American Education Group/Schools/Fusion Division/Manhattan/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (86, 119);
INSERT INTO read_permissions(position, directory) VALUES (87, 119);
INSERT INTO read_permissions(position, directory) VALUES (88, 119);
INSERT INTO read_permissions(position, directory) VALUES (89, 119);
INSERT INTO read_permissions(position, directory) VALUES (90, 119);
INSERT INTO read_permissions(position, directory) VALUES (91, 119);
INSERT INTO read_permissions(position, directory) VALUES (92, 119);
INSERT INTO read_permissions(position, directory) VALUES (93, 119);
INSERT INTO read_permissions(position, directory) VALUES (94, 119);
INSERT INTO read_permissions(position, directory) VALUES (95, 119);
INSERT INTO read_permissions(position, directory) VALUES (96, 119);
INSERT INTO read_permissions(position, directory) VALUES (97, 119);
INSERT INTO read_permissions(position, directory) VALUES (98, 119);

INSERT INTO edit_permissions(position, directory) VALUES (86, 119);
INSERT INTO edit_permissions(position, directory) VALUES (87, 119);
INSERT INTO edit_permissions(position, directory) VALUES (88, 119);
INSERT INTO edit_permissions(position, directory) VALUES (89, 119);
INSERT INTO edit_permissions(position, directory) VALUES (90, 119);
INSERT INTO edit_permissions(position, directory) VALUES (91, 119);
INSERT INTO edit_permissions(position, directory) VALUES (92, 119);
INSERT INTO edit_permissions(position, directory) VALUES (93, 119);
INSERT INTO edit_permissions(position, directory) VALUES (94, 119);
INSERT INTO edit_permissions(position, directory) VALUES (95, 119);
INSERT INTO edit_permissions(position, directory) VALUES (96, 119);
INSERT INTO edit_permissions(position, directory) VALUES (97, 119);
INSERT INTO edit_permissions(position, directory) VALUES (98, 119);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (86, 120);
INSERT INTO edit_permissions(position, directory) VALUES (87, 120);
INSERT INTO edit_permissions(position, directory) VALUES (88, 120);
INSERT INTO edit_permissions(position, directory) VALUES (89, 120);
INSERT INTO edit_permissions(position, directory) VALUES (90, 120);
INSERT INTO edit_permissions(position, directory) VALUES (91, 120);
INSERT INTO edit_permissions(position, directory) VALUES (92, 120);
INSERT INTO edit_permissions(position, directory) VALUES (93, 120);
INSERT INTO edit_permissions(position, directory) VALUES (94, 120);
INSERT INTO edit_permissions(position, directory) VALUES (95, 120);
INSERT INTO edit_permissions(position, directory) VALUES (96, 120);
INSERT INTO edit_permissions(position, directory) VALUES (97, 120);
INSERT INTO edit_permissions(position, directory) VALUES (98, 120);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (86, 121);
INSERT INTO read_permissions(position, directory) VALUES (88, 121);
INSERT INTO read_permissions(position, directory) VALUES (89, 121);
INSERT INTO read_permissions(position, directory) VALUES (90, 121);
INSERT INTO read_permissions(position, directory) VALUES (91, 121);
INSERT INTO read_permissions(position, directory) VALUES (93, 121);
INSERT INTO read_permissions(position, directory) VALUES (95, 121);

INSERT INTO edit_permissions(position, directory) VALUES (86, 121);
INSERT INTO edit_permissions(position, directory) VALUES (88, 121);
INSERT INTO edit_permissions(position, directory) VALUES (89, 121);
INSERT INTO edit_permissions(position, directory) VALUES (90, 121);
INSERT INTO edit_permissions(position, directory) VALUES (91, 121);
INSERT INTO edit_permissions(position, directory) VALUES (93, 121);
INSERT INTO edit_permissions(position, directory) VALUES (95, 121);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (93, 122);

INSERT INTO edit_permissions(position, directory) VALUES (93, 122);

-- American Education Group/Schools/Fusion Division/Mission Viejo/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (99, 123);
INSERT INTO read_permissions(position, directory) VALUES (100, 123);
INSERT INTO read_permissions(position, directory) VALUES (101, 123);
INSERT INTO read_permissions(position, directory) VALUES (102, 123);
INSERT INTO read_permissions(position, directory) VALUES (103, 123);
INSERT INTO read_permissions(position, directory) VALUES (104, 123);
INSERT INTO read_permissions(position, directory) VALUES (105, 123);
INSERT INTO read_permissions(position, directory) VALUES (106, 123);
INSERT INTO read_permissions(position, directory) VALUES (107, 123);
INSERT INTO read_permissions(position, directory) VALUES (108, 123);
INSERT INTO read_permissions(position, directory) VALUES (109, 123);
INSERT INTO read_permissions(position, directory) VALUES (110, 123);
INSERT INTO read_permissions(position, directory) VALUES (111, 123);

INSERT INTO edit_permissions(position, directory) VALUES (99, 123);
INSERT INTO edit_permissions(position, directory) VALUES (100, 123);
INSERT INTO edit_permissions(position, directory) VALUES (101, 123);
INSERT INTO edit_permissions(position, directory) VALUES (102, 123);
INSERT INTO edit_permissions(position, directory) VALUES (103, 123);
INSERT INTO edit_permissions(position, directory) VALUES (104, 123);
INSERT INTO edit_permissions(position, directory) VALUES (105, 123);
INSERT INTO edit_permissions(position, directory) VALUES (106, 123);
INSERT INTO edit_permissions(position, directory) VALUES (107, 123);
INSERT INTO edit_permissions(position, directory) VALUES (108, 123);
INSERT INTO edit_permissions(position, directory) VALUES (109, 123);
INSERT INTO edit_permissions(position, directory) VALUES (110, 123);
INSERT INTO edit_permissions(position, directory) VALUES (111, 123);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (99, 124);
INSERT INTO edit_permissions(position, directory) VALUES (100, 124);
INSERT INTO edit_permissions(position, directory) VALUES (101, 124);
INSERT INTO edit_permissions(position, directory) VALUES (102, 124);
INSERT INTO edit_permissions(position, directory) VALUES (103, 124);
INSERT INTO edit_permissions(position, directory) VALUES (104, 124);
INSERT INTO edit_permissions(position, directory) VALUES (105, 124);
INSERT INTO edit_permissions(position, directory) VALUES (106, 124);
INSERT INTO edit_permissions(position, directory) VALUES (107, 124);
INSERT INTO edit_permissions(position, directory) VALUES (108, 124);
INSERT INTO edit_permissions(position, directory) VALUES (109, 124);
INSERT INTO edit_permissions(position, directory) VALUES (110, 124);
INSERT INTO edit_permissions(position, directory) VALUES (111, 124);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (99, 125);
INSERT INTO read_permissions(position, directory) VALUES (101, 125);
INSERT INTO read_permissions(position, directory) VALUES (102, 125);
INSERT INTO read_permissions(position, directory) VALUES (103, 125);
INSERT INTO read_permissions(position, directory) VALUES (104, 125);
INSERT INTO read_permissions(position, directory) VALUES (106, 125);
INSERT INTO read_permissions(position, directory) VALUES (108, 125);

INSERT INTO edit_permissions(position, directory) VALUES (99, 125);
INSERT INTO edit_permissions(position, directory) VALUES (101, 125);
INSERT INTO edit_permissions(position, directory) VALUES (102, 125);
INSERT INTO edit_permissions(position, directory) VALUES (103, 125);
INSERT INTO edit_permissions(position, directory) VALUES (104, 125);
INSERT INTO edit_permissions(position, directory) VALUES (106, 125);
INSERT INTO edit_permissions(position, directory) VALUES (108, 125);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (106, 126);

INSERT INTO edit_permissions(position, directory) VALUES (106, 126);

-- American Education Group/Schools/Fusion Division/Pasadena/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (112, 127);
INSERT INTO read_permissions(position, directory) VALUES (113, 127);
INSERT INTO read_permissions(position, directory) VALUES (114, 127);
INSERT INTO read_permissions(position, directory) VALUES (115, 127);
INSERT INTO read_permissions(position, directory) VALUES (116, 127);
INSERT INTO read_permissions(position, directory) VALUES (117, 127);
INSERT INTO read_permissions(position, directory) VALUES (118, 127);
INSERT INTO read_permissions(position, directory) VALUES (119, 127);
INSERT INTO read_permissions(position, directory) VALUES (120, 127);
INSERT INTO read_permissions(position, directory) VALUES (121, 127);
INSERT INTO read_permissions(position, directory) VALUES (122, 127);
INSERT INTO read_permissions(position, directory) VALUES (123, 127);
INSERT INTO read_permissions(position, directory) VALUES (124, 127);

INSERT INTO edit_permissions(position, directory) VALUES (112, 127);
INSERT INTO edit_permissions(position, directory) VALUES (113, 127);
INSERT INTO edit_permissions(position, directory) VALUES (114, 127);
INSERT INTO edit_permissions(position, directory) VALUES (115, 127);
INSERT INTO edit_permissions(position, directory) VALUES (116, 127);
INSERT INTO edit_permissions(position, directory) VALUES (117, 127);
INSERT INTO edit_permissions(position, directory) VALUES (118, 127);
INSERT INTO edit_permissions(position, directory) VALUES (119, 127);
INSERT INTO edit_permissions(position, directory) VALUES (120, 127);
INSERT INTO edit_permissions(position, directory) VALUES (121, 127);
INSERT INTO edit_permissions(position, directory) VALUES (122, 127);
INSERT INTO edit_permissions(position, directory) VALUES (123, 127);
INSERT INTO edit_permissions(position, directory) VALUES (124, 127);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (112, 128);
INSERT INTO edit_permissions(position, directory) VALUES (113, 128);
INSERT INTO edit_permissions(position, directory) VALUES (114, 128);
INSERT INTO edit_permissions(position, directory) VALUES (115, 128);
INSERT INTO edit_permissions(position, directory) VALUES (116, 128);
INSERT INTO edit_permissions(position, directory) VALUES (117, 128);
INSERT INTO edit_permissions(position, directory) VALUES (118, 128);
INSERT INTO edit_permissions(position, directory) VALUES (119, 128);
INSERT INTO edit_permissions(position, directory) VALUES (120, 128);
INSERT INTO edit_permissions(position, directory) VALUES (121, 128);
INSERT INTO edit_permissions(position, directory) VALUES (122, 128);
INSERT INTO edit_permissions(position, directory) VALUES (123, 128);
INSERT INTO edit_permissions(position, directory) VALUES (124, 128);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (112, 129);
INSERT INTO read_permissions(position, directory) VALUES (114, 129);
INSERT INTO read_permissions(position, directory) VALUES (115, 129);
INSERT INTO read_permissions(position, directory) VALUES (116, 129);
INSERT INTO read_permissions(position, directory) VALUES (117, 129);
INSERT INTO read_permissions(position, directory) VALUES (119, 129);
INSERT INTO read_permissions(position, directory) VALUES (121, 129);

INSERT INTO edit_permissions(position, directory) VALUES (112, 129);
INSERT INTO edit_permissions(position, directory) VALUES (114, 129);
INSERT INTO edit_permissions(position, directory) VALUES (115, 129);
INSERT INTO edit_permissions(position, directory) VALUES (116, 129);
INSERT INTO edit_permissions(position, directory) VALUES (117, 129);
INSERT INTO edit_permissions(position, directory) VALUES (119, 129);
INSERT INTO edit_permissions(position, directory) VALUES (121, 129);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (119, 130);

INSERT INTO edit_permissions(position, directory) VALUES (119, 130);

-- American Education Group/Schools/Fusion Division/Regional/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (125, 131);
INSERT INTO read_permissions(position, directory) VALUES (126, 131);
INSERT INTO read_permissions(position, directory) VALUES (127, 131);
INSERT INTO read_permissions(position, directory) VALUES (128, 131);
INSERT INTO read_permissions(position, directory) VALUES (129, 131);
INSERT INTO read_permissions(position, directory) VALUES (130, 131);
INSERT INTO read_permissions(position, directory) VALUES (131, 131);
INSERT INTO read_permissions(position, directory) VALUES (132, 131);
INSERT INTO read_permissions(position, directory) VALUES (133, 131);
INSERT INTO read_permissions(position, directory) VALUES (134, 131);
INSERT INTO read_permissions(position, directory) VALUES (135, 131);
INSERT INTO read_permissions(position, directory) VALUES (136, 131);
INSERT INTO read_permissions(position, directory) VALUES (137, 131);


INSERT INTO edit_permissions(position, directory) VALUES (125, 131);
INSERT INTO edit_permissions(position, directory) VALUES (126, 131);
INSERT INTO edit_permissions(position, directory) VALUES (127, 131);
INSERT INTO edit_permissions(position, directory) VALUES (128, 131);
INSERT INTO edit_permissions(position, directory) VALUES (129, 131);
INSERT INTO edit_permissions(position, directory) VALUES (130, 131);
INSERT INTO edit_permissions(position, directory) VALUES (131, 131);
INSERT INTO edit_permissions(position, directory) VALUES (132, 131);
INSERT INTO edit_permissions(position, directory) VALUES (133, 131);
INSERT INTO edit_permissions(position, directory) VALUES (134, 131);
INSERT INTO edit_permissions(position, directory) VALUES (135, 131);
INSERT INTO edit_permissions(position, directory) VALUES (136, 131);
INSERT INTO edit_permissions(position, directory) VALUES (137, 131);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (125, 132);
INSERT INTO edit_permissions(position, directory) VALUES (126, 132);
INSERT INTO edit_permissions(position, directory) VALUES (127, 132);
INSERT INTO edit_permissions(position, directory) VALUES (128, 132);
INSERT INTO edit_permissions(position, directory) VALUES (129, 132);
INSERT INTO edit_permissions(position, directory) VALUES (130, 132);
INSERT INTO edit_permissions(position, directory) VALUES (131, 132);
INSERT INTO edit_permissions(position, directory) VALUES (132, 132);
INSERT INTO edit_permissions(position, directory) VALUES (133, 132);
INSERT INTO edit_permissions(position, directory) VALUES (134, 132);
INSERT INTO edit_permissions(position, directory) VALUES (135, 132);
INSERT INTO edit_permissions(position, directory) VALUES (136, 132);
INSERT INTO edit_permissions(position, directory) VALUES (137, 132);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (125, 133);
INSERT INTO read_permissions(position, directory) VALUES (127, 133);
INSERT INTO read_permissions(position, directory) VALUES (128, 133);
INSERT INTO read_permissions(position, directory) VALUES (129, 133);
INSERT INTO read_permissions(position, directory) VALUES (130, 133);
INSERT INTO read_permissions(position, directory) VALUES (132, 133);
INSERT INTO read_permissions(position, directory) VALUES (134, 133);

INSERT INTO edit_permissions(position, directory) VALUES (125, 133);
INSERT INTO edit_permissions(position, directory) VALUES (127, 133);
INSERT INTO edit_permissions(position, directory) VALUES (128, 133);
INSERT INTO edit_permissions(position, directory) VALUES (129, 133);
INSERT INTO edit_permissions(position, directory) VALUES (130, 133);
INSERT INTO edit_permissions(position, directory) VALUES (132, 133);
INSERT INTO edit_permissions(position, directory) VALUES (134, 133);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (132, 134);

INSERT INTO edit_permissions(position, directory) VALUES (132, 134);

-- American Education Group/Schools/Fusion Division/San Francisco/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (138, 135);
INSERT INTO read_permissions(position, directory) VALUES (139, 135);
INSERT INTO read_permissions(position, directory) VALUES (140, 135);
INSERT INTO read_permissions(position, directory) VALUES (141, 135);
INSERT INTO read_permissions(position, directory) VALUES (142, 135);
INSERT INTO read_permissions(position, directory) VALUES (143, 135);
INSERT INTO read_permissions(position, directory) VALUES (144, 135);
INSERT INTO read_permissions(position, directory) VALUES (145, 135);
INSERT INTO read_permissions(position, directory) VALUES (146, 135);
INSERT INTO read_permissions(position, directory) VALUES (147, 135);
INSERT INTO read_permissions(position, directory) VALUES (148, 135);
INSERT INTO read_permissions(position, directory) VALUES (149, 135);
INSERT INTO read_permissions(position, directory) VALUES (150, 135);

INSERT INTO edit_permissions(position, directory) VALUES (138, 135);
INSERT INTO edit_permissions(position, directory) VALUES (139, 135);
INSERT INTO edit_permissions(position, directory) VALUES (140, 135);
INSERT INTO edit_permissions(position, directory) VALUES (141, 135);
INSERT INTO edit_permissions(position, directory) VALUES (142, 135);
INSERT INTO edit_permissions(position, directory) VALUES (143, 135);
INSERT INTO edit_permissions(position, directory) VALUES (144, 135);
INSERT INTO edit_permissions(position, directory) VALUES (145, 135);
INSERT INTO edit_permissions(position, directory) VALUES (146, 135);
INSERT INTO edit_permissions(position, directory) VALUES (147, 135);
INSERT INTO edit_permissions(position, directory) VALUES (148, 135);
INSERT INTO edit_permissions(position, directory) VALUES (149, 135);
INSERT INTO edit_permissions(position, directory) VALUES (150, 135);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (138, 136);
INSERT INTO edit_permissions(position, directory) VALUES (139, 136);
INSERT INTO edit_permissions(position, directory) VALUES (140, 136);
INSERT INTO edit_permissions(position, directory) VALUES (141, 136);
INSERT INTO edit_permissions(position, directory) VALUES (142, 136);
INSERT INTO edit_permissions(position, directory) VALUES (143, 136);
INSERT INTO edit_permissions(position, directory) VALUES (144, 136);
INSERT INTO edit_permissions(position, directory) VALUES (145, 136);
INSERT INTO edit_permissions(position, directory) VALUES (146, 136);
INSERT INTO edit_permissions(position, directory) VALUES (147, 136);
INSERT INTO edit_permissions(position, directory) VALUES (148, 136);
INSERT INTO edit_permissions(position, directory) VALUES (149, 136);
INSERT INTO edit_permissions(position, directory) VALUES (150, 136);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (138, 137);
INSERT INTO read_permissions(position, directory) VALUES (140, 137);
INSERT INTO read_permissions(position, directory) VALUES (141, 137);
INSERT INTO read_permissions(position, directory) VALUES (142, 137);
INSERT INTO read_permissions(position, directory) VALUES (143, 137);
INSERT INTO read_permissions(position, directory) VALUES (145, 137);
INSERT INTO read_permissions(position, directory) VALUES (147, 137);

INSERT INTO edit_permissions(position, directory) VALUES (138, 137);
INSERT INTO edit_permissions(position, directory) VALUES (140, 137);
INSERT INTO edit_permissions(position, directory) VALUES (141, 137);
INSERT INTO edit_permissions(position, directory) VALUES (142, 137);
INSERT INTO edit_permissions(position, directory) VALUES (143, 137);
INSERT INTO edit_permissions(position, directory) VALUES (145, 137);
INSERT INTO edit_permissions(position, directory) VALUES (147, 137);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (145, 138);

INSERT INTO edit_permissions(position, directory) VALUES (145, 138);

-- American Education Group/Schools/Fusion Division/San Mateo/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (151, 139);
INSERT INTO read_permissions(position, directory) VALUES (152, 139);
INSERT INTO read_permissions(position, directory) VALUES (153, 139);
INSERT INTO read_permissions(position, directory) VALUES (154, 139);
INSERT INTO read_permissions(position, directory) VALUES (155, 139);
INSERT INTO read_permissions(position, directory) VALUES (156, 139);
INSERT INTO read_permissions(position, directory) VALUES (157, 139);
INSERT INTO read_permissions(position, directory) VALUES (158, 139);
INSERT INTO read_permissions(position, directory) VALUES (159, 139);
INSERT INTO read_permissions(position, directory) VALUES (160, 139);
INSERT INTO read_permissions(position, directory) VALUES (161, 139);
INSERT INTO read_permissions(position, directory) VALUES (162, 139);
INSERT INTO read_permissions(position, directory) VALUES (163, 139);

INSERT INTO edit_permissions(position, directory) VALUES (151, 139);
INSERT INTO edit_permissions(position, directory) VALUES (152, 139);
INSERT INTO edit_permissions(position, directory) VALUES (153, 139);
INSERT INTO edit_permissions(position, directory) VALUES (154, 139);
INSERT INTO edit_permissions(position, directory) VALUES (155, 139);
INSERT INTO edit_permissions(position, directory) VALUES (156, 139);
INSERT INTO edit_permissions(position, directory) VALUES (157, 139);
INSERT INTO edit_permissions(position, directory) VALUES (158, 139);
INSERT INTO edit_permissions(position, directory) VALUES (159, 139);
INSERT INTO edit_permissions(position, directory) VALUES (160, 139);
INSERT INTO edit_permissions(position, directory) VALUES (161, 139);
INSERT INTO edit_permissions(position, directory) VALUES (162, 139);
INSERT INTO edit_permissions(position, directory) VALUES (163, 139);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (151, 140);
INSERT INTO edit_permissions(position, directory) VALUES (152, 140);
INSERT INTO edit_permissions(position, directory) VALUES (153, 140);
INSERT INTO edit_permissions(position, directory) VALUES (154, 140);
INSERT INTO edit_permissions(position, directory) VALUES (155, 140);
INSERT INTO edit_permissions(position, directory) VALUES (156, 140);
INSERT INTO edit_permissions(position, directory) VALUES (157, 140);
INSERT INTO edit_permissions(position, directory) VALUES (158, 140);
INSERT INTO edit_permissions(position, directory) VALUES (159, 140);
INSERT INTO edit_permissions(position, directory) VALUES (160, 140);
INSERT INTO edit_permissions(position, directory) VALUES (161, 140);
INSERT INTO edit_permissions(position, directory) VALUES (162, 140);
INSERT INTO edit_permissions(position, directory) VALUES (163, 140);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (151, 141);
INSERT INTO read_permissions(position, directory) VALUES (153, 141);
INSERT INTO read_permissions(position, directory) VALUES (154, 141);
INSERT INTO read_permissions(position, directory) VALUES (155, 141);
INSERT INTO read_permissions(position, directory) VALUES (156, 141);
INSERT INTO read_permissions(position, directory) VALUES (158, 141);
INSERT INTO read_permissions(position, directory) VALUES (160, 141);

INSERT INTO edit_permissions(position, directory) VALUES (151, 141);
INSERT INTO edit_permissions(position, directory) VALUES (153, 141);
INSERT INTO edit_permissions(position, directory) VALUES (154, 141);
INSERT INTO edit_permissions(position, directory) VALUES (155, 141);
INSERT INTO edit_permissions(position, directory) VALUES (156, 141);
INSERT INTO edit_permissions(position, directory) VALUES (158, 141);
INSERT INTO edit_permissions(position, directory) VALUES (160, 141);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (158, 142);

INSERT INTO edit_permissions(position, directory) VALUES (158, 142);

-- American Education Group/Schools/Fusion Division/Solana Beach/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (164, 143);
INSERT INTO read_permissions(position, directory) VALUES (165, 143);
INSERT INTO read_permissions(position, directory) VALUES (166, 143);
INSERT INTO read_permissions(position, directory) VALUES (167, 143);
INSERT INTO read_permissions(position, directory) VALUES (168, 143);
INSERT INTO read_permissions(position, directory) VALUES (169, 143);
INSERT INTO read_permissions(position, directory) VALUES (170, 143);
INSERT INTO read_permissions(position, directory) VALUES (171, 143);
INSERT INTO read_permissions(position, directory) VALUES (172, 143);
INSERT INTO read_permissions(position, directory) VALUES (173, 143);
INSERT INTO read_permissions(position, directory) VALUES (174, 143);
INSERT INTO read_permissions(position, directory) VALUES (175, 143);
INSERT INTO read_permissions(position, directory) VALUES (176, 143);

INSERT INTO edit_permissions(position, directory) VALUES (164, 143);
INSERT INTO edit_permissions(position, directory) VALUES (165, 143);
INSERT INTO edit_permissions(position, directory) VALUES (166, 143);
INSERT INTO edit_permissions(position, directory) VALUES (167, 143);
INSERT INTO edit_permissions(position, directory) VALUES (168, 143);
INSERT INTO edit_permissions(position, directory) VALUES (169, 143);
INSERT INTO edit_permissions(position, directory) VALUES (170, 143);
INSERT INTO edit_permissions(position, directory) VALUES (171, 143);
INSERT INTO edit_permissions(position, directory) VALUES (172, 143);
INSERT INTO edit_permissions(position, directory) VALUES (173, 143);
INSERT INTO edit_permissions(position, directory) VALUES (174, 143);
INSERT INTO edit_permissions(position, directory) VALUES (175, 143);
INSERT INTO edit_permissions(position, directory) VALUES (176, 143);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (164, 144);
INSERT INTO edit_permissions(position, directory) VALUES (165, 144);
INSERT INTO edit_permissions(position, directory) VALUES (166, 144);
INSERT INTO edit_permissions(position, directory) VALUES (167, 144);
INSERT INTO edit_permissions(position, directory) VALUES (168, 144);
INSERT INTO edit_permissions(position, directory) VALUES (169, 144);
INSERT INTO edit_permissions(position, directory) VALUES (170, 144);
INSERT INTO edit_permissions(position, directory) VALUES (171, 144);
INSERT INTO edit_permissions(position, directory) VALUES (172, 144);
INSERT INTO edit_permissions(position, directory) VALUES (173, 144);
INSERT INTO edit_permissions(position, directory) VALUES (174, 144);
INSERT INTO edit_permissions(position, directory) VALUES (175, 144);
INSERT INTO edit_permissions(position, directory) VALUES (176, 144);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (164, 145);
INSERT INTO read_permissions(position, directory) VALUES (166, 145);
INSERT INTO read_permissions(position, directory) VALUES (167, 145);
INSERT INTO read_permissions(position, directory) VALUES (168, 145);
INSERT INTO read_permissions(position, directory) VALUES (169, 145);
INSERT INTO read_permissions(position, directory) VALUES (171, 145);
INSERT INTO read_permissions(position, directory) VALUES (173, 145);

INSERT INTO edit_permissions(position, directory) VALUES (164, 145);
INSERT INTO edit_permissions(position, directory) VALUES (166, 145);
INSERT INTO edit_permissions(position, directory) VALUES (167, 145);
INSERT INTO edit_permissions(position, directory) VALUES (168, 145);
INSERT INTO edit_permissions(position, directory) VALUES (169, 145);
INSERT INTO edit_permissions(position, directory) VALUES (171, 145);
INSERT INTO edit_permissions(position, directory) VALUES (173, 145);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (171, 146);

INSERT INTO edit_permissions(position, directory) VALUES (171, 146);

-- American Education Group/Schools/Fusion Division/South Bay/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (177, 147);
INSERT INTO read_permissions(position, directory) VALUES (178, 147);
INSERT INTO read_permissions(position, directory) VALUES (179, 147);
INSERT INTO read_permissions(position, directory) VALUES (180, 147);
INSERT INTO read_permissions(position, directory) VALUES (181, 147);
INSERT INTO read_permissions(position, directory) VALUES (182, 147);
INSERT INTO read_permissions(position, directory) VALUES (183, 147);
INSERT INTO read_permissions(position, directory) VALUES (184, 147);
INSERT INTO read_permissions(position, directory) VALUES (185, 147);
INSERT INTO read_permissions(position, directory) VALUES (186, 147);
INSERT INTO read_permissions(position, directory) VALUES (187, 147);
INSERT INTO read_permissions(position, directory) VALUES (188, 147);
INSERT INTO read_permissions(position, directory) VALUES (189, 147);

INSERT INTO edit_permissions(position, directory) VALUES (177, 147);
INSERT INTO edit_permissions(position, directory) VALUES (178, 147);
INSERT INTO edit_permissions(position, directory) VALUES (179, 147);
INSERT INTO edit_permissions(position, directory) VALUES (180, 147);
INSERT INTO edit_permissions(position, directory) VALUES (181, 147);
INSERT INTO edit_permissions(position, directory) VALUES (182, 147);
INSERT INTO edit_permissions(position, directory) VALUES (183, 147);
INSERT INTO edit_permissions(position, directory) VALUES (184, 147);
INSERT INTO edit_permissions(position, directory) VALUES (185, 147);
INSERT INTO edit_permissions(position, directory) VALUES (186, 147);
INSERT INTO edit_permissions(position, directory) VALUES (187, 147);
INSERT INTO edit_permissions(position, directory) VALUES (188, 147);
INSERT INTO edit_permissions(position, directory) VALUES (189, 147);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (177, 148);
INSERT INTO edit_permissions(position, directory) VALUES (178, 148);
INSERT INTO edit_permissions(position, directory) VALUES (179, 148);
INSERT INTO edit_permissions(position, directory) VALUES (180, 148);
INSERT INTO edit_permissions(position, directory) VALUES (181, 148);
INSERT INTO edit_permissions(position, directory) VALUES (182, 148);
INSERT INTO edit_permissions(position, directory) VALUES (183, 148);
INSERT INTO edit_permissions(position, directory) VALUES (184, 148);
INSERT INTO edit_permissions(position, directory) VALUES (185, 148);
INSERT INTO edit_permissions(position, directory) VALUES (186, 148);
INSERT INTO edit_permissions(position, directory) VALUES (187, 148);
INSERT INTO edit_permissions(position, directory) VALUES (188, 148);
INSERT INTO edit_permissions(position, directory) VALUES (189, 148);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (177, 149);
INSERT INTO read_permissions(position, directory) VALUES (179, 149);
INSERT INTO read_permissions(position, directory) VALUES (180, 149);
INSERT INTO read_permissions(position, directory) VALUES (181, 149);
INSERT INTO read_permissions(position, directory) VALUES (182, 149);
INSERT INTO read_permissions(position, directory) VALUES (184, 149);
INSERT INTO read_permissions(position, directory) VALUES (186, 149);

INSERT INTO edit_permissions(position, directory) VALUES (177, 149);
INSERT INTO edit_permissions(position, directory) VALUES (179, 149);
INSERT INTO edit_permissions(position, directory) VALUES (180, 149);
INSERT INTO edit_permissions(position, directory) VALUES (181, 149);
INSERT INTO edit_permissions(position, directory) VALUES (182, 149);
INSERT INTO edit_permissions(position, directory) VALUES (184, 149);
INSERT INTO edit_permissions(position, directory) VALUES (186, 149);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (184, 150);

INSERT INTO edit_permissions(position, directory) VALUES (184, 150);

-- American Education Group/Schools/Fusion Division/Walnut Creek/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (190, 151);
INSERT INTO read_permissions(position, directory) VALUES (191, 151);
INSERT INTO read_permissions(position, directory) VALUES (192, 151);
INSERT INTO read_permissions(position, directory) VALUES (193, 151);
INSERT INTO read_permissions(position, directory) VALUES (194, 151);
INSERT INTO read_permissions(position, directory) VALUES (195, 151);
INSERT INTO read_permissions(position, directory) VALUES (196, 151);
INSERT INTO read_permissions(position, directory) VALUES (197, 151);
INSERT INTO read_permissions(position, directory) VALUES (198, 151);
INSERT INTO read_permissions(position, directory) VALUES (199, 151);
INSERT INTO read_permissions(position, directory) VALUES (200, 151);
INSERT INTO read_permissions(position, directory) VALUES (201, 151);
INSERT INTO read_permissions(position, directory) VALUES (202, 151);

INSERT INTO edit_permissions(position, directory) VALUES (190, 151);
INSERT INTO edit_permissions(position, directory) VALUES (191, 151);
INSERT INTO edit_permissions(position, directory) VALUES (192, 151);
INSERT INTO edit_permissions(position, directory) VALUES (193, 151);
INSERT INTO edit_permissions(position, directory) VALUES (194, 151);
INSERT INTO edit_permissions(position, directory) VALUES (195, 151);
INSERT INTO edit_permissions(position, directory) VALUES (196, 151);
INSERT INTO edit_permissions(position, directory) VALUES (197, 151);
INSERT INTO edit_permissions(position, directory) VALUES (198, 151);
INSERT INTO edit_permissions(position, directory) VALUES (199, 151);
INSERT INTO edit_permissions(position, directory) VALUES (200, 151);
INSERT INTO edit_permissions(position, directory) VALUES (201, 151);
INSERT INTO edit_permissions(position, directory) VALUES (202, 151);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (190, 152);
INSERT INTO edit_permissions(position, directory) VALUES (191, 152);
INSERT INTO edit_permissions(position, directory) VALUES (192, 152);
INSERT INTO edit_permissions(position, directory) VALUES (193, 152);
INSERT INTO edit_permissions(position, directory) VALUES (194, 152);
INSERT INTO edit_permissions(position, directory) VALUES (195, 152);
INSERT INTO edit_permissions(position, directory) VALUES (196, 152);
INSERT INTO edit_permissions(position, directory) VALUES (197, 152);
INSERT INTO edit_permissions(position, directory) VALUES (198, 152);
INSERT INTO edit_permissions(position, directory) VALUES (199, 152);
INSERT INTO edit_permissions(position, directory) VALUES (200, 152);
INSERT INTO edit_permissions(position, directory) VALUES (201, 152);
INSERT INTO edit_permissions(position, directory) VALUES (202, 152);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (190, 153);
INSERT INTO read_permissions(position, directory) VALUES (192, 153);
INSERT INTO read_permissions(position, directory) VALUES (193, 153);
INSERT INTO read_permissions(position, directory) VALUES (194, 153);
INSERT INTO read_permissions(position, directory) VALUES (195, 153);
INSERT INTO read_permissions(position, directory) VALUES (197, 153);
INSERT INTO read_permissions(position, directory) VALUES (199, 153);

INSERT INTO edit_permissions(position, directory) VALUES (190, 153);
INSERT INTO edit_permissions(position, directory) VALUES (192, 153);
INSERT INTO edit_permissions(position, directory) VALUES (193, 153);
INSERT INTO edit_permissions(position, directory) VALUES (194, 153);
INSERT INTO edit_permissions(position, directory) VALUES (195, 153);
INSERT INTO edit_permissions(position, directory) VALUES (197, 153);
INSERT INTO edit_permissions(position, directory) VALUES (199, 153);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (197, 154);

INSERT INTO edit_permissions(position, directory) VALUES (197, 154);

-- American Education Group/Schools/Fusion Division/Warner Center/
--   Staff
INSERT INTO read_permissions(position, directory) VALUES (203, 155);
INSERT INTO read_permissions(position, directory) VALUES (204, 155);
INSERT INTO read_permissions(position, directory) VALUES (205, 155);
INSERT INTO read_permissions(position, directory) VALUES (206, 155);
INSERT INTO read_permissions(position, directory) VALUES (207, 155);
INSERT INTO read_permissions(position, directory) VALUES (208, 155);
INSERT INTO read_permissions(position, directory) VALUES (209, 155);
INSERT INTO read_permissions(position, directory) VALUES (210, 155);
INSERT INTO read_permissions(position, directory) VALUES (211, 155);
INSERT INTO read_permissions(position, directory) VALUES (212, 155);
INSERT INTO read_permissions(position, directory) VALUES (213, 155);
INSERT INTO read_permissions(position, directory) VALUES (214, 155);
INSERT INTO read_permissions(position, directory) VALUES (215, 155);

INSERT INTO edit_permissions(position, directory) VALUES (203, 155);
INSERT INTO edit_permissions(position, directory) VALUES (204, 155);
INSERT INTO edit_permissions(position, directory) VALUES (205, 155);
INSERT INTO edit_permissions(position, directory) VALUES (206, 155);
INSERT INTO edit_permissions(position, directory) VALUES (207, 155);
INSERT INTO edit_permissions(position, directory) VALUES (208, 155);
INSERT INTO edit_permissions(position, directory) VALUES (209, 155);
INSERT INTO edit_permissions(position, directory) VALUES (210, 155);
INSERT INTO edit_permissions(position, directory) VALUES (211, 155);
INSERT INTO edit_permissions(position, directory) VALUES (212, 155);
INSERT INTO edit_permissions(position, directory) VALUES (213, 155);
INSERT INTO edit_permissions(position, directory) VALUES (214, 155);
INSERT INTO edit_permissions(position, directory) VALUES (215, 155);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (203, 156);
INSERT INTO edit_permissions(position, directory) VALUES (204, 156);
INSERT INTO edit_permissions(position, directory) VALUES (205, 156);
INSERT INTO edit_permissions(position, directory) VALUES (206, 156);
INSERT INTO edit_permissions(position, directory) VALUES (207, 156);
INSERT INTO edit_permissions(position, directory) VALUES (208, 156);
INSERT INTO edit_permissions(position, directory) VALUES (209, 156);
INSERT INTO edit_permissions(position, directory) VALUES (210, 156);
INSERT INTO edit_permissions(position, directory) VALUES (211, 156);
INSERT INTO edit_permissions(position, directory) VALUES (212, 156);
INSERT INTO edit_permissions(position, directory) VALUES (213, 156);
INSERT INTO edit_permissions(position, directory) VALUES (214, 156);
INSERT INTO edit_permissions(position, directory) VALUES (215, 156);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (203, 157);
INSERT INTO read_permissions(position, directory) VALUES (205, 157);
INSERT INTO read_permissions(position, directory) VALUES (206, 157);
INSERT INTO read_permissions(position, directory) VALUES (207, 157);
INSERT INTO read_permissions(position, directory) VALUES (208, 157);
INSERT INTO read_permissions(position, directory) VALUES (210, 157);
INSERT INTO read_permissions(position, directory) VALUES (212, 157);

INSERT INTO edit_permissions(position, directory) VALUES (203, 157);
INSERT INTO edit_permissions(position, directory) VALUES (205, 157);
INSERT INTO edit_permissions(position, directory) VALUES (206, 157);
INSERT INTO edit_permissions(position, directory) VALUES (207, 157);
INSERT INTO edit_permissions(position, directory) VALUES (208, 157);
INSERT INTO edit_permissions(position, directory) VALUES (210, 157);
INSERT INTO edit_permissions(position, directory) VALUES (212, 157);

--   Head of School
INSERT INTO read_permissions(position, directory) VALUES (210, 158);

INSERT INTO edit_permissions(position, directory) VALUES (210, 158);

-- American Education Group/Schools/Fusion Division/Fusionology/
--   Fusionology Content
INSERT INTO read_permissions(position, directory) VALUES (1, 159);
INSERT INTO read_permissions(position, directory) VALUES (2, 159);
INSERT INTO read_permissions(position, directory) VALUES (3, 159);
INSERT INTO read_permissions(position, directory) VALUES (4, 159);
INSERT INTO read_permissions(position, directory) VALUES (5, 159);
INSERT INTO read_permissions(position, directory) VALUES (6, 159);
INSERT INTO read_permissions(position, directory) VALUES (7, 159);
INSERT INTO read_permissions(position, directory) VALUES (8, 159);
INSERT INTO read_permissions(position, directory) VALUES (9, 159);
INSERT INTO read_permissions(position, directory) VALUES (10, 159);
INSERT INTO read_permissions(position, directory) VALUES (11, 159);
INSERT INTO read_permissions(position, directory) VALUES (12, 159);
INSERT INTO read_permissions(position, directory) VALUES (13, 159);
INSERT INTO read_permissions(position, directory) VALUES (14, 159);
INSERT INTO read_permissions(position, directory) VALUES (15, 159);
INSERT INTO read_permissions(position, directory) VALUES (16, 159);
INSERT INTO read_permissions(position, directory) VALUES (17, 159);
INSERT INTO read_permissions(position, directory) VALUES (18, 159);
INSERT INTO read_permissions(position, directory) VALUES (19, 159);
INSERT INTO read_permissions(position, directory) VALUES (20, 159);
INSERT INTO read_permissions(position, directory) VALUES (21, 159);
INSERT INTO read_permissions(position, directory) VALUES (22, 159);
INSERT INTO read_permissions(position, directory) VALUES (23, 159);
INSERT INTO read_permissions(position, directory) VALUES (24, 159);
INSERT INTO read_permissions(position, directory) VALUES (25, 159);
INSERT INTO read_permissions(position, directory) VALUES (26, 159);
INSERT INTO read_permissions(position, directory) VALUES (27, 159);
INSERT INTO read_permissions(position, directory) VALUES (28, 159);
INSERT INTO read_permissions(position, directory) VALUES (29, 159);
INSERT INTO read_permissions(position, directory) VALUES (30, 159);
INSERT INTO read_permissions(position, directory) VALUES (31, 159);
INSERT INTO read_permissions(position, directory) VALUES (32, 159);
INSERT INTO read_permissions(position, directory) VALUES (33, 159);
INSERT INTO read_permissions(position, directory) VALUES (34, 159);
INSERT INTO read_permissions(position, directory) VALUES (36, 159);
INSERT INTO read_permissions(position, directory) VALUES (37, 159);
INSERT INTO read_permissions(position, directory) VALUES (38, 159);
INSERT INTO read_permissions(position, directory) VALUES (39, 159);
INSERT INTO read_permissions(position, directory) VALUES (40, 159);
INSERT INTO read_permissions(position, directory) VALUES (41, 159);
INSERT INTO read_permissions(position, directory) VALUES (42, 159);
INSERT INTO read_permissions(position, directory) VALUES (43, 159);
INSERT INTO read_permissions(position, directory) VALUES (44, 159);
INSERT INTO read_permissions(position, directory) VALUES (47, 159);
INSERT INTO read_permissions(position, directory) VALUES (49, 159);
INSERT INTO read_permissions(position, directory) VALUES (50, 159);
INSERT INTO read_permissions(position, directory) VALUES (51, 159);
INSERT INTO read_permissions(position, directory) VALUES (52, 159);
INSERT INTO read_permissions(position, directory) VALUES (53, 159);
INSERT INTO read_permissions(position, directory) VALUES (54, 159);
INSERT INTO read_permissions(position, directory) VALUES (55, 159);
INSERT INTO read_permissions(position, directory) VALUES (56, 159);
INSERT INTO read_permissions(position, directory) VALUES (57, 159);
INSERT INTO read_permissions(position, directory) VALUES (60, 159);
INSERT INTO read_permissions(position, directory) VALUES (62, 159);
INSERT INTO read_permissions(position, directory) VALUES (63, 159);
INSERT INTO read_permissions(position, directory) VALUES (64, 159);
INSERT INTO read_permissions(position, directory) VALUES (65, 159);
INSERT INTO read_permissions(position, directory) VALUES (66, 159);
INSERT INTO read_permissions(position, directory) VALUES (67, 159);
INSERT INTO read_permissions(position, directory) VALUES (68, 159);
INSERT INTO read_permissions(position, directory) VALUES (69, 159);
INSERT INTO read_permissions(position, directory) VALUES (70, 159);
INSERT INTO read_permissions(position, directory) VALUES (73, 159);
INSERT INTO read_permissions(position, directory) VALUES (75, 159);
INSERT INTO read_permissions(position, directory) VALUES (76, 159);
INSERT INTO read_permissions(position, directory) VALUES (77, 159);
INSERT INTO read_permissions(position, directory) VALUES (78, 159);
INSERT INTO read_permissions(position, directory) VALUES (79, 159);
INSERT INTO read_permissions(position, directory) VALUES (80, 159);
INSERT INTO read_permissions(position, directory) VALUES (81, 159);
INSERT INTO read_permissions(position, directory) VALUES (82, 159);
INSERT INTO read_permissions(position, directory) VALUES (83, 159);
INSERT INTO read_permissions(position, directory) VALUES (86, 159);
INSERT INTO read_permissions(position, directory) VALUES (88, 159);
INSERT INTO read_permissions(position, directory) VALUES (89, 159);
INSERT INTO read_permissions(position, directory) VALUES (90, 159);
INSERT INTO read_permissions(position, directory) VALUES (91, 159);
INSERT INTO read_permissions(position, directory) VALUES (92, 159);
INSERT INTO read_permissions(position, directory) VALUES (93, 159);
INSERT INTO read_permissions(position, directory) VALUES (94, 159);
INSERT INTO read_permissions(position, directory) VALUES (95, 159);
INSERT INTO read_permissions(position, directory) VALUES (96, 159);
INSERT INTO read_permissions(position, directory) VALUES (99, 159);
INSERT INTO read_permissions(position, directory) VALUES (101, 159);
INSERT INTO read_permissions(position, directory) VALUES (102, 159);
INSERT INTO read_permissions(position, directory) VALUES (103, 159);
INSERT INTO read_permissions(position, directory) VALUES (104, 159);
INSERT INTO read_permissions(position, directory) VALUES (105, 159);
INSERT INTO read_permissions(position, directory) VALUES (106, 159);
INSERT INTO read_permissions(position, directory) VALUES (107, 159);
INSERT INTO read_permissions(position, directory) VALUES (108, 159);
INSERT INTO read_permissions(position, directory) VALUES (109, 159);
INSERT INTO read_permissions(position, directory) VALUES (112, 159);
INSERT INTO read_permissions(position, directory) VALUES (114, 159);
INSERT INTO read_permissions(position, directory) VALUES (115, 159);
INSERT INTO read_permissions(position, directory) VALUES (116, 159);
INSERT INTO read_permissions(position, directory) VALUES (117, 159);
INSERT INTO read_permissions(position, directory) VALUES (118, 159);
INSERT INTO read_permissions(position, directory) VALUES (119, 159);
INSERT INTO read_permissions(position, directory) VALUES (120, 159);
INSERT INTO read_permissions(position, directory) VALUES (121, 159);
INSERT INTO read_permissions(position, directory) VALUES (122, 159);
INSERT INTO read_permissions(position, directory) VALUES (125, 159);
INSERT INTO read_permissions(position, directory) VALUES (127, 159);
INSERT INTO read_permissions(position, directory) VALUES (128, 159);
INSERT INTO read_permissions(position, directory) VALUES (129, 159);
INSERT INTO read_permissions(position, directory) VALUES (130, 159);
INSERT INTO read_permissions(position, directory) VALUES (131, 159);
INSERT INTO read_permissions(position, directory) VALUES (132, 159);
INSERT INTO read_permissions(position, directory) VALUES (133, 159);
INSERT INTO read_permissions(position, directory) VALUES (134, 159);
INSERT INTO read_permissions(position, directory) VALUES (135, 159);
INSERT INTO read_permissions(position, directory) VALUES (138, 159);
INSERT INTO read_permissions(position, directory) VALUES (140, 159);
INSERT INTO read_permissions(position, directory) VALUES (141, 159);
INSERT INTO read_permissions(position, directory) VALUES (142, 159);
INSERT INTO read_permissions(position, directory) VALUES (143, 159);
INSERT INTO read_permissions(position, directory) VALUES (144, 159);
INSERT INTO read_permissions(position, directory) VALUES (145, 159);
INSERT INTO read_permissions(position, directory) VALUES (146, 159);
INSERT INTO read_permissions(position, directory) VALUES (147, 159);
INSERT INTO read_permissions(position, directory) VALUES (148, 159);
INSERT INTO read_permissions(position, directory) VALUES (151, 159);
INSERT INTO read_permissions(position, directory) VALUES (153, 159);
INSERT INTO read_permissions(position, directory) VALUES (154, 159);
INSERT INTO read_permissions(position, directory) VALUES (155, 159);
INSERT INTO read_permissions(position, directory) VALUES (156, 159);
INSERT INTO read_permissions(position, directory) VALUES (157, 159);
INSERT INTO read_permissions(position, directory) VALUES (158, 159);
INSERT INTO read_permissions(position, directory) VALUES (159, 159);
INSERT INTO read_permissions(position, directory) VALUES (160, 159);
INSERT INTO read_permissions(position, directory) VALUES (161, 159);
INSERT INTO read_permissions(position, directory) VALUES (164, 159);
INSERT INTO read_permissions(position, directory) VALUES (166, 159);
INSERT INTO read_permissions(position, directory) VALUES (167, 159);
INSERT INTO read_permissions(position, directory) VALUES (168, 159);
INSERT INTO read_permissions(position, directory) VALUES (169, 159);
INSERT INTO read_permissions(position, directory) VALUES (170, 159);
INSERT INTO read_permissions(position, directory) VALUES (171, 159);
INSERT INTO read_permissions(position, directory) VALUES (172, 159);
INSERT INTO read_permissions(position, directory) VALUES (173, 159);
INSERT INTO read_permissions(position, directory) VALUES (174, 159);
INSERT INTO read_permissions(position, directory) VALUES (177, 159);
INSERT INTO read_permissions(position, directory) VALUES (179, 159);
INSERT INTO read_permissions(position, directory) VALUES (180, 159);
INSERT INTO read_permissions(position, directory) VALUES (181, 159);
INSERT INTO read_permissions(position, directory) VALUES (182, 159);
INSERT INTO read_permissions(position, directory) VALUES (183, 159);
INSERT INTO read_permissions(position, directory) VALUES (184, 159);
INSERT INTO read_permissions(position, directory) VALUES (185, 159);
INSERT INTO read_permissions(position, directory) VALUES (186, 159);
INSERT INTO read_permissions(position, directory) VALUES (187, 159);
INSERT INTO read_permissions(position, directory) VALUES (190, 159);
INSERT INTO read_permissions(position, directory) VALUES (192, 159);
INSERT INTO read_permissions(position, directory) VALUES (193, 159);
INSERT INTO read_permissions(position, directory) VALUES (194, 159);
INSERT INTO read_permissions(position, directory) VALUES (195, 159);
INSERT INTO read_permissions(position, directory) VALUES (196, 159);
INSERT INTO read_permissions(position, directory) VALUES (197, 159);
INSERT INTO read_permissions(position, directory) VALUES (198, 159);
INSERT INTO read_permissions(position, directory) VALUES (199, 159);
INSERT INTO read_permissions(position, directory) VALUES (200, 159);
INSERT INTO read_permissions(position, directory) VALUES (203, 159);
INSERT INTO read_permissions(position, directory) VALUES (205, 159);
INSERT INTO read_permissions(position, directory) VALUES (206, 159);
INSERT INTO read_permissions(position, directory) VALUES (207, 159);
INSERT INTO read_permissions(position, directory) VALUES (208, 159);
INSERT INTO read_permissions(position, directory) VALUES (209, 159);
INSERT INTO read_permissions(position, directory) VALUES (210, 159);
INSERT INTO read_permissions(position, directory) VALUES (211, 159);
INSERT INTO read_permissions(position, directory) VALUES (212, 159);
INSERT INTO read_permissions(position, directory) VALUES (213, 159);
INSERT INTO read_permissions(position, directory) VALUES (216, 159);
INSERT INTO read_permissions(position, directory) VALUES (218, 159);
INSERT INTO read_permissions(position, directory) VALUES (219, 159);
INSERT INTO read_permissions(position, directory) VALUES (220, 159);
INSERT INTO read_permissions(position, directory) VALUES (221, 159);
INSERT INTO read_permissions(position, directory) VALUES (222, 159);
INSERT INTO read_permissions(position, directory) VALUES (223, 159);
INSERT INTO read_permissions(position, directory) VALUES (224, 159);
INSERT INTO read_permissions(position, directory) VALUES (225, 159);
INSERT INTO read_permissions(position, directory) VALUES (226, 159);

INSERT INTO edit_permissions(position, directory) VALUES (1,159);
INSERT INTO edit_permissions(position, directory) VALUES (2,159);
INSERT INTO edit_permissions(position, directory) VALUES (3,159);
INSERT INTO edit_permissions(position, directory) VALUES (4,159);
INSERT INTO edit_permissions(position, directory) VALUES (5,159);
INSERT INTO edit_permissions(position, directory) VALUES (6,159);
INSERT INTO edit_permissions(position, directory) VALUES (7,159);
INSERT INTO edit_permissions(position, directory) VALUES (8,159);
INSERT INTO edit_permissions(position, directory) VALUES (9,159);
INSERT INTO edit_permissions(position, directory) VALUES (10,159);
INSERT INTO edit_permissions(position, directory) VALUES (11,159);
INSERT INTO edit_permissions(position, directory) VALUES (12,159);
INSERT INTO edit_permissions(position, directory) VALUES (13,159);
INSERT INTO edit_permissions(position, directory) VALUES (14,159);
INSERT INTO edit_permissions(position, directory) VALUES (15,159);
INSERT INTO edit_permissions(position, directory) VALUES (16,159);
INSERT INTO edit_permissions(position, directory) VALUES (17,159);
INSERT INTO edit_permissions(position, directory) VALUES (18,159);
INSERT INTO edit_permissions(position, directory) VALUES (19,159);
INSERT INTO edit_permissions(position, directory) VALUES (20,159);
INSERT INTO edit_permissions(position, directory) VALUES (21,159);
INSERT INTO edit_permissions(position, directory) VALUES (22,159);
INSERT INTO edit_permissions(position, directory) VALUES (23,159);
INSERT INTO edit_permissions(position, directory) VALUES (24,159);
INSERT INTO edit_permissions(position, directory) VALUES (25,159);
INSERT INTO edit_permissions(position, directory) VALUES (26,159);
INSERT INTO edit_permissions(position, directory) VALUES (27,159);
INSERT INTO edit_permissions(position, directory) VALUES (28,159);
INSERT INTO edit_permissions(position, directory) VALUES (29,159);
INSERT INTO edit_permissions(position, directory) VALUES (30,159);
INSERT INTO edit_permissions(position, directory) VALUES (31,159);
INSERT INTO edit_permissions(position, directory) VALUES (32,159);
INSERT INTO edit_permissions(position, directory) VALUES (33,159);
INSERT INTO edit_permissions(position, directory) VALUES (40,159);
INSERT INTO edit_permissions(position, directory) VALUES (53,159);
INSERT INTO edit_permissions(position, directory) VALUES (66,159);
INSERT INTO edit_permissions(position, directory) VALUES (79,159);
INSERT INTO edit_permissions(position, directory) VALUES (92,159);
INSERT INTO edit_permissions(position, directory) VALUES (105,159);
INSERT INTO edit_permissions(position, directory) VALUES (118,159);
INSERT INTO edit_permissions(position, directory) VALUES (131,159);
INSERT INTO edit_permissions(position, directory) VALUES (144,159);
INSERT INTO edit_permissions(position, directory) VALUES (157,159);
INSERT INTO edit_permissions(position, directory) VALUES (170,159);
INSERT INTO edit_permissions(position, directory) VALUES (183,159);
INSERT INTO edit_permissions(position, directory) VALUES (196,159);
INSERT INTO edit_permissions(position, directory) VALUES (209,159);
INSERT INTO edit_permissions(position, directory) VALUES (222,159);
INSERT INTO edit_permissions(position, directory) VALUES (295,159);


--   Private
INSERT INTO read_permissions(position, directory) VALUES (1,160);
INSERT INTO read_permissions(position, directory) VALUES (2,160);
INSERT INTO read_permissions(position, directory) VALUES (3,160);
INSERT INTO read_permissions(position, directory) VALUES (4,160);
INSERT INTO read_permissions(position, directory) VALUES (5,160);
INSERT INTO read_permissions(position, directory) VALUES (6,160);
INSERT INTO read_permissions(position, directory) VALUES (7,160);
INSERT INTO read_permissions(position, directory) VALUES (8,160);
INSERT INTO read_permissions(position, directory) VALUES (9,160);
INSERT INTO read_permissions(position, directory) VALUES (10,160);
INSERT INTO read_permissions(position, directory) VALUES (11,160);
INSERT INTO read_permissions(position, directory) VALUES (12,160);
INSERT INTO read_permissions(position, directory) VALUES (13,160);
INSERT INTO read_permissions(position, directory) VALUES (14,160);
INSERT INTO read_permissions(position, directory) VALUES (15,160);
INSERT INTO read_permissions(position, directory) VALUES (16,160);
INSERT INTO read_permissions(position, directory) VALUES (17,160);
INSERT INTO read_permissions(position, directory) VALUES (18,160);
INSERT INTO read_permissions(position, directory) VALUES (19,160);
INSERT INTO read_permissions(position, directory) VALUES (20,160);
INSERT INTO read_permissions(position, directory) VALUES (21,160);
INSERT INTO read_permissions(position, directory) VALUES (22,160);
INSERT INTO read_permissions(position, directory) VALUES (23,160);
INSERT INTO read_permissions(position, directory) VALUES (24,160);
INSERT INTO read_permissions(position, directory) VALUES (25,160);
INSERT INTO read_permissions(position, directory) VALUES (26,160);
INSERT INTO read_permissions(position, directory) VALUES (27,160);
INSERT INTO read_permissions(position, directory) VALUES (28,160);
INSERT INTO read_permissions(position, directory) VALUES (29,160);
INSERT INTO read_permissions(position, directory) VALUES (30,160);
INSERT INTO read_permissions(position, directory) VALUES (31,160);
INSERT INTO read_permissions(position, directory) VALUES (32,160);
INSERT INTO read_permissions(position, directory) VALUES (33,160);
INSERT INTO read_permissions(position, directory) VALUES (40,160);
INSERT INTO read_permissions(position, directory) VALUES (53,160);
INSERT INTO read_permissions(position, directory) VALUES (66,160);
INSERT INTO read_permissions(position, directory) VALUES (79,160);
INSERT INTO read_permissions(position, directory) VALUES (92,160);
INSERT INTO read_permissions(position, directory) VALUES (105,160);
INSERT INTO read_permissions(position, directory) VALUES (118,160);
INSERT INTO read_permissions(position, directory) VALUES (131,160);
INSERT INTO read_permissions(position, directory) VALUES (144,160);
INSERT INTO read_permissions(position, directory) VALUES (157,160);
INSERT INTO read_permissions(position, directory) VALUES (170,160);
INSERT INTO read_permissions(position, directory) VALUES (183,160);
INSERT INTO read_permissions(position, directory) VALUES (196,160);
INSERT INTO read_permissions(position, directory) VALUES (209,160);
INSERT INTO read_permissions(position, directory) VALUES (222,160);
INSERT INTO read_permissions(position, directory) VALUES (295,160);

INSERT INTO edit_permissions(position, directory) VALUES (1,160);
INSERT INTO edit_permissions(position, directory) VALUES (2,160);
INSERT INTO edit_permissions(position, directory) VALUES (3,160);
INSERT INTO edit_permissions(position, directory) VALUES (4,160);
INSERT INTO edit_permissions(position, directory) VALUES (5,160);
INSERT INTO edit_permissions(position, directory) VALUES (6,160);
INSERT INTO edit_permissions(position, directory) VALUES (7,160);
INSERT INTO edit_permissions(position, directory) VALUES (8,160);
INSERT INTO edit_permissions(position, directory) VALUES (9,160);
INSERT INTO edit_permissions(position, directory) VALUES (10,160);
INSERT INTO edit_permissions(position, directory) VALUES (11,160);
INSERT INTO edit_permissions(position, directory) VALUES (12,160);
INSERT INTO edit_permissions(position, directory) VALUES (13,160);
INSERT INTO edit_permissions(position, directory) VALUES (14,160);
INSERT INTO edit_permissions(position, directory) VALUES (15,160);
INSERT INTO edit_permissions(position, directory) VALUES (16,160);
INSERT INTO edit_permissions(position, directory) VALUES (17,160);
INSERT INTO edit_permissions(position, directory) VALUES (18,160);
INSERT INTO edit_permissions(position, directory) VALUES (19,160);
INSERT INTO edit_permissions(position, directory) VALUES (20,160);
INSERT INTO edit_permissions(position, directory) VALUES (21,160);
INSERT INTO edit_permissions(position, directory) VALUES (22,160);
INSERT INTO edit_permissions(position, directory) VALUES (23,160);
INSERT INTO edit_permissions(position, directory) VALUES (24,160);
INSERT INTO edit_permissions(position, directory) VALUES (25,160);
INSERT INTO edit_permissions(position, directory) VALUES (26,160);
INSERT INTO edit_permissions(position, directory) VALUES (27,160);
INSERT INTO edit_permissions(position, directory) VALUES (28,160);
INSERT INTO edit_permissions(position, directory) VALUES (29,160);
INSERT INTO edit_permissions(position, directory) VALUES (30,160);
INSERT INTO edit_permissions(position, directory) VALUES (31,160);
INSERT INTO edit_permissions(position, directory) VALUES (32,160);
INSERT INTO edit_permissions(position, directory) VALUES (33,160);
INSERT INTO edit_permissions(position, directory) VALUES (40,160);
INSERT INTO edit_permissions(position, directory) VALUES (53,160);
INSERT INTO edit_permissions(position, directory) VALUES (66,160);
INSERT INTO edit_permissions(position, directory) VALUES (79,160);
INSERT INTO edit_permissions(position, directory) VALUES (92,160);
INSERT INTO edit_permissions(position, directory) VALUES (105,160);
INSERT INTO edit_permissions(position, directory) VALUES (118,160);
INSERT INTO edit_permissions(position, directory) VALUES (131,160);
INSERT INTO edit_permissions(position, directory) VALUES (144,160);
INSERT INTO edit_permissions(position, directory) VALUES (157,160);
INSERT INTO edit_permissions(position, directory) VALUES (170,160);
INSERT INTO edit_permissions(position, directory) VALUES (183,160);
INSERT INTO edit_permissions(position, directory) VALUES (196,160);
INSERT INTO edit_permissions(position, directory) VALUES (209,160);
INSERT INTO edit_permissions(position, directory) VALUES (222,160);
INSERT INTO edit_permissions(position, directory) VALUES (295,160);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (1,161);
INSERT INTO edit_permissions(position, directory) VALUES (2,161);
INSERT INTO edit_permissions(position, directory) VALUES (3,161);
INSERT INTO edit_permissions(position, directory) VALUES (4,161);
INSERT INTO edit_permissions(position, directory) VALUES (5,161);
INSERT INTO edit_permissions(position, directory) VALUES (6,161);
INSERT INTO edit_permissions(position, directory) VALUES (7,161);
INSERT INTO edit_permissions(position, directory) VALUES (8,161);
INSERT INTO edit_permissions(position, directory) VALUES (9,161);
INSERT INTO edit_permissions(position, directory) VALUES (10,161);
INSERT INTO edit_permissions(position, directory) VALUES (11,161);
INSERT INTO edit_permissions(position, directory) VALUES (12,161);
INSERT INTO edit_permissions(position, directory) VALUES (13,161);
INSERT INTO edit_permissions(position, directory) VALUES (14,161);
INSERT INTO edit_permissions(position, directory) VALUES (15,161);
INSERT INTO edit_permissions(position, directory) VALUES (16,161);
INSERT INTO edit_permissions(position, directory) VALUES (17,161);
INSERT INTO edit_permissions(position, directory) VALUES (18,161);
INSERT INTO edit_permissions(position, directory) VALUES (19,161);
INSERT INTO edit_permissions(position, directory) VALUES (20,161);
INSERT INTO edit_permissions(position, directory) VALUES (21,161);
INSERT INTO edit_permissions(position, directory) VALUES (22,161);
INSERT INTO edit_permissions(position, directory) VALUES (23,161);
INSERT INTO edit_permissions(position, directory) VALUES (24,161);
INSERT INTO edit_permissions(position, directory) VALUES (25,161);
INSERT INTO edit_permissions(position, directory) VALUES (26,161);
INSERT INTO edit_permissions(position, directory) VALUES (27,161);
INSERT INTO edit_permissions(position, directory) VALUES (28,161);
INSERT INTO edit_permissions(position, directory) VALUES (29,161);
INSERT INTO edit_permissions(position, directory) VALUES (30,161);
INSERT INTO edit_permissions(position, directory) VALUES (31,161);
INSERT INTO edit_permissions(position, directory) VALUES (32,161);
INSERT INTO edit_permissions(position, directory) VALUES (33,161);
INSERT INTO edit_permissions(position, directory) VALUES (40,161);
INSERT INTO edit_permissions(position, directory) VALUES (53,161);
INSERT INTO edit_permissions(position, directory) VALUES (66,161);
INSERT INTO edit_permissions(position, directory) VALUES (79,161);
INSERT INTO edit_permissions(position, directory) VALUES (92,161);
INSERT INTO edit_permissions(position, directory) VALUES (105,161);
INSERT INTO edit_permissions(position, directory) VALUES (118,161);
INSERT INTO edit_permissions(position, directory) VALUES (131,161);
INSERT INTO edit_permissions(position, directory) VALUES (144,161);
INSERT INTO edit_permissions(position, directory) VALUES (157,161);
INSERT INTO edit_permissions(position, directory) VALUES (170,161);
INSERT INTO edit_permissions(position, directory) VALUES (183,161);
INSERT INTO edit_permissions(position, directory) VALUES (196,161);
INSERT INTO edit_permissions(position, directory) VALUES (209,161);
INSERT INTO edit_permissions(position, directory) VALUES (222,161);
INSERT INTO edit_permissions(position, directory) VALUES (295,161);

--   Collaboration
INSERT INTO read_permissions(position, directory) VALUES (1, 162);
INSERT INTO read_permissions(position, directory) VALUES (2, 162);
INSERT INTO read_permissions(position, directory) VALUES (3, 162);
INSERT INTO read_permissions(position, directory) VALUES (4, 162);
INSERT INTO read_permissions(position, directory) VALUES (5, 162);
INSERT INTO read_permissions(position, directory) VALUES (6, 162);
INSERT INTO read_permissions(position, directory) VALUES (7, 162);
INSERT INTO read_permissions(position, directory) VALUES (8, 162);
INSERT INTO read_permissions(position, directory) VALUES (9, 162);
INSERT INTO read_permissions(position, directory) VALUES (10, 162);
INSERT INTO read_permissions(position, directory) VALUES (11, 162);
INSERT INTO read_permissions(position, directory) VALUES (12, 162);
INSERT INTO read_permissions(position, directory) VALUES (13, 162);
INSERT INTO read_permissions(position, directory) VALUES (14, 162);
INSERT INTO read_permissions(position, directory) VALUES (15, 162);
INSERT INTO read_permissions(position, directory) VALUES (16, 162);
INSERT INTO read_permissions(position, directory) VALUES (17, 162);
INSERT INTO read_permissions(position, directory) VALUES (18, 162);
INSERT INTO read_permissions(position, directory) VALUES (19, 162);
INSERT INTO read_permissions(position, directory) VALUES (20, 162);
INSERT INTO read_permissions(position, directory) VALUES (21, 162);
INSERT INTO read_permissions(position, directory) VALUES (22, 162);
INSERT INTO read_permissions(position, directory) VALUES (23, 162);
INSERT INTO read_permissions(position, directory) VALUES (24, 162);
INSERT INTO read_permissions(position, directory) VALUES (25, 162);
INSERT INTO read_permissions(position, directory) VALUES (26, 162);
INSERT INTO read_permissions(position, directory) VALUES (27, 162);
INSERT INTO read_permissions(position, directory) VALUES (28, 162);
INSERT INTO read_permissions(position, directory) VALUES (29, 162);
INSERT INTO read_permissions(position, directory) VALUES (30, 162);
INSERT INTO read_permissions(position, directory) VALUES (31, 162);
INSERT INTO read_permissions(position, directory) VALUES (32, 162);
INSERT INTO read_permissions(position, directory) VALUES (33, 162);
INSERT INTO read_permissions(position, directory) VALUES (34, 162);
INSERT INTO read_permissions(position, directory) VALUES (36, 162);
INSERT INTO read_permissions(position, directory) VALUES (37, 162);
INSERT INTO read_permissions(position, directory) VALUES (38, 162);
INSERT INTO read_permissions(position, directory) VALUES (39, 162);
INSERT INTO read_permissions(position, directory) VALUES (40, 162);
INSERT INTO read_permissions(position, directory) VALUES (41, 162);
INSERT INTO read_permissions(position, directory) VALUES (42, 162);
INSERT INTO read_permissions(position, directory) VALUES (43, 162);
INSERT INTO read_permissions(position, directory) VALUES (44, 162);
INSERT INTO read_permissions(position, directory) VALUES (47, 162);
INSERT INTO read_permissions(position, directory) VALUES (49, 162);
INSERT INTO read_permissions(position, directory) VALUES (50, 162);
INSERT INTO read_permissions(position, directory) VALUES (51, 162);
INSERT INTO read_permissions(position, directory) VALUES (52, 162);
INSERT INTO read_permissions(position, directory) VALUES (53, 162);
INSERT INTO read_permissions(position, directory) VALUES (54, 162);
INSERT INTO read_permissions(position, directory) VALUES (55, 162);
INSERT INTO read_permissions(position, directory) VALUES (56, 162);
INSERT INTO read_permissions(position, directory) VALUES (57, 162);
INSERT INTO read_permissions(position, directory) VALUES (60, 162);
INSERT INTO read_permissions(position, directory) VALUES (62, 162);
INSERT INTO read_permissions(position, directory) VALUES (63, 162);
INSERT INTO read_permissions(position, directory) VALUES (64, 162);
INSERT INTO read_permissions(position, directory) VALUES (65, 162);
INSERT INTO read_permissions(position, directory) VALUES (66, 162);
INSERT INTO read_permissions(position, directory) VALUES (67, 162);
INSERT INTO read_permissions(position, directory) VALUES (68, 162);
INSERT INTO read_permissions(position, directory) VALUES (69, 162);
INSERT INTO read_permissions(position, directory) VALUES (70, 162);
INSERT INTO read_permissions(position, directory) VALUES (73, 162);
INSERT INTO read_permissions(position, directory) VALUES (75, 162);
INSERT INTO read_permissions(position, directory) VALUES (76, 162);
INSERT INTO read_permissions(position, directory) VALUES (77, 162);
INSERT INTO read_permissions(position, directory) VALUES (78, 162);
INSERT INTO read_permissions(position, directory) VALUES (79, 162);
INSERT INTO read_permissions(position, directory) VALUES (80, 162);
INSERT INTO read_permissions(position, directory) VALUES (81, 162);
INSERT INTO read_permissions(position, directory) VALUES (82, 162);
INSERT INTO read_permissions(position, directory) VALUES (83, 162);
INSERT INTO read_permissions(position, directory) VALUES (86, 162);
INSERT INTO read_permissions(position, directory) VALUES (88, 162);
INSERT INTO read_permissions(position, directory) VALUES (89, 162);
INSERT INTO read_permissions(position, directory) VALUES (90, 162);
INSERT INTO read_permissions(position, directory) VALUES (91, 162);
INSERT INTO read_permissions(position, directory) VALUES (92, 162);
INSERT INTO read_permissions(position, directory) VALUES (93, 162);
INSERT INTO read_permissions(position, directory) VALUES (94, 162);
INSERT INTO read_permissions(position, directory) VALUES (95, 162);
INSERT INTO read_permissions(position, directory) VALUES (96, 162);
INSERT INTO read_permissions(position, directory) VALUES (99, 162);
INSERT INTO read_permissions(position, directory) VALUES (101, 162);
INSERT INTO read_permissions(position, directory) VALUES (102, 162);
INSERT INTO read_permissions(position, directory) VALUES (103, 162);
INSERT INTO read_permissions(position, directory) VALUES (104, 162);
INSERT INTO read_permissions(position, directory) VALUES (105, 162);
INSERT INTO read_permissions(position, directory) VALUES (106, 162);
INSERT INTO read_permissions(position, directory) VALUES (107, 162);
INSERT INTO read_permissions(position, directory) VALUES (108, 162);
INSERT INTO read_permissions(position, directory) VALUES (109, 162);
INSERT INTO read_permissions(position, directory) VALUES (112, 162);
INSERT INTO read_permissions(position, directory) VALUES (114, 162);
INSERT INTO read_permissions(position, directory) VALUES (115, 162);
INSERT INTO read_permissions(position, directory) VALUES (116, 162);
INSERT INTO read_permissions(position, directory) VALUES (117, 162);
INSERT INTO read_permissions(position, directory) VALUES (118, 162);
INSERT INTO read_permissions(position, directory) VALUES (119, 162);
INSERT INTO read_permissions(position, directory) VALUES (120, 162);
INSERT INTO read_permissions(position, directory) VALUES (121, 162);
INSERT INTO read_permissions(position, directory) VALUES (122, 162);
INSERT INTO read_permissions(position, directory) VALUES (125, 162);
INSERT INTO read_permissions(position, directory) VALUES (127, 162);
INSERT INTO read_permissions(position, directory) VALUES (128, 162);
INSERT INTO read_permissions(position, directory) VALUES (129, 162);
INSERT INTO read_permissions(position, directory) VALUES (130, 162);
INSERT INTO read_permissions(position, directory) VALUES (131, 162);
INSERT INTO read_permissions(position, directory) VALUES (132, 162);
INSERT INTO read_permissions(position, directory) VALUES (133, 162);
INSERT INTO read_permissions(position, directory) VALUES (134, 162);
INSERT INTO read_permissions(position, directory) VALUES (135, 162);
INSERT INTO read_permissions(position, directory) VALUES (138, 162);
INSERT INTO read_permissions(position, directory) VALUES (140, 162);
INSERT INTO read_permissions(position, directory) VALUES (141, 162);
INSERT INTO read_permissions(position, directory) VALUES (142, 162);
INSERT INTO read_permissions(position, directory) VALUES (143, 162);
INSERT INTO read_permissions(position, directory) VALUES (144, 162);
INSERT INTO read_permissions(position, directory) VALUES (145, 162);
INSERT INTO read_permissions(position, directory) VALUES (146, 162);
INSERT INTO read_permissions(position, directory) VALUES (147, 162);
INSERT INTO read_permissions(position, directory) VALUES (148, 162);
INSERT INTO read_permissions(position, directory) VALUES (151, 162);
INSERT INTO read_permissions(position, directory) VALUES (153, 162);
INSERT INTO read_permissions(position, directory) VALUES (154, 162);
INSERT INTO read_permissions(position, directory) VALUES (155, 162);
INSERT INTO read_permissions(position, directory) VALUES (156, 162);
INSERT INTO read_permissions(position, directory) VALUES (157, 162);
INSERT INTO read_permissions(position, directory) VALUES (158, 162);
INSERT INTO read_permissions(position, directory) VALUES (159, 162);
INSERT INTO read_permissions(position, directory) VALUES (160, 162);
INSERT INTO read_permissions(position, directory) VALUES (161, 162);
INSERT INTO read_permissions(position, directory) VALUES (164, 162);
INSERT INTO read_permissions(position, directory) VALUES (166, 162);
INSERT INTO read_permissions(position, directory) VALUES (167, 162);
INSERT INTO read_permissions(position, directory) VALUES (168, 162);
INSERT INTO read_permissions(position, directory) VALUES (169, 162);
INSERT INTO read_permissions(position, directory) VALUES (170, 162);
INSERT INTO read_permissions(position, directory) VALUES (171, 162);
INSERT INTO read_permissions(position, directory) VALUES (172, 162);
INSERT INTO read_permissions(position, directory) VALUES (173, 162);
INSERT INTO read_permissions(position, directory) VALUES (174, 162);
INSERT INTO read_permissions(position, directory) VALUES (177, 162);
INSERT INTO read_permissions(position, directory) VALUES (179, 162);
INSERT INTO read_permissions(position, directory) VALUES (180, 162);
INSERT INTO read_permissions(position, directory) VALUES (181, 162);
INSERT INTO read_permissions(position, directory) VALUES (182, 162);
INSERT INTO read_permissions(position, directory) VALUES (183, 162);
INSERT INTO read_permissions(position, directory) VALUES (184, 162);
INSERT INTO read_permissions(position, directory) VALUES (185, 162);
INSERT INTO read_permissions(position, directory) VALUES (186, 162);
INSERT INTO read_permissions(position, directory) VALUES (187, 162);
INSERT INTO read_permissions(position, directory) VALUES (190, 162);
INSERT INTO read_permissions(position, directory) VALUES (192, 162);
INSERT INTO read_permissions(position, directory) VALUES (193, 162);
INSERT INTO read_permissions(position, directory) VALUES (194, 162);
INSERT INTO read_permissions(position, directory) VALUES (195, 162);
INSERT INTO read_permissions(position, directory) VALUES (196, 162);
INSERT INTO read_permissions(position, directory) VALUES (197, 162);
INSERT INTO read_permissions(position, directory) VALUES (198, 162);
INSERT INTO read_permissions(position, directory) VALUES (199, 162);
INSERT INTO read_permissions(position, directory) VALUES (200, 162);
INSERT INTO read_permissions(position, directory) VALUES (203, 162);
INSERT INTO read_permissions(position, directory) VALUES (205, 162);
INSERT INTO read_permissions(position, directory) VALUES (206, 162);
INSERT INTO read_permissions(position, directory) VALUES (207, 162);
INSERT INTO read_permissions(position, directory) VALUES (208, 162);
INSERT INTO read_permissions(position, directory) VALUES (209, 162);
INSERT INTO read_permissions(position, directory) VALUES (210, 162);
INSERT INTO read_permissions(position, directory) VALUES (211, 162);
INSERT INTO read_permissions(position, directory) VALUES (212, 162);
INSERT INTO read_permissions(position, directory) VALUES (213, 162);
INSERT INTO read_permissions(position, directory) VALUES (216, 162);
INSERT INTO read_permissions(position, directory) VALUES (218, 162);
INSERT INTO read_permissions(position, directory) VALUES (219, 162);
INSERT INTO read_permissions(position, directory) VALUES (220, 162);
INSERT INTO read_permissions(position, directory) VALUES (221, 162);
INSERT INTO read_permissions(position, directory) VALUES (222, 162);
INSERT INTO read_permissions(position, directory) VALUES (223, 162);
INSERT INTO read_permissions(position, directory) VALUES (224, 162);
INSERT INTO read_permissions(position, directory) VALUES (225, 162);
INSERT INTO read_permissions(position, directory) VALUES (226, 162);


INSERT INTO edit_permissions(position, directory) VALUES (1, 162);
INSERT INTO edit_permissions(position, directory) VALUES (2, 162);
INSERT INTO edit_permissions(position, directory) VALUES (3, 162);
INSERT INTO edit_permissions(position, directory) VALUES (4, 162);
INSERT INTO edit_permissions(position, directory) VALUES (5, 162);
INSERT INTO edit_permissions(position, directory) VALUES (6, 162);
INSERT INTO edit_permissions(position, directory) VALUES (7, 162);
INSERT INTO edit_permissions(position, directory) VALUES (8, 162);
INSERT INTO edit_permissions(position, directory) VALUES (9, 162);
INSERT INTO edit_permissions(position, directory) VALUES (10, 162);
INSERT INTO edit_permissions(position, directory) VALUES (11, 162);
INSERT INTO edit_permissions(position, directory) VALUES (12, 162);
INSERT INTO edit_permissions(position, directory) VALUES (13, 162);
INSERT INTO edit_permissions(position, directory) VALUES (14, 162);
INSERT INTO edit_permissions(position, directory) VALUES (15, 162);
INSERT INTO edit_permissions(position, directory) VALUES (16, 162);
INSERT INTO edit_permissions(position, directory) VALUES (17, 162);
INSERT INTO edit_permissions(position, directory) VALUES (18, 162);
INSERT INTO edit_permissions(position, directory) VALUES (19, 162);
INSERT INTO edit_permissions(position, directory) VALUES (20, 162);
INSERT INTO edit_permissions(position, directory) VALUES (21, 162);
INSERT INTO edit_permissions(position, directory) VALUES (22, 162);
INSERT INTO edit_permissions(position, directory) VALUES (23, 162);
INSERT INTO edit_permissions(position, directory) VALUES (24, 162);
INSERT INTO edit_permissions(position, directory) VALUES (25, 162);
INSERT INTO edit_permissions(position, directory) VALUES (26, 162);
INSERT INTO edit_permissions(position, directory) VALUES (27, 162);
INSERT INTO edit_permissions(position, directory) VALUES (28, 162);
INSERT INTO edit_permissions(position, directory) VALUES (29, 162);
INSERT INTO edit_permissions(position, directory) VALUES (30, 162);
INSERT INTO edit_permissions(position, directory) VALUES (31, 162);
INSERT INTO edit_permissions(position, directory) VALUES (32, 162);
INSERT INTO edit_permissions(position, directory) VALUES (33, 162);
INSERT INTO edit_permissions(position, directory) VALUES (34, 162);
INSERT INTO edit_permissions(position, directory) VALUES (36, 162);
INSERT INTO edit_permissions(position, directory) VALUES (37, 162);
INSERT INTO edit_permissions(position, directory) VALUES (38, 162);
INSERT INTO edit_permissions(position, directory) VALUES (39, 162);
INSERT INTO edit_permissions(position, directory) VALUES (40, 162);
INSERT INTO edit_permissions(position, directory) VALUES (41, 162);
INSERT INTO edit_permissions(position, directory) VALUES (42, 162);
INSERT INTO edit_permissions(position, directory) VALUES (43, 162);
INSERT INTO edit_permissions(position, directory) VALUES (44, 162);
INSERT INTO edit_permissions(position, directory) VALUES (47, 162);
INSERT INTO edit_permissions(position, directory) VALUES (49, 162);
INSERT INTO edit_permissions(position, directory) VALUES (50, 162);
INSERT INTO edit_permissions(position, directory) VALUES (51, 162);
INSERT INTO edit_permissions(position, directory) VALUES (52, 162);
INSERT INTO edit_permissions(position, directory) VALUES (53, 162);
INSERT INTO edit_permissions(position, directory) VALUES (54, 162);
INSERT INTO edit_permissions(position, directory) VALUES (55, 162);
INSERT INTO edit_permissions(position, directory) VALUES (56, 162);
INSERT INTO edit_permissions(position, directory) VALUES (57, 162);
INSERT INTO edit_permissions(position, directory) VALUES (60, 162);
INSERT INTO edit_permissions(position, directory) VALUES (62, 162);
INSERT INTO edit_permissions(position, directory) VALUES (63, 162);
INSERT INTO edit_permissions(position, directory) VALUES (64, 162);
INSERT INTO edit_permissions(position, directory) VALUES (65, 162);
INSERT INTO edit_permissions(position, directory) VALUES (66, 162);
INSERT INTO edit_permissions(position, directory) VALUES (67, 162);
INSERT INTO edit_permissions(position, directory) VALUES (68, 162);
INSERT INTO edit_permissions(position, directory) VALUES (69, 162);
INSERT INTO edit_permissions(position, directory) VALUES (70, 162);
INSERT INTO edit_permissions(position, directory) VALUES (73, 162);
INSERT INTO edit_permissions(position, directory) VALUES (75, 162);
INSERT INTO edit_permissions(position, directory) VALUES (76, 162);
INSERT INTO edit_permissions(position, directory) VALUES (77, 162);
INSERT INTO edit_permissions(position, directory) VALUES (78, 162);
INSERT INTO edit_permissions(position, directory) VALUES (79, 162);
INSERT INTO edit_permissions(position, directory) VALUES (80, 162);
INSERT INTO edit_permissions(position, directory) VALUES (81, 162);
INSERT INTO edit_permissions(position, directory) VALUES (82, 162);
INSERT INTO edit_permissions(position, directory) VALUES (83, 162);
INSERT INTO edit_permissions(position, directory) VALUES (86, 162);
INSERT INTO edit_permissions(position, directory) VALUES (88, 162);
INSERT INTO edit_permissions(position, directory) VALUES (89, 162);
INSERT INTO edit_permissions(position, directory) VALUES (90, 162);
INSERT INTO edit_permissions(position, directory) VALUES (91, 162);
INSERT INTO edit_permissions(position, directory) VALUES (92, 162);
INSERT INTO edit_permissions(position, directory) VALUES (93, 162);
INSERT INTO edit_permissions(position, directory) VALUES (94, 162);
INSERT INTO edit_permissions(position, directory) VALUES (95, 162);
INSERT INTO edit_permissions(position, directory) VALUES (96, 162);
INSERT INTO edit_permissions(position, directory) VALUES (99, 162);
INSERT INTO edit_permissions(position, directory) VALUES (101, 162);
INSERT INTO edit_permissions(position, directory) VALUES (102, 162);
INSERT INTO edit_permissions(position, directory) VALUES (103, 162);
INSERT INTO edit_permissions(position, directory) VALUES (104, 162);
INSERT INTO edit_permissions(position, directory) VALUES (105, 162);
INSERT INTO edit_permissions(position, directory) VALUES (106, 162);
INSERT INTO edit_permissions(position, directory) VALUES (107, 162);
INSERT INTO edit_permissions(position, directory) VALUES (108, 162);
INSERT INTO edit_permissions(position, directory) VALUES (109, 162);
INSERT INTO edit_permissions(position, directory) VALUES (112, 162);
INSERT INTO edit_permissions(position, directory) VALUES (114, 162);
INSERT INTO edit_permissions(position, directory) VALUES (115, 162);
INSERT INTO edit_permissions(position, directory) VALUES (116, 162);
INSERT INTO edit_permissions(position, directory) VALUES (117, 162);
INSERT INTO edit_permissions(position, directory) VALUES (118, 162);
INSERT INTO edit_permissions(position, directory) VALUES (119, 162);
INSERT INTO edit_permissions(position, directory) VALUES (120, 162);
INSERT INTO edit_permissions(position, directory) VALUES (121, 162);
INSERT INTO edit_permissions(position, directory) VALUES (122, 162);
INSERT INTO edit_permissions(position, directory) VALUES (125, 162);
INSERT INTO edit_permissions(position, directory) VALUES (127, 162);
INSERT INTO edit_permissions(position, directory) VALUES (128, 162);
INSERT INTO edit_permissions(position, directory) VALUES (129, 162);
INSERT INTO edit_permissions(position, directory) VALUES (130, 162);
INSERT INTO edit_permissions(position, directory) VALUES (131, 162);
INSERT INTO edit_permissions(position, directory) VALUES (132, 162);
INSERT INTO edit_permissions(position, directory) VALUES (133, 162);
INSERT INTO edit_permissions(position, directory) VALUES (134, 162);
INSERT INTO edit_permissions(position, directory) VALUES (135, 162);
INSERT INTO edit_permissions(position, directory) VALUES (138, 162);
INSERT INTO edit_permissions(position, directory) VALUES (140, 162);
INSERT INTO edit_permissions(position, directory) VALUES (141, 162);
INSERT INTO edit_permissions(position, directory) VALUES (142, 162);
INSERT INTO edit_permissions(position, directory) VALUES (143, 162);
INSERT INTO edit_permissions(position, directory) VALUES (144, 162);
INSERT INTO edit_permissions(position, directory) VALUES (145, 162);
INSERT INTO edit_permissions(position, directory) VALUES (146, 162);
INSERT INTO edit_permissions(position, directory) VALUES (147, 162);
INSERT INTO edit_permissions(position, directory) VALUES (148, 162);
INSERT INTO edit_permissions(position, directory) VALUES (151, 162);
INSERT INTO edit_permissions(position, directory) VALUES (153, 162);
INSERT INTO edit_permissions(position, directory) VALUES (154, 162);
INSERT INTO edit_permissions(position, directory) VALUES (155, 162);
INSERT INTO edit_permissions(position, directory) VALUES (156, 162);
INSERT INTO edit_permissions(position, directory) VALUES (157, 162);
INSERT INTO edit_permissions(position, directory) VALUES (158, 162);
INSERT INTO edit_permissions(position, directory) VALUES (159, 162);
INSERT INTO edit_permissions(position, directory) VALUES (160, 162);
INSERT INTO edit_permissions(position, directory) VALUES (161, 162);
INSERT INTO edit_permissions(position, directory) VALUES (164, 162);
INSERT INTO edit_permissions(position, directory) VALUES (166, 162);
INSERT INTO edit_permissions(position, directory) VALUES (167, 162);
INSERT INTO edit_permissions(position, directory) VALUES (168, 162);
INSERT INTO edit_permissions(position, directory) VALUES (169, 162);
INSERT INTO edit_permissions(position, directory) VALUES (170, 162);
INSERT INTO edit_permissions(position, directory) VALUES (171, 162);
INSERT INTO edit_permissions(position, directory) VALUES (172, 162);
INSERT INTO edit_permissions(position, directory) VALUES (173, 162);
INSERT INTO edit_permissions(position, directory) VALUES (174, 162);
INSERT INTO edit_permissions(position, directory) VALUES (177, 162);
INSERT INTO edit_permissions(position, directory) VALUES (179, 162);
INSERT INTO edit_permissions(position, directory) VALUES (180, 162);
INSERT INTO edit_permissions(position, directory) VALUES (181, 162);
INSERT INTO edit_permissions(position, directory) VALUES (182, 162);
INSERT INTO edit_permissions(position, directory) VALUES (183, 162);
INSERT INTO edit_permissions(position, directory) VALUES (184, 162);
INSERT INTO edit_permissions(position, directory) VALUES (185, 162);
INSERT INTO edit_permissions(position, directory) VALUES (186, 162);
INSERT INTO edit_permissions(position, directory) VALUES (187, 162);
INSERT INTO edit_permissions(position, directory) VALUES (190, 162);
INSERT INTO edit_permissions(position, directory) VALUES (192, 162);
INSERT INTO edit_permissions(position, directory) VALUES (193, 162);
INSERT INTO edit_permissions(position, directory) VALUES (194, 162);
INSERT INTO edit_permissions(position, directory) VALUES (195, 162);
INSERT INTO edit_permissions(position, directory) VALUES (196, 162);
INSERT INTO edit_permissions(position, directory) VALUES (197, 162);
INSERT INTO edit_permissions(position, directory) VALUES (198, 162);
INSERT INTO edit_permissions(position, directory) VALUES (199, 162);
INSERT INTO edit_permissions(position, directory) VALUES (200, 162);
INSERT INTO edit_permissions(position, directory) VALUES (203, 162);
INSERT INTO edit_permissions(position, directory) VALUES (205, 162);
INSERT INTO edit_permissions(position, directory) VALUES (206, 162);
INSERT INTO edit_permissions(position, directory) VALUES (207, 162);
INSERT INTO edit_permissions(position, directory) VALUES (208, 162);
INSERT INTO edit_permissions(position, directory) VALUES (209, 162);
INSERT INTO edit_permissions(position, directory) VALUES (210, 162);
INSERT INTO edit_permissions(position, directory) VALUES (211, 162);
INSERT INTO edit_permissions(position, directory) VALUES (212, 162);
INSERT INTO edit_permissions(position, directory) VALUES (213, 162);
INSERT INTO edit_permissions(position, directory) VALUES (216, 162);
INSERT INTO edit_permissions(position, directory) VALUES (218, 162);
INSERT INTO edit_permissions(position, directory) VALUES (219, 162);
INSERT INTO edit_permissions(position, directory) VALUES (220, 162);
INSERT INTO edit_permissions(position, directory) VALUES (221, 162);
INSERT INTO edit_permissions(position, directory) VALUES (222, 162);
INSERT INTO edit_permissions(position, directory) VALUES (223, 162);
INSERT INTO edit_permissions(position, directory) VALUES (224, 162);
INSERT INTO edit_permissions(position, directory) VALUES (225, 162);
INSERT INTO edit_permissions(position, directory) VALUES (226, 162);

-- American Education Group/Schools/Fusion Division/Discussion Board/
--   Marketing
INSERT INTO read_permissions(position, directory) VALUES (23,163);
INSERT INTO read_permissions(position, directory) VALUES (24,163);
INSERT INTO read_permissions(position, directory) VALUES (25,163);
INSERT INTO read_permissions(position, directory) VALUES (26,163);
INSERT INTO read_permissions(position, directory) VALUES (27,163);
INSERT INTO read_permissions(position, directory) VALUES (28,163);
INSERT INTO read_permissions(position, directory) VALUES (29,163);
INSERT INTO read_permissions(position, directory) VALUES (30,163);
INSERT INTO read_permissions(position, directory) VALUES (36,163);
INSERT INTO read_permissions(position, directory) VALUES (49,163);
INSERT INTO read_permissions(position, directory) VALUES (62,163);
INSERT INTO read_permissions(position, directory) VALUES (75,163);
INSERT INTO read_permissions(position, directory) VALUES (88,163);
INSERT INTO read_permissions(position, directory) VALUES (101,163);
INSERT INTO read_permissions(position, directory) VALUES (114,163);
INSERT INTO read_permissions(position, directory) VALUES (127,163);
INSERT INTO read_permissions(position, directory) VALUES (140,163);
INSERT INTO read_permissions(position, directory) VALUES (153,163);
INSERT INTO read_permissions(position, directory) VALUES (166,163);
INSERT INTO read_permissions(position, directory) VALUES (179,163);
INSERT INTO read_permissions(position, directory) VALUES (192,163);
INSERT INTO read_permissions(position, directory) VALUES (205,163);
INSERT INTO read_permissions(position, directory) VALUES (218,163);


INSERT INTO edit_permissions(position, directory) VALUES (23,163);
INSERT INTO edit_permissions(position, directory) VALUES (24,163);
INSERT INTO edit_permissions(position, directory) VALUES (25,163);
INSERT INTO edit_permissions(position, directory) VALUES (26,163);
INSERT INTO edit_permissions(position, directory) VALUES (27,163);
INSERT INTO edit_permissions(position, directory) VALUES (28,163);
INSERT INTO edit_permissions(position, directory) VALUES (29,163);
INSERT INTO edit_permissions(position, directory) VALUES (30,163);
INSERT INTO edit_permissions(position, directory) VALUES (36,163);
INSERT INTO edit_permissions(position, directory) VALUES (49,163);
INSERT INTO edit_permissions(position, directory) VALUES (62,163);
INSERT INTO edit_permissions(position, directory) VALUES (75,163);
INSERT INTO edit_permissions(position, directory) VALUES (88,163);
INSERT INTO edit_permissions(position, directory) VALUES (101,163);
INSERT INTO edit_permissions(position, directory) VALUES (114,163);
INSERT INTO edit_permissions(position, directory) VALUES (127,163);
INSERT INTO edit_permissions(position, directory) VALUES (140,163);
INSERT INTO edit_permissions(position, directory) VALUES (153,163);
INSERT INTO edit_permissions(position, directory) VALUES (166,163);
INSERT INTO edit_permissions(position, directory) VALUES (179,163);
INSERT INTO edit_permissions(position, directory) VALUES (192,163);
INSERT INTO edit_permissions(position, directory) VALUES (205,163);
INSERT INTO edit_permissions(position, directory) VALUES (218,163);

-- American Education Group/Schools/Fusion Division/Outreach/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (23,164);
INSERT INTO read_permissions(position, directory) VALUES (24,164);
INSERT INTO read_permissions(position, directory) VALUES (25,164);
INSERT INTO read_permissions(position, directory) VALUES (26,164);
INSERT INTO read_permissions(position, directory) VALUES (27,164);
INSERT INTO read_permissions(position, directory) VALUES (28,164);
INSERT INTO read_permissions(position, directory) VALUES (29,164);
INSERT INTO read_permissions(position, directory) VALUES (30,164);
INSERT INTO read_permissions(position, directory) VALUES (36,164);
INSERT INTO read_permissions(position, directory) VALUES (49,164);
INSERT INTO read_permissions(position, directory) VALUES (62,164);
INSERT INTO read_permissions(position, directory) VALUES (75,164);
INSERT INTO read_permissions(position, directory) VALUES (88,164);
INSERT INTO read_permissions(position, directory) VALUES (101,164);
INSERT INTO read_permissions(position, directory) VALUES (114,164);
INSERT INTO read_permissions(position, directory) VALUES (127,164);
INSERT INTO read_permissions(position, directory) VALUES (140,164);
INSERT INTO read_permissions(position, directory) VALUES (153,164);
INSERT INTO read_permissions(position, directory) VALUES (166,164);
INSERT INTO read_permissions(position, directory) VALUES (179,164);
INSERT INTO read_permissions(position, directory) VALUES (192,164);
INSERT INTO read_permissions(position, directory) VALUES (205,164);
INSERT INTO read_permissions(position, directory) VALUES (218,164);


INSERT INTO edit_permissions(position, directory) VALUES (23,164);
INSERT INTO edit_permissions(position, directory) VALUES (24,164);
INSERT INTO edit_permissions(position, directory) VALUES (25,164);
INSERT INTO edit_permissions(position, directory) VALUES (26,164);
INSERT INTO edit_permissions(position, directory) VALUES (27,164);
INSERT INTO edit_permissions(position, directory) VALUES (28,164);
INSERT INTO edit_permissions(position, directory) VALUES (29,164);
INSERT INTO edit_permissions(position, directory) VALUES (30,164);
INSERT INTO edit_permissions(position, directory) VALUES (36,164);
INSERT INTO edit_permissions(position, directory) VALUES (49,164);
INSERT INTO edit_permissions(position, directory) VALUES (62,164);
INSERT INTO edit_permissions(position, directory) VALUES (75,164);
INSERT INTO edit_permissions(position, directory) VALUES (88,164);
INSERT INTO edit_permissions(position, directory) VALUES (101,164);
INSERT INTO edit_permissions(position, directory) VALUES (114,164);
INSERT INTO edit_permissions(position, directory) VALUES (127,164);
INSERT INTO edit_permissions(position, directory) VALUES (140,164);
INSERT INTO edit_permissions(position, directory) VALUES (153,164);
INSERT INTO edit_permissions(position, directory) VALUES (166,164);
INSERT INTO edit_permissions(position, directory) VALUES (179,164);
INSERT INTO edit_permissions(position, directory) VALUES (192,164);
INSERT INTO edit_permissions(position, directory) VALUES (205,164);
INSERT INTO edit_permissions(position, directory) VALUES (218,164);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (23,165);
INSERT INTO edit_permissions(position, directory) VALUES (24,165);
INSERT INTO edit_permissions(position, directory) VALUES (25,165);
INSERT INTO edit_permissions(position, directory) VALUES (26,165);
INSERT INTO edit_permissions(position, directory) VALUES (27,165);
INSERT INTO edit_permissions(position, directory) VALUES (28,165);
INSERT INTO edit_permissions(position, directory) VALUES (29,165);
INSERT INTO edit_permissions(position, directory) VALUES (30,165);
INSERT INTO edit_permissions(position, directory) VALUES (36,165);
INSERT INTO edit_permissions(position, directory) VALUES (49,165);
INSERT INTO edit_permissions(position, directory) VALUES (62,165);
INSERT INTO edit_permissions(position, directory) VALUES (75,165);
INSERT INTO edit_permissions(position, directory) VALUES (88,165);
INSERT INTO edit_permissions(position, directory) VALUES (101,165);
INSERT INTO edit_permissions(position, directory) VALUES (114,165);
INSERT INTO edit_permissions(position, directory) VALUES (127,165);
INSERT INTO edit_permissions(position, directory) VALUES (140,165);
INSERT INTO edit_permissions(position, directory) VALUES (153,165);
INSERT INTO edit_permissions(position, directory) VALUES (166,165);
INSERT INTO edit_permissions(position, directory) VALUES (179,165);
INSERT INTO edit_permissions(position, directory) VALUES (192,165);
INSERT INTO edit_permissions(position, directory) VALUES (205,165);
INSERT INTO edit_permissions(position, directory) VALUES (218,165);

--   Outreach Discussions
INSERT INTO read_permissions(position, directory) VALUES (23,166);
INSERT INTO read_permissions(position, directory) VALUES (24,166);
INSERT INTO read_permissions(position, directory) VALUES (25,166);
INSERT INTO read_permissions(position, directory) VALUES (26,166);
INSERT INTO read_permissions(position, directory) VALUES (27,166);
INSERT INTO read_permissions(position, directory) VALUES (28,166);
INSERT INTO read_permissions(position, directory) VALUES (29,166);
INSERT INTO read_permissions(position, directory) VALUES (30,166);
INSERT INTO read_permissions(position, directory) VALUES (36,166);
INSERT INTO read_permissions(position, directory) VALUES (49,166);
INSERT INTO read_permissions(position, directory) VALUES (62,166);
INSERT INTO read_permissions(position, directory) VALUES (75,166);
INSERT INTO read_permissions(position, directory) VALUES (88,166);
INSERT INTO read_permissions(position, directory) VALUES (101,166);
INSERT INTO read_permissions(position, directory) VALUES (114,166);
INSERT INTO read_permissions(position, directory) VALUES (127,166);
INSERT INTO read_permissions(position, directory) VALUES (140,166);
INSERT INTO read_permissions(position, directory) VALUES (153,166);
INSERT INTO read_permissions(position, directory) VALUES (166,166);
INSERT INTO read_permissions(position, directory) VALUES (179,166);
INSERT INTO read_permissions(position, directory) VALUES (192,166);
INSERT INTO read_permissions(position, directory) VALUES (205,166);
INSERT INTO read_permissions(position, directory) VALUES (218,166);


INSERT INTO edit_permissions(position, directory) VALUES (23,166);
INSERT INTO edit_permissions(position, directory) VALUES (24,166);
INSERT INTO edit_permissions(position, directory) VALUES (25,166);

INSERT INTO edit_permissions(position, directory) VALUES (26,166);
INSERT INTO edit_permissions(position, directory) VALUES (27,166);
INSERT INTO edit_permissions(position, directory) VALUES (28,166);
INSERT INTO edit_permissions(position, directory) VALUES (29,166);
INSERT INTO edit_permissions(position, directory) VALUES (30,166);
INSERT INTO edit_permissions(position, directory) VALUES (36,166);
INSERT INTO edit_permissions(position, directory) VALUES (49,166);
INSERT INTO edit_permissions(position, directory) VALUES (62,166);
INSERT INTO edit_permissions(position, directory) VALUES (75,166);
INSERT INTO edit_permissions(position, directory) VALUES (88,166);
INSERT INTO edit_permissions(position, directory) VALUES (101,166);
INSERT INTO edit_permissions(position, directory) VALUES (114,166);
INSERT INTO edit_permissions(position, directory) VALUES (127,166);
INSERT INTO edit_permissions(position, directory) VALUES (140,166);
INSERT INTO edit_permissions(position, directory) VALUES (153,166);
INSERT INTO edit_permissions(position, directory) VALUES (166,166);
INSERT INTO edit_permissions(position, directory) VALUES (179,166);

INSERT INTO edit_permissions(position, directory) VALUES (192,166);
INSERT INTO edit_permissions(position, directory) VALUES (205,166);
INSERT INTO edit_permissions(position, directory) VALUES (218,166);

-- American Education Group/Schools/Fusion Division/Accounting/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (16,167);
INSERT INTO read_permissions(position, directory) VALUES (17,167);
INSERT INTO read_permissions(position, directory) VALUES (18,167);
INSERT INTO read_permissions(position, directory) VALUES (19,167);
INSERT INTO read_permissions(position, directory) VALUES (20,167);
INSERT INTO read_permissions(position, directory) VALUES (21,167);
INSERT INTO read_permissions(position, directory) VALUES (22,167);

INSERT INTO edit_permissions(position, directory) VALUES (16,167);
INSERT INTO edit_permissions(position, directory) VALUES (17,167);
INSERT INTO edit_permissions(position, directory) VALUES (18,167);
INSERT INTO edit_permissions(position, directory) VALUES (19,167);
INSERT INTO edit_permissions(position, directory) VALUES (20,167);
INSERT INTO edit_permissions(position, directory) VALUES (21,167);
INSERT INTO edit_permissions(position, directory) VALUES (22,167);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (16,168);
INSERT INTO edit_permissions(position, directory) VALUES (17,168);
INSERT INTO edit_permissions(position, directory) VALUES (18,168);
INSERT INTO edit_permissions(position, directory) VALUES (19,168);
INSERT INTO edit_permissions(position, directory) VALUES (20,168);
INSERT INTO edit_permissions(position, directory) VALUES (21,168);
INSERT INTO edit_permissions(position, directory) VALUES (22,168);

--   Billing
INSERT INTO read_permissions(position, directory) VALUES (16,169);
INSERT INTO read_permissions(position, directory) VALUES (17,169);
INSERT INTO read_permissions(position, directory) VALUES (18,169);
INSERT INTO read_permissions(position, directory) VALUES (19,169);
INSERT INTO read_permissions(position, directory) VALUES (20,169);
INSERT INTO read_permissions(position, directory) VALUES (21,169);
INSERT INTO read_permissions(position, directory) VALUES (22,169);
INSERT INTO read_permissions(position, directory) VALUES (229,169);
INSERT INTO read_permissions(position, directory) VALUES (231,169);
INSERT INTO read_permissions(position, directory) VALUES (295,169);
INSERT INTO read_permissions(position, directory) VALUES (296,169);
INSERT INTO read_permissions(position, directory) VALUES (34, 169);
INSERT INTO read_permissions(position, directory) VALUES (37, 169);
INSERT INTO read_permissions(position, directory) VALUES (38, 169);
INSERT INTO read_permissions(position, directory) VALUES (41, 169);
INSERT INTO read_permissions(position, directory) VALUES (42, 169);
INSERT INTO read_permissions(position, directory) VALUES (43, 169);
INSERT INTO read_permissions(position, directory) VALUES (47, 169);
INSERT INTO read_permissions(position, directory) VALUES (50, 169);
INSERT INTO read_permissions(position, directory) VALUES (51, 169);
INSERT INTO read_permissions(position, directory) VALUES (54, 169);
INSERT INTO read_permissions(position, directory) VALUES (55, 169);
INSERT INTO read_permissions(position, directory) VALUES (56, 169);
INSERT INTO read_permissions(position, directory) VALUES (60, 169);
INSERT INTO read_permissions(position, directory) VALUES (63, 169);
INSERT INTO read_permissions(position, directory) VALUES (64, 169);
INSERT INTO read_permissions(position, directory) VALUES (67, 169);
INSERT INTO read_permissions(position, directory) VALUES (68, 169);
INSERT INTO read_permissions(position, directory) VALUES (69, 169);
INSERT INTO read_permissions(position, directory) VALUES (73, 169);
INSERT INTO read_permissions(position, directory) VALUES (76, 169);
INSERT INTO read_permissions(position, directory) VALUES (77, 169);
INSERT INTO read_permissions(position, directory) VALUES (80, 169);
INSERT INTO read_permissions(position, directory) VALUES (81, 169);
INSERT INTO read_permissions(position, directory) VALUES (82, 169);
INSERT INTO read_permissions(position, directory) VALUES (86, 169);
INSERT INTO read_permissions(position, directory) VALUES (89, 169);
INSERT INTO read_permissions(position, directory) VALUES (90, 169);
INSERT INTO read_permissions(position, directory) VALUES (93, 169);
INSERT INTO read_permissions(position, directory) VALUES (94, 169);
INSERT INTO read_permissions(position, directory) VALUES (95, 169);
INSERT INTO read_permissions(position, directory) VALUES (99, 169);
INSERT INTO read_permissions(position, directory) VALUES (102, 169);
INSERT INTO read_permissions(position, directory) VALUES (103, 169);
INSERT INTO read_permissions(position, directory) VALUES (106, 169);
INSERT INTO read_permissions(position, directory) VALUES (107, 169);
INSERT INTO read_permissions(position, directory) VALUES (108, 169);
INSERT INTO read_permissions(position, directory) VALUES (112, 169);
INSERT INTO read_permissions(position, directory) VALUES (115, 169);
INSERT INTO read_permissions(position, directory) VALUES (116, 169);
INSERT INTO read_permissions(position, directory) VALUES (119, 169);
INSERT INTO read_permissions(position, directory) VALUES (120, 169);
INSERT INTO read_permissions(position, directory) VALUES (121, 169);
INSERT INTO read_permissions(position, directory) VALUES (125, 169);
INSERT INTO read_permissions(position, directory) VALUES (128, 169);
INSERT INTO read_permissions(position, directory) VALUES (129, 169);
INSERT INTO read_permissions(position, directory) VALUES (132, 169);
INSERT INTO read_permissions(position, directory) VALUES (133, 169);
INSERT INTO read_permissions(position, directory) VALUES (134, 169);
INSERT INTO read_permissions(position, directory) VALUES (138, 169);
INSERT INTO read_permissions(position, directory) VALUES (141, 169);
INSERT INTO read_permissions(position, directory) VALUES (142, 169);
INSERT INTO read_permissions(position, directory) VALUES (145, 169);
INSERT INTO read_permissions(position, directory) VALUES (146, 169);
INSERT INTO read_permissions(position, directory) VALUES (147, 169);
INSERT INTO read_permissions(position, directory) VALUES (151, 169);
INSERT INTO read_permissions(position, directory) VALUES (154, 169);
INSERT INTO read_permissions(position, directory) VALUES (155, 169);
INSERT INTO read_permissions(position, directory) VALUES (158, 169);
INSERT INTO read_permissions(position, directory) VALUES (159, 169);
INSERT INTO read_permissions(position, directory) VALUES (160, 169);
INSERT INTO read_permissions(position, directory) VALUES (164, 169);
INSERT INTO read_permissions(position, directory) VALUES (167, 169);
INSERT INTO read_permissions(position, directory) VALUES (168, 169);
INSERT INTO read_permissions(position, directory) VALUES (171, 169);
INSERT INTO read_permissions(position, directory) VALUES (172, 169);
INSERT INTO read_permissions(position, directory) VALUES (173, 169);
INSERT INTO read_permissions(position, directory) VALUES (177, 169);
INSERT INTO read_permissions(position, directory) VALUES (180, 169);
INSERT INTO read_permissions(position, directory) VALUES (181, 169);
INSERT INTO read_permissions(position, directory) VALUES (184, 169);
INSERT INTO read_permissions(position, directory) VALUES (185, 169);
INSERT INTO read_permissions(position, directory) VALUES (186, 169);
INSERT INTO read_permissions(position, directory) VALUES (190, 169);
INSERT INTO read_permissions(position, directory) VALUES (193, 169);
INSERT INTO read_permissions(position, directory) VALUES (194, 169);
INSERT INTO read_permissions(position, directory) VALUES (197, 169);
INSERT INTO read_permissions(position, directory) VALUES (198, 169);
INSERT INTO read_permissions(position, directory) VALUES (199, 169);
INSERT INTO read_permissions(position, directory) VALUES (203, 169);
INSERT INTO read_permissions(position, directory) VALUES (206, 169);
INSERT INTO read_permissions(position, directory) VALUES (207, 169);
INSERT INTO read_permissions(position, directory) VALUES (210, 169);
INSERT INTO read_permissions(position, directory) VALUES (211, 169);
INSERT INTO read_permissions(position, directory) VALUES (212, 169);
INSERT INTO read_permissions(position, directory) VALUES (216, 169);
INSERT INTO read_permissions(position, directory) VALUES (219, 169);
INSERT INTO read_permissions(position, directory) VALUES (220, 169);
INSERT INTO read_permissions(position, directory) VALUES (223, 169);
INSERT INTO read_permissions(position, directory) VALUES (224, 169);
INSERT INTO read_permissions(position, directory) VALUES (225, 169);

INSERT INTO edit_permissions(position, directory) VALUES (16,169);
INSERT INTO edit_permissions(position, directory) VALUES (17,169);
INSERT INTO edit_permissions(position, directory) VALUES (18,169);
INSERT INTO edit_permissions(position, directory) VALUES (19,169);
INSERT INTO edit_permissions(position, directory) VALUES (20,169);
INSERT INTO edit_permissions(position, directory) VALUES (21,169);
INSERT INTO edit_permissions(position, directory) VALUES (22,169);
INSERT INTO edit_permissions(position, directory) VALUES (229,169);
INSERT INTO edit_permissions(position, directory) VALUES (231,169);
INSERT INTO edit_permissions(position, directory) VALUES (295,169);
INSERT INTO edit_permissions(position, directory) VALUES (296,169);
INSERT INTO edit_permissions(position, directory) VALUES (34, 169);
INSERT INTO edit_permissions(position, directory) VALUES (38, 169);
INSERT INTO edit_permissions(position, directory) VALUES (41, 169);
INSERT INTO edit_permissions(position, directory) VALUES (42, 169);
INSERT INTO edit_permissions(position, directory) VALUES (43, 169);
INSERT INTO edit_permissions(position, directory) VALUES (47, 169);
INSERT INTO edit_permissions(position, directory) VALUES (51, 169);
INSERT INTO edit_permissions(position, directory) VALUES (54, 169);
INSERT INTO edit_permissions(position, directory) VALUES (55, 169);
INSERT INTO edit_permissions(position, directory) VALUES (56, 169);
INSERT INTO edit_permissions(position, directory) VALUES (60, 169);
INSERT INTO edit_permissions(position, directory) VALUES (64, 169);
INSERT INTO edit_permissions(position, directory) VALUES (67, 169);
INSERT INTO edit_permissions(position, directory) VALUES (68, 169);
INSERT INTO edit_permissions(position, directory) VALUES (69, 169);
INSERT INTO edit_permissions(position, directory) VALUES (73, 169);
INSERT INTO edit_permissions(position, directory) VALUES (77, 169);
INSERT INTO edit_permissions(position, directory) VALUES (80, 169);
INSERT INTO edit_permissions(position, directory) VALUES (81, 169);
INSERT INTO edit_permissions(position, directory) VALUES (82, 169);
INSERT INTO edit_permissions(position, directory) VALUES (86, 169);
INSERT INTO edit_permissions(position, directory) VALUES (90, 169);
INSERT INTO edit_permissions(position, directory) VALUES (93, 169);
INSERT INTO edit_permissions(position, directory) VALUES (94, 169);
INSERT INTO edit_permissions(position, directory) VALUES (95, 169);
INSERT INTO edit_permissions(position, directory) VALUES (99, 169);
INSERT INTO edit_permissions(position, directory) VALUES (103, 169);
INSERT INTO edit_permissions(position, directory) VALUES (106, 169);
INSERT INTO edit_permissions(position, directory) VALUES (107, 169);
INSERT INTO edit_permissions(position, directory) VALUES (108, 169);
INSERT INTO edit_permissions(position, directory) VALUES (112, 169);
INSERT INTO edit_permissions(position, directory) VALUES (116, 169);
INSERT INTO edit_permissions(position, directory) VALUES (119, 169);
INSERT INTO edit_permissions(position, directory) VALUES (120, 169);
INSERT INTO edit_permissions(position, directory) VALUES (121, 169);
INSERT INTO edit_permissions(position, directory) VALUES (125, 169);
INSERT INTO edit_permissions(position, directory) VALUES (129, 169);
INSERT INTO edit_permissions(position, directory) VALUES (132, 169);
INSERT INTO edit_permissions(position, directory) VALUES (133, 169);
INSERT INTO edit_permissions(position, directory) VALUES (134, 169);
INSERT INTO edit_permissions(position, directory) VALUES (138, 169);
INSERT INTO edit_permissions(position, directory) VALUES (142, 169);
INSERT INTO edit_permissions(position, directory) VALUES (145, 169);
INSERT INTO edit_permissions(position, directory) VALUES (146, 169);
INSERT INTO edit_permissions(position, directory) VALUES (147, 169);
INSERT INTO edit_permissions(position, directory) VALUES (151, 169);
INSERT INTO edit_permissions(position, directory) VALUES (155, 169);
INSERT INTO edit_permissions(position, directory) VALUES (158, 169);
INSERT INTO edit_permissions(position, directory) VALUES (159, 169);
INSERT INTO edit_permissions(position, directory) VALUES (160, 169);
INSERT INTO edit_permissions(position, directory) VALUES (164, 169);
INSERT INTO edit_permissions(position, directory) VALUES (168, 169);
INSERT INTO edit_permissions(position, directory) VALUES (171, 169);
INSERT INTO edit_permissions(position, directory) VALUES (172, 169);
INSERT INTO edit_permissions(position, directory) VALUES (173, 169);
INSERT INTO edit_permissions(position, directory) VALUES (177, 169);
INSERT INTO edit_permissions(position, directory) VALUES (181, 169);
INSERT INTO edit_permissions(position, directory) VALUES (184, 169);
INSERT INTO edit_permissions(position, directory) VALUES (185, 169);
INSERT INTO edit_permissions(position, directory) VALUES (186, 169);
INSERT INTO edit_permissions(position, directory) VALUES (190, 169);
INSERT INTO edit_permissions(position, directory) VALUES (194, 169);
INSERT INTO edit_permissions(position, directory) VALUES (197, 169);
INSERT INTO edit_permissions(position, directory) VALUES (198, 169);
INSERT INTO edit_permissions(position, directory) VALUES (199, 169);
INSERT INTO edit_permissions(position, directory) VALUES (203, 169);
INSERT INTO edit_permissions(position, directory) VALUES (207, 169);
INSERT INTO edit_permissions(position, directory) VALUES (210, 169);
INSERT INTO edit_permissions(position, directory) VALUES (211, 169);
INSERT INTO edit_permissions(position, directory) VALUES (212, 169);
INSERT INTO edit_permissions(position, directory) VALUES (216, 169);
INSERT INTO edit_permissions(position, directory) VALUES (220, 169);
INSERT INTO edit_permissions(position, directory) VALUES (223, 169);
INSERT INTO edit_permissions(position, directory) VALUES (224, 169);
INSERT INTO edit_permissions(position, directory) VALUES (225, 169);

--   Budget

INSERT INTO read_permissions(position, directory) VALUES (16,170);
INSERT INTO read_permissions(position, directory) VALUES (17,170);
INSERT INTO read_permissions(position, directory) VALUES (18,170);
INSERT INTO read_permissions(position, directory) VALUES (19,170);
INSERT INTO read_permissions(position, directory) VALUES (20,170);
INSERT INTO read_permissions(position, directory) VALUES (21,170);
INSERT INTO read_permissions(position, directory) VALUES (22,170);
INSERT INTO read_permissions(position, directory) VALUES (229,170);
INSERT INTO read_permissions(position, directory) VALUES (231,170);
INSERT INTO read_permissions(position, directory) VALUES (295,170);
INSERT INTO read_permissions(position, directory) VALUES (296,170);
INSERT INTO read_permissions(position, directory) VALUES (34, 170);
INSERT INTO read_permissions(position, directory) VALUES (38, 170);
INSERT INTO read_permissions(position, directory) VALUES (41, 170);
INSERT INTO read_permissions(position, directory) VALUES (42, 170);
INSERT INTO read_permissions(position, directory) VALUES (43, 170);
INSERT INTO read_permissions(position, directory) VALUES (47, 170);
INSERT INTO read_permissions(position, directory) VALUES (51, 170);
INSERT INTO read_permissions(position, directory) VALUES (54, 170);
INSERT INTO read_permissions(position, directory) VALUES (55, 170);
INSERT INTO read_permissions(position, directory) VALUES (56, 170);
INSERT INTO read_permissions(position, directory) VALUES (60, 170);
INSERT INTO read_permissions(position, directory) VALUES (64, 170);
INSERT INTO read_permissions(position, directory) VALUES (67, 170);
INSERT INTO read_permissions(position, directory) VALUES (68, 170);
INSERT INTO read_permissions(position, directory) VALUES (69, 170);
INSERT INTO read_permissions(position, directory) VALUES (73, 170);
INSERT INTO read_permissions(position, directory) VALUES (77, 170);
INSERT INTO read_permissions(position, directory) VALUES (80, 170);
INSERT INTO read_permissions(position, directory) VALUES (81, 170);

INSERT INTO read_permissions(position, directory) VALUES (82, 170);
INSERT INTO read_permissions(position, directory) VALUES (86, 170);
INSERT INTO read_permissions(position, directory) VALUES (90, 170);
INSERT INTO read_permissions(position, directory) VALUES (93, 170);
INSERT INTO read_permissions(position, directory) VALUES (94, 170);
INSERT INTO read_permissions(position, directory) VALUES (95, 170);
INSERT INTO read_permissions(position, directory) VALUES (99, 170);
INSERT INTO read_permissions(position, directory) VALUES (103, 170);
INSERT INTO read_permissions(position, directory) VALUES (106, 170);
INSERT INTO read_permissions(position, directory) VALUES (107, 170);
INSERT INTO read_permissions(position, directory) VALUES (108, 170);
INSERT INTO read_permissions(position, directory) VALUES (112, 170);
INSERT INTO read_permissions(position, directory) VALUES (116, 170);
INSERT INTO read_permissions(position, directory) VALUES (119, 170);
INSERT INTO read_permissions(position, directory) VALUES (120, 170);
INSERT INTO read_permissions(position, directory) VALUES (121, 170);
INSERT INTO read_permissions(position, directory) VALUES (125, 170);
INSERT INTO read_permissions(position, directory) VALUES (129, 170);
INSERT INTO read_permissions(position, directory) VALUES (132, 170);
INSERT INTO read_permissions(position, directory) VALUES (133, 170);
INSERT INTO read_permissions(position, directory) VALUES (134, 170);
INSERT INTO read_permissions(position, directory) VALUES (138, 170);
INSERT INTO read_permissions(position, directory) VALUES (142, 170);
INSERT INTO read_permissions(position, directory) VALUES (145, 170);
INSERT INTO read_permissions(position, directory) VALUES (146, 170);
INSERT INTO read_permissions(position, directory) VALUES (147, 170);
INSERT INTO read_permissions(position, directory) VALUES (151, 170);
INSERT INTO read_permissions(position, directory) VALUES (155, 170);
INSERT INTO read_permissions(position, directory) VALUES (158, 170);
INSERT INTO read_permissions(position, directory) VALUES (159, 170);
INSERT INTO read_permissions(position, directory) VALUES (160, 170);
INSERT INTO read_permissions(position, directory) VALUES (164, 170);
INSERT INTO read_permissions(position, directory) VALUES (168, 170);
INSERT INTO read_permissions(position, directory) VALUES (171, 170);
INSERT INTO read_permissions(position, directory) VALUES (172, 170);
INSERT INTO read_permissions(position, directory) VALUES (173, 170);
INSERT INTO read_permissions(position, directory) VALUES (177, 170);
INSERT INTO read_permissions(position, directory) VALUES (181, 170);
INSERT INTO read_permissions(position, directory) VALUES (184, 170);
INSERT INTO read_permissions(position, directory) VALUES (185, 170);
INSERT INTO read_permissions(position, directory) VALUES (186, 170);
INSERT INTO read_permissions(position, directory) VALUES (190, 170);
INSERT INTO read_permissions(position, directory) VALUES (194, 170);
INSERT INTO read_permissions(position, directory) VALUES (197, 170);
INSERT INTO read_permissions(position, directory) VALUES (198, 170);
INSERT INTO read_permissions(position, directory) VALUES (199, 170);
INSERT INTO read_permissions(position, directory) VALUES (203, 170);
INSERT INTO read_permissions(position, directory) VALUES (207, 170);
INSERT INTO read_permissions(position, directory) VALUES (210, 170);
INSERT INTO read_permissions(position, directory) VALUES (211, 170);
INSERT INTO read_permissions(position, directory) VALUES (212, 170);
INSERT INTO read_permissions(position, directory) VALUES (216, 170);
INSERT INTO read_permissions(position, directory) VALUES (220, 170);
INSERT INTO read_permissions(position, directory) VALUES (223, 170);
INSERT INTO read_permissions(position, directory) VALUES (224, 170);
INSERT INTO read_permissions(position, directory) VALUES (225, 170);

-- INSERT INTO edit_permissions(position, directory) VALUES (,170); ---------------------------------------------------------------------------------------------------------

-- American Education Group/Schools/Fusion Division/Leadership/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (1,171);
INSERT INTO read_permissions(position, directory) VALUES (2,171);
INSERT INTO read_permissions(position, directory) VALUES (3,171);
INSERT INTO read_permissions(position, directory) VALUES (4,171);
INSERT INTO read_permissions(position, directory) VALUES (14,171);
INSERT INTO read_permissions(position, directory) VALUES (231,171);
INSERT INTO read_permissions(position, directory) VALUES (291,171);

INSERT INTO edit_permissions(position, directory) VALUES (1,171);
INSERT INTO edit_permissions(position, directory) VALUES (2,171);
INSERT INTO edit_permissions(position, directory) VALUES (3,171);
INSERT INTO edit_permissions(position, directory) VALUES (4,171);
INSERT INTO edit_permissions(position, directory) VALUES (14,171);
INSERT INTO edit_permissions(position, directory) VALUES (231,171);
INSERT INTO edit_permissions(position, directory) VALUES (291,171);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (1,172);
INSERT INTO edit_permissions(position, directory) VALUES (2,172);
INSERT INTO edit_permissions(position, directory) VALUES (3,172);
INSERT INTO edit_permissions(position, directory) VALUES (4,172);
INSERT INTO edit_permissions(position, directory) VALUES (14,172);
INSERT INTO edit_permissions(position, directory) VALUES (231,172);
INSERT INTO edit_permissions(position, directory) VALUES (291,172);

-- American Education Group/Schools/Fusion Division/Registrar/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (44,173);
INSERT INTO read_permissions(position, directory) VALUES (57,173);
INSERT INTO read_permissions(position, directory) VALUES (70,173);
INSERT INTO read_permissions(position, directory) VALUES (83,173);
INSERT INTO read_permissions(position, directory) VALUES (96,173);
INSERT INTO read_permissions(position, directory) VALUES (109,173);
INSERT INTO read_permissions(position, directory) VALUES (122,173);
INSERT INTO read_permissions(position, directory) VALUES (135,173);
INSERT INTO read_permissions(position, directory) VALUES (148,173);
INSERT INTO read_permissions(position, directory) VALUES (161,173);
INSERT INTO read_permissions(position, directory) VALUES (174,173);
INSERT INTO read_permissions(position, directory) VALUES (187,173);
INSERT INTO read_permissions(position, directory) VALUES (200,173);
INSERT INTO read_permissions(position, directory) VALUES (213,173);
INSERT INTO read_permissions(position, directory) VALUES (226,173);
INSERT INTO read_permissions(position, directory) VALUES (231,173);
INSERT INTO read_permissions(position, directory) VALUES (291,173);

INSERT INTO edit_permissions(position, directory) VALUES (44,173);
INSERT INTO edit_permissions(position, directory) VALUES (57,173);
INSERT INTO edit_permissions(position, directory) VALUES (70,173);
INSERT INTO edit_permissions(position, directory) VALUES (83,173);
INSERT INTO edit_permissions(position, directory) VALUES (96,173);
INSERT INTO edit_permissions(position, directory) VALUES (109,173);
INSERT INTO edit_permissions(position, directory) VALUES (122,173);
INSERT INTO edit_permissions(position, directory) VALUES (135,173);
INSERT INTO edit_permissions(position, directory) VALUES (148,173);
INSERT INTO edit_permissions(position, directory) VALUES (161,173);
INSERT INTO edit_permissions(position, directory) VALUES (174,173);
INSERT INTO edit_permissions(position, directory) VALUES (187,173);
INSERT INTO edit_permissions(position, directory) VALUES (200,173);
INSERT INTO edit_permissions(position, directory) VALUES (213,173);
INSERT INTO edit_permissions(position, directory) VALUES (226,173);
INSERT INTO edit_permissions(position, directory) VALUES (231,173);
INSERT INTO edit_permissions(position, directory) VALUES (291,173);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (44,174);
INSERT INTO edit_permissions(position, directory) VALUES (57,174);
INSERT INTO edit_permissions(position, directory) VALUES (70,174);
INSERT INTO edit_permissions(position, directory) VALUES (83,174);
INSERT INTO edit_permissions(position, directory) VALUES (96,174);
INSERT INTO edit_permissions(position, directory) VALUES (109,174);
INSERT INTO edit_permissions(position, directory) VALUES (122,174);
INSERT INTO edit_permissions(position, directory) VALUES (135,174);
INSERT INTO edit_permissions(position, directory) VALUES (148,174);
INSERT INTO edit_permissions(position, directory) VALUES (161,174);
INSERT INTO edit_permissions(position, directory) VALUES (174,174);
INSERT INTO edit_permissions(position, directory) VALUES (187,174);
INSERT INTO edit_permissions(position, directory) VALUES (200,174);
INSERT INTO edit_permissions(position, directory) VALUES (213,174);
INSERT INTO edit_permissions(position, directory) VALUES (226,174);
INSERT INTO edit_permissions(position, directory) VALUES (231,174);
INSERT INTO edit_permissions(position, directory) VALUES (291,174);

--   Site Pages
INSERT INTO read_permissions(position, directory) VALUES (34,175);
INSERT INTO read_permissions(position, directory) VALUES (35,175);
INSERT INTO read_permissions(position, directory) VALUES (36,175);
INSERT INTO read_permissions(position, directory) VALUES (37,175);
INSERT INTO read_permissions(position, directory) VALUES (38,175);
INSERT INTO read_permissions(position, directory) VALUES (39,175);
INSERT INTO read_permissions(position, directory) VALUES (40,175);
INSERT INTO read_permissions(position, directory) VALUES (41,175);
INSERT INTO read_permissions(position, directory) VALUES (42,175);
INSERT INTO read_permissions(position, directory) VALUES (43,175);
INSERT INTO read_permissions(position, directory) VALUES (44,175);
INSERT INTO read_permissions(position, directory) VALUES (45,175);
INSERT INTO read_permissions(position, directory) VALUES (46,175);
INSERT INTO read_permissions(position, directory) VALUES (47,175);
INSERT INTO read_permissions(position, directory) VALUES (48,175);
INSERT INTO read_permissions(position, directory) VALUES (49,175);
INSERT INTO read_permissions(position, directory) VALUES (50,175);
INSERT INTO read_permissions(position, directory) VALUES (51,175);
INSERT INTO read_permissions(position, directory) VALUES (52,175);
INSERT INTO read_permissions(position, directory) VALUES (53,175);
INSERT INTO read_permissions(position, directory) VALUES (54,175);
INSERT INTO read_permissions(position, directory) VALUES (55,175);
INSERT INTO read_permissions(position, directory) VALUES (56,175);
INSERT INTO read_permissions(position, directory) VALUES (57,175);
INSERT INTO read_permissions(position, directory) VALUES (58,175);
INSERT INTO read_permissions(position, directory) VALUES (59,175);
INSERT INTO read_permissions(position, directory) VALUES (60,175);
INSERT INTO read_permissions(position, directory) VALUES (61,175);
INSERT INTO read_permissions(position, directory) VALUES (62,175);
INSERT INTO read_permissions(position, directory) VALUES (63,175);
INSERT INTO read_permissions(position, directory) VALUES (64,175);
INSERT INTO read_permissions(position, directory) VALUES (65,175);
INSERT INTO read_permissions(position, directory) VALUES (66,175);
INSERT INTO read_permissions(position, directory) VALUES (67,175);
INSERT INTO read_permissions(position, directory) VALUES (68,175);
INSERT INTO read_permissions(position, directory) VALUES (69,175);
INSERT INTO read_permissions(position, directory) VALUES (70,175);
INSERT INTO read_permissions(position, directory) VALUES (71,175);
INSERT INTO read_permissions(position, directory) VALUES (72,175);
INSERT INTO read_permissions(position, directory) VALUES (73,175);
INSERT INTO read_permissions(position, directory) VALUES (74,175);
INSERT INTO read_permissions(position, directory) VALUES (75,175);
INSERT INTO read_permissions(position, directory) VALUES (76,175);
INSERT INTO read_permissions(position, directory) VALUES (77,175);
INSERT INTO read_permissions(position, directory) VALUES (78,175);
INSERT INTO read_permissions(position, directory) VALUES (79,175);
INSERT INTO read_permissions(position, directory) VALUES (80,175);
INSERT INTO read_permissions(position, directory) VALUES (81,175);
INSERT INTO read_permissions(position, directory) VALUES (82,175);
INSERT INTO read_permissions(position, directory) VALUES (83,175);
INSERT INTO read_permissions(position, directory) VALUES (84,175);
INSERT INTO read_permissions(position, directory) VALUES (85,175);
INSERT INTO read_permissions(position, directory) VALUES (86,175);
INSERT INTO read_permissions(position, directory) VALUES (87,175);
INSERT INTO read_permissions(position, directory) VALUES (88,175);
INSERT INTO read_permissions(position, directory) VALUES (89,175);
INSERT INTO read_permissions(position, directory) VALUES (90,175);
INSERT INTO read_permissions(position, directory) VALUES (91,175);
INSERT INTO read_permissions(position, directory) VALUES (92,175);
INSERT INTO read_permissions(position, directory) VALUES (93,175);
INSERT INTO read_permissions(position, directory) VALUES (94,175);
INSERT INTO read_permissions(position, directory) VALUES (95,175);
INSERT INTO read_permissions(position, directory) VALUES (96,175);
INSERT INTO read_permissions(position, directory) VALUES (97,175);
INSERT INTO read_permissions(position, directory) VALUES (98,175);
INSERT INTO read_permissions(position, directory) VALUES (99,175);
INSERT INTO read_permissions(position, directory) VALUES (100,175);
INSERT INTO read_permissions(position, directory) VALUES (101,175);
INSERT INTO read_permissions(position, directory) VALUES (102,175);
INSERT INTO read_permissions(position, directory) VALUES (103,175);
INSERT INTO read_permissions(position, directory) VALUES (104,175);
INSERT INTO read_permissions(position, directory) VALUES (105,175);
INSERT INTO read_permissions(position, directory) VALUES (106,175);
INSERT INTO read_permissions(position, directory) VALUES (107,175);
INSERT INTO read_permissions(position, directory) VALUES (108,175);
INSERT INTO read_permissions(position, directory) VALUES (109,175);
INSERT INTO read_permissions(position, directory) VALUES (110,175);
INSERT INTO read_permissions(position, directory) VALUES (111,175);
INSERT INTO read_permissions(position, directory) VALUES (112,175);
INSERT INTO read_permissions(position, directory) VALUES (113,175);
INSERT INTO read_permissions(position, directory) VALUES (114,175);
INSERT INTO read_permissions(position, directory) VALUES (115,175);
INSERT INTO read_permissions(position, directory) VALUES (116,175);
INSERT INTO read_permissions(position, directory) VALUES (117,175);
INSERT INTO read_permissions(position, directory) VALUES (118,175);
INSERT INTO read_permissions(position, directory) VALUES (119,175);
INSERT INTO read_permissions(position, directory) VALUES (120,175);
INSERT INTO read_permissions(position, directory) VALUES (121,175);
INSERT INTO read_permissions(position, directory) VALUES (122,175);
INSERT INTO read_permissions(position, directory) VALUES (123,175);
INSERT INTO read_permissions(position, directory) VALUES (124,175);
INSERT INTO read_permissions(position, directory) VALUES (125,175);
INSERT INTO read_permissions(position, directory) VALUES (126,175);
INSERT INTO read_permissions(position, directory) VALUES (127,175);
INSERT INTO read_permissions(position, directory) VALUES (128,175);
INSERT INTO read_permissions(position, directory) VALUES (129,175);
INSERT INTO read_permissions(position, directory) VALUES (130,175);
INSERT INTO read_permissions(position, directory) VALUES (131,175);
INSERT INTO read_permissions(position, directory) VALUES (132,175);
INSERT INTO read_permissions(position, directory) VALUES (133,175);
INSERT INTO read_permissions(position, directory) VALUES (134,175);
INSERT INTO read_permissions(position, directory) VALUES (135,175);
INSERT INTO read_permissions(position, directory) VALUES (136,175);
INSERT INTO read_permissions(position, directory) VALUES (137,175);
INSERT INTO read_permissions(position, directory) VALUES (138,175);
INSERT INTO read_permissions(position, directory) VALUES (139,175);
INSERT INTO read_permissions(position, directory) VALUES (140,175);
INSERT INTO read_permissions(position, directory) VALUES (141,175);
INSERT INTO read_permissions(position, directory) VALUES (142,175);
INSERT INTO read_permissions(position, directory) VALUES (143,175);
INSERT INTO read_permissions(position, directory) VALUES (144,175);
INSERT INTO read_permissions(position, directory) VALUES (145,175);
INSERT INTO read_permissions(position, directory) VALUES (146,175);
INSERT INTO read_permissions(position, directory) VALUES (147,175);
INSERT INTO read_permissions(position, directory) VALUES (148,175);
INSERT INTO read_permissions(position, directory) VALUES (149,175);
INSERT INTO read_permissions(position, directory) VALUES (150,175);
INSERT INTO read_permissions(position, directory) VALUES (151,175);
INSERT INTO read_permissions(position, directory) VALUES (152,175);
INSERT INTO read_permissions(position, directory) VALUES (153,175);
INSERT INTO read_permissions(position, directory) VALUES (154,175);
INSERT INTO read_permissions(position, directory) VALUES (155,175);
INSERT INTO read_permissions(position, directory) VALUES (156,175);
INSERT INTO read_permissions(position, directory) VALUES (157,175);
INSERT INTO read_permissions(position, directory) VALUES (158,175);
INSERT INTO read_permissions(position, directory) VALUES (159,175);
INSERT INTO read_permissions(position, directory) VALUES (160,175);
INSERT INTO read_permissions(position, directory) VALUES (161,175);
INSERT INTO read_permissions(position, directory) VALUES (162,175);
INSERT INTO read_permissions(position, directory) VALUES (163,175);
INSERT INTO read_permissions(position, directory) VALUES (164,175);
INSERT INTO read_permissions(position, directory) VALUES (165,175);
INSERT INTO read_permissions(position, directory) VALUES (166,175);
INSERT INTO read_permissions(position, directory) VALUES (167,175);
INSERT INTO read_permissions(position, directory) VALUES (168,175);
INSERT INTO read_permissions(position, directory) VALUES (169,175);
INSERT INTO read_permissions(position, directory) VALUES (170,175);
INSERT INTO read_permissions(position, directory) VALUES (171,175);
INSERT INTO read_permissions(position, directory) VALUES (172,175);
INSERT INTO read_permissions(position, directory) VALUES (173,175);
INSERT INTO read_permissions(position, directory) VALUES (174,175);
INSERT INTO read_permissions(position, directory) VALUES (175,175);
INSERT INTO read_permissions(position, directory) VALUES (176,175);
INSERT INTO read_permissions(position, directory) VALUES (177,175);
INSERT INTO read_permissions(position, directory) VALUES (178,175);
INSERT INTO read_permissions(position, directory) VALUES (179,175);
INSERT INTO read_permissions(position, directory) VALUES (180,175);
INSERT INTO read_permissions(position, directory) VALUES (181,175);
INSERT INTO read_permissions(position, directory) VALUES (182,175);
INSERT INTO read_permissions(position, directory) VALUES (183,175);
INSERT INTO read_permissions(position, directory) VALUES (184,175);
INSERT INTO read_permissions(position, directory) VALUES (185,175);
INSERT INTO read_permissions(position, directory) VALUES (186,175);
INSERT INTO read_permissions(position, directory) VALUES (187,175);
INSERT INTO read_permissions(position, directory) VALUES (188,175);
INSERT INTO read_permissions(position, directory) VALUES (189,175);
INSERT INTO read_permissions(position, directory) VALUES (190,175);
INSERT INTO read_permissions(position, directory) VALUES (191,175);
INSERT INTO read_permissions(position, directory) VALUES (192,175);
INSERT INTO read_permissions(position, directory) VALUES (193,175);
INSERT INTO read_permissions(position, directory) VALUES (194,175);
INSERT INTO read_permissions(position, directory) VALUES (195,175);
INSERT INTO read_permissions(position, directory) VALUES (196,175);
INSERT INTO read_permissions(position, directory) VALUES (197,175);
INSERT INTO read_permissions(position, directory) VALUES (198,175);
INSERT INTO read_permissions(position, directory) VALUES (199,175);
INSERT INTO read_permissions(position, directory) VALUES (200,175);
INSERT INTO read_permissions(position, directory) VALUES (201,175);
INSERT INTO read_permissions(position, directory) VALUES (202,175);
INSERT INTO read_permissions(position, directory) VALUES (203,175);
INSERT INTO read_permissions(position, directory) VALUES (204,175);
INSERT INTO read_permissions(position, directory) VALUES (205,175);
INSERT INTO read_permissions(position, directory) VALUES (206,175);
INSERT INTO read_permissions(position, directory) VALUES (207,175);
INSERT INTO read_permissions(position, directory) VALUES (208,175);
INSERT INTO read_permissions(position, directory) VALUES (209,175);
INSERT INTO read_permissions(position, directory) VALUES (210,175);
INSERT INTO read_permissions(position, directory) VALUES (211,175);
INSERT INTO read_permissions(position, directory) VALUES (212,175);
INSERT INTO read_permissions(position, directory) VALUES (213,175);
INSERT INTO read_permissions(position, directory) VALUES (214,175);
INSERT INTO read_permissions(position, directory) VALUES (215,175);
INSERT INTO read_permissions(position, directory) VALUES (216,175);
INSERT INTO read_permissions(position, directory) VALUES (217,175);
INSERT INTO read_permissions(position, directory) VALUES (218,175);
INSERT INTO read_permissions(position, directory) VALUES (219,175);
INSERT INTO read_permissions(position, directory) VALUES (220,175);
INSERT INTO read_permissions(position, directory) VALUES (221,175);
INSERT INTO read_permissions(position, directory) VALUES (222,175);
INSERT INTO read_permissions(position, directory) VALUES (223,175);
INSERT INTO read_permissions(position, directory) VALUES (224,175);
INSERT INTO read_permissions(position, directory) VALUES (225,175);
INSERT INTO read_permissions(position, directory) VALUES (226,175);
INSERT INTO read_permissions(position, directory) VALUES (227,175);
INSERT INTO read_permissions(position, directory) VALUES (228,175);
INSERT INTO read_permissions(position, directory) VALUES (229,175);
INSERT INTO read_permissions(position, directory) VALUES (230,175);
INSERT INTO read_permissions(position, directory) VALUES (231,175);
INSERT INTO read_permissions(position, directory) VALUES (295,175);
INSERT INTO read_permissions(position, directory) VALUES (296,175);

INSERT INTO edit_permissions(position, directory) VALUES (44,175);
INSERT INTO edit_permissions(position, directory) VALUES (57,175);
INSERT INTO edit_permissions(position, directory) VALUES (70,175);
INSERT INTO edit_permissions(position, directory) VALUES (83,175);
INSERT INTO edit_permissions(position, directory) VALUES (96,175);
INSERT INTO edit_permissions(position, directory) VALUES (109,175);
INSERT INTO edit_permissions(position, directory) VALUES (122,175);
INSERT INTO edit_permissions(position, directory) VALUES (135,175);
INSERT INTO edit_permissions(position, directory) VALUES (148,175);
INSERT INTO edit_permissions(position, directory) VALUES (161,175);
INSERT INTO edit_permissions(position, directory) VALUES (174,175);
INSERT INTO edit_permissions(position, directory) VALUES (187,175);
INSERT INTO edit_permissions(position, directory) VALUES (200,175);
INSERT INTO edit_permissions(position, directory) VALUES (213,175);
INSERT INTO edit_permissions(position, directory) VALUES (226,175);
INSERT INTO edit_permissions(position, directory) VALUES (231,175);
INSERT INTO edit_permissions(position, directory) VALUES (296,175);

--   Transcript Requests
INSERT INTO read_permissions(position, directory) VALUES (34, 176);
INSERT INTO read_permissions(position, directory) VALUES (35, 176);
INSERT INTO read_permissions(position, directory) VALUES (36, 176);
INSERT INTO read_permissions(position, directory) VALUES (37, 176);
INSERT INTO read_permissions(position, directory) VALUES (38, 176);
INSERT INTO read_permissions(position, directory) VALUES (39, 176);

INSERT INTO read_permissions(position, directory) VALUES (40, 176);
INSERT INTO read_permissions(position, directory) VALUES (41, 176);
INSERT INTO read_permissions(position, directory) VALUES (42, 176);
INSERT INTO read_permissions(position, directory) VALUES (43, 176);
INSERT INTO read_permissions(position, directory) VALUES (44, 176);
INSERT INTO read_permissions(position, directory) VALUES (45, 176);
INSERT INTO read_permissions(position, directory) VALUES (46, 176);
INSERT INTO read_permissions(position, directory) VALUES (47, 176);
INSERT INTO read_permissions(position, directory) VALUES (48, 176);
INSERT INTO read_permissions(position, directory) VALUES (49, 176);
INSERT INTO read_permissions(position, directory) VALUES (50, 176);
INSERT INTO read_permissions(position, directory) VALUES (51, 176);
INSERT INTO read_permissions(position, directory) VALUES (52, 176);
INSERT INTO read_permissions(position, directory) VALUES (53, 176);
INSERT INTO read_permissions(position, directory) VALUES (54, 176);
INSERT INTO read_permissions(position, directory) VALUES (55, 176);
INSERT INTO read_permissions(position, directory) VALUES (56, 176);
INSERT INTO read_permissions(position, directory) VALUES (57, 176);
INSERT INTO read_permissions(position, directory) VALUES (58, 176);
INSERT INTO read_permissions(position, directory) VALUES (59, 176);
INSERT INTO read_permissions(position, directory) VALUES (60, 176);
INSERT INTO read_permissions(position, directory) VALUES (61, 176);
INSERT INTO read_permissions(position, directory) VALUES (62, 176);
INSERT INTO read_permissions(position, directory) VALUES (63, 176);
INSERT INTO read_permissions(position, directory) VALUES (64, 176);
INSERT INTO read_permissions(position, directory) VALUES (65, 176);
INSERT INTO read_permissions(position, directory) VALUES (66, 176);
INSERT INTO read_permissions(position, directory) VALUES (67, 176);
INSERT INTO read_permissions(position, directory) VALUES (68, 176);
INSERT INTO read_permissions(position, directory) VALUES (69, 176);
INSERT INTO read_permissions(position, directory) VALUES (70, 176);
INSERT INTO read_permissions(position, directory) VALUES (71, 176);
INSERT INTO read_permissions(position, directory) VALUES (72, 176);
INSERT INTO read_permissions(position, directory) VALUES (73, 176);
INSERT INTO read_permissions(position, directory) VALUES (74, 176);
INSERT INTO read_permissions(position, directory) VALUES (75, 176);
INSERT INTO read_permissions(position, directory) VALUES (76, 176);
INSERT INTO read_permissions(position, directory) VALUES (77, 176);
INSERT INTO read_permissions(position, directory) VALUES (78, 176);
INSERT INTO read_permissions(position, directory) VALUES (79, 176);
INSERT INTO read_permissions(position, directory) VALUES (80, 176);
INSERT INTO read_permissions(position, directory) VALUES (81, 176);
INSERT INTO read_permissions(position, directory) VALUES (82, 176);
INSERT INTO read_permissions(position, directory) VALUES (83, 176);
INSERT INTO read_permissions(position, directory) VALUES (84, 176);
INSERT INTO read_permissions(position, directory) VALUES (85, 176);
INSERT INTO read_permissions(position, directory) VALUES (86, 176);
INSERT INTO read_permissions(position, directory) VALUES (87, 176);
INSERT INTO read_permissions(position, directory) VALUES (88, 176);
INSERT INTO read_permissions(position, directory) VALUES (89, 176);
INSERT INTO read_permissions(position, directory) VALUES (90, 176);
INSERT INTO read_permissions(position, directory) VALUES (91, 176);
INSERT INTO read_permissions(position, directory) VALUES (92, 176);
INSERT INTO read_permissions(position, directory) VALUES (93, 176);
INSERT INTO read_permissions(position, directory) VALUES (94, 176);
INSERT INTO read_permissions(position, directory) VALUES (95, 176);
INSERT INTO read_permissions(position, directory) VALUES (96, 176);
INSERT INTO read_permissions(position, directory) VALUES (97, 176);
INSERT INTO read_permissions(position, directory) VALUES (98, 176);
INSERT INTO read_permissions(position, directory) VALUES (99, 176);
INSERT INTO read_permissions(position, directory) VALUES (100, 176);
INSERT INTO read_permissions(position, directory) VALUES (101, 176);
INSERT INTO read_permissions(position, directory) VALUES (102, 176);
INSERT INTO read_permissions(position, directory) VALUES (103, 176);
INSERT INTO read_permissions(position, directory) VALUES (104, 176);
INSERT INTO read_permissions(position, directory) VALUES (105, 176);
INSERT INTO read_permissions(position, directory) VALUES (106, 176);
INSERT INTO read_permissions(position, directory) VALUES (107, 176);
INSERT INTO read_permissions(position, directory) VALUES (108, 176);
INSERT INTO read_permissions(position, directory) VALUES (109, 176);
INSERT INTO read_permissions(position, directory) VALUES (110, 176);
INSERT INTO read_permissions(position, directory) VALUES (111, 176);
INSERT INTO read_permissions(position, directory) VALUES (112, 176);
INSERT INTO read_permissions(position, directory) VALUES (113, 176);
INSERT INTO read_permissions(position, directory) VALUES (114, 176);
INSERT INTO read_permissions(position, directory) VALUES (115, 176);
INSERT INTO read_permissions(position, directory) VALUES (116, 176);
INSERT INTO read_permissions(position, directory) VALUES (117, 176);
INSERT INTO read_permissions(position, directory) VALUES (118, 176);
INSERT INTO read_permissions(position, directory) VALUES (119, 176);
INSERT INTO read_permissions(position, directory) VALUES (120, 176);
INSERT INTO read_permissions(position, directory) VALUES (121, 176);
INSERT INTO read_permissions(position, directory) VALUES (122, 176);
INSERT INTO read_permissions(position, directory) VALUES (123, 176);
INSERT INTO read_permissions(position, directory) VALUES (124, 176);
INSERT INTO read_permissions(position, directory) VALUES (125, 176);
INSERT INTO read_permissions(position, directory) VALUES (126, 176);
INSERT INTO read_permissions(position, directory) VALUES (127, 176);
INSERT INTO read_permissions(position, directory) VALUES (128, 176);
INSERT INTO read_permissions(position, directory) VALUES (129, 176);
INSERT INTO read_permissions(position, directory) VALUES (130, 176);
INSERT INTO read_permissions(position, directory) VALUES (131, 176);
INSERT INTO read_permissions(position, directory) VALUES (132, 176);
INSERT INTO read_permissions(position, directory) VALUES (133, 176);
INSERT INTO read_permissions(position, directory) VALUES (134, 176);
INSERT INTO read_permissions(position, directory) VALUES (135, 176);
INSERT INTO read_permissions(position, directory) VALUES (136, 176);
INSERT INTO read_permissions(position, directory) VALUES (137, 176);
INSERT INTO read_permissions(position, directory) VALUES (138, 176);
INSERT INTO read_permissions(position, directory) VALUES (139, 176);
INSERT INTO read_permissions(position, directory) VALUES (140, 176);
INSERT INTO read_permissions(position, directory) VALUES (141, 176);
INSERT INTO read_permissions(position, directory) VALUES (142, 176);
INSERT INTO read_permissions(position, directory) VALUES (143, 176);
INSERT INTO read_permissions(position, directory) VALUES (144, 176);
INSERT INTO read_permissions(position, directory) VALUES (145, 176);
INSERT INTO read_permissions(position, directory) VALUES (146, 176);
INSERT INTO read_permissions(position, directory) VALUES (147, 176);
INSERT INTO read_permissions(position, directory) VALUES (148, 176);
INSERT INTO read_permissions(position, directory) VALUES (149, 176);
INSERT INTO read_permissions(position, directory) VALUES (150, 176);
INSERT INTO read_permissions(position, directory) VALUES (151, 176);
INSERT INTO read_permissions(position, directory) VALUES (152, 176);
INSERT INTO read_permissions(position, directory) VALUES (153, 176);
INSERT INTO read_permissions(position, directory) VALUES (154, 176);
INSERT INTO read_permissions(position, directory) VALUES (155, 176);
INSERT INTO read_permissions(position, directory) VALUES (156, 176);
INSERT INTO read_permissions(position, directory) VALUES (157, 176);
INSERT INTO read_permissions(position, directory) VALUES (158, 176);
INSERT INTO read_permissions(position, directory) VALUES (159, 176);
INSERT INTO read_permissions(position, directory) VALUES (160, 176);
INSERT INTO read_permissions(position, directory) VALUES (161, 176);
INSERT INTO read_permissions(position, directory) VALUES (162, 176);
INSERT INTO read_permissions(position, directory) VALUES (163, 176);
INSERT INTO read_permissions(position, directory) VALUES (164, 176);
INSERT INTO read_permissions(position, directory) VALUES (165, 176);
INSERT INTO read_permissions(position, directory) VALUES (166, 176);
INSERT INTO read_permissions(position, directory) VALUES (167, 176);
INSERT INTO read_permissions(position, directory) VALUES (168, 176);
INSERT INTO read_permissions(position, directory) VALUES (169, 176);
INSERT INTO read_permissions(position, directory) VALUES (170, 176);
INSERT INTO read_permissions(position, directory) VALUES (171, 176);
INSERT INTO read_permissions(position, directory) VALUES (172, 176);
INSERT INTO read_permissions(position, directory) VALUES (173, 176);
INSERT INTO read_permissions(position, directory) VALUES (174, 176);
INSERT INTO read_permissions(position, directory) VALUES (175, 176);
INSERT INTO read_permissions(position, directory) VALUES (176, 176);
INSERT INTO read_permissions(position, directory) VALUES (177, 176);
INSERT INTO read_permissions(position, directory) VALUES (178, 176);
INSERT INTO read_permissions(position, directory) VALUES (179, 176);
INSERT INTO read_permissions(position, directory) VALUES (180, 176);
INSERT INTO read_permissions(position, directory) VALUES (181, 176);
INSERT INTO read_permissions(position, directory) VALUES (182, 176);
INSERT INTO read_permissions(position, directory) VALUES (183, 176);
INSERT INTO read_permissions(position, directory) VALUES (184, 176);
INSERT INTO read_permissions(position, directory) VALUES (185, 176);
INSERT INTO read_permissions(position, directory) VALUES (186, 176);
INSERT INTO read_permissions(position, directory) VALUES (187, 176);
INSERT INTO read_permissions(position, directory) VALUES (188, 176);
INSERT INTO read_permissions(position, directory) VALUES (189, 176);
INSERT INTO read_permissions(position, directory) VALUES (190, 176);
INSERT INTO read_permissions(position, directory) VALUES (191, 176);
INSERT INTO read_permissions(position, directory) VALUES (192, 176);
INSERT INTO read_permissions(position, directory) VALUES (193, 176);
INSERT INTO read_permissions(position, directory) VALUES (194, 176);
INSERT INTO read_permissions(position, directory) VALUES (195, 176);
INSERT INTO read_permissions(position, directory) VALUES (196, 176);
INSERT INTO read_permissions(position, directory) VALUES (197, 176);
INSERT INTO read_permissions(position, directory) VALUES (198, 176);
INSERT INTO read_permissions(position, directory) VALUES (199, 176);
INSERT INTO read_permissions(position, directory) VALUES (200, 176);
INSERT INTO read_permissions(position, directory) VALUES (201, 176);
INSERT INTO read_permissions(position, directory) VALUES (202, 176);
INSERT INTO read_permissions(position, directory) VALUES (203, 176);
INSERT INTO read_permissions(position, directory) VALUES (204, 176);
INSERT INTO read_permissions(position, directory) VALUES (205, 176);
INSERT INTO read_permissions(position, directory) VALUES (206, 176);
INSERT INTO read_permissions(position, directory) VALUES (207, 176);
INSERT INTO read_permissions(position, directory) VALUES (208, 176);
INSERT INTO read_permissions(position, directory) VALUES (209, 176);
INSERT INTO read_permissions(position, directory) VALUES (210, 176);
INSERT INTO read_permissions(position, directory) VALUES (211, 176);
INSERT INTO read_permissions(position, directory) VALUES (212, 176);
INSERT INTO read_permissions(position, directory) VALUES (213, 176);
INSERT INTO read_permissions(position, directory) VALUES (214, 176);
INSERT INTO read_permissions(position, directory) VALUES (215, 176);
INSERT INTO read_permissions(position, directory) VALUES (216, 176);
INSERT INTO read_permissions(position, directory) VALUES (217, 176);
INSERT INTO read_permissions(position, directory) VALUES (218, 176);
INSERT INTO read_permissions(position, directory) VALUES (219, 176);
INSERT INTO read_permissions(position, directory) VALUES (220, 176);
INSERT INTO read_permissions(position, directory) VALUES (221, 176);
INSERT INTO read_permissions(position, directory) VALUES (222, 176);
INSERT INTO read_permissions(position, directory) VALUES (223, 176);
INSERT INTO read_permissions(position, directory) VALUES (224, 176);
INSERT INTO read_permissions(position, directory) VALUES (225, 176);
INSERT INTO read_permissions(position, directory) VALUES (226, 176);
INSERT INTO read_permissions(position, directory) VALUES (227, 176);
INSERT INTO read_permissions(position, directory) VALUES (228, 176);
INSERT INTO read_permissions(position, directory) VALUES (229, 176);
INSERT INTO read_permissions(position, directory) VALUES (230, 176);
INSERT INTO read_permissions(position, directory) VALUES (231, 176);
INSERT INTO read_permissions(position, directory) VALUES (295, 176);
INSERT INTO read_permissions(position, directory) VALUES (296, 176);

INSERT INTO edit_permissions(position, directory) VALUES (34, 176);
INSERT INTO edit_permissions(position, directory) VALUES (35, 176);
INSERT INTO edit_permissions(position, directory) VALUES (36, 176);
INSERT INTO edit_permissions(position, directory) VALUES (37, 176);
INSERT INTO edit_permissions(position, directory) VALUES (38, 176);
INSERT INTO edit_permissions(position, directory) VALUES (39, 176);
INSERT INTO edit_permissions(position, directory) VALUES (40, 176);
INSERT INTO edit_permissions(position, directory) VALUES (41, 176);
INSERT INTO edit_permissions(position, directory) VALUES (42, 176);
INSERT INTO edit_permissions(position, directory) VALUES (43, 176);
INSERT INTO edit_permissions(position, directory) VALUES (44, 176);
INSERT INTO edit_permissions(position, directory) VALUES (45, 176);
INSERT INTO edit_permissions(position, directory) VALUES (46, 176);
INSERT INTO edit_permissions(position, directory) VALUES (47, 176);
INSERT INTO edit_permissions(position, directory) VALUES (48, 176);
INSERT INTO edit_permissions(position, directory) VALUES (49, 176);
INSERT INTO edit_permissions(position, directory) VALUES (50, 176);
INSERT INTO edit_permissions(position, directory) VALUES (51, 176);
INSERT INTO edit_permissions(position, directory) VALUES (52, 176);
INSERT INTO edit_permissions(position, directory) VALUES (53, 176);
INSERT INTO edit_permissions(position, directory) VALUES (54, 176);
INSERT INTO edit_permissions(position, directory) VALUES (55, 176);
INSERT INTO edit_permissions(position, directory) VALUES (56, 176);
INSERT INTO edit_permissions(position, directory) VALUES (57, 176);
INSERT INTO edit_permissions(position, directory) VALUES (58, 176);
INSERT INTO edit_permissions(position, directory) VALUES (59, 176);
INSERT INTO edit_permissions(position, directory) VALUES (60, 176);
INSERT INTO edit_permissions(position, directory) VALUES (61, 176);
INSERT INTO edit_permissions(position, directory) VALUES (62, 176);
INSERT INTO edit_permissions(position, directory) VALUES (63, 176);
INSERT INTO edit_permissions(position, directory) VALUES (64, 176);
INSERT INTO edit_permissions(position, directory) VALUES (65, 176);
INSERT INTO edit_permissions(position, directory) VALUES (66, 176);
INSERT INTO edit_permissions(position, directory) VALUES (67, 176);
INSERT INTO edit_permissions(position, directory) VALUES (68, 176);
INSERT INTO edit_permissions(position, directory) VALUES (69, 176);
INSERT INTO edit_permissions(position, directory) VALUES (70, 176);
INSERT INTO edit_permissions(position, directory) VALUES (71, 176);
INSERT INTO edit_permissions(position, directory) VALUES (72, 176);
INSERT INTO edit_permissions(position, directory) VALUES (73, 176);
INSERT INTO edit_permissions(position, directory) VALUES (74, 176);
INSERT INTO edit_permissions(position, directory) VALUES (75, 176);
INSERT INTO edit_permissions(position, directory) VALUES (76, 176);
INSERT INTO edit_permissions(position, directory) VALUES (77, 176);
INSERT INTO edit_permissions(position, directory) VALUES (78, 176);
INSERT INTO edit_permissions(position, directory) VALUES (79, 176);
INSERT INTO edit_permissions(position, directory) VALUES (80, 176);
INSERT INTO edit_permissions(position, directory) VALUES (81, 176);
INSERT INTO edit_permissions(position, directory) VALUES (82, 176);
INSERT INTO edit_permissions(position, directory) VALUES (83, 176);
INSERT INTO edit_permissions(position, directory) VALUES (84, 176);
INSERT INTO edit_permissions(position, directory) VALUES (85, 176);
INSERT INTO edit_permissions(position, directory) VALUES (86, 176);
INSERT INTO edit_permissions(position, directory) VALUES (87, 176);
INSERT INTO edit_permissions(position, directory) VALUES (88, 176);
INSERT INTO edit_permissions(position, directory) VALUES (89, 176);
INSERT INTO edit_permissions(position, directory) VALUES (90, 176);
INSERT INTO edit_permissions(position, directory) VALUES (91, 176);
INSERT INTO edit_permissions(position, directory) VALUES (92, 176);
INSERT INTO edit_permissions(position, directory) VALUES (93, 176);
INSERT INTO edit_permissions(position, directory) VALUES (94, 176);
INSERT INTO edit_permissions(position, directory) VALUES (95, 176);
INSERT INTO edit_permissions(position, directory) VALUES (96, 176);
INSERT INTO edit_permissions(position, directory) VALUES (97, 176);
INSERT INTO edit_permissions(position, directory) VALUES (98, 176);
INSERT INTO edit_permissions(position, directory) VALUES (99, 176);
INSERT INTO edit_permissions(position, directory) VALUES (100, 176);
INSERT INTO edit_permissions(position, directory) VALUES (101, 176);
INSERT INTO edit_permissions(position, directory) VALUES (102, 176);
INSERT INTO edit_permissions(position, directory) VALUES (103, 176);
INSERT INTO edit_permissions(position, directory) VALUES (104, 176);
INSERT INTO edit_permissions(position, directory) VALUES (105, 176);
INSERT INTO edit_permissions(position, directory) VALUES (106, 176);
INSERT INTO edit_permissions(position, directory) VALUES (107, 176);
INSERT INTO edit_permissions(position, directory) VALUES (108, 176);
INSERT INTO edit_permissions(position, directory) VALUES (109, 176);
INSERT INTO edit_permissions(position, directory) VALUES (110, 176);
INSERT INTO edit_permissions(position, directory) VALUES (111, 176);
INSERT INTO edit_permissions(position, directory) VALUES (112, 176);
INSERT INTO edit_permissions(position, directory) VALUES (113, 176);
INSERT INTO edit_permissions(position, directory) VALUES (114, 176);
INSERT INTO edit_permissions(position, directory) VALUES (115, 176);
INSERT INTO edit_permissions(position, directory) VALUES (116, 176);
INSERT INTO edit_permissions(position, directory) VALUES (117, 176);
INSERT INTO edit_permissions(position, directory) VALUES (118, 176);
INSERT INTO edit_permissions(position, directory) VALUES (119, 176);
INSERT INTO edit_permissions(position, directory) VALUES (120, 176);
INSERT INTO edit_permissions(position, directory) VALUES (121, 176);
INSERT INTO edit_permissions(position, directory) VALUES (122, 176);
INSERT INTO edit_permissions(position, directory) VALUES (123, 176);
INSERT INTO edit_permissions(position, directory) VALUES (124, 176);
INSERT INTO edit_permissions(position, directory) VALUES (125, 176);
INSERT INTO edit_permissions(position, directory) VALUES (126, 176);
INSERT INTO edit_permissions(position, directory) VALUES (127, 176);
INSERT INTO edit_permissions(position, directory) VALUES (128, 176);
INSERT INTO edit_permissions(position, directory) VALUES (129, 176);
INSERT INTO edit_permissions(position, directory) VALUES (130, 176);
INSERT INTO edit_permissions(position, directory) VALUES (131, 176);
INSERT INTO edit_permissions(position, directory) VALUES (132, 176);
INSERT INTO edit_permissions(position, directory) VALUES (133, 176);
INSERT INTO edit_permissions(position, directory) VALUES (134, 176);
INSERT INTO edit_permissions(position, directory) VALUES (135, 176);
INSERT INTO edit_permissions(position, directory) VALUES (136, 176);
INSERT INTO edit_permissions(position, directory) VALUES (137, 176);
INSERT INTO edit_permissions(position, directory) VALUES (138, 176);
INSERT INTO edit_permissions(position, directory) VALUES (139, 176);
INSERT INTO edit_permissions(position, directory) VALUES (140, 176);
INSERT INTO edit_permissions(position, directory) VALUES (141, 176);
INSERT INTO edit_permissions(position, directory) VALUES (142, 176);
INSERT INTO edit_permissions(position, directory) VALUES (143, 176);
INSERT INTO edit_permissions(position, directory) VALUES (144, 176);
INSERT INTO edit_permissions(position, directory) VALUES (145, 176);
INSERT INTO edit_permissions(position, directory) VALUES (146, 176);
INSERT INTO edit_permissions(position, directory) VALUES (147, 176);
INSERT INTO edit_permissions(position, directory) VALUES (148, 176);
INSERT INTO edit_permissions(position, directory) VALUES (149, 176);
INSERT INTO edit_permissions(position, directory) VALUES (150, 176);
INSERT INTO edit_permissions(position, directory) VALUES (151, 176);
INSERT INTO edit_permissions(position, directory) VALUES (152, 176);
INSERT INTO edit_permissions(position, directory) VALUES (153, 176);
INSERT INTO edit_permissions(position, directory) VALUES (154, 176);
INSERT INTO edit_permissions(position, directory) VALUES (155, 176);
INSERT INTO edit_permissions(position, directory) VALUES (156, 176);
INSERT INTO edit_permissions(position, directory) VALUES (157, 176);
INSERT INTO edit_permissions(position, directory) VALUES (158, 176);
INSERT INTO edit_permissions(position, directory) VALUES (159, 176);
INSERT INTO edit_permissions(position, directory) VALUES (160, 176);
INSERT INTO edit_permissions(position, directory) VALUES (161, 176);
INSERT INTO edit_permissions(position, directory) VALUES (162, 176);
INSERT INTO edit_permissions(position, directory) VALUES (163, 176);
INSERT INTO edit_permissions(position, directory) VALUES (164, 176);
INSERT INTO edit_permissions(position, directory) VALUES (165, 176);
INSERT INTO edit_permissions(position, directory) VALUES (166, 176);
INSERT INTO edit_permissions(position, directory) VALUES (167, 176);
INSERT INTO edit_permissions(position, directory) VALUES (168, 176);
INSERT INTO edit_permissions(position, directory) VALUES (169, 176);
INSERT INTO edit_permissions(position, directory) VALUES (170, 176);
INSERT INTO edit_permissions(position, directory) VALUES (171, 176);
INSERT INTO edit_permissions(position, directory) VALUES (172, 176);
INSERT INTO edit_permissions(position, directory) VALUES (173, 176);
INSERT INTO edit_permissions(position, directory) VALUES (174, 176);
INSERT INTO edit_permissions(position, directory) VALUES (175, 176);
INSERT INTO edit_permissions(position, directory) VALUES (176, 176);
INSERT INTO edit_permissions(position, directory) VALUES (177, 176);
INSERT INTO edit_permissions(position, directory) VALUES (178, 176);
INSERT INTO edit_permissions(position, directory) VALUES (179, 176);
INSERT INTO edit_permissions(position, directory) VALUES (180, 176);
INSERT INTO edit_permissions(position, directory) VALUES (181, 176);
INSERT INTO edit_permissions(position, directory) VALUES (182, 176);
INSERT INTO edit_permissions(position, directory) VALUES (183, 176);
INSERT INTO edit_permissions(position, directory) VALUES (184, 176);
INSERT INTO edit_permissions(position, directory) VALUES (185, 176);
INSERT INTO edit_permissions(position, directory) VALUES (186, 176);
INSERT INTO edit_permissions(position, directory) VALUES (187, 176);
INSERT INTO edit_permissions(position, directory) VALUES (188, 176);
INSERT INTO edit_permissions(position, directory) VALUES (189, 176);
INSERT INTO edit_permissions(position, directory) VALUES (190, 176);
INSERT INTO edit_permissions(position, directory) VALUES (191, 176);
INSERT INTO edit_permissions(position, directory) VALUES (192, 176);
INSERT INTO edit_permissions(position, directory) VALUES (193, 176);
INSERT INTO edit_permissions(position, directory) VALUES (194, 176);
INSERT INTO edit_permissions(position, directory) VALUES (195, 176);
INSERT INTO edit_permissions(position, directory) VALUES (196, 176);
INSERT INTO edit_permissions(position, directory) VALUES (197, 176);
INSERT INTO edit_permissions(position, directory) VALUES (198, 176);
INSERT INTO edit_permissions(position, directory) VALUES (199, 176);
INSERT INTO edit_permissions(position, directory) VALUES (200, 176);
INSERT INTO edit_permissions(position, directory) VALUES (201, 176);
INSERT INTO edit_permissions(position, directory) VALUES (202, 176);
INSERT INTO edit_permissions(position, directory) VALUES (203, 176);
INSERT INTO edit_permissions(position, directory) VALUES (204, 176);
INSERT INTO edit_permissions(position, directory) VALUES (205, 176);
INSERT INTO edit_permissions(position, directory) VALUES (206, 176);
INSERT INTO edit_permissions(position, directory) VALUES (207, 176);
INSERT INTO edit_permissions(position, directory) VALUES (208, 176);
INSERT INTO edit_permissions(position, directory) VALUES (209, 176);
INSERT INTO edit_permissions(position, directory) VALUES (210, 176);
INSERT INTO edit_permissions(position, directory) VALUES (211, 176);
INSERT INTO edit_permissions(position, directory) VALUES (212, 176);
INSERT INTO edit_permissions(position, directory) VALUES (213, 176);
INSERT INTO edit_permissions(position, directory) VALUES (214, 176);

INSERT INTO edit_permissions(position, directory) VALUES (215, 176);
INSERT INTO edit_permissions(position, directory) VALUES (216, 176);
INSERT INTO edit_permissions(position, directory) VALUES (217, 176);
INSERT INTO edit_permissions(position, directory) VALUES (218, 176);
INSERT INTO edit_permissions(position, directory) VALUES (219, 176);
INSERT INTO edit_permissions(position, directory) VALUES (220, 176);
INSERT INTO edit_permissions(position, directory) VALUES (221, 176);
INSERT INTO edit_permissions(position, directory) VALUES (222, 176);
INSERT INTO edit_permissions(position, directory) VALUES (223, 176);
INSERT INTO edit_permissions(position, directory) VALUES (224, 176);
INSERT INTO edit_permissions(position, directory) VALUES (225, 176);
INSERT INTO edit_permissions(position, directory) VALUES (226, 176);
INSERT INTO edit_permissions(position, directory) VALUES (227, 176);
INSERT INTO edit_permissions(position, directory) VALUES (228, 176);
INSERT INTO edit_permissions(position, directory) VALUES (229, 176);
INSERT INTO edit_permissions(position, directory) VALUES (230, 176);
INSERT INTO edit_permissions(position, directory) VALUES (231, 176);
INSERT INTO edit_permissions(position, directory) VALUES (295, 176);
INSERT INTO edit_permissions(position, directory) VALUES (296, 176);

--   POC
INSERT INTO read_permissions(position, directory) VALUES (34, 177);
INSERT INTO read_permissions(position, directory) VALUES (35, 177);
INSERT INTO read_permissions(position, directory) VALUES (36, 177);
INSERT INTO read_permissions(position, directory) VALUES (37, 177);
INSERT INTO read_permissions(position, directory) VALUES (38, 177);
INSERT INTO read_permissions(position, directory) VALUES (39, 177);
INSERT INTO read_permissions(position, directory) VALUES (40, 177);
INSERT INTO read_permissions(position, directory) VALUES (41, 177);
INSERT INTO read_permissions(position, directory) VALUES (42, 177);
INSERT INTO read_permissions(position, directory) VALUES (43, 177);
INSERT INTO read_permissions(position, directory) VALUES (44, 177);
INSERT INTO read_permissions(position, directory) VALUES (45, 177);
INSERT INTO read_permissions(position, directory) VALUES (46, 177);
INSERT INTO read_permissions(position, directory) VALUES (47, 177);
INSERT INTO read_permissions(position, directory) VALUES (48, 177);
INSERT INTO read_permissions(position, directory) VALUES (49, 177);
INSERT INTO read_permissions(position, directory) VALUES (50, 177);
INSERT INTO read_permissions(position, directory) VALUES (51, 177);
INSERT INTO read_permissions(position, directory) VALUES (52, 177);
INSERT INTO read_permissions(position, directory) VALUES (53, 177);
INSERT INTO read_permissions(position, directory) VALUES (54, 177);
INSERT INTO read_permissions(position, directory) VALUES (55, 177);
INSERT INTO read_permissions(position, directory) VALUES (56, 177);
INSERT INTO read_permissions(position, directory) VALUES (57, 177);
INSERT INTO read_permissions(position, directory) VALUES (58, 177);
INSERT INTO read_permissions(position, directory) VALUES (59, 177);
INSERT INTO read_permissions(position, directory) VALUES (60, 177);
INSERT INTO read_permissions(position, directory) VALUES (61, 177);
INSERT INTO read_permissions(position, directory) VALUES (62, 177);
INSERT INTO read_permissions(position, directory) VALUES (63, 177);
INSERT INTO read_permissions(position, directory) VALUES (64, 177);
INSERT INTO read_permissions(position, directory) VALUES (65, 177);
INSERT INTO read_permissions(position, directory) VALUES (66, 177);
INSERT INTO read_permissions(position, directory) VALUES (67, 177);
INSERT INTO read_permissions(position, directory) VALUES (68, 177);
INSERT INTO read_permissions(position, directory) VALUES (69, 177);
INSERT INTO read_permissions(position, directory) VALUES (70, 177);
INSERT INTO read_permissions(position, directory) VALUES (71, 177);
INSERT INTO read_permissions(position, directory) VALUES (72, 177);
INSERT INTO read_permissions(position, directory) VALUES (73, 177);
INSERT INTO read_permissions(position, directory) VALUES (74, 177);
INSERT INTO read_permissions(position, directory) VALUES (75, 177);
INSERT INTO read_permissions(position, directory) VALUES (76, 177);
INSERT INTO read_permissions(position, directory) VALUES (77, 177);
INSERT INTO read_permissions(position, directory) VALUES (78, 177);
INSERT INTO read_permissions(position, directory) VALUES (79, 177);
INSERT INTO read_permissions(position, directory) VALUES (80, 177);
INSERT INTO read_permissions(position, directory) VALUES (81, 177);
INSERT INTO read_permissions(position, directory) VALUES (82, 177);
INSERT INTO read_permissions(position, directory) VALUES (83, 177);
INSERT INTO read_permissions(position, directory) VALUES (84, 177);
INSERT INTO read_permissions(position, directory) VALUES (85, 177);
INSERT INTO read_permissions(position, directory) VALUES (86, 177);
INSERT INTO read_permissions(position, directory) VALUES (87, 177);
INSERT INTO read_permissions(position, directory) VALUES (88, 177);
INSERT INTO read_permissions(position, directory) VALUES (89, 177);
INSERT INTO read_permissions(position, directory) VALUES (90, 177);
INSERT INTO read_permissions(position, directory) VALUES (91, 177);
INSERT INTO read_permissions(position, directory) VALUES (92, 177);
INSERT INTO read_permissions(position, directory) VALUES (93, 177);
INSERT INTO read_permissions(position, directory) VALUES (94, 177);
INSERT INTO read_permissions(position, directory) VALUES (95, 177);
INSERT INTO read_permissions(position, directory) VALUES (96, 177);
INSERT INTO read_permissions(position, directory) VALUES (97, 177);
INSERT INTO read_permissions(position, directory) VALUES (98, 177);
INSERT INTO read_permissions(position, directory) VALUES (99, 177);
INSERT INTO read_permissions(position, directory) VALUES (100, 177);
INSERT INTO read_permissions(position, directory) VALUES (101, 177);
INSERT INTO read_permissions(position, directory) VALUES (102, 177);
INSERT INTO read_permissions(position, directory) VALUES (103, 177);
INSERT INTO read_permissions(position, directory) VALUES (104, 177);
INSERT INTO read_permissions(position, directory) VALUES (105, 177);
INSERT INTO read_permissions(position, directory) VALUES (106, 177);
INSERT INTO read_permissions(position, directory) VALUES (107, 177);
INSERT INTO read_permissions(position, directory) VALUES (108, 177);
INSERT INTO read_permissions(position, directory) VALUES (109, 177);
INSERT INTO read_permissions(position, directory) VALUES (110, 177);
INSERT INTO read_permissions(position, directory) VALUES (111, 177);
INSERT INTO read_permissions(position, directory) VALUES (112, 177);
INSERT INTO read_permissions(position, directory) VALUES (113, 177);
INSERT INTO read_permissions(position, directory) VALUES (114, 177);
INSERT INTO read_permissions(position, directory) VALUES (115, 177);
INSERT INTO read_permissions(position, directory) VALUES (116, 177);
INSERT INTO read_permissions(position, directory) VALUES (117, 177);
INSERT INTO read_permissions(position, directory) VALUES (118, 177);
INSERT INTO read_permissions(position, directory) VALUES (119, 177);
INSERT INTO read_permissions(position, directory) VALUES (120, 177);
INSERT INTO read_permissions(position, directory) VALUES (121, 177);
INSERT INTO read_permissions(position, directory) VALUES (122, 177);
INSERT INTO read_permissions(position, directory) VALUES (123, 177);
INSERT INTO read_permissions(position, directory) VALUES (124, 177);
INSERT INTO read_permissions(position, directory) VALUES (125, 177);
INSERT INTO read_permissions(position, directory) VALUES (126, 177);
INSERT INTO read_permissions(position, directory) VALUES (127, 177);
INSERT INTO read_permissions(position, directory) VALUES (128, 177);
INSERT INTO read_permissions(position, directory) VALUES (129, 177);
INSERT INTO read_permissions(position, directory) VALUES (130, 177);
INSERT INTO read_permissions(position, directory) VALUES (131, 177);
INSERT INTO read_permissions(position, directory) VALUES (132, 177);
INSERT INTO read_permissions(position, directory) VALUES (133, 177);
INSERT INTO read_permissions(position, directory) VALUES (134, 177);
INSERT INTO read_permissions(position, directory) VALUES (135, 177);
INSERT INTO read_permissions(position, directory) VALUES (136, 177);
INSERT INTO read_permissions(position, directory) VALUES (137, 177);
INSERT INTO read_permissions(position, directory) VALUES (138, 177);
INSERT INTO read_permissions(position, directory) VALUES (139, 177);
INSERT INTO read_permissions(position, directory) VALUES (140, 177);
INSERT INTO read_permissions(position, directory) VALUES (141, 177);
INSERT INTO read_permissions(position, directory) VALUES (142, 177);
INSERT INTO read_permissions(position, directory) VALUES (143, 177);
INSERT INTO read_permissions(position, directory) VALUES (144, 177);
INSERT INTO read_permissions(position, directory) VALUES (145, 177);
INSERT INTO read_permissions(position, directory) VALUES (146, 177);
INSERT INTO read_permissions(position, directory) VALUES (147, 177);
INSERT INTO read_permissions(position, directory) VALUES (148, 177);
INSERT INTO read_permissions(position, directory) VALUES (149, 177);
INSERT INTO read_permissions(position, directory) VALUES (150, 177);
INSERT INTO read_permissions(position, directory) VALUES (151, 177);
INSERT INTO read_permissions(position, directory) VALUES (152, 177);
INSERT INTO read_permissions(position, directory) VALUES (153, 177);
INSERT INTO read_permissions(position, directory) VALUES (154, 177);
INSERT INTO read_permissions(position, directory) VALUES (155, 177);
INSERT INTO read_permissions(position, directory) VALUES (156, 177);
INSERT INTO read_permissions(position, directory) VALUES (157, 177);
INSERT INTO read_permissions(position, directory) VALUES (158, 177);
INSERT INTO read_permissions(position, directory) VALUES (159, 177);
INSERT INTO read_permissions(position, directory) VALUES (160, 177);
INSERT INTO read_permissions(position, directory) VALUES (161, 177);
INSERT INTO read_permissions(position, directory) VALUES (162, 177);
INSERT INTO read_permissions(position, directory) VALUES (163, 177);
INSERT INTO read_permissions(position, directory) VALUES (164, 177);
INSERT INTO read_permissions(position, directory) VALUES (165, 177);
INSERT INTO read_permissions(position, directory) VALUES (166, 177);
INSERT INTO read_permissions(position, directory) VALUES (167, 177);
INSERT INTO read_permissions(position, directory) VALUES (168, 177);
INSERT INTO read_permissions(position, directory) VALUES (169, 177);
INSERT INTO read_permissions(position, directory) VALUES (170, 177);
INSERT INTO read_permissions(position, directory) VALUES (171, 177);
INSERT INTO read_permissions(position, directory) VALUES (172, 177);
INSERT INTO read_permissions(position, directory) VALUES (173, 177);
INSERT INTO read_permissions(position, directory) VALUES (174, 177);
INSERT INTO read_permissions(position, directory) VALUES (175, 177);
INSERT INTO read_permissions(position, directory) VALUES (176, 177);
INSERT INTO read_permissions(position, directory) VALUES (177, 177);
INSERT INTO read_permissions(position, directory) VALUES (178, 177);
INSERT INTO read_permissions(position, directory) VALUES (179, 177);
INSERT INTO read_permissions(position, directory) VALUES (180, 177);
INSERT INTO read_permissions(position, directory) VALUES (181, 177);
INSERT INTO read_permissions(position, directory) VALUES (182, 177);
INSERT INTO read_permissions(position, directory) VALUES (183, 177);
INSERT INTO read_permissions(position, directory) VALUES (184, 177);
INSERT INTO read_permissions(position, directory) VALUES (185, 177);
INSERT INTO read_permissions(position, directory) VALUES (186, 177);
INSERT INTO read_permissions(position, directory) VALUES (187, 177);
INSERT INTO read_permissions(position, directory) VALUES (188, 177);
INSERT INTO read_permissions(position, directory) VALUES (189, 177);
INSERT INTO read_permissions(position, directory) VALUES (190, 177);
INSERT INTO read_permissions(position, directory) VALUES (191, 177);
INSERT INTO read_permissions(position, directory) VALUES (192, 177);
INSERT INTO read_permissions(position, directory) VALUES (193, 177);
INSERT INTO read_permissions(position, directory) VALUES (194, 177);
INSERT INTO read_permissions(position, directory) VALUES (195, 177);
INSERT INTO read_permissions(position, directory) VALUES (196, 177);
INSERT INTO read_permissions(position, directory) VALUES (197, 177);
INSERT INTO read_permissions(position, directory) VALUES (198, 177);
INSERT INTO read_permissions(position, directory) VALUES (199, 177);
INSERT INTO read_permissions(position, directory) VALUES (200, 177);
INSERT INTO read_permissions(position, directory) VALUES (201, 177);
INSERT INTO read_permissions(position, directory) VALUES (202, 177);
INSERT INTO read_permissions(position, directory) VALUES (203, 177);
INSERT INTO read_permissions(position, directory) VALUES (204, 177);
INSERT INTO read_permissions(position, directory) VALUES (205, 177);
INSERT INTO read_permissions(position, directory) VALUES (206, 177);
INSERT INTO read_permissions(position, directory) VALUES (207, 177);
INSERT INTO read_permissions(position, directory) VALUES (208, 177);
INSERT INTO read_permissions(position, directory) VALUES (209, 177);
INSERT INTO read_permissions(position, directory) VALUES (210, 177);
INSERT INTO read_permissions(position, directory) VALUES (211, 177);
INSERT INTO read_permissions(position, directory) VALUES (212, 177);
INSERT INTO read_permissions(position, directory) VALUES (213, 177);
INSERT INTO read_permissions(position, directory) VALUES (214, 177);
INSERT INTO read_permissions(position, directory) VALUES (215, 177);
INSERT INTO read_permissions(position, directory) VALUES (216, 177);
INSERT INTO read_permissions(position, directory) VALUES (217, 177);
INSERT INTO read_permissions(position, directory) VALUES (218, 177);
INSERT INTO read_permissions(position, directory) VALUES (219, 177);
INSERT INTO read_permissions(position, directory) VALUES (220, 177);
INSERT INTO read_permissions(position, directory) VALUES (221, 177);
INSERT INTO read_permissions(position, directory) VALUES (222, 177);
INSERT INTO read_permissions(position, directory) VALUES (223, 177);
INSERT INTO read_permissions(position, directory) VALUES (224, 177);
INSERT INTO read_permissions(position, directory) VALUES (225, 177);
INSERT INTO read_permissions(position, directory) VALUES (226, 177);
INSERT INTO read_permissions(position, directory) VALUES (227, 177);
INSERT INTO read_permissions(position, directory) VALUES (228, 177);
INSERT INTO read_permissions(position, directory) VALUES (229, 177);
INSERT INTO read_permissions(position, directory) VALUES (230, 177);
INSERT INTO read_permissions(position, directory) VALUES (231, 177);
INSERT INTO read_permissions(position, directory) VALUES (295, 177);
INSERT INTO read_permissions(position, directory) VALUES (296, 177);

INSERT INTO edit_permissions(position, directory) VALUES (34, 177);
INSERT INTO edit_permissions(position, directory) VALUES (35, 177);
INSERT INTO edit_permissions(position, directory) VALUES (36, 177);
INSERT INTO edit_permissions(position, directory) VALUES (37, 177);
INSERT INTO edit_permissions(position, directory) VALUES (38, 177);
INSERT INTO edit_permissions(position, directory) VALUES (39, 177);
INSERT INTO edit_permissions(position, directory) VALUES (40, 177);
INSERT INTO edit_permissions(position, directory) VALUES (41, 177);
INSERT INTO edit_permissions(position, directory) VALUES (42, 177);
INSERT INTO edit_permissions(position, directory) VALUES (43, 177);
INSERT INTO edit_permissions(position, directory) VALUES (44, 177);
INSERT INTO edit_permissions(position, directory) VALUES (45, 177);
INSERT INTO edit_permissions(position, directory) VALUES (46, 177);
INSERT INTO edit_permissions(position, directory) VALUES (47, 177);
INSERT INTO edit_permissions(position, directory) VALUES (48, 177);
INSERT INTO edit_permissions(position, directory) VALUES (49, 177);
INSERT INTO edit_permissions(position, directory) VALUES (50, 177);
INSERT INTO edit_permissions(position, directory) VALUES (51, 177);
INSERT INTO edit_permissions(position, directory) VALUES (52, 177);
INSERT INTO edit_permissions(position, directory) VALUES (53, 177);
INSERT INTO edit_permissions(position, directory) VALUES (54, 177);
INSERT INTO edit_permissions(position, directory) VALUES (55, 177);
INSERT INTO edit_permissions(position, directory) VALUES (56, 177);
INSERT INTO edit_permissions(position, directory) VALUES (57, 177);
INSERT INTO edit_permissions(position, directory) VALUES (58, 177);
INSERT INTO edit_permissions(position, directory) VALUES (59, 177);
INSERT INTO edit_permissions(position, directory) VALUES (60, 177);
INSERT INTO edit_permissions(position, directory) VALUES (61, 177);
INSERT INTO edit_permissions(position, directory) VALUES (62, 177);
INSERT INTO edit_permissions(position, directory) VALUES (63, 177);
INSERT INTO edit_permissions(position, directory) VALUES (64, 177);
INSERT INTO edit_permissions(position, directory) VALUES (65, 177);
INSERT INTO edit_permissions(position, directory) VALUES (66, 177);
INSERT INTO edit_permissions(position, directory) VALUES (67, 177);
INSERT INTO edit_permissions(position, directory) VALUES (68, 177);
INSERT INTO edit_permissions(position, directory) VALUES (69, 177);
INSERT INTO edit_permissions(position, directory) VALUES (70, 177);
INSERT INTO edit_permissions(position, directory) VALUES (71, 177);
INSERT INTO edit_permissions(position, directory) VALUES (72, 177);
INSERT INTO edit_permissions(position, directory) VALUES (73, 177);
INSERT INTO edit_permissions(position, directory) VALUES (74, 177);
INSERT INTO edit_permissions(position, directory) VALUES (75, 177);
INSERT INTO edit_permissions(position, directory) VALUES (76, 177);
INSERT INTO edit_permissions(position, directory) VALUES (77, 177);
INSERT INTO edit_permissions(position, directory) VALUES (78, 177);
INSERT INTO edit_permissions(position, directory) VALUES (79, 177);
INSERT INTO edit_permissions(position, directory) VALUES (80, 177);
INSERT INTO edit_permissions(position, directory) VALUES (81, 177);
INSERT INTO edit_permissions(position, directory) VALUES (82, 177);
INSERT INTO edit_permissions(position, directory) VALUES (83, 177);
INSERT INTO edit_permissions(position, directory) VALUES (84, 177);
INSERT INTO edit_permissions(position, directory) VALUES (85, 177);
INSERT INTO edit_permissions(position, directory) VALUES (86, 177);
INSERT INTO edit_permissions(position, directory) VALUES (87, 177);
INSERT INTO edit_permissions(position, directory) VALUES (88, 177);
INSERT INTO edit_permissions(position, directory) VALUES (89, 177);
INSERT INTO edit_permissions(position, directory) VALUES (90, 177);
INSERT INTO edit_permissions(position, directory) VALUES (91, 177);
INSERT INTO edit_permissions(position, directory) VALUES (92, 177);
INSERT INTO edit_permissions(position, directory) VALUES (93, 177);
INSERT INTO edit_permissions(position, directory) VALUES (94, 177);
INSERT INTO edit_permissions(position, directory) VALUES (95, 177);
INSERT INTO edit_permissions(position, directory) VALUES (96, 177);
INSERT INTO edit_permissions(position, directory) VALUES (97, 177);
INSERT INTO edit_permissions(position, directory) VALUES (98, 177);
INSERT INTO edit_permissions(position, directory) VALUES (99, 177);
INSERT INTO edit_permissions(position, directory) VALUES (100, 177);
INSERT INTO edit_permissions(position, directory) VALUES (101, 177);
INSERT INTO edit_permissions(position, directory) VALUES (102, 177);
INSERT INTO edit_permissions(position, directory) VALUES (103, 177);
INSERT INTO edit_permissions(position, directory) VALUES (104, 177);
INSERT INTO edit_permissions(position, directory) VALUES (105, 177);
INSERT INTO edit_permissions(position, directory) VALUES (106, 177);
INSERT INTO edit_permissions(position, directory) VALUES (107, 177);
INSERT INTO edit_permissions(position, directory) VALUES (108, 177);
INSERT INTO edit_permissions(position, directory) VALUES (109, 177);
INSERT INTO edit_permissions(position, directory) VALUES (110, 177);
INSERT INTO edit_permissions(position, directory) VALUES (111, 177);
INSERT INTO edit_permissions(position, directory) VALUES (112, 177);
INSERT INTO edit_permissions(position, directory) VALUES (113, 177);
INSERT INTO edit_permissions(position, directory) VALUES (114, 177);
INSERT INTO edit_permissions(position, directory) VALUES (115, 177);
INSERT INTO edit_permissions(position, directory) VALUES (116, 177);
INSERT INTO edit_permissions(position, directory) VALUES (117, 177);
INSERT INTO edit_permissions(position, directory) VALUES (118, 177);
INSERT INTO edit_permissions(position, directory) VALUES (119, 177);
INSERT INTO edit_permissions(position, directory) VALUES (120, 177);
INSERT INTO edit_permissions(position, directory) VALUES (121, 177);
INSERT INTO edit_permissions(position, directory) VALUES (122, 177);
INSERT INTO edit_permissions(position, directory) VALUES (123, 177);
INSERT INTO edit_permissions(position, directory) VALUES (124, 177);
INSERT INTO edit_permissions(position, directory) VALUES (125, 177);
INSERT INTO edit_permissions(position, directory) VALUES (126, 177);
INSERT INTO edit_permissions(position, directory) VALUES (127, 177);
INSERT INTO edit_permissions(position, directory) VALUES (128, 177);
INSERT INTO edit_permissions(position, directory) VALUES (129, 177);
INSERT INTO edit_permissions(position, directory) VALUES (130, 177);
INSERT INTO edit_permissions(position, directory) VALUES (131, 177);
INSERT INTO edit_permissions(position, directory) VALUES (132, 177);
INSERT INTO edit_permissions(position, directory) VALUES (133, 177);
INSERT INTO edit_permissions(position, directory) VALUES (134, 177);
INSERT INTO edit_permissions(position, directory) VALUES (135, 177);
INSERT INTO edit_permissions(position, directory) VALUES (136, 177);
INSERT INTO edit_permissions(position, directory) VALUES (137, 177);
INSERT INTO edit_permissions(position, directory) VALUES (138, 177);
INSERT INTO edit_permissions(position, directory) VALUES (139, 177);
INSERT INTO edit_permissions(position, directory) VALUES (140, 177);
INSERT INTO edit_permissions(position, directory) VALUES (141, 177);
INSERT INTO edit_permissions(position, directory) VALUES (142, 177);
INSERT INTO edit_permissions(position, directory) VALUES (143, 177);
INSERT INTO edit_permissions(position, directory) VALUES (144, 177);
INSERT INTO edit_permissions(position, directory) VALUES (145, 177);
INSERT INTO edit_permissions(position, directory) VALUES (146, 177);
INSERT INTO edit_permissions(position, directory) VALUES (147, 177);
INSERT INTO edit_permissions(position, directory) VALUES (148, 177);
INSERT INTO edit_permissions(position, directory) VALUES (149, 177);
INSERT INTO edit_permissions(position, directory) VALUES (150, 177);
INSERT INTO edit_permissions(position, directory) VALUES (151, 177);
INSERT INTO edit_permissions(position, directory) VALUES (152, 177);
INSERT INTO edit_permissions(position, directory) VALUES (153, 177);
INSERT INTO edit_permissions(position, directory) VALUES (154, 177);
INSERT INTO edit_permissions(position, directory) VALUES (155, 177);
INSERT INTO edit_permissions(position, directory) VALUES (156, 177);
INSERT INTO edit_permissions(position, directory) VALUES (157, 177);
INSERT INTO edit_permissions(position, directory) VALUES (158, 177);
INSERT INTO edit_permissions(position, directory) VALUES (159, 177);
INSERT INTO edit_permissions(position, directory) VALUES (160, 177);
INSERT INTO edit_permissions(position, directory) VALUES (161, 177);
INSERT INTO edit_permissions(position, directory) VALUES (162, 177);
INSERT INTO edit_permissions(position, directory) VALUES (163, 177);
INSERT INTO edit_permissions(position, directory) VALUES (164, 177);
INSERT INTO edit_permissions(position, directory) VALUES (165, 177);
INSERT INTO edit_permissions(position, directory) VALUES (166, 177);
INSERT INTO edit_permissions(position, directory) VALUES (167, 177);
INSERT INTO edit_permissions(position, directory) VALUES (168, 177);
INSERT INTO edit_permissions(position, directory) VALUES (169, 177);
INSERT INTO edit_permissions(position, directory) VALUES (170, 177);
INSERT INTO edit_permissions(position, directory) VALUES (171, 177);
INSERT INTO edit_permissions(position, directory) VALUES (172, 177);
INSERT INTO edit_permissions(position, directory) VALUES (173, 177);
INSERT INTO edit_permissions(position, directory) VALUES (174, 177);
INSERT INTO edit_permissions(position, directory) VALUES (175, 177);
INSERT INTO edit_permissions(position, directory) VALUES (176, 177);
INSERT INTO edit_permissions(position, directory) VALUES (177, 177);
INSERT INTO edit_permissions(position, directory) VALUES (178, 177);
INSERT INTO edit_permissions(position, directory) VALUES (179, 177);
INSERT INTO edit_permissions(position, directory) VALUES (180, 177);
INSERT INTO edit_permissions(position, directory) VALUES (181, 177);
INSERT INTO edit_permissions(position, directory) VALUES (182, 177);
INSERT INTO edit_permissions(position, directory) VALUES (183, 177);
INSERT INTO edit_permissions(position, directory) VALUES (184, 177);
INSERT INTO edit_permissions(position, directory) VALUES (185, 177);
INSERT INTO edit_permissions(position, directory) VALUES (186, 177);
INSERT INTO edit_permissions(position, directory) VALUES (187, 177);
INSERT INTO edit_permissions(position, directory) VALUES (188, 177);
INSERT INTO edit_permissions(position, directory) VALUES (189, 177);
INSERT INTO edit_permissions(position, directory) VALUES (190, 177);
INSERT INTO edit_permissions(position, directory) VALUES (191, 177);
INSERT INTO edit_permissions(position, directory) VALUES (192, 177);
INSERT INTO edit_permissions(position, directory) VALUES (193, 177);
INSERT INTO edit_permissions(position, directory) VALUES (194, 177);
INSERT INTO edit_permissions(position, directory) VALUES (195, 177);
INSERT INTO edit_permissions(position, directory) VALUES (196, 177);
INSERT INTO edit_permissions(position, directory) VALUES (197, 177);
INSERT INTO edit_permissions(position, directory) VALUES (198, 177);
INSERT INTO edit_permissions(position, directory) VALUES (199, 177);
INSERT INTO edit_permissions(position, directory) VALUES (200, 177);
INSERT INTO edit_permissions(position, directory) VALUES (201, 177);
INSERT INTO edit_permissions(position, directory) VALUES (202, 177);
INSERT INTO edit_permissions(position, directory) VALUES (203, 177);
INSERT INTO edit_permissions(position, directory) VALUES (204, 177);
INSERT INTO edit_permissions(position, directory) VALUES (205, 177);
INSERT INTO edit_permissions(position, directory) VALUES (206, 177);
INSERT INTO edit_permissions(position, directory) VALUES (207, 177);
INSERT INTO edit_permissions(position, directory) VALUES (208, 177);
INSERT INTO edit_permissions(position, directory) VALUES (209, 177);
INSERT INTO edit_permissions(position, directory) VALUES (210, 177);
INSERT INTO edit_permissions(position, directory) VALUES (211, 177);
INSERT INTO edit_permissions(position, directory) VALUES (212, 177);
INSERT INTO edit_permissions(position, directory) VALUES (213, 177);
INSERT INTO edit_permissions(position, directory) VALUES (214, 177);
INSERT INTO edit_permissions(position, directory) VALUES (215, 177);
INSERT INTO edit_permissions(position, directory) VALUES (216, 177);
INSERT INTO edit_permissions(position, directory) VALUES (217, 177);
INSERT INTO edit_permissions(position, directory) VALUES (218, 177);
INSERT INTO edit_permissions(position, directory) VALUES (219, 177);
INSERT INTO edit_permissions(position, directory) VALUES (220, 177);
INSERT INTO edit_permissions(position, directory) VALUES (221, 177);
INSERT INTO edit_permissions(position, directory) VALUES (222, 177);
INSERT INTO edit_permissions(position, directory) VALUES (223, 177);
INSERT INTO edit_permissions(position, directory) VALUES (224, 177);
INSERT INTO edit_permissions(position, directory) VALUES (225, 177);
INSERT INTO edit_permissions(position, directory) VALUES (226, 177);
INSERT INTO edit_permissions(position, directory) VALUES (227, 177);
INSERT INTO edit_permissions(position, directory) VALUES (228, 177);
INSERT INTO edit_permissions(position, directory) VALUES (229, 177);
INSERT INTO edit_permissions(position, directory) VALUES (230, 177);
INSERT INTO edit_permissions(position, directory) VALUES (231, 177);
INSERT INTO edit_permissions(position, directory) VALUES (295, 177);
INSERT INTO edit_permissions(position, directory) VALUES (296, 177);

-- Americane Education Group/Schools/Fusion Division/Curriculum/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (7,178);
INSERT INTO read_permissions(position, directory) VALUES (8,178);
INSERT INTO read_permissions(position, directory) VALUES (9,178);
INSERT INTO read_permissions(position, directory) VALUES (10,178);
INSERT INTO read_permissions(position, directory) VALUES (231,178);
INSERT INTO read_permissions(position, directory) VALUES (296,178);

INSERT INTO edit_permissions(position, directory) VALUES (7,178);
INSERT INTO edit_permissions(position, directory) VALUES (8,178);
INSERT INTO edit_permissions(position, directory) VALUES (9,178);
INSERT INTO edit_permissions(position, directory) VALUES (10,178);
INSERT INTO edit_permissions(position, directory) VALUES (231,178);
INSERT INTO edit_permissions(position, directory) VALUES (296,178);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (7,179);
INSERT INTO edit_permissions(position, directory) VALUES (8,179);
INSERT INTO edit_permissions(position, directory) VALUES (9,179);
INSERT INTO edit_permissions(position, directory) VALUES (10,179);
INSERT INTO edit_permissions(position, directory) VALUES (231,179);
INSERT INTO edit_permissions(position, directory) VALUES (296,179);

-- Americane Education Group/Schools/Fusion Division/Curriculum/EPICenter!/
--   Public
-- INSERT INTO edit_permissions(position, directory) VALUES (,180); (case-by-case)

-- American Education Group/Schools/Fusion Division/Training/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (229,181);
INSERT INTO read_permissions(position, directory) VALUES (231,181);
INSERT INTO read_permissions(position, directory) VALUES (232,181);
INSERT INTO read_permissions(position, directory) VALUES (296,181);

INSERT INTO edit_permissions(position, directory) VALUES (229,181);
INSERT INTO edit_permissions(position, directory) VALUES (231,181);
INSERT INTO edit_permissions(position, directory) VALUES (232,181);
INSERT INTO edit_permissions(position, directory) VALUES (296,181);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (229,182);
INSERT INTO edit_permissions(position, directory) VALUES (231,182);
INSERT INTO edit_permissions(position, directory) VALUES (232,182);
INSERT INTO edit_permissions(position, directory) VALUES (296,182);

-- American Education Group/Schools/Lexis/Barnstable/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (233,183);
INSERT INTO read_permissions(position, directory) VALUES (234,183);
INSERT INTO read_permissions(position, directory) VALUES (235,183);
INSERT INTO read_permissions(position, directory) VALUES (236,183);
INSERT INTO read_permissions(position, directory) VALUES (237,183);
INSERT INTO read_permissions(position, directory) VALUES (238,183);

INSERT INTO edit_permissions(position, directory) VALUES (233,183);
INSERT INTO edit_permissions(position, directory) VALUES (234,183);
INSERT INTO edit_permissions(position, directory) VALUES (235,183);
INSERT INTO edit_permissions(position, directory) VALUES (236,183);
INSERT INTO edit_permissions(position, directory) VALUES (237,183);
INSERT INTO edit_permissions(position, directory) VALUES (238,183);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (233,184);
INSERT INTO edit_permissions(position, directory) VALUES (234,184);
INSERT INTO edit_permissions(position, directory) VALUES (235,184);
INSERT INTO edit_permissions(position, directory) VALUES (236,184);
INSERT INTO edit_permissions(position, directory) VALUES (237,184);
INSERT INTO edit_permissions(position, directory) VALUES (238,184);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (233,185);
INSERT INTO read_permissions(position, directory) VALUES (234,185);
INSERT INTO read_permissions(position, directory) VALUES (235,185);
INSERT INTO read_permissions(position, directory) VALUES (236,185);



INSERT INTO edit_permissions(position, directory) VALUES (233,185);
INSERT INTO edit_permissions(position, directory) VALUES (234,185);
INSERT INTO edit_permissions(position, directory) VALUES (235,185);
INSERT INTO edit_permissions(position, directory) VALUES (236,185);

--   School
INSERT INTO read_permissions(position, directory) VALUES (233,186);
INSERT INTO read_permissions(position, directory) VALUES (234,186);
INSERT INTO read_permissions(position, directory) VALUES (235,186);
INSERT INTO read_permissions(position, directory) VALUES (236,186);
INSERT INTO read_permissions(position, directory) VALUES (237,186);
INSERT INTO read_permissions(position, directory) VALUES (238,186);

INSERT INTO edit_permissions(position, directory) VALUES (233,186);
INSERT INTO edit_permissions(position, directory) VALUES (234,186);
INSERT INTO edit_permissions(position, directory) VALUES (235,186);
INSERT INTO edit_permissions(position, directory) VALUES (236,186);
INSERT INTO edit_permissions(position, directory) VALUES (237,186);
INSERT INTO edit_permissions(position, directory) VALUES (238,186);

--   Sick or Coverage
INSERT INTO read_permissions(position, directory) VALUES (233,187);
INSERT INTO read_permissions(position, directory) VALUES (234,187);
INSERT INTO read_permissions(position, directory) VALUES (235,187);
INSERT INTO read_permissions(position, directory) VALUES (236,187);
INSERT INTO read_permissions(position, directory) VALUES (237,187);
INSERT INTO read_permissions(position, directory) VALUES (238,187);

INSERT INTO edit_permissions(position, directory) VALUES (233,187);
INSERT INTO edit_permissions(position, directory) VALUES (234,187);
INSERT INTO edit_permissions(position, directory) VALUES (235,187);
INSERT INTO edit_permissions(position, directory) VALUES (236,187);
INSERT INTO edit_permissions(position, directory) VALUES (237,187);
INSERT INTO edit_permissions(position, directory) VALUES (238,187);

-- American Education Group/Schools/Lexis/Shreiner/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (239,188);
INSERT INTO read_permissions(position, directory) VALUES (240,188);
INSERT INTO read_permissions(position, directory) VALUES (241,188);
INSERT INTO read_permissions(position, directory) VALUES (242,188);
INSERT INTO read_permissions(position, directory) VALUES (243,188);

INSERT INTO edit_permissions(position, directory) VALUES (239,188);
INSERT INTO edit_permissions(position, directory) VALUES (240,188);
INSERT INTO edit_permissions(position, directory) VALUES (241,188);
INSERT INTO edit_permissions(position, directory) VALUES (242,188);
INSERT INTO edit_permissions(position, directory) VALUES (243,188);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (239,189);
INSERT INTO edit_permissions(position, directory) VALUES (240,189);
INSERT INTO edit_permissions(position, directory) VALUES (241,189);
INSERT INTO edit_permissions(position, directory) VALUES (242,189);
INSERT INTO edit_permissions(position, directory) VALUES (243,189);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (239,190);
INSERT INTO read_permissions(position, directory) VALUES (240,190);
INSERT INTO read_permissions(position, directory) VALUES (241,190);

INSERT INTO edit_permissions(position, directory) VALUES (239,190);
INSERT INTO edit_permissions(position, directory) VALUES (240,190);
INSERT INTO edit_permissions(position, directory) VALUES (241,190);

--   School
INSERT INTO read_permissions(position, directory) VALUES (239,191);
INSERT INTO read_permissions(position, directory) VALUES (240,191);
INSERT INTO read_permissions(position, directory) VALUES (241,191);
INSERT INTO read_permissions(position, directory) VALUES (242,191);
INSERT INTO read_permissions(position, directory) VALUES (243,191);

INSERT INTO edit_permissions(position, directory) VALUES (239,191);
INSERT INTO edit_permissions(position, directory) VALUES (240,191);
INSERT INTO edit_permissions(position, directory) VALUES (241,191);
INSERT INTO edit_permissions(position, directory) VALUES (242,191);
INSERT INTO edit_permissions(position, directory) VALUES (243,191);

--   Sick or Coverage
INSERT INTO read_permissions(position, directory) VALUES (239,192);
INSERT INTO read_permissions(position, directory) VALUES (240,192);
INSERT INTO read_permissions(position, directory) VALUES (241,192);
INSERT INTO read_permissions(position, directory) VALUES (242,192);
INSERT INTO read_permissions(position, directory) VALUES (243,192);

INSERT INTO edit_permissions(position, directory) VALUES (239,192);
INSERT INTO edit_permissions(position, directory) VALUES (240,192);
INSERT INTO edit_permissions(position, directory) VALUES (241,192);
INSERT INTO edit_permissions(position, directory) VALUES (242,192);
INSERT INTO edit_permissions(position, directory) VALUES (243,192);

-- American Education Group/Schools/Lexis/Tampa Day/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (244,193);
INSERT INTO read_permissions(position, directory) VALUES (245,193);
INSERT INTO read_permissions(position, directory) VALUES (246,193);
INSERT INTO read_permissions(position, directory) VALUES (247,193);
INSERT INTO read_permissions(position, directory) VALUES (248,193);
INSERT INTO read_permissions(position, directory) VALUES (249,193);
INSERT INTO read_permissions(position, directory) VALUES (250,193);
INSERT INTO read_permissions(position, directory) VALUES (251,193);

INSERT INTO edit_permissions(position, directory) VALUES (244,193);
INSERT INTO edit_permissions(position, directory) VALUES (245,193);
INSERT INTO edit_permissions(position, directory) VALUES (246,193);
INSERT INTO edit_permissions(position, directory) VALUES (247,193);
INSERT INTO edit_permissions(position, directory) VALUES (248,193);
INSERT INTO edit_permissions(position, directory) VALUES (249,193);
INSERT INTO edit_permissions(position, directory) VALUES (250,193);
INSERT INTO edit_permissions(position, directory) VALUES (251,193);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (244,194);
INSERT INTO edit_permissions(position, directory) VALUES (245,194);
INSERT INTO edit_permissions(position, directory) VALUES (246,194);
INSERT INTO edit_permissions(position, directory) VALUES (247,194);
INSERT INTO edit_permissions(position, directory) VALUES (248,194);
INSERT INTO edit_permissions(position, directory) VALUES (249,194);
INSERT INTO edit_permissions(position, directory) VALUES (250,194);
INSERT INTO edit_permissions(position, directory) VALUES (251,194);

--   Administrators
INSERT INTO read_permissions(position, directory) VALUES (244,195);
INSERT INTO read_permissions(position, directory) VALUES (247,195);
INSERT INTO read_permissions(position, directory) VALUES (248,195);

INSERT INTO edit_permissions(position, directory) VALUES (244,195);
INSERT INTO edit_permissions(position, directory) VALUES (247,195);
INSERT INTO edit_permissions(position, directory) VALUES (248,195);

--   School
INSERT INTO read_permissions(position, directory) VALUES (244,196);
INSERT INTO read_permissions(position, directory) VALUES (245,196);
INSERT INTO read_permissions(position, directory) VALUES (246,196);
INSERT INTO read_permissions(position, directory) VALUES (247,196);
INSERT INTO read_permissions(position, directory) VALUES (248,196);
INSERT INTO read_permissions(position, directory) VALUES (249,196);
INSERT INTO read_permissions(position, directory) VALUES (250,196);
INSERT INTO read_permissions(position, directory) VALUES (251,196);

INSERT INTO edit_permissions(position, directory) VALUES (244,196);
INSERT INTO edit_permissions(position, directory) VALUES (245,196);
INSERT INTO edit_permissions(position, directory) VALUES (246,196);
INSERT INTO edit_permissions(position, directory) VALUES (247,196);
INSERT INTO edit_permissions(position, directory) VALUES (248,196);
INSERT INTO edit_permissions(position, directory) VALUES (249,196);
INSERT INTO edit_permissions(position, directory) VALUES (250,196);
INSERT INTO edit_permissions(position, directory) VALUES (251,196);

--   Sick or Coverage
INSERT INTO read_permissions(position, directory) VALUES (244,197);
INSERT INTO read_permissions(position, directory) VALUES (245,197);
INSERT INTO read_permissions(position, directory) VALUES (246,197);
INSERT INTO read_permissions(position, directory) VALUES (247,197);
INSERT INTO read_permissions(position, directory) VALUES (248,197);
INSERT INTO read_permissions(position, directory) VALUES (249,197);
INSERT INTO read_permissions(position, directory) VALUES (250,197);
INSERT INTO read_permissions(position, directory) VALUES (251,197);

INSERT INTO edit_permissions(position, directory) VALUES (244,197);
INSERT INTO edit_permissions(position, directory) VALUES (245,197);
INSERT INTO edit_permissions(position, directory) VALUES (246,197);
INSERT INTO edit_permissions(position, directory) VALUES (247,197);
INSERT INTO edit_permissions(position, directory) VALUES (248,197);
INSERT INTO edit_permissions(position, directory) VALUES (249,197);
INSERT INTO edit_permissions(position, directory) VALUES (250,197);
INSERT INTO edit_permissions(position, directory) VALUES (251,197);

-- American Education Group/Schools/Lexis/Talking Heads/
--   Leadership
INSERT INTO read_permissions(position, directory) VALUES (233,198);
INSERT INTO read_permissions(position, directory) VALUES (239,198);
INSERT INTO read_permissions(position, directory) VALUES (244,198);

INSERT INTO edit_permissions(position, directory) VALUES (233,198);
INSERT INTO edit_permissions(position, directory) VALUES (239,198);
INSERT INTO edit_permissions(position, directory) VALUES (244,198);

--   EPIC! Customer Service
-- INSERT INTO read_permissions(position, directory) VALUES (,199); ----------------------------------------------------------------------------------------------------------

-- INSERT INTO edit_permissions(position, directory) VALUES (,199);

-- American Education Group/Schools/Lexis/Curriculum/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (233,200);
INSERT INTO read_permissions(position, directory) VALUES (234,200);
INSERT INTO read_permissions(position, directory) VALUES (235,200);
INSERT INTO read_permissions(position, directory) VALUES (236,200);
INSERT INTO read_permissions(position, directory) VALUES (237,200);
INSERT INTO read_permissions(position, directory) VALUES (238,200);
INSERT INTO read_permissions(position, directory) VALUES (239,200);
INSERT INTO read_permissions(position, directory) VALUES (240,200);
INSERT INTO read_permissions(position, directory) VALUES (241,200);
INSERT INTO read_permissions(position, directory) VALUES (242,200);
INSERT INTO read_permissions(position, directory) VALUES (243,200);
INSERT INTO read_permissions(position, directory) VALUES (244,200);
INSERT INTO read_permissions(position, directory) VALUES (245,200);
INSERT INTO read_permissions(position, directory) VALUES (246,200);
INSERT INTO read_permissions(position, directory) VALUES (247,200);
INSERT INTO read_permissions(position, directory) VALUES (248,200);
INSERT INTO read_permissions(position, directory) VALUES (249,200);
INSERT INTO read_permissions(position, directory) VALUES (250,200);
INSERT INTO read_permissions(position, directory) VALUES (251,200);

INSERT INTO edit_permissions(position, directory) VALUES (233,200);
INSERT INTO edit_permissions(position, directory) VALUES (234,200);
INSERT INTO edit_permissions(position, directory) VALUES (235,200);
INSERT INTO edit_permissions(position, directory) VALUES (236,200);
INSERT INTO edit_permissions(position, directory) VALUES (237,200);
INSERT INTO edit_permissions(position, directory) VALUES (238,200);
INSERT INTO edit_permissions(position, directory) VALUES (239,200);
INSERT INTO edit_permissions(position, directory) VALUES (240,200);
INSERT INTO edit_permissions(position, directory) VALUES (241,200);
INSERT INTO edit_permissions(position, directory) VALUES (242,200);
INSERT INTO edit_permissions(position, directory) VALUES (243,200);
INSERT INTO edit_permissions(position, directory) VALUES (244,200);
INSERT INTO edit_permissions(position, directory) VALUES (245,200);
INSERT INTO edit_permissions(position, directory) VALUES (246,200);
INSERT INTO edit_permissions(position, directory) VALUES (247,200);
INSERT INTO edit_permissions(position, directory) VALUES (248,200);
INSERT INTO edit_permissions(position, directory) VALUES (249,200);
INSERT INTO edit_permissions(position, directory) VALUES (250,200);
INSERT INTO edit_permissions(position, directory) VALUES (251,200);

--   Public
INSERT INTO edit_permissions(position, directory) VALUES (233,201);
INSERT INTO edit_permissions(position, directory) VALUES (234,201);
INSERT INTO edit_permissions(position, directory) VALUES (235,201);
INSERT INTO edit_permissions(position, directory) VALUES (236,201);
INSERT INTO edit_permissions(position, directory) VALUES (237,201);
INSERT INTO edit_permissions(position, directory) VALUES (238,201);
INSERT INTO edit_permissions(position, directory) VALUES (239,201);
INSERT INTO edit_permissions(position, directory) VALUES (240,201);
INSERT INTO edit_permissions(position, directory) VALUES (241,201);
INSERT INTO edit_permissions(position, directory) VALUES (242,201);
INSERT INTO edit_permissions(position, directory) VALUES (243,201);
INSERT INTO edit_permissions(position, directory) VALUES (244,201);
INSERT INTO edit_permissions(position, directory) VALUES (245,201);
INSERT INTO edit_permissions(position, directory) VALUES (246,201);
INSERT INTO edit_permissions(position, directory) VALUES (247,201);
INSERT INTO edit_permissions(position, directory) VALUES (248,201);
INSERT INTO edit_permissions(position, directory) VALUES (249,201);
INSERT INTO edit_permissions(position, directory) VALUES (250,201);

INSERT INTO edit_permissions(position, directory) VALUES (251,201);

-- American Education Group/Schools/Lexis/Scholarship/
--   Private
INSERT INTO read_permissions(position, directory) VALUES (233,202);
INSERT INTO read_permissions(position, directory) VALUES (234,202);
INSERT INTO read_permissions(position, directory) VALUES (235,202);
INSERT INTO read_permissions(position, directory) VALUES (236,202);
INSERT INTO read_permissions(position, directory) VALUES (237,202);
INSERT INTO read_permissions(position, directory) VALUES (238,202);
INSERT INTO read_permissions(position, directory) VALUES (239,202);
INSERT INTO read_permissions(position, directory) VALUES (240,202);
INSERT INTO read_permissions(position, directory) VALUES (241,202);
INSERT INTO read_permissions(position, directory) VALUES (242,202);
INSERT INTO read_permissions(position, directory) VALUES (243,202);
INSERT INTO read_permissions(position, directory) VALUES (244,202);
INSERT INTO read_permissions(position, directory) VALUES (245,202);
INSERT INTO read_permissions(position, directory) VALUES (246,202);
INSERT INTO read_permissions(position, directory) VALUES (247,202);
INSERT INTO read_permissions(position, directory) VALUES (248,202);
INSERT INTO read_permissions(position, directory) VALUES (249,202);
INSERT INTO read_permissions(position, directory) VALUES (250,202);
INSERT INTO read_permissions(position, directory) VALUES (251,202);

INSERT INTO edit_permissions(position, directory) VALUES (233,202);
INSERT INTO edit_permissions(position, directory) VALUES (234,202);
INSERT INTO edit_permissions(position, directory) VALUES (235,202);
INSERT INTO edit_permissions(position, directory) VALUES (236,202);
INSERT INTO edit_permissions(position, directory) VALUES (237,202);
INSERT INTO edit_permissions(position, directory) VALUES (238,202);
INSERT INTO edit_permissions(position, directory) VALUES (239,202);
INSERT INTO edit_permissions(position, directory) VALUES (240,202);
INSERT INTO edit_permissions(position, directory) VALUES (241,202);
INSERT INTO edit_permissions(position, directory) VALUES (242,202);
INSERT INTO edit_permissions(position, directory) VALUES (243,202);
INSERT INTO edit_permissions(position, directory) VALUES (244,202);
INSERT INTO edit_permissions(position, directory) VALUES (245,202);
INSERT INTO edit_permissions(position, directory) VALUES (246,202);
INSERT INTO edit_permissions(position, directory) VALUES (247,202);
INSERT INTO edit_permissions(position, directory) VALUES (248,202);
INSERT INTO edit_permissions(position, directory) VALUES (249,202);
INSERT INTO edit_permissions(position, directory) VALUES (250,202);
INSERT INTO edit_permissions(position, directory) VALUES (251,202);

-- distribution_groups
INSERT INTO distribution_groups(dgName) VALUES ("AEGStaffAll");									-- 1
INSERT INTO distribution_groups(dgName) VALUES ("FusionAssistantDirector_DG");					-- 2
INSERT INTO distribution_groups(dgName) VALUES ("FusionDirectorOfFirstImpressions_DG");			-- 3
INSERT INTO distribution_groups(dgName) VALUES ("FusionDirectorOfStudentDevelopment_DG");		-- 4
INSERT INTO distribution_groups(dgName) VALUES ("FusionHeadOfSchool_DG");						-- 5
INSERT INTO distribution_groups(dgName) VALUES ("FusionInformationSpecialist_DG");				-- 6
INSERT INTO distribution_groups(dgName) VALUES ("FusionMasterTeacher_DG");						-- 7
INSERT INTO distribution_groups(dgName) VALUES ("FusionOutreach_DG");							-- 8
INSERT INTO distribution_groups(dgName) VALUES ("FusionRegional_DG");							-- 9
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffALL_DG");							-- 10
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffHB_DG");							-- 11
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffLA_DG");							-- 12
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffLG_DG");							-- 13
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffLI_DG");							-- 14
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffMN_DG");							-- 15
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffMV_DG");							-- 16
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffPD_DG");							-- 17
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffSB_DG");							-- 18
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffSD_DG");							-- 19
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffSF_DG");							-- 20
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffSLB_DG");							-- 21
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffSM_DG");							-- 22
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffWC_DG");							-- 23
INSERT INTO distribution_groups(dgName) VALUES ("FusionStaffWCR_DG");							-- 24
INSERT INTO distribution_groups(dgName) VALUES ("LexisStaffAll_DG");							-- 25
INSERT INTO distribution_groups(dgName) VALUES ("LSAssociateDirectors_DG");						-- 26
INSERT INTO distribution_groups(dgName) VALUES ("LSBostonDirectors_DG");						-- 27
INSERT INTO distribution_groups(dgName) VALUES ("LSCurriculumTeam_DG");							-- 28
INSERT INTO distribution_groups(dgName) VALUES ("LSExecutiveDirector_DG");						-- 29
INSERT INTO distribution_groups(dgName) VALUES ("LSExecutiveDirectorandAssociateDirectors_DG");	-- 30
INSERT INTO distribution_groups(dgName) VALUES ("LSInnovationsMeetingParticipants");			-- 31
INSERT INTO distribution_groups(dgName) VALUES ("LSMVDirectors_DG");							-- 32
INSERT INTO distribution_groups(dgName) VALUES ("LSSeniorManagementTeam_DG");					-- 33
INSERT INTO distribution_groups(dgName) VALUES ("LSStaffAll_DG");								-- 34
INSERT INTO distribution_groups(dgName) VALUES ("LSTrainingTeam_DG");							-- 35
INSERT INTO distribution_groups(dgName) VALUES ("ShreinerStaffAll_DG");							-- 36
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayAdmin_DG");							-- 37
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayCamp_DG");								-- 38
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayFriends_DG");							-- 39
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayFrontOffice_DG");						-- 40
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayInfo_DG");								-- 41
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayLowerDivision_DG");					-- 42
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayNews_DG");								-- 43
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayParents_DG");							-- 44
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayPta_DG");								-- 45
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayRead_DG");								-- 46
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayStaffAll_DG");							-- 47
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayTds_DG");								-- 48
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayTechnology_DG");						-- 49
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayTest_DG");								-- 50
INSERT INTO distribution_groups(dgName) VALUES ("TampaDayUpperDivision_DG");					-- 51
INSERT INTO distribution_groups(dgName) VALUES ("TampaDay_DG");									-- 52
INSERT INTO distribution_groups(dgName) VALUES ("DGAccessAll_DG");								-- 53

-- receive_dg
--   AEGStaffAll
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,1);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,2);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,3);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,4);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,5);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,6);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,7);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,8);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,9);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,10);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,11);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,12);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,13);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,14);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,15);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,16);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,17);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,18);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,19);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,20);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,21);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,22);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,23);

INSERT INTO receive_dg(distributionGroup, position) VALUES (1,24);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,25);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,26);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,27);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,28);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,29);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,30);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,31);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,32);
INSERT INTO receive_dg(distributionGroup, position) VALUES (1,33);

--   FusionAssistantDirector_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,34);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,47);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,60);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,73);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,86);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,99);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,112);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,125);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,138);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,151);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,164);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,177);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,190);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,203);
INSERT INTO receive_dg(distributionGroup, position) VALUES (2,216);

--   FusionDirectorOfFirstImpressions_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,37);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,50);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,63);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,76);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,89);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,102);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,115);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,128);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,141);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,154);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,167);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,180);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,193);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,206);
INSERT INTO receive_dg(distributionGroup, position) VALUES (3,219);

--   FusionDirectorOfStudentDevelopment_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,38);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,51);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,64);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,77);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,90);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,103);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,116);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,129);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,142);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,155);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,168);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,181);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,194);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,207);
INSERT INTO receive_dg(distributionGroup, position) VALUES (4,220);


--   FusionHeadOfSchool_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,41);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,54);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,67);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,80);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,93);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,106);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,119);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,132);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,145);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,158);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,171);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,184);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,197);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,210);
INSERT INTO receive_dg(distributionGroup, position) VALUES (5,223);

--   FusionInformationSpecialist_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,42);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,55);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,68);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,81);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,94);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,107);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,120);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,133);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,146);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,159);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,172);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,185);

INSERT INTO receive_dg(distributionGroup, position) VALUES (6,198);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,211);
INSERT INTO receive_dg(distributionGroup, position) VALUES (6,224);

--   FusionMasterTeacher_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,43);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,56);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,69);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,82);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,95);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,108);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,121);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,134);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,147);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,160);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,173);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,186);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,199);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,212);
INSERT INTO receive_dg(distributionGroup, position) VALUES (7,225);

--   FusionOutreach_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,36);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,49);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,62);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,75);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,88);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,101);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,114);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,127);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,140);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,153);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,166);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,179);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,192);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,205);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,218);
INSERT INTO receive_dg(distributionGroup, position) VALUES (8,230);

--   FusionRegional_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,229);
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,230);
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,231);
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,232);
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,295);
INSERT INTO receive_dg(distributionGroup, position) VALUES (9,296);

--   FusionStaffALL_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,34);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,35);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,36);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,37);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,38);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,39);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,40);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,41);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,42);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,43);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,44);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,45);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,46);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,47);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,48);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,49);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,50);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,51);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,52);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,53);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,54);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,55);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,56);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,57);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,58);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,59);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,60);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,61);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,62);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,63);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,64);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,65);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,66);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,67);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,68);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,69);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,70);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,71);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,72);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,73);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,74);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,75);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,76);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,77);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,78);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,79);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,80);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,81);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,82);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,83);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,84);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,85);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,86);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,87);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,88);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,89);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,90);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,91);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,92);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,93);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,94);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,95);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,96);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,97);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,98);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,99);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,100);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,101);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,102);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,103);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,104);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,105);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,106);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,107);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,108);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,109);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,110);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,111);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,112);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,113);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,114);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,115);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,116);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,117);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,118);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,119);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,120);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,121);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,122);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,123);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,124);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,125);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,126);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,127);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,128);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,129);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,130);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,131);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,132);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,133);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,134);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,135);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,136);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,137);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,138);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,139);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,140);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,141);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,142);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,143);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,144);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,145);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,146);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,147);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,148);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,149);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,150);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,151);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,152);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,153);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,154);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,155);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,156);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,157);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,158);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,159);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,160);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,161);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,162);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,163);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,164);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,165);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,166);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,167);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,168);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,169);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,170);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,171);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,172);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,173);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,174);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,175);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,176);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,177);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,178);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,179);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,180);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,181);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,182);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,183);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,184);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,185);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,186);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,187);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,188);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,189);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,190);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,191);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,192);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,193);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,194);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,195);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,196);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,197);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,198);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,199);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,200);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,201);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,202);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,203);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,204);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,205);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,206);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,207);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,208);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,209);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,210);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,211);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,212);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,213);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,214);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,215);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,216);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,217);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,218);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,219);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,220);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,221);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,222);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,223);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,224);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,225);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,226);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,227);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,228);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,229);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,230);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,231);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,232);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,233);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,234);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,235);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,236);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,237);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,238);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,239);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,240);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,241);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,242);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,243);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,244);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,245);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,246);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,247);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,248);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,249);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,250);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,251);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,252);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,253);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,254);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,255);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,256);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,257);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,258);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,259);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,260);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,261);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,262);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,263);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,264);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,265);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,266);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,267);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,268);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,269);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,270);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,271);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,272);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,273);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,274);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,275);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,276);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,277);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,278);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,279);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,280);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,281);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,282);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,283);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,284);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,285);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,286);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,287);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,288);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,289);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,290);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,291);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,292);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,293);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,294);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,295);
INSERT INTO receive_dg(distributionGroup, position) VALUES (10,296);

--   FusionStaffHB_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,34);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,35);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,36);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,37);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,38);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,39);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,40);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,41);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,42);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,43);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,44);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,45);
INSERT INTO receive_dg(distributionGroup, position) VALUES (11,46);

--   FusionStaffLA_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,47);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,48);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,49);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,50);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,51);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,52);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,53);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,54);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,55);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,56);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,57);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,58);
INSERT INTO receive_dg(distributionGroup, position) VALUES (12,59);

--   FusionStaffLG_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,60);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,61);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,62);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,63);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,64);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,65);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,66);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,67);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,68);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,69);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,70);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,71);
INSERT INTO receive_dg(distributionGroup, position) VALUES (13,72);

--   FusionStaffLI_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,203);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,204);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,205);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,206);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,207);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,208);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,209);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,210);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,211);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,212);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,213);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,214);
INSERT INTO receive_dg(distributionGroup, position) VALUES (14,215);

--   FusionStaffMN_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,190);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,191);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,192);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,193);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,194);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,195);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,196);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,197);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,198);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,199);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,200);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,201);
INSERT INTO receive_dg(distributionGroup, position) VALUES (15,202);

--   FusionStaffMV_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,73);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,74);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,75);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,76);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,77);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,78);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,79);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,80);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,81);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,82);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,83);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,84);
INSERT INTO receive_dg(distributionGroup, position) VALUES (16,85);

--   FusionStaffPD_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,86);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,87);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,88);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,89);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,90);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,91);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,92);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,93);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,94);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,95);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,96);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,97);
INSERT INTO receive_dg(distributionGroup, position) VALUES (17,98);

--   FusionStaffSB_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,138);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,139);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,140);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,141);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,142);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,143);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,144);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,145);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,146);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,147);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,148);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,149);
INSERT INTO receive_dg(distributionGroup, position) VALUES (18,150);

--   FusionStaffSD_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,99);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,100);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,101);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,102);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,103);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,104);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,105);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,106);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,107);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,108);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,109);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,110);
INSERT INTO receive_dg(distributionGroup, position) VALUES (19,111);

--   FusionStaffSF_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,112);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,113);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,114);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,115);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,116);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,117);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,118);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,119);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,120);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,121);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,122);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,123);
INSERT INTO receive_dg(distributionGroup, position) VALUES (20,124);

--   FusionStaffSLB_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,151);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,152);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,153);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,154);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,155);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,156);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,157);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,158);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,159);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,160);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,161);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,162);
INSERT INTO receive_dg(distributionGroup, position) VALUES (21,163);

--   FusionStaffSM_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,125);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,126);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,127);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,128);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,129);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,130);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,131);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,132);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,133);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,134);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,135);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,136);
INSERT INTO receive_dg(distributionGroup, position) VALUES (22,137);

--   FusionStaffWC_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,177);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,178);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,179);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,180);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,181);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,182);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,183);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,184);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,185);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,186);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,187);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,188);
INSERT INTO receive_dg(distributionGroup, position) VALUES (23,189);

--   FusionStaffWCR_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,164);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,165);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,166);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,167);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,168);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,169);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,170);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,171);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,172);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,173);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,174);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,175);
INSERT INTO receive_dg(distributionGroup, position) VALUES (24,176);

--   LexisStaffAll_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,233);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,234);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,235);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,236);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,237);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,238);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,239);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,240);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,241);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,242);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,243);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,244);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,245);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,246);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,247);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,248);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,249);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,250);
INSERT INTO receive_dg(distributionGroup, position) VALUES (25,251);

--   LSAssociateDirectors_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (26,);

--   LSBostonDirectors_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (27,);

--   LSCurriculumTeam_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (28,); --------------------------------------------------------------------------------------------------------

--   LSExecutiveDirector_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (29,);

--   LSExecutiveDirectorandAssociateDirectors_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (30,);

--   LSInnovationsMeetingParticipants
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (31,);

--   LSMVDirectors_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (32,);

--   LSSeniorManagementTeam_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (33,);

--   LSStaffAll_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (34,);

--   LSTrainingTeam_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (35,);

--   ShreinerStaffAll_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (36,239);
INSERT INTO receive_dg(distributionGroup, position) VALUES (36,240);
INSERT INTO receive_dg(distributionGroup, position) VALUES (36,241);
INSERT INTO receive_dg(distributionGroup, position) VALUES (36,242);
INSERT INTO receive_dg(distributionGroup, position) VALUES (36,243);

--   TampaDayAdmin_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,244);
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,245);
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,246);
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,247);
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,248);
INSERT INTO receive_dg(distributionGroup, position) VALUES (37,249);

--   TampaDayCamp_DG
INSERT INTO receive_dg(distributionGroup, position) VALUES (38,247);
INSERT INTO receive_dg(distributionGroup, position) VALUES (38,249);

--   TampaDayFriends_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (39,);

--   TampaDayFrontOffice_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (40,);

--   TampaDayInfo_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (41,);

--   TampaDayLowerDivision_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (42,);

--   TampaDayNews_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (43,);

--   TampaDayParents_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (44,);

--   TampaDayPta_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (45,);

--   TampaDayRead_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (46,);

--   TampaDayStaffAll_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (47,);

--   TampaDayTds_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (48,);

--   TampaDayTechnology_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (49,);

--   TampaDayTest_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (50,);

--   TampaDayUpperDivision_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (51,);

--   TampaDay_DG
-- INSERT INTO receive_dg(distributionGroup, position) VALUES (52,);





-- send_to_dg
--   AEGStaffAll
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,1);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,2);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,3);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,4);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,5);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,6);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,7);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,8);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,9);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,10);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,11);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,12);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,13);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,14);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,15);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,16);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,17);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,18);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,19);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,20);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,21);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,22);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,23);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,24);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,25);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,26);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,27);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,28);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,29);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,30);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,31);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,32);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (1,33);

--   FusionAssistantDirector_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,34);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,47);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,60);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,73);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,86);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,99);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,112);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,125);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,138);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,151);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,164);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,177);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,190);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,203);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,216);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (2,296);

--   FusionDirectorOfFirstImpressions_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,37);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,50);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,63);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,76);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,89);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,102);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,115);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,128);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,141);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,154);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,167);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,180);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,193);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,206);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,219);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (3,296);

--   FusionDirectorOfStudentDevelopment_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,38);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,51);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,64);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,77);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,90);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,103);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,116);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,129);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,142);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,155);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,168);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,181);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,194);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,207);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,220);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (4,296);

--   FusionHeadOfSchool_DG
--     Regional Director
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,296);
--     Fusion HOS
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,41);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,54);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,67);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,80);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,93);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,106);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,119);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,132);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,145);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,158);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,171);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,184);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,197);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,210);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,223);
--     Fusionologist
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,40);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,53);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,66);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,79);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,92);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,105);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,118);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,131);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,144);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,157);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,170);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,183);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,196);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,209);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (5,222);

--   FusionInformationSpecialist_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,42);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,55);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,68);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,81);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,94);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,107);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,120);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,133);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,146);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,159);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,172);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,185);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,198);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,211);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,224);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (6,296);

--   FusionMasterTeacher_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,43);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,56);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,69);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,82);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,95);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,108);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,121);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,134);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,147);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,160);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,173);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,186);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,199);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,212);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,225);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (7,296);

--   FusionOutreach_DG
--     RDO
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,296);
--     Fusionologist
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,40);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,53);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,66);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,79);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,92);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,105);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,118);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,131);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,144);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,157);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,170);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,183);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,196);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,209);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,222);
--     DCO
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,36);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,49);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,62);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,75);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,88);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,101);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,114);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,127);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,140);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,153);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,166);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,179);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,192);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,205);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,218);
--     RDCO
INSERT INTO send_to_dg(distributionGroup, position) VALUES (8,230);

--   FusionRegional_DG
--     RDO
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,296);
--     Fus
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,40);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,53);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,66);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,79);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,92);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,105);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,118);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,131);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,144);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,157);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,170);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,183);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,196);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,209);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (9,222);

--   FusionStaffALL_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,1);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,2);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,3);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,4);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,5);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,6);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,7);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,8);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,9);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,11);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,12);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,14);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,16);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,17);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,23);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,24);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,32);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,33);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (10,296);

--   FusionStaffHB_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,34);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,35);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,37);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,38);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,39);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,40);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,41);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,42);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,43);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,44);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,45);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,46);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (11,296);

--   FusionStaffLA_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,47);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,48);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,50);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,51);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,52);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,53);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,54);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,55);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,56);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,57);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,58);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,59);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (12,296);

--   FusionStaffLG_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,60);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,61);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,63);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,64);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,65);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,66);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,67);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,68);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,69);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,70);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,71);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,72);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (13,296);

--   FusionStaffLI_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,203);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,204);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,206);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,207);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,208);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,209);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,210);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,211);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,212);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,213);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,214);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,215);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (14,296);

--   FusionStaffMN_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,190);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,191);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,193);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,194);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,195);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,196);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,197);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,198);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,199);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,200);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,201);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,202);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (15,296);

--   FusionStaffMV_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,73);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,74);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,76);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,77);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,78);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,79);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,80);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,81);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,82);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,83);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,84);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (16,85);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (21,296);

--   FusionStaffSM_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,125);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,126);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,128);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,129);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,130);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,131);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,132);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,133);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,134);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,135);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,136);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,137);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (22,296);

--   FusionStaffWC_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,177);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,178);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,180);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,181);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,182);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,183);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,184);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,185);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,186);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,187);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,188);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,189);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (23,296);

--   FusionStaffWCR_DG
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,164);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,165);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,167);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,168);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,169);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,170);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,171);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,172);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,173);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,174);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,175);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,176);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,229);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,230);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,231);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,232);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,295);
INSERT INTO send_to_dg(distributionGroup, position) VALUES (24,296);

--   LexisStaffAll_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (25,);

--   LSAssociateDirectors_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (26,);

--   LSBostonDirectors_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (27,);

--   LSCurriculumTeam_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (28,);

--   LSExecutiveDirector_DG

-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (29,);

--   LSExecutiveDirectorandAssociateDirectors_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (30,);

--   LSInnovationsMeetingParticipants
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (31,);

--   LSMVDirectors_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (32,);

--   LSSeniorManagementTeam_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (33,);

--   LSStaffAll_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (34,);

--   LSTrainingTeam_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (35,);

--   ShreinerStaffAll_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (36,);

--   TampaDayAdmin_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (37,);

--   TampaDayCamp_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (38,);

--   TampaDayFriends_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (39,);

--   TampaDayFrontOffice_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (40,);

--   TampaDayInfo_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (41,);

--   TampaDayLowerDivision_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (42,);

--   TampaDayNews_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (43,);

--   TampaDayParents_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (44,);

--   TampaDayPta_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (45,);

--   TampaDayRead_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (46,);

--   TampaDayStaffAll_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (47,);

--   TampaDayTds_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (48,);

--   TampaDayTechnology_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (49,);

--   TampaDayTest_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (50,);

--   TampaDayUpperDivision_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (51,);

--   TampaDay_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (52,);

--   DGAccessAll_DG
-- INSERT INTO send_to_dg(distributionGroup, position) VALUES (53,);
