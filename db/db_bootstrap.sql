CREATE DATABASE gym;

CREATE USER 'webapp'@'%' IDENTIFIED BY 'joshandrachel';

GRANT ALL PRIVILEGES ON gym.* TO 'webapp'@'%';

FLUSH PRIVILEGES;

USE gym;

CREATE TABLE members
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    Minor_status BOOLEAN NOT NULL,
    First_name VARCHAR(40) NOT NULL,
    Last_name VARCHAR(40) NOT NULL,
    Middle_initial CHAR(40),
    Date_of_birth DATE NOT NULL,
    Street_address VARCHAR(100) NOT NULL,
    Zip CHAR(10) NOT NULL,
    State CHAR(2) NOT NULL,
    City VARCHAR(60) NOT NULL,
    Team_ID INTEGER,
    Membership_type CHAR(1) NOT NULL,
    Frozen BOOLEAN NOT NULL,
    Payment_type CHAR(1) NOT NULL,
    Waiver_ID INTEGER,
    Email VARCHAR(64) NOT NULL,
    Phone CHAR(13) NOT NULL,
    Last_check_in DATE,
    PRIMARY KEY (ID)
);

CREATE TABLE nonmembers
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    First_name VARCHAR(40) NOT NULL,
    Last_name VARCHAR(40) NOT NULL,
    Middle_initial CHAR(1),
    Date_of_birth DATE NOT NULL,
    Street_address VARCHAR(64) NOT NULL,
    Zip CHAR(10) NOT NULL,
    State CHAR(2) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Email VARCHAR(64) NOT NULL,
    Phone CHAR(13) NOT NULL,
    Number_of_visits INTEGER DEFAULT 1,
    Waiver_ID INTEGER,
    PRIMARY KEY (ID)
);

CREATE TABLE employees
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    First_name VARCHAR(40) NOT NULL,
    Last_name VARCHAR(40) NOT NULL,
    Middle_initial CHAR(1),
    Date_of_birth DATE NOT NULL,
    Street_address VARCHAR(64) NOT NULL,
    Zip CHAR(10) NOT NULL,
    State CHAR(2) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Email VARCHAR(64) NOT NULL,
    Phone CHAR(13) NOT NULL,
    Hire_date DATE NOT NULL,
    Manager_ID INTEGER,
    PRIMARY KEY (ID)
);

CREATE TABLE shifts
(
    Employee_ID INTEGER AUTO_INCREMENT NOT NULL,
    Shift_ID INTEGER NOT NULL,
    Start DATETIME NOT NULL,
    End DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Employee_ID, Shift_ID)
);

CREATE TABLE waivers
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    Waiver_type_minor CHAR(1) NOT NULL,
    Date_signed TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID)
);

CREATE TABLE teams
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    Max_capacity INTEGER NOT NULL,
    Current_capacity INTEGER NOT NULL,
    Meeting_time TIME NOT NULL,

    -- The following came from https://stackoverflow.com/questions/11924346/storing-days-in-mysql-database
    Days_of_week TEXT NOT NULL,

    Age_group VARCHAR(30) NOT NULL,
    Open_closed BOOLEAN NOT NULL,
    Experience_level VARCHAR(30) NOT NULL,
    Coach_ID INTEGER NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE passes
(
    ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    Nonmember_ID INTEGER NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID)
);

CREATE TABLE dates_used
(
    Pass_ID INTEGER NOT NULL,
    Usage_ID INTEGER UNIQUE AUTO_INCREMENT NOT NULL,
    Date_used DATE NOT NULL,
    PRIMARY KEY (Pass_ID, Usage_ID)
);

ALTER TABLE members
ADD CONSTRAINT fk_members_team
        FOREIGN KEY (Team_ID) REFERENCES teams (ID)
        ON UPDATE cascade ON DELETE restrict,

ADD CONSTRAINT fk_members_waiver
        FOREIGN KEY (Waiver_ID) REFERENCES waivers (ID)
        ON UPDATE cascade ON DELETE restrict;

ALTER TABLE nonmembers
ADD CONSTRAINT fk_nonmembers_waiver
        FOREIGN KEY (Waiver_ID) REFERENCES waivers (ID)
        ON UPDATE cascade ON DELETE restrict;

ALTER TABLE employees
ADD CONSTRAINT fk_employees_manager
        FOREIGN KEY (Manager_ID) REFERENCES employees (ID)
        ON UPDATE cascade ON DELETE restrict;

ALTER TABLE shifts
ADD CONSTRAINT fk_shifts_employee
        FOREIGN KEY (Employee_ID) REFERENCES employees (ID)
        ON UPDATE cascade ON DELETE cascade;

ALTER TABLE teams
ADD CONSTRAINT fk_teams_coach
        FOREIGN KEY (Coach_ID) REFERENCES employees (ID)
        ON UPDATE cascade ON DELETE restrict;

ALTER TABLE passes
ADD CONSTRAINT fk_pass_nonmember
        FOREIGN KEY (Nonmember_ID) REFERENCES nonmembers (ID)
        ON UPDATE cascade ON DELETE restrict;

ALTER TABLE dates_used
ADD CONSTRAINT fk_dates_used_pass
        FOREIGN KEY (Pass_ID) REFERENCES  passes (ID)
        ON UPDATE cascade ON DELETE cascade;

-- waiver data
insert into waivers (ID, Waiver_type_minor, Date_signed) values (1, false, '2022-10-19');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (2, true, '2022-03-11');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (3, false, '2021-12-25');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (4, false, '2022-02-03');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (5, true, '2022-04-07');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (6, true, '2022-10-16');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (7, false, '2022-01-04');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (8, true, '2022-06-27');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (9, false, '2022-03-13');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (10, true, '2022-08-03');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (11, true, '2022-03-22');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (12, true, '2022-10-30');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (13, true, '2022-01-12');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (14, false, '2022-11-07');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (15, true, '2022-08-02');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (16, false, '2022-04-15');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (17, false, '2022-02-21');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (18, false, '2022-02-16');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (19, true, '2022-06-11');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (20, false, '2022-08-30');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (21, true, '2022-09-05');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (22, true, '2022-06-08');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (23, true, '2022-03-12');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (24, false, '2022-10-21');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (25, false, '2022-03-08');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (26, true, '2022-06-29');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (27, false, '2022-04-01');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (28, true, '2021-12-22');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (29, true, '2022-10-18');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (30, true, '2022-04-28');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (31, false, '2022-10-29');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (32, true, '2022-01-31');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (33, true, '2022-07-28');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (34, true, '2022-06-08');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (35, true, '2022-03-11');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (36, false, '2022-03-28');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (37, false, '2022-08-21');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (38, true, '2022-06-27');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (39, true, '2022-03-27');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (40, false, '2022-07-07');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (41, false, '2022-04-21');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (42, false, '2022-06-17');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (43, false, '2022-09-22');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (44, false, '2022-11-19');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (45, false, '2022-03-23');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (46, true, '2022-05-19');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (47, true, '2022-05-27');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (48, true, '2022-07-14');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (49, false, '2022-08-16');
insert into waivers (ID, Waiver_type_minor, Date_signed) values (50, false, '2022-09-09');

-- nonmembers data
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (1, 'Conni', 'Netti', 'F', '2022-04-01', '78133 North Alley', '91406', 'CA', 'Van Nuys', 'cnetti0@lycos.com', '626-654-1719', 49, 26);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (2, 'Erskine', 'Aimson', null, '2022-01-06', '72 Tomscot Junction', '99709', 'AK', 'Fairbanks', 'eaimson1@netscape.com', '907-796-8142', 44, 27);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (3, 'Jessika', 'Milmith', null, '2022-05-04', '70 Debra Trail', '77281', 'TX', 'Houston', 'jmilmith2@telegraph.co.uk', '713-672-1217', 54, 28);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (4, 'Ingmar', 'Dorling', 'M', '2022-01-13', '7 Mockingbird Lane', '25321', 'WV', 'Charleston', 'idorling3@netscape.com', '304-860-6286', 73, 29);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (5, 'Amabel', 'Bleiman', null, '2022-09-19', '9088 Dayton Circle', '68105', 'NE', 'Omaha', 'ableiman4@fema.gov', '402-319-4693', 89, 30);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (6, 'Amandi', 'Goult', null, '2022-08-12', '07271 Hintze Way', '01605', 'MA', 'Worcester', 'agoult5@nps.gov', '508-209-0646', 99, 31);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (7, 'Torr', 'Tolworthie', null, '2022-01-06', '9 Merchant Plaza', '32590', 'FL', 'Pensacola', 'ttolworthie6@pbs.org', '850-694-5431', 65, 32);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (8, 'Theodor', 'Yarrall', 'M', '2022-10-11', '0669 Trailsway Alley', '30022', 'GA', 'Alpharetta', 'tyarrall7@irs.gov', '770-375-6967', 71, 33);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (9, 'Elmore', 'Larne', 'M', '2022-07-21', '1161 Graedel Junction', '15210', 'PA', 'Pittsburgh', 'elarne8@redcross.org', '724-649-6625', 17, 34);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (10, 'Obidiah', 'Lonsdale', 'M', '2022-11-08', '99521 Straubel Avenue', '35242', 'AL', 'Birmingham', 'olonsdale9@google.de', '205-793-6808', 62, 35);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (11, 'Gillie', 'Kliement', null, '2021-11-24', '1840 Grim Terrace', '40256', 'KY', 'Louisville', 'gkliementa@nationalgeographic.com', '502-426-1253', 72, 36);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (12, 'Rosetta', 'Tunna', 'F', '2022-10-17', '6 Beilfuss Junction', '24009', 'VA', 'Roanoke', 'rtunnab@stumbleupon.com', '540-538-4118', 87, 37);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (13, 'Hort', 'Mendes', 'M', '2022-10-10', '16707 Bobwhite Drive', '35815', 'AL', 'Huntsville', 'hmendesc@umn.edu', '256-419-9987', 16, 38);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (14, 'Barrie', 'Cram', 'F', '2021-11-27', '0685 Rowland Junction', '04109', 'ME', 'Portland', 'bcramd@samsung.com', '207-487-7618', 9, 39);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (15, 'Halie', 'Sweynson', 'F', '2022-08-29', '42 Heffernan Pass', '32511', 'FL', 'Pensacola', 'hsweynsone@jalbum.net', '850-252-8553', 16, 40);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (16, 'Malinde', 'Malzard', 'F', '2022-10-24', '3 Erie Lane', '70160', 'LA', 'New Orleans', 'mmalzardf@cyberchimps.com', '504-199-5081', 46, 41);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (17, 'Thibaut', 'Southerden', null, '2022-08-18', '0 Springs Circle', '73197', 'OK', 'Oklahoma City', 'tsoutherdeng@noaa.gov', '405-357-4343', 65, 42);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (18, 'Goober', 'Selvey', 'M', '2022-01-15', '3225 Pawling Way', '85025', 'AZ', 'Phoenix', 'gselveyh@yelp.com', '480-936-7984', 43, 43);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (19, 'L;urette', 'Ritzman', 'F', '2022-02-22', '81705 Jackson Center', '06533', 'CT', 'New Haven', 'lritzmani@blogtalkradio.com', '203-775-2543', 37, 44);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (20, 'Noll', 'Fishlee', null, '2022-02-07', '252 Comanche Center', '29225', 'SC', 'Columbia', 'nfishleej@hatena.ne.jp', '803-345-7925', 28, 45);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (21, 'Lovell', 'Camelli', 'M', '2022-07-04', '1 Menomonie Point', '86305', 'AZ', 'Prescott', 'lcamellik@ustream.tv', '928-409-9290', 33, 46);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (22, 'Collette', 'Cornelis', 'F', '2022-02-03', '66 Reindahl Parkway', '38181', 'TN', 'Memphis', 'ccornelisl@senate.gov', '901-589-7386', 75, 47);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (23, 'Rockie', 'Aubray', 'M', '2022-01-21', '14614 Mayfield Parkway', '10115', 'NY', 'New York City', 'raubraym@blogger.com', '212-989-5964', 23, 48);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (24, 'Honor', 'Favell', 'F', '2022-08-25', '47 Milwaukee Trail', '33164', 'FL', 'Miami', 'hfavelln@imageshack.us', '786-573-5221', 52, 49);
insert into nonmembers (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Number_of_visits, Waiver_ID) values (25, 'Kerrie', 'Studeart', 'F', '2022-01-05', '9 Forster Avenue', '75353', 'TX', 'Dallas', 'kstudearto@prnewswire.com', '214-946-5608', 33, 50);

-- members data
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (1, true, 'Dee', 'Lambell', 'I', '2000-03-12', '11 Scott Street', '76162', 'TX', 'Fort Worth', 'M', true, 'F', 19, 'dlambell0@eventbrite.com', '682-544-2939');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (2, false, 'Brent', 'Verni', 'Y', '2000-03-12', '33 Michigan Court', '20883', 'TX', 'Gaithersburg', 'M', true, 'M', 14, 'bverni1@answers.com', '240-737-6557');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (3, false, 'Sergeant', 'Tristram', 'V', '2000-03-12', '59018 6th Terrace', '35815', 'TX', 'Huntsville', 'M', true, 'M', 1, 'stristram2@cbsnews.com', '256-220-8154');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (4, false, 'Kenneth', 'Brunini', 'M', '2000-03-12', '20 Vera Place', '53790', 'TX', 'Madison', 'M', true, 'M', 19, 'kbrunini3@geocities.jp', '608-160-8377');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (5, false, 'Ragnar', 'Higford', 'F', '2000-03-12', '45 Annamark Drive', '85010', 'TX', 'Phoenix', 'M', false, 'M', 16, 'rhigford4@ox.ac.uk', '602-157-5186');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (6, true, 'Osborne', 'Skiggs', 'B', '2000-03-12', '5 Hansons Center', '28256', 'TX', 'Charlotte', 'M', true, 'M', 9, 'oskiggs5@freewebs.com', '704-157-2862');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (7, false, 'Alva', 'Tidbury', 'T', '2000-03-12', '4 Nancy Drive', '61651', 'TX', 'Peoria', 'F', true, 'M', 6, 'atidbury6@cnet.com', '309-331-3242');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (8, true, 'Lynnette', 'Rodd', 'T', '2000-03-12', '1 Acker Pass', '97229', 'TX', 'Portland', 'F', true, 'F', 1, 'lrodd7@twitpic.com', '503-213-0816');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (9, false, 'Thekla', 'Ricciardelli', 'U', '2000-03-12', '533 West Road', '55448', 'TX', 'Minneapolis', 'F', false, 'F', 18, 'tricciardelli8@mozilla.com', '612-462-2008');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (10, false, 'Cloris', 'Hudd', 'I', '2000-03-12', '021 Randy Avenue', '95113', 'TX', 'San Jose', 'M', true, 'F', 12, 'chudd9@scribd.com', '408-526-0943');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (11, true, 'Chanda', 'McCall', 'F', '2000-03-12', '958 Karstens Street', '98447', 'TX', 'Tacoma', 'M', false, 'F', 7, 'cmccalla@soundcloud.com', '253-817-4669');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (12, false, 'Mia', 'Diano', 'R', '2000-03-12', '14238 Russell Pass', '77299', 'TX', 'Houston', 'M', true, 'F', 6, 'mdianob@biglobe.ne.jp', '713-287-2397');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (13, false, 'Adelbert', 'Elvy', 'K', '2000-03-12', '3 Hoffman Circle', '88558', 'TX', 'El Paso', 'M', true, 'M', 6, 'aelvyc@live.com', '915-160-2498');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (14, false, 'Sindee', 'Alliot', 'U', '2000-03-12', '57666 Spenser Trail', '02203', 'TX', 'Boston', 'F', true, 'F', 19, 'salliotd@linkedin.com', '617-981-5216');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (15, false, 'Ferdy', 'Betancourt', 'M', '2000-03-12', '59698 Cody Park', '93407', 'TX', 'San Luis Obispo', 'F', false, 'M', 23, 'fbetancourte@moonfruit.com', '805-272-0119');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (16, false, 'Johnny', 'Scholtz', 'L', '2000-03-12', '06 Towne Street', '77045', 'TX', 'Houston', 'M', false, 'M', 18, 'jscholtzf@yolasite.com', '281-537-5066');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (17, false, 'Naomi', 'Teas', 'D', '2000-03-12', '5 Erie Circle', '80525', 'TX', 'Fort Collins', 'M', true, 'F', 14, 'nteasg@springer.com', '970-564-9334');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (18, false, 'Durward', 'Roseman', 'L', '2000-03-12', '02715 Sommers Plaza', '28815', 'TX', 'Asheville', 'M', true, 'M', 12, 'drosemanh@smugmug.com', '828-998-2935');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (19, true, 'Ezmeralda', 'Coggins', 'M', '2000-03-12', '683 Mendota Trail', '23277', 'TX', 'Richmond', 'F', true, 'F', 21, 'ecogginsi@webeden.co.uk', '804-492-0472');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (20, true, 'Auberta', 'Goodbody', 'O', '2000-03-12', '435 John Wall Avenue', '43656', 'TX', 'Toledo', 'M', false, 'F', 2, 'agoodbodyj@angelfire.com', '419-569-4943');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (21, false, 'Stanislas', 'Petrescu', 'S', '2000-03-12', '942 Kim Terrace', '60674', 'TX', 'Chicago', 'F', false, 'M', 21, 'spetrescuk@technorati.com', '312-652-4577');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (22, false, 'Micaela', 'Sprules', 'D', '2000-03-12', '3 Miller Alley', '10165', 'TX', 'New York City', 'F', true, 'F', 2, 'msprulesl@google.com.au', '917-112-9424');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (23, true, 'Corly', 'Grgic', 'Q', '2000-03-12', '70 Schurz Street', '59623', 'TX', 'Helena', 'M', true, 'F', 6, 'cgrgicm@stanford.edu', '406-505-7573');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (24, false, 'Eldridge', 'Pye', 'X', '2000-03-12', '471 Declaration Road', '91841', 'TX', 'Alhambra', 'F', true, 'M', 17, 'epyen@discuz.net', '626-830-7426');
insert into members (ID, Minor_status, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Membership_type, Frozen, Payment_type, Waiver_ID, Email, Phone) values (25, true, 'Helga', 'Ancketill', 'P', '2000-03-12', '655 Leroy Lane', '37914', 'TX', 'Knoxville', 'M', false, 'F', 8, 'hancketillo@boston.com', '865-910-2085');

-- employees
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (1, 'Giacomo', 'Kittman', 'M', '1997-12-23', '9574 Trailsway Alley', '77554', 'TX', 'Galveston', 'gkittman0@e-recht24.de', '281-609-6865', '2020-12-24', null);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (2, 'Welsh', 'Colten', 'M', '1983-03-15', '6 Harbort Crossing', '19810', 'DE', 'Wilmington', 'wcolten1@nyu.edu', '302-937-1731', '2020-01-15', null);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (3, 'Jermain', 'Denacamp', 'M', '1975-02-03', '41821 Express Junction', '85297', 'AZ', 'Gilbert', 'jdenacamp2@goo.gl', '480-373-0186', '2020-02-11', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (4, 'Shelden', 'McGowan', 'M', '2006-09-06', '96079 Cottonwood Crossing', '32405', 'FL', 'Panama City', 'smcgowan3@google.fr', '850-379-3399', '2019-05-07', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (5, 'Shaun', 'Gawke', 'F', '1971-08-11', '0415 Graceland Circle', '33336', 'FL', 'Fort Lauderdale', 'sgawke4@cafepress.com', '754-569-3203', '2021-02-13', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (6, 'Shari', 'Sacks', 'F', '2001-04-06', '0 Melody Park', '84125', 'UT', 'Salt Lake City', 'ssacks5@skype.com', '801-829-0866', '2021-08-17', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (7, 'Tye', 'Lackham', 'M', '2000-11-25', '622 Claremont Circle', '80270', 'CO', 'Denver', 'tlackham6@nature.com', '303-723-0854', '2019-07-24', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (8, 'Roseanne', 'Rikkard', 'F', '1981-12-15', '3174 Kenwood Point', '77505', 'TX', 'Pasadena', 'rrikkard7@dion.ne.jp', '281-899-5670', '2019-02-23', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (9, 'Trueman', 'Bardwell', 'M', '1999-09-19', '3687 Lotheville Lane', '60674', 'IL', 'Chicago', 'tbardwell8@lulu.com', '312-918-0854', '2020-07-17', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (10, 'Vivien', 'Davis', 'F', '1975-05-29', '11699 Mayer Lane', '95128', 'CA', 'San Jose', 'vdavis9@newsvine.com', '408-579-9949', '2019-06-28', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (11, 'Leigh', 'Rowth', 'M', '1976-09-29', '417 Colorado Park', '10203', 'NY', 'New York City', 'lrowtha@sogou.com', '212-742-4147', '2021-07-16', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (12, 'Clarance', 'McCormack', 'M', '1972-02-19', '99478 Daystar Plaza', '63116', 'MO', 'Saint Louis', 'cmccormackb@networksolutions.com', '314-169-5823', '2020-03-18', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (13, 'Kilian', 'Rebillard', 'M', '2008-08-15', '1302 Randy Pass', '87195', 'NM', 'Albuquerque', 'krebillardc@newyorker.com', '505-597-0985', '2021-12-12', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (14, 'Micheline', 'Nevison', 'F', '1997-09-24', '051 Independence Circle', '33325', 'FL', 'Fort Lauderdale', 'mnevisond@comcast.net', '954-767-9266', '2020-03-14', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (15, 'Nat', 'Lassells', 'M', '2006-11-11', '030 Waubesa Court', '14646', 'NY', 'Rochester', 'nlassellse@360.cn', '585-340-4028', '2019-07-16', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (16, 'Remington', 'Waring', 'M', '2008-06-30', '985 Debra Lane', '92505', 'CA', 'Riverside', 'rwaringf@smugmug.com', '909-450-6180', '2021-11-16', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (17, 'Ximenez', 'Grzegorczyk', 'M', '1964-10-31', '3680 Everett Center', '85045', 'AZ', 'Phoenix', 'xgrzegorczykg@e-recht24.de', '602-568-4822', '2020-05-18', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (18, 'Patrica', 'Vennart', 'F', '1968-02-19', '44 Thackeray Trail', '32830', 'FL', 'Orlando', 'pvennarth@bbb.org', '407-819-4441', '2021-01-21', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (19, 'Emilio', 'Osmon', 'M', '1977-04-14', '3 Bellgrove Road', '80150', 'CO', 'Englewood', 'eosmoni@weebly.com', '303-264-8419', '2020-05-22', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (20, 'Camella', 'Colloby', 'F', '1993-06-01', '45849 Vidon Junction', '01114', 'MA', 'Springfield', 'ccollobyj@theglobeandmail.com', '413-298-4081', '2021-01-05', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (21, 'Kassey', 'Allardyce', 'F', '1962-11-27', '2624 Memorial Terrace', '98166', 'WA', 'Seattle', 'kallardycek@barnesandnoble.com', '360-974-7537', '2019-12-08', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (22, 'Piper', 'Elloit', 'F', '2000-02-24', '0 Gulseth Center', '97216', 'OR', 'Portland', 'pelloitl@dagondesign.com', '503-606-8041', '2021-09-18', 1);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (23, 'Noemi', 'Brauns', 'F', '1970-10-13', '28481 Schurz Point', '80638', 'CO', 'Greeley', 'nbraunsm@uol.com.br', '970-536-3394', '2020-12-08', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (24, 'Sibeal', 'Readwood', 'F', '1984-02-04', '650 Westerfield Center', '33034', 'FL', 'Homestead', 'sreadwoodn@nifty.com', '786-631-6838', '2019-09-15', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (25, 'Benjamen', 'Fullicks', 'M', '2007-12-13', '8 Bartillon Park', '20319', 'DC', 'Washington', 'bfullickso@washingtonpost.com', '202-132-0669', '2020-03-18', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (26, 'Delinda', 'Le Breton De La Vieuville', 'F', '1998-09-19', '0 South Hill', '50347', 'IA', 'Des Moines', 'dlebretondelavieuvillep@cloudflare.com', '515-155-9088', '2021-12-10', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (27, 'Sheri', 'Rannie', 'F', '1981-02-22', '9 Spaight Drive', '33330', 'FL', 'Fort Lauderdale', 'srannieq@about.com', '954-886-5526', '2021-04-28', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (28, 'Rafaelita', 'Matura', 'F', '2012-07-30', '39 Morrow Place', '49444', 'MI', 'Muskegon', 'rmaturar@tinypic.com', '231-932-5401', '2021-10-14', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (29, 'Corbie', 'Hundall', 'M', '2010-10-14', '46734 Ryan Circle', '20337', 'DC', 'Washington', 'chundalls@loc.gov', '202-551-8218', '2021-07-09', 2);
insert into employees (ID, First_name, Last_name, Middle_initial, Date_of_birth, Street_address, Zip, State, City, Email, Phone, Hire_date, Manager_ID) values (30, 'Lawrence', 'Ailward', 'M', '2000-02-03', '48153 Corscot Lane', '17622', 'PA', 'Lancaster', 'lailwardt@storify.com', '717-903-1430', '2021-05-21', 1);

-- passes
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (1, 20, 'Month', '2021-11-27');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (2, 16, 'Month', '2021-02-11');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (3, 21, 'Month', '2022-09-24');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (4, 1, 'Month', '2020-10-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (5, 14, 'Month', '2022-05-24');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (6, 3, 'Month', '2021-01-16');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (7, 6, 'Month', '2022-05-11');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (8, 24, 'Month', '2022-06-30');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (9, 19, 'Month', '2020-08-26');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (10, 1, 'Month', '2021-07-18');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (11, 7, 'Month', '2021-11-01');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (12, 4, 'Month', '2022-07-06');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (13, 24, 'Month', '2020-06-23');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (14, 24, 'Month', '2022-04-10');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (15, 2, 'Month', '2021-08-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (16, 3, 'Month', '2020-08-31');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (17, 6, 'Month', '2020-08-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (18, 25, 'Month', '2022-08-11');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (19, 5, 'Month', '2021-09-12');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (20, 20, 'Month', '2020-06-07');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (21, 14, 'Month', '2020-09-27');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (22, 4, 'Month', '2022-01-04');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (23, 12, 'Month', '2021-11-27');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (24, 1, 'Month', '2022-11-09');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (25, 16, 'Month', '2020-10-14');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (26, 3, 'Month', '2021-02-05');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (27, 20, 'Month', '2020-12-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (28, 14, 'Month', '2020-08-13');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (29, 20, 'Month', '2022-09-18');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (30, 23, 'Month', '2020-11-12');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (31, 2, 'Month', '2020-09-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (32, 3, 'Month', '2022-05-08');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (33, 1, 'Month', '2020-09-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (34, 19, 'Month', '2020-12-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (35, 12, 'Month', '2021-03-28');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (36, 24, 'Month', '2020-07-25');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (37, 24, 'Month', '2021-12-02');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (38, 25, 'Month', '2021-07-12');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (39, 20, 'Month', '2022-01-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (40, 25, 'Month', '2020-10-06');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (41, 16, 'Month', '2022-02-12');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (42, 25, 'Month', '2022-02-17');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (43, 9, 'Month', '2022-01-17');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (44, 4, 'Month', '2021-07-02');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (45, 3, 'Month', '2021-09-15');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (46, 17, 'Month', '2021-09-08');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (47, 4, 'Month', '2021-09-23');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (48, 23, 'Month', '2021-05-09');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (49, 22, 'Month', '2022-11-04');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (50, 5, 'Month', '2021-07-05');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (51, 16, 'Month', '2022-08-31');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (52, 17, 'Month', '2022-09-02');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (53, 5, 'Month', '2022-10-03');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (54, 6, 'Month', '2021-09-02');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (55, 23, 'Month', '2021-05-29');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (56, 11, 'Month', '2020-08-24');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (57, 10, 'Month', '2022-01-28');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (58, 8, 'Month', '2020-07-09');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (59, 25, 'Month', '2022-05-06');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (60, 14, 'Month', '2020-11-02');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (61, 24, 'Month', '2021-09-28');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (62, 16, 'Month', '2022-02-19');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (63, 3, 'Month', '2021-12-05');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (64, 10, 'Month', '2022-06-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (65, 11, 'Month', '2022-08-08');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (66, 22, 'Month', '2020-09-26');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (67, 21, 'Month', '2022-09-09');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (68, 10, 'Month', '2020-11-01');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (69, 24, 'Month', '2020-05-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (70, 21, 'Month', '2020-11-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (71, 6, 'Month', '2022-06-23');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (72, 22, 'Month', '2022-01-15');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (73, 3, 'Month', '2022-07-31');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (74, 7, 'Month', '2020-11-24');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (75, 1, 'Month', '2021-08-26');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (76, 19, 'Month', '2021-09-18');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (77, 12, 'Month', '2022-04-01');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (78, 14, 'Month', '2020-07-31');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (79, 18, 'Month', '2022-07-30');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (80, 17, 'Month', '2021-11-16');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (81, 20, 'Month', '2021-11-17');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (82, 18, 'Month', '2022-08-11');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (83, 25, 'Month', '2022-01-28');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (84, 11, 'Month', '2020-11-13');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (85, 7, 'Month', '2022-08-09');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (86, 10, 'Month', '2022-07-19');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (87, 2, 'Month', '2020-10-29');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (88, 5, 'Month', '2022-02-08');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (89, 3, 'Month', '2022-10-24');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (90, 6, 'Month', '2020-10-17');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (91, 3, 'Month', '2022-09-08');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (92, 25, 'Month', '2020-10-14');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (93, 16, 'Month', '2021-01-25');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (94, 2, 'Month', '2020-10-25');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (95, 4, 'Month', '2021-01-14');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (96, 16, 'Month', '2021-09-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (97, 22, 'Month', '2022-04-21');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (98, 24, 'Month', '2020-05-22');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (99, 3, 'Month', '2022-08-30');
insert into passes (ID, Nonmember_ID, Type, Purchase_Date) values (100, 23, 'Month', '2020-05-18');


-- teams
insert into teams (ID, Max_capacity, Current_capacity, Meeting_time, Days_of_week, Age_Group, Open_closed, Experience_level, Coach_ID) values (1, 20, 15, '03:39', 'Monday, Wednesday', '17+', true, 'Adult Beginner', 4);
insert into teams (ID, Max_capacity, Current_capacity, Meeting_time, Days_of_week, Age_Group, Open_closed, Experience_level, Coach_ID) values (2, 20, 6, '10:29', 'Tuesday, Friday', '17+', true, 'Adult Intermediate', 3);
insert into teams (ID, Max_capacity, Current_capacity, Meeting_time, Days_of_week, Age_Group, Open_closed, Experience_level, Coach_ID) values (3, 20, 17, '8:11', 'Tuesday, Thursday', '5-17', true, 'Youth Beginner', 4);
insert into teams (ID, Max_capacity, Current_capacity, Meeting_time, Days_of_week, Age_Group, Open_closed, Experience_level, Coach_ID) values (4, 20, 9, '9:15', 'Saturday, Thursday', '5-17', true, 'Youth Advanced', 3);

-- shifts
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 1, '2022-01-04 22:01:51', '2022-07-28 09:04:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 2, '2021-05-17 00:55:44', '2022-03-09 01:18:36');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 3, '2021-03-03 16:19:42', '2021-07-22 06:43:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 4, '2021-01-30 08:42:41', '2022-09-23 14:57:05');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 5, '2022-07-11 08:58:11', '2021-06-07 06:07:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 6, '2022-07-26 15:05:40', '2022-10-03 19:13:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 7, '2021-11-12 11:36:58', '2021-02-13 22:19:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 8, '2021-05-02 20:26:49', '2021-07-05 22:07:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 9, '2021-07-26 09:02:50', '2021-06-09 21:13:37');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 10, '2022-08-13 17:36:26', '2021-08-09 15:22:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 11, '2020-12-26 09:32:41', '2021-03-11 17:57:05');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 12, '2022-05-10 07:44:53', '2022-03-20 11:55:53');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 13, '2021-02-08 00:45:46', '2022-08-11 13:40:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 14, '2021-05-11 14:17:54', '2021-04-26 04:47:00');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 15, '2021-04-03 09:52:10', '2022-11-17 21:41:31');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 16, '2021-12-19 22:49:45', '2021-05-04 16:50:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 17, '2021-03-11 01:52:58', '2020-12-31 16:39:08');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 18, '2022-07-03 12:35:58', '2022-01-02 04:35:00');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 19, '2022-10-11 23:01:04', '2021-06-16 02:42:09');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 20, '2021-03-28 03:45:28', '2021-12-31 14:22:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 21, '2022-01-15 00:57:44', '2021-12-27 19:14:53');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 22, '2022-11-07 13:46:38', '2021-08-18 01:49:29');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 23, '2022-02-07 09:15:05', '2021-08-05 03:06:48');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 24, '2021-03-15 19:28:19', '2022-07-25 08:52:57');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 25, '2022-02-10 07:04:26', '2021-10-14 20:15:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 26, '2021-10-08 19:57:05', '2021-04-22 05:17:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 27, '2021-10-23 02:38:19', '2022-09-26 16:28:00');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 28, '2022-11-07 21:07:01', '2022-05-01 20:48:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 29, '2021-05-08 11:36:54', '2021-07-27 12:48:26');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 30, '2021-08-01 07:04:06', '2021-09-27 20:05:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 31, '2021-11-09 01:46:39', '2022-02-27 06:33:29');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 32, '2022-09-17 13:47:20', '2022-03-20 11:46:09');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 33, '2022-01-12 21:09:35', '2022-03-24 17:19:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 34, '2020-12-22 16:43:28', '2022-11-04 08:10:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 35, '2021-08-14 16:40:31', '2022-09-20 03:46:49');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 36, '2020-12-23 09:40:41', '2021-02-07 19:33:39');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 37, '2021-11-08 18:51:19', '2021-07-02 18:47:51');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 38, '2021-02-11 16:10:28', '2022-09-21 11:32:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 39, '2021-08-19 21:59:40', '2022-04-13 22:15:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 40, '2021-10-09 01:04:12', '2022-05-23 20:47:22');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 41, '2022-03-18 09:12:21', '2021-09-08 10:44:31');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 42, '2021-07-18 17:53:50', '2021-01-04 00:21:26');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 43, '2022-04-23 05:28:39', '2021-10-08 16:07:48');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 44, '2022-06-17 12:15:34', '2022-02-02 15:42:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 45, '2021-09-17 08:20:39', '2022-07-18 18:33:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 46, '2022-08-23 06:14:50', '2022-01-07 14:52:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 47, '2021-03-11 00:58:50', '2021-08-01 23:46:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 48, '2022-05-26 04:21:17', '2022-10-17 06:56:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 49, '2021-11-22 19:53:20', '2021-05-14 05:59:12');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 50, '2021-11-15 13:37:26', '2022-07-15 07:16:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 51, '2022-02-24 07:46:43', '2021-11-03 16:37:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 52, '2021-10-13 22:55:37', '2021-08-18 02:54:49');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 53, '2022-03-03 05:23:39', '2022-01-04 15:29:25');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 54, '2020-12-28 17:02:29', '2022-08-01 11:45:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 55, '2022-08-29 15:26:42', '2022-10-22 06:29:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 56, '2021-05-10 09:15:33', '2021-10-11 10:29:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 57, '2022-08-01 20:55:49', '2021-12-08 12:28:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 58, '2021-12-20 05:20:53', '2021-07-29 08:38:08');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 59, '2021-02-25 23:09:06', '2022-07-31 22:30:17');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 60, '2020-12-11 08:46:31', '2021-12-21 22:34:57');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 61, '2022-10-23 12:15:21', '2021-09-30 07:08:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 62, '2022-02-20 02:54:40', '2022-10-11 21:19:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 63, '2022-06-01 05:57:38', '2021-01-04 19:05:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 64, '2021-02-09 14:33:45', '2020-12-27 11:48:55');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 65, '2022-04-27 00:11:47', '2022-10-04 17:43:08');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 66, '2021-08-31 04:13:05', '2021-03-24 08:47:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 67, '2021-05-16 09:21:20', '2020-12-15 02:27:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 68, '2022-08-07 20:59:09', '2022-03-08 16:50:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 69, '2022-05-31 01:21:09', '2021-07-21 06:16:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 70, '2021-05-13 01:56:24', '2021-10-26 10:39:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 71, '2022-05-11 08:11:48', '2021-05-04 05:26:56');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 72, '2022-01-12 06:44:23', '2022-03-20 06:33:53');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 73, '2021-07-23 19:40:04', '2021-10-17 22:53:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 74, '2022-08-17 19:20:43', '2022-06-09 12:59:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 75, '2022-10-22 04:19:35', '2021-07-02 19:23:13');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 76, '2022-09-24 03:59:41', '2021-10-03 20:56:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 77, '2020-12-23 16:09:51', '2022-06-30 00:44:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 78, '2021-10-14 07:59:11', '2022-02-26 23:13:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 79, '2022-09-09 12:54:40', '2022-09-27 05:52:20');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 80, '2022-07-02 08:16:55', '2021-04-17 00:38:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 81, '2021-03-15 15:11:01', '2021-08-09 04:16:14');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 82, '2021-01-01 16:59:18', '2022-02-20 09:52:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 83, '2022-06-20 10:17:51', '2020-12-16 02:55:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 84, '2021-01-16 08:26:37', '2022-01-22 02:03:46');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 85, '2021-12-16 22:13:52', '2021-02-16 18:46:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 86, '2022-07-03 01:51:34', '2021-04-25 00:13:55');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 87, '2022-01-01 13:19:48', '2022-08-14 06:37:41');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 88, '2021-09-19 05:53:30', '2022-01-29 01:50:57');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 89, '2021-02-14 21:16:04', '2022-03-28 10:22:44');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 90, '2022-06-22 18:07:13', '2021-01-27 01:42:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 91, '2021-04-07 21:34:47', '2020-12-15 01:28:46');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 92, '2021-04-25 21:28:00', '2021-02-14 14:34:13');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 93, '2022-03-06 05:08:12', '2021-11-01 14:23:31');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 94, '2021-06-08 13:16:45', '2021-12-25 03:17:18');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 95, '2022-09-24 19:10:18', '2022-06-29 05:34:28');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 96, '2021-11-10 19:51:40', '2021-03-29 21:06:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 97, '2021-03-27 23:15:00', '2022-07-24 21:06:51');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 98, '2022-03-31 12:06:58', '2022-09-15 05:09:55');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 99, '2021-02-16 20:48:10', '2022-01-23 18:57:04');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 100, '2021-02-21 05:49:28', '2021-10-07 23:21:20');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 101, '2021-08-25 19:36:37', '2022-07-04 00:54:02');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 102, '2021-09-11 02:17:48', '2022-02-19 21:27:33');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 103, '2022-02-25 05:18:20', '2021-03-14 00:28:02');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 104, '2022-06-26 13:56:12', '2021-06-06 11:19:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 105, '2021-04-01 18:49:59', '2021-10-17 18:18:07');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 106, '2022-10-12 16:35:58', '2021-09-25 09:47:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 107, '2021-02-14 11:52:31', '2022-11-13 10:56:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 108, '2021-03-05 05:50:36', '2021-01-13 16:54:11');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 109, '2021-01-09 07:23:10', '2021-07-06 07:02:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 110, '2021-08-11 11:31:37', '2021-04-16 02:00:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 111, '2022-03-01 05:30:40', '2021-01-27 15:09:05');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 112, '2021-12-25 14:05:07', '2021-02-02 12:21:18');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 113, '2022-05-15 02:04:33', '2021-10-03 21:28:08');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 114, '2021-11-29 16:36:02', '2020-12-26 17:17:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 115, '2021-11-16 07:40:52', '2021-02-22 16:49:39');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 116, '2021-02-11 10:18:52', '2021-09-28 15:37:04');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 117, '2022-05-20 05:44:22', '2022-01-28 01:39:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 118, '2021-08-17 21:38:56', '2022-09-18 22:54:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 119, '2021-04-16 18:03:11', '2022-05-19 18:19:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 120, '2021-03-23 12:32:20', '2022-10-28 11:49:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 121, '2021-07-27 00:39:20', '2020-12-31 15:47:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 122, '2021-11-04 01:10:45', '2022-10-04 04:02:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 123, '2021-05-10 03:35:28', '2022-09-21 15:25:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 124, '2020-12-16 19:57:00', '2021-02-13 15:46:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 125, '2021-10-23 14:31:23', '2021-11-25 00:55:09');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 126, '2022-09-04 00:48:41', '2022-03-19 07:23:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 127, '2021-12-25 21:08:31', '2022-02-07 04:01:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 128, '2022-10-24 08:57:06', '2022-02-02 11:21:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 129, '2020-12-30 04:11:20', '2021-03-08 23:49:02');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 130, '2021-10-05 08:30:31', '2021-08-29 23:45:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 131, '2022-06-19 06:52:25', '2021-12-26 14:02:41');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 132, '2021-04-19 08:57:16', '2022-07-12 11:33:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 133, '2021-10-30 11:09:43', '2022-07-06 08:46:00');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 134, '2020-12-19 19:08:51', '2022-10-17 01:06:37');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 135, '2021-01-24 12:51:13', '2021-02-26 16:38:12');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 136, '2021-08-11 23:15:23', '2022-07-03 07:51:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 137, '2021-04-01 15:01:44', '2021-02-20 14:48:51');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 138, '2021-08-22 18:45:21', '2021-04-16 15:56:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 139, '2021-01-12 11:14:08', '2022-04-10 22:51:56');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 140, '2021-02-07 21:46:43', '2021-12-17 01:50:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 141, '2021-12-26 00:07:26', '2020-12-26 10:47:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 142, '2021-03-03 11:45:19', '2021-10-30 08:50:32');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 143, '2022-03-18 02:25:08', '2022-08-25 06:50:11');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 144, '2022-10-08 09:41:01', '2022-04-26 11:49:49');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 145, '2022-01-07 10:56:36', '2022-05-02 00:14:44');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 146, '2021-05-12 21:06:53', '2021-01-16 05:12:28');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 147, '2022-10-29 11:09:24', '2021-11-24 13:52:22');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 148, '2021-06-07 04:00:44', '2021-03-23 16:29:44');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 149, '2022-06-21 17:59:42', '2021-02-07 14:03:59');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 150, '2021-08-31 12:24:52', '2022-03-24 11:23:40');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 151, '2021-12-26 18:44:04', '2021-10-28 13:17:00');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 152, '2021-02-11 00:50:48', '2022-03-17 14:58:56');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 153, '2021-07-14 18:46:23', '2021-12-06 13:58:15');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 154, '2021-02-16 23:49:55', '2021-08-03 19:22:45');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 155, '2021-04-10 14:46:38', '2022-03-29 10:31:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 156, '2021-10-06 11:55:55', '2021-01-14 21:51:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 157, '2021-06-06 17:47:22', '2022-11-10 22:40:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 158, '2022-07-02 00:01:41', '2021-04-17 12:31:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 159, '2022-08-26 00:10:35', '2021-10-15 08:13:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 160, '2021-10-27 13:14:15', '2022-06-28 06:36:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 161, '2022-05-21 06:17:31', '2021-06-26 08:34:43');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 162, '2021-04-21 21:39:18', '2021-04-05 04:57:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 163, '2022-11-17 10:51:58', '2022-10-30 18:41:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 164, '2022-08-29 17:48:39', '2022-08-03 11:32:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 165, '2021-02-28 04:58:09', '2022-06-06 18:09:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 166, '2022-09-30 09:45:57', '2021-08-06 09:15:58');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 167, '2022-06-06 07:38:36', '2022-04-05 06:18:25');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 168, '2022-07-26 07:38:14', '2021-12-23 01:20:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 169, '2022-03-09 09:30:08', '2022-03-01 20:10:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 170, '2021-03-09 16:53:12', '2021-09-19 07:03:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 171, '2021-10-31 01:59:59', '2021-09-18 05:07:18');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 172, '2022-03-02 19:30:45', '2022-11-16 21:36:31');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 173, '2022-10-17 20:18:16', '2022-09-02 22:03:29');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 174, '2021-03-24 08:37:03', '2021-10-16 15:38:32');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 175, '2022-03-04 00:29:45', '2022-05-14 21:19:42');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 176, '2022-08-13 09:01:15', '2021-02-16 04:36:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 177, '2022-08-20 22:19:27', '2021-03-13 07:42:48');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 178, '2022-04-16 21:35:43', '2021-09-09 12:33:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 179, '2021-09-21 11:19:17', '2022-03-18 03:44:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 180, '2022-01-22 19:28:01', '2021-12-12 07:18:50');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 181, '2021-05-20 23:28:10', '2021-06-04 12:25:36');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 182, '2021-04-02 22:31:35', '2022-02-01 02:36:09');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 183, '2021-09-05 03:00:03', '2022-09-15 10:56:51');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 184, '2022-06-06 09:17:31', '2021-11-03 19:18:05');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 185, '2021-07-13 08:33:43', '2021-07-20 00:24:20');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 186, '2021-10-03 23:12:48', '2021-03-12 15:25:28');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 187, '2022-10-01 04:00:14', '2022-11-11 14:05:26');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 188, '2022-04-20 03:06:36', '2021-09-18 07:34:53');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 189, '2021-06-12 12:57:13', '2022-09-15 20:52:51');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 190, '2021-11-25 16:57:10', '2021-04-04 10:26:13');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 191, '2021-12-09 07:45:51', '2022-04-27 12:40:03');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 192, '2021-08-08 10:33:45', '2021-02-18 19:16:04');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 193, '2021-11-26 04:02:21', '2022-08-29 23:35:44');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 194, '2021-05-18 15:51:37', '2021-10-14 01:34:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 195, '2022-04-17 22:14:21', '2022-10-07 01:11:43');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 196, '2021-11-10 10:45:16', '2021-07-09 16:53:08');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 197, '2022-07-08 20:12:54', '2021-12-15 21:16:46');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 198, '2021-02-08 16:12:13', '2021-03-15 23:48:46');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 199, '2021-01-04 16:48:13', '2021-07-10 13:11:22');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 200, '2022-09-28 19:10:36', '2021-07-17 02:31:33');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 201, '2022-06-10 03:31:33', '2021-03-15 11:21:15');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 202, '2022-08-09 07:21:11', '2021-01-13 23:39:26');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 203, '2021-03-31 23:26:30', '2022-01-19 22:38:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 204, '2022-03-06 18:00:39', '2021-03-22 11:30:48');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 205, '2021-06-21 03:43:04', '2022-02-01 10:47:49');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 206, '2021-01-14 19:42:54', '2022-08-04 19:32:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 207, '2022-10-07 01:46:16', '2021-10-05 22:22:44');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 208, '2021-01-07 22:09:49', '2022-10-07 05:39:02');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 209, '2021-03-13 12:00:31', '2021-09-19 08:46:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 210, '2022-05-15 06:03:32', '2021-12-26 12:25:21');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 211, '2022-01-25 13:06:19', '2022-03-19 14:50:14');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 212, '2020-12-31 14:27:32', '2021-12-26 20:59:41');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 213, '2021-11-11 08:16:15', '2022-08-31 07:19:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 214, '2022-07-10 09:05:46', '2021-01-27 11:45:37');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 215, '2022-09-27 17:27:39', '2020-12-11 23:13:40');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 216, '2022-07-07 14:06:46', '2022-01-07 21:22:20');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 217, '2021-10-06 09:40:00', '2022-11-06 20:31:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 218, '2021-11-05 10:39:15', '2021-01-20 17:02:55');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 219, '2022-05-18 14:45:43', '2021-01-26 03:47:24');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 220, '2021-06-26 18:00:44', '2021-09-24 09:10:11');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 221, '2022-09-02 01:28:23', '2021-08-04 10:38:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 222, '2022-09-02 16:11:29', '2021-03-21 05:32:39');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 223, '2021-04-24 03:09:51', '2022-11-11 04:10:34');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 224, '2021-09-28 19:30:53', '2022-08-13 08:18:47');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 225, '2022-01-04 06:52:17', '2021-03-29 00:05:16');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 226, '2021-12-11 01:20:25', '2022-05-12 03:14:27');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 227, '2022-08-06 09:23:48', '2022-03-20 07:10:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 228, '2021-05-21 22:52:15', '2022-06-21 08:47:40');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 229, '2022-04-24 01:37:12', '2022-07-04 09:40:01');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 230, '2021-05-23 09:44:37', '2022-03-26 13:30:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 231, '2021-08-10 02:01:53', '2021-08-27 13:24:20');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 232, '2021-05-27 00:00:32', '2021-04-05 17:34:38');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 233, '2020-12-15 15:38:27', '2021-10-13 06:48:32');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 234, '2021-12-30 05:55:27', '2021-10-22 12:26:30');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 235, '2022-03-20 01:56:09', '2021-02-20 08:24:36');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 236, '2020-12-15 20:38:26', '2022-08-31 01:55:55');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 237, '2021-03-17 09:55:19', '2022-01-11 09:44:06');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 238, '2021-02-01 06:47:49', '2021-10-19 20:38:35');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 239, '2022-10-11 23:25:30', '2022-02-28 07:03:31');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 240, '2021-09-30 09:42:20', '2022-07-01 16:36:17');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 241, '2022-10-26 13:10:40', '2021-02-28 13:53:23');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 242, '2022-03-22 02:26:57', '2021-05-03 16:43:10');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 243, '2022-11-09 14:14:25', '2022-03-17 19:50:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 244, '2021-12-28 04:32:11', '2021-09-09 14:21:05');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 245, '2022-08-20 11:41:46', '2022-06-03 03:38:29');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (1, 246, '2022-09-14 12:39:24', '2022-02-11 18:31:46');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (3, 247, '2021-06-24 23:03:15', '2021-12-30 03:36:19');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (2, 248, '2022-10-16 06:46:28', '2022-10-27 05:03:26');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (5, 249, '2022-08-03 23:20:31', '2021-11-29 16:11:53');
insert into shifts (Employee_ID, Shift_ID, Start, End) values (4, 250, '2022-07-11 07:34:59', '2021-11-03 13:06:23');

-- dates used
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 1, '2021-03-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 2, '2022-03-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 3, '2022-06-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 4, '2021-11-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 5, '2022-07-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 6, '2020-08-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 7, '2022-02-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 8, '2022-02-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (70, 9, '2021-05-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 10, '2020-11-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 11, '2020-07-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 12, '2021-04-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 13, '2022-06-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 14, '2020-05-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (16, 15, '2021-08-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 16, '2022-07-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (95, 17, '2021-10-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 18, '2021-09-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 19, '2020-10-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 20, '2021-04-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (63, 21, '2021-09-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 22, '2021-07-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 23, '2020-06-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 24, '2021-10-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 25, '2022-04-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 26, '2021-05-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 27, '2021-04-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 28, '2020-09-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (88, 29, '2020-09-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (59, 30, '2020-05-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 31, '2020-10-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 32, '2021-03-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (91, 33, '2022-08-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 34, '2021-02-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 35, '2021-05-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (16, 36, '2021-02-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 37, '2020-10-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (72, 38, '2021-05-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (63, 39, '2022-03-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 40, '2022-03-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 41, '2021-02-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (39, 42, '2021-05-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 43, '2020-06-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 44, '2020-11-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 45, '2021-11-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 46, '2020-09-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 47, '2021-11-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 48, '2021-06-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (64, 49, '2020-11-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (85, 50, '2022-11-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 51, '2022-09-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 52, '2021-06-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (22, 53, '2022-09-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 54, '2022-10-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 55, '2020-10-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 56, '2021-04-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 57, '2022-10-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (14, 58, '2022-11-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (55, 59, '2021-03-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (22, 60, '2022-02-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 61, '2020-07-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 62, '2020-05-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 63, '2022-05-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 64, '2021-09-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 65, '2022-09-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 66, '2022-01-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 67, '2022-10-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (45, 68, '2022-02-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 69, '2020-11-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (72, 70, '2021-07-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (91, 71, '2022-08-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (5, 72, '2021-10-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 73, '2022-01-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 74, '2020-06-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 75, '2021-10-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 76, '2021-11-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 77, '2021-03-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 78, '2021-10-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 79, '2021-11-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (34, 80, '2021-02-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 81, '2021-04-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (39, 82, '2021-01-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (14, 83, '2021-04-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 84, '2021-04-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 85, '2020-09-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 86, '2021-03-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (34, 87, '2020-12-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 88, '2021-09-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 89, '2020-12-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (77, 90, '2021-02-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 91, '2021-09-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 92, '2022-04-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 93, '2022-07-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 94, '2021-10-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (55, 95, '2021-11-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 96, '2021-04-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 97, '2021-09-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 98, '2020-08-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 99, '2021-05-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 100, '2022-06-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (31, 101, '2021-08-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 102, '2022-07-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 103, '2020-09-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 104, '2021-07-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 105, '2021-10-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 106, '2021-11-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 107, '2021-05-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 108, '2022-05-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 109, '2021-04-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (57, 110, '2022-04-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (50, 111, '2020-10-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (51, 112, '2021-04-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 113, '2020-09-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 114, '2022-02-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 115, '2021-04-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 116, '2022-08-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 117, '2022-10-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 118, '2020-06-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (14, 119, '2021-02-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 120, '2020-09-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (61, 121, '2020-11-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 122, '2021-03-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 123, '2021-11-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 124, '2020-09-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (28, 125, '2021-05-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 126, '2020-12-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 127, '2022-06-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (87, 128, '2021-09-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (64, 129, '2021-02-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 130, '2022-08-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (95, 131, '2022-05-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 132, '2022-10-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (28, 133, '2022-03-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 134, '2022-08-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 135, '2021-01-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 136, '2021-05-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 137, '2020-06-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 138, '2020-11-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 139, '2022-02-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 140, '2020-12-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (99, 141, '2022-01-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 142, '2022-07-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 143, '2021-10-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 144, '2021-04-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 145, '2021-04-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 146, '2020-09-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (34, 147, '2021-05-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (24, 148, '2022-09-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (25, 149, '2022-08-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (39, 150, '2021-08-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 151, '2020-09-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 152, '2021-04-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 153, '2021-02-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 154, '2021-09-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 155, '2022-04-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 156, '2021-02-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 157, '2021-08-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 158, '2022-02-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (51, 159, '2020-08-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (17, 160, '2021-03-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (87, 161, '2022-02-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 162, '2021-12-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 163, '2022-08-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 164, '2021-12-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 165, '2022-02-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (95, 166, '2022-11-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (57, 167, '2020-09-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 168, '2020-08-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 169, '2022-05-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 170, '2020-09-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 171, '2022-04-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 172, '2020-06-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 173, '2020-10-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 174, '2021-08-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (51, 175, '2022-08-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (38, 176, '2021-10-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 177, '2022-09-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 178, '2021-06-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (62, 179, '2021-03-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 180, '2021-07-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 181, '2020-06-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (34, 182, '2021-03-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 183, '2021-12-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 184, '2021-12-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 185, '2021-10-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 186, '2022-04-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 187, '2021-05-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 188, '2020-11-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 189, '2022-06-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (99, 190, '2020-07-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 191, '2022-02-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 192, '2021-02-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 193, '2022-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 194, '2021-03-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (67, 195, '2020-08-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (99, 196, '2020-12-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 197, '2021-03-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 198, '2022-08-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 199, '2021-04-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (22, 200, '2021-08-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 201, '2020-07-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 202, '2021-02-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 203, '2021-08-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 204, '2021-09-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (59, 205, '2022-07-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 206, '2022-04-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 207, '2021-10-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 208, '2022-09-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (61, 209, '2021-04-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 210, '2020-05-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 211, '2020-06-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (51, 212, '2021-10-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 213, '2022-08-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (5, 214, '2021-06-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 215, '2020-11-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 216, '2022-04-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 217, '2022-01-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 218, '2021-04-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 219, '2022-11-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 220, '2020-12-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 221, '2022-08-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 222, '2022-02-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 223, '2022-02-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 224, '2021-09-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 225, '2022-02-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 226, '2020-06-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 227, '2022-07-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (99, 228, '2020-12-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 229, '2022-04-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 230, '2022-09-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 231, '2021-02-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 232, '2022-02-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 233, '2020-08-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 234, '2021-01-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 235, '2022-10-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (71, 236, '2021-11-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (87, 237, '2022-03-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (67, 238, '2021-11-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 239, '2020-11-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 240, '2021-03-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 241, '2022-02-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 242, '2020-07-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (74, 243, '2022-05-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 244, '2021-10-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 245, '2020-11-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (22, 246, '2021-07-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 247, '2021-12-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 248, '2022-10-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 249, '2022-04-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 250, '2021-10-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (88, 251, '2020-05-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (33, 252, '2022-01-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 253, '2021-02-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 254, '2022-02-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 255, '2022-02-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 256, '2022-10-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (28, 257, '2021-03-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 258, '2021-10-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 259, '2020-12-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 260, '2021-07-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 261, '2021-05-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 262, '2022-07-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 263, '2021-11-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 264, '2021-03-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 265, '2021-03-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (18, 266, '2022-10-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 267, '2021-01-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 268, '2021-05-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (85, 269, '2020-11-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 270, '2021-10-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (71, 271, '2021-12-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 272, '2022-07-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (67, 273, '2022-06-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 274, '2022-08-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (55, 275, '2022-06-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 276, '2022-11-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 277, '2022-03-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (31, 278, '2021-06-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 279, '2021-05-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 280, '2022-02-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 281, '2021-04-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 282, '2021-10-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 283, '2022-06-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 284, '2022-06-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 285, '2021-05-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 286, '2020-12-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (16, 287, '2021-08-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 288, '2020-06-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 289, '2021-02-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 290, '2021-09-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 291, '2020-12-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (21, 292, '2020-10-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 293, '2022-04-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 294, '2021-04-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 295, '2021-06-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 296, '2022-08-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (45, 297, '2021-05-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 298, '2020-08-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 299, '2022-09-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 300, '2021-07-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 301, '2020-09-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 302, '2021-12-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 303, '2020-10-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 304, '2020-08-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 305, '2022-06-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 306, '2022-07-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (22, 307, '2020-06-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 308, '2020-09-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (61, 309, '2022-04-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (2, 310, '2020-07-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (28, 311, '2021-02-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (62, 312, '2021-12-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (17, 313, '2022-02-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (82, 314, '2021-09-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 315, '2021-09-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 316, '2022-10-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 317, '2020-10-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 318, '2021-11-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (85, 319, '2022-04-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 320, '2021-02-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (88, 321, '2022-04-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 322, '2020-11-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 323, '2021-05-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 324, '2020-06-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 325, '2020-12-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 326, '2021-08-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (47, 327, '2022-03-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 328, '2022-01-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 329, '2022-06-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 330, '2020-10-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 331, '2022-04-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 332, '2022-02-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 333, '2021-06-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (57, 334, '2022-03-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 335, '2021-12-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 336, '2021-09-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 337, '2021-02-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 338, '2022-08-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 339, '2021-07-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (16, 340, '2021-04-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 341, '2022-05-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 342, '2021-01-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 343, '2021-01-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 344, '2022-06-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (14, 345, '2021-10-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 346, '2020-10-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 347, '2020-09-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 348, '2020-12-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (63, 349, '2021-03-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (82, 350, '2022-03-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 351, '2021-12-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 352, '2022-01-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (61, 353, '2020-07-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 354, '2021-09-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 355, '2022-06-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 356, '2022-01-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 357, '2021-01-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 358, '2022-08-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 359, '2022-07-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 360, '2021-07-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 361, '2020-08-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 362, '2021-12-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 363, '2020-09-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (85, 364, '2021-06-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 365, '2021-04-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (41, 366, '2021-12-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 367, '2022-03-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 368, '2021-11-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 369, '2022-06-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (74, 370, '2022-01-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (19, 371, '2021-03-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (50, 372, '2021-02-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (45, 373, '2021-11-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 374, '2022-06-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 375, '2022-03-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (31, 376, '2020-07-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 377, '2021-02-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 378, '2021-08-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (63, 379, '2021-04-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 380, '2022-05-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 381, '2021-05-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (64, 382, '2021-08-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 383, '2020-12-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 384, '2020-10-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 385, '2020-09-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 386, '2021-05-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (74, 387, '2020-12-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 388, '2020-10-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 389, '2022-11-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 390, '2020-06-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 391, '2022-09-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 392, '2021-11-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 393, '2022-05-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 394, '2022-04-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (5, 395, '2020-12-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 396, '2022-03-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 397, '2021-11-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (71, 398, '2020-09-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 399, '2020-07-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 400, '2022-01-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 401, '2022-06-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 402, '2020-06-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (50, 403, '2021-04-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 404, '2020-07-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 405, '2021-05-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (40, 406, '2022-06-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 407, '2021-03-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 408, '2020-09-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 409, '2020-06-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 410, '2022-09-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 411, '2022-02-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 412, '2020-11-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 413, '2021-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 414, '2020-09-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 415, '2022-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 416, '2020-07-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 417, '2020-08-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 418, '2021-05-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (70, 419, '2021-11-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (87, 420, '2020-12-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 421, '2021-08-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 422, '2021-04-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 423, '2021-10-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 424, '2021-07-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 425, '2022-02-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 426, '2021-08-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 427, '2022-05-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 428, '2020-05-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 429, '2021-09-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 430, '2020-11-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (85, 431, '2022-04-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 432, '2021-12-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (56, 433, '2022-01-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (89, 434, '2020-11-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 435, '2021-09-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (38, 436, '2021-04-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (32, 437, '2021-07-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 438, '2020-08-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (86, 439, '2020-11-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 440, '2021-08-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (70, 441, '2020-10-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 442, '2022-08-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 443, '2020-08-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 444, '2022-11-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 445, '2020-12-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 446, '2020-08-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 447, '2022-02-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 448, '2020-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 449, '2020-12-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 450, '2022-03-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 451, '2021-11-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (70, 452, '2022-10-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 453, '2021-03-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 454, '2021-01-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (92, 455, '2022-03-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 456, '2020-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 457, '2022-01-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 458, '2021-12-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 459, '2022-02-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 460, '2021-08-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 461, '2020-08-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (45, 462, '2020-10-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (55, 463, '2020-05-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (52, 464, '2021-03-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 465, '2022-10-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 466, '2022-08-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (82, 467, '2020-12-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 468, '2021-12-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 469, '2021-03-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (10, 470, '2021-12-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 471, '2020-07-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 472, '2020-10-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (25, 473, '2022-06-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 474, '2020-10-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 475, '2020-08-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 476, '2022-03-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 477, '2022-03-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (16, 478, '2021-11-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (81, 479, '2022-07-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (79, 480, '2020-08-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 481, '2020-07-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (95, 482, '2021-02-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (78, 483, '2022-03-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (88, 484, '2021-06-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (23, 485, '2022-10-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 486, '2022-05-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 487, '2022-01-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 488, '2022-08-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (5, 489, '2020-10-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (17, 490, '2021-03-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 491, '2021-08-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (53, 492, '2020-11-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (100, 493, '2022-03-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 494, '2020-11-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (71, 495, '2020-12-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (71, 496, '2021-10-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 497, '2022-06-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (59, 498, '2020-09-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (58, 499, '2021-08-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (43, 500, '2021-06-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (5, 501, '2021-01-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 502, '2021-07-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 503, '2020-10-22');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (8, 504, '2022-05-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (54, 505, '2022-02-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (50, 506, '2022-05-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (15, 507, '2020-08-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 508, '2020-09-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (89, 509, '2020-08-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 510, '2020-12-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 511, '2022-07-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (82, 512, '2021-09-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (27, 513, '2021-05-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 514, '2020-11-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (33, 515, '2020-11-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (40, 516, '2022-09-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 517, '2022-08-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (9, 518, '2021-02-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 519, '2021-05-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (13, 520, '2020-11-16');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 521, '2022-08-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (89, 522, '2022-10-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (74, 523, '2021-01-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 524, '2020-06-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (62, 525, '2022-03-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (62, 526, '2022-02-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (73, 527, '2021-05-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (2, 528, '2021-06-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 529, '2021-08-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (67, 530, '2022-04-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 531, '2020-11-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 532, '2022-02-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (44, 533, '2020-06-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (25, 534, '2022-07-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 535, '2020-07-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 536, '2021-06-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 537, '2021-02-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 538, '2021-03-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 539, '2021-03-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 540, '2022-02-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 541, '2021-12-27');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (38, 542, '2020-10-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (39, 543, '2022-01-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 544, '2021-04-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (17, 545, '2021-02-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (72, 546, '2022-05-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 547, '2022-07-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 548, '2022-09-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (95, 549, '2022-03-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (69, 550, '2022-09-13');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (96, 551, '2022-11-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (3, 552, '2022-01-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (11, 553, '2020-06-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 554, '2020-08-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (68, 555, '2020-08-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 556, '2022-02-25');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (26, 557, '2020-09-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (37, 558, '2020-12-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (75, 559, '2020-09-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (17, 560, '2020-07-21');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (48, 561, '2021-12-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (66, 562, '2021-02-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (72, 563, '2020-09-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 564, '2020-08-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (1, 565, '2021-04-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 566, '2022-07-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (12, 567, '2021-02-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (63, 568, '2021-04-19');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (84, 569, '2022-01-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (20, 570, '2020-11-24');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (4, 571, '2022-07-05');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 572, '2021-02-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (36, 573, '2021-01-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 574, '2021-11-18');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 575, '2020-06-10');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (24, 576, '2021-08-09');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (49, 577, '2021-06-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 578, '2022-05-06');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (30, 579, '2022-02-28');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (94, 580, '2021-11-29');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (90, 581, '2020-08-03');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (29, 582, '2022-08-11');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (46, 583, '2020-11-08');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (61, 584, '2022-10-26');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (7, 585, '2021-06-20');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (93, 586, '2020-07-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (35, 587, '2021-01-07');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (97, 588, '2021-01-12');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 589, '2022-09-02');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (25, 590, '2022-09-14');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (83, 591, '2022-10-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (98, 592, '2021-08-17');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (80, 593, '2020-12-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (76, 594, '2022-03-01');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 595, '2020-09-15');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (65, 596, '2021-01-31');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (6, 597, '2020-11-04');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (42, 598, '2021-11-30');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (60, 599, '2021-05-23');
insert into dates_used (Pass_ID, Usage_ID, Date_used) values (25, 600, '2020-11-02');
