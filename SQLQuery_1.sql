--CREATE a new database HRManagement
CREATE DATABASE HRManagement;
--Create a schema called HRAdmin
GO
CREATE SCHEMA HRAdmin;
GO
--Create a Department table
CREATE TABLE [HRAdmin].[Department] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a employee position table
CREATE TABLE [HRAdmin].[Position] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a Onboarding-Offboarding table
CREATE TABLE [HRAdmin].[OnboardingOffboarding] (
    [ID]        INT  IDENTITY (1, 1) NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate]   DATE NOT NULL,
    CONSTRAINT [PK_OnboardingOffboarding] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a EmployeeLevel table
CREATE TABLE [HRAdmin].[EmployeeLevel] (
    [ID]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (50) NOT NULL,
    [PayRate] FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_EmployeeLevel] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a EmployeeType table
CREATE TABLE [HRAdmin].[EmployeeType] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_EmployeeType] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a Payroll table
CREATE TABLE [HRAdmin].[Payroll] (
    [ID]         INT        IDENTITY (1, 1) NOT NULL,
    [TotalHours] FLOAT (53) NOT NULL,
    [Tax]        FLOAT (53) NOT NULL,
    [Deduction]  FLOAT (53) NOT NULL,
    [NetPay]     FLOAT (53) NOT NULL,
    CONSTRAINT [PK_Payroll] PRIMARY KEY CLUSTERED ([ID] ASC)
);
--Create a Employee table
CREATE TABLE [HRAdmin].[Employee] (
    [ID]              INT           IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    [Email]           NVARCHAR (50) NOT NULL,
    [Phone]           NVARCHAR (50) NOT NULL,
    [OnboardingID]    INT           NOT NULL,
    [EmployeeLevelID] INT           NOT NULL,
    [EmployeeTypeID]  INT           NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Employee_EmployeeLevel] FOREIGN KEY ([EmployeeLevelID]) REFERENCES [HRAdmin].[EmployeeLevel] ([ID]),
    CONSTRAINT [FK_Employee_EmployeeType] FOREIGN KEY ([EmployeeTypeID]) REFERENCES [HRAdmin].[EmployeeType] ([ID]),
    CONSTRAINT [FK_Employee_Onboarding] FOREIGN KEY ([OnboardingID]) REFERENCES [HRAdmin].[OnboardingOffboarding] ([ID])
);
--Create a EmployeePay table
CREATE TABLE [HRAdmin].[EmployeePay] (
    [ID]         INT  IDENTITY (1, 1) NOT NULL,
    [EmployeeID] INT  NOT NULL,
    [PayrollID]  INT  NOT NULL,
    [PayDate]    DATE NOT NULL,
    CONSTRAINT [PK_EmployeePay] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_EmployeePay_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [HRAdmin].[Employee] ([ID]),
    CONSTRAINT [FK_EmployeePay_PayrollID] FOREIGN KEY ([PayrollID]) REFERENCES [HRAdmin].[Payroll] ([ID])
);
--Create a DepartmentPosition table
CREATE TABLE [HRAdmin].[DepartmentPosition] (
    [ID]           INT IDENTITY (1, 1) NOT NULL,
    [EmployeeID]   INT NOT NULL,
    [DepartmentID] INT NOT NULL,
    [PositionID]   INT NOT NULL,
    CONSTRAINT [PK_DepartmentPosition] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_DepartmentPosition_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [HRAdmin].[Department] ([ID]),
    CONSTRAINT [FK_DepartmentPosition_Employee] FOREIGN KEY ([EmployeeID]) REFERENCES [HRAdmin].[Employee] ([ID]),
    CONSTRAINT [FK_DepartmentPosition_Position] FOREIGN KEY ([PositionID]) REFERENCES [HRAdmin].[Position] ([ID])
);
--Insert data into Department table
INSERT INTO [HRAdmin].[Department] ([Name])
VALUES
    ('Quality Assurance'),
    ('Human Resources'),
    ('Marketing'),
    ('Finance'),
    ('Information Technology'),
    ('Sales'),
    ('Research and Development'),
    ('Customer Service'),
    ('Operations'),
    ('Legal');

SELECT * FROM HRAdmin.Department;
--Insert data into position table
INSERT INTO [HRAdmin].[Position] ([Name])
VALUES
    ('Quality Assurance Tester'),
    ('HR Coordinator'),
    ('Marketing Specialist'),
    ('Financial Analyst'),
    ('Software Engineer'),
    ('Sales Associate'),
    ('Research Analyst'),
    ('Customer Service Representative'),
    ('Operations Manager'),
    ('Manager');

SELECT * FROM HRAdmin.Position;

--Insert data into EmployeeLevel table  
INSERT INTO [HRAdmin].[EmployeeLevel] ([Name], [PayRate])
VALUES
    ('Entry Level', 50000.00),
    ('Junior', 60000.00),
    ('Intermediate', 75000.00),
    ('Senior', 90000.00),
    ('Lead', 110000.00),
    ('Manager', 130000.00),
    ('Director', 150000.00),
    ('Vice President', 180000.00),
    ('Senior Vice President', 200000.00),
    ('Executive', 250000.00);

SELECT * FROM HRAdmin.EmployeeLevel;

--Change EndDate Column data type to null for the employee that are still working in the company.
ALTER TABLE [HRAdmin].[OnboardingOffboarding]
ALTER COLUMN [EndDate] DATE NULL;

--Insert data into OnboardingOffboarding table
INSERT INTO [HRAdmin].[OnboardingOffboarding] ([StartDate], [EndDate])
VALUES
    ('2020-01-01', NULL),
    ('2018-02-15', '2022-03-01'),
    ('2021-04-03', NULL),
    ('2022-06-10', '2023-11-12'),
    ('2016-08-05', '2020-08-20'),
    ('2012-09-15', '2018-09-30'),
    ('2019-11-02', NULL),
    ('2000-01-10', '2012-01-25'),
    ('2017-03-05', '2022-12-01'),
    ('2006-05-01', NULL);

SELECT * FROM [HRAdmin].[OnboardingOffboarding];

--Insert data into EmployeeType table
INSERT INTO [HRAdmin].[EmployeeType] ([Name])
VALUES
    ('Full-Time'),
    ('Part-Time'),
    ('Contractor'),
    ('Temporary'),
    ('Intern'),
    ('Consultant'),
    ('Freelancer'),
    ('Seasonal'),
    ('Remote'),
    ('On-Call');

SELECT * FROM [HRAdmin].[EmployeeType];

--Insert data into Payroll table
INSERT INTO [HRAdmin].[Payroll] ([TotalHours], [Tax], [Deduction], [NetPay])
VALUES
    (40.0, 1000.0, 200.0, 3500.0),
    (30.5, 800.0, 150.0, 2800.0),
    (25.0, 600.0, 120.0, 2000.0),
    (37.0, 950.0, 180.0, 3200.0),
    (45.5, 1200.0, 250.0, 4000.0),
    (20.0, 500.0, 100.0, 1800.0),
    (42.5, 1100.0, 220.0, 3700.0),
    (38.0, 980.0, 200.0, 3400.0),
    (28.0, 750.0, 140.0, 2600.0),
    (33.5, 880.0, 170.0, 3000.0);

SELECT * FROM [HRAdmin].[Payroll];

--Insert data into Employee table
INSERT INTO [HRAdmin].[Employee] ([Name], [Email], [Phone], [OnboardingID], [EmployeeLevelID], [EmployeeTypeID])
VALUES
    ('John Doe', 'john.doe@email.com', '555-1234', 32, 3, 1),
    ('Jane Smith', 'jane.smith@email.com', '555-5678', 33, 4, 2),
    ('Bob Johnson', 'bob.johnson@email.com', '555-9876', 34, 2, 4),
    ('Alice Brown', 'alice.brown@email.com', '555-4321', 35, 5, 3),
    ('David White', 'david.white@email.com', '555-8765', 36, 1, 2),
    ('Emily Davis', 'emily.davis@email.com', '555-3456', 37, 6, 5),
    ('Chris Miller', 'chris.miller@email.com', '555-6543', 38, 7, 6),
    ('Sara Lee', 'sara.lee@email.com', '555-2345', 39, 8, 9),
    ('Mike Wilson', 'mike.wilson@email.com', '555-7890', 40, 9, 7),
    ('Lisa Chen', 'lisa.chen@email.com', '555-8765', 41, 10, 8);

SELECT * FROM [HRAdmin].[Employee];

--Insert data into EmployeePay table
INSERT INTO [HRAdmin].[EmployeePay] ([EmployeeID], [PayrollID], [PayDate])
VALUES
    (1, 1, '2023-01-15'),
    (2, 2, '2023-02-28'),
    (3, 3, '2023-03-15'),
    (4, 4, '2023-04-30'),
    (5, 5, '2023-05-15'),
    (6, 6, '2023-06-30'),
    (7, 7, '2023-07-15'),
    (8, 8, '2023-08-31'),
    (9, 9, '2023-09-15'),
    (10, 10, '2023-10-31');

SELECT * FROM [HRAdmin].[EmployeePay];

--Insert data into DepartmentPosition table
INSERT INTO [HRAdmin].[DepartmentPosition] ([EmployeeID], [DepartmentID], [PositionID])
VALUES
    (1, 11, 1),
    (2, 12, 2),
    (3, 13, 3),
    (4, 14, 4),
    (5, 15, 5),
    (6, 16, 6),
    (7, 17, 7),
    (8, 18, 8),
    (9, 19, 9),
    (10, 20, 10);

SELECT * FROM [HRAdmin].[DepartmentPosition];

--Create a login with password under Master
CREATE LOGIN Loginhr WITH PASSWORD = 'HrManagement@123';
--Create a user from the login
CREATE USER HRCoordinator FROM LOGIN Loginhr;
--Create a user with ALTER, READ, and EXECUTE permissions and associate that user with a login. 
ALTER ROLE db_datareader ADD MEMBER HRCoordinator;

GRANT EXECUTE TO HRCoordinator;
-- create login Loginhrmanager with password in Master
CREATE LOGIN Loginhrmanager WITH PASSWORD = 'HrManager@456';
--Create a user from login
CREATE USER HRManger FROM LOGIN Loginhrmanager;
-- Create a user with ALTER, READ, and EXECUTE permissions and associate that user with a login. 
GRANT SELECT, INSERT, UPDATE, DELETE ON [HRAdmin].[Employee] TO HRManger;

--create Procedure

--Procedure 1:Employee's Department: This procedure lists all employee payment, given the Employee's ID.
CREATE PROCEDURE GetEmployee
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM [HRAdmin].[EmployeePay] WHERE EmployeeID = @EmployeeID;
END;

EXEC GetEmployee @EmployeeID = 9;

--Procedure 2: Employee-Onboarding Details: This procedure retrieves a Employee's name, email, phone, startdate and enddate based on input parameters: EmployeeID and OnboardingID.
CREATE PROCEDURE GetEmployeeOnboarding
    @EmployeeID INT, @OnboardingID INT
AS
BEGIN
    SELECT e.[Name], e.[Email], e.[Phone], o.[StartDate], o.[EndDate]
    FROM [HRAdmin].[Employee] AS e
    JOIN [HRAdmin].[OnboardingOffboarding] AS o
    ON e.ID = @EmployeeID AND o.ID = @OnboardingID;
END;

-- Example of calling the stored procedure
EXEC GetEmployeeOnboarding @EmployeeID = 3, @OnboardingID = 32;

CREATE PROCEDURE GetEmployeeTypeOnboarding
    @EmployeeID INT,
    @EmployeeTypeID INT,
    @OnboardingID INT
AS
BEGIN
    SELECT e.[Name], e.[Email], e.[Phone], et.[Name] AS EmployeeTypeName, o.[StartDate] AS OnboardingDate
    FROM [HRAdmin].[Employee] AS e
    JOIN [HRAdmin].[EmployeeType] AS et ON e.EmployeeTypeID = et.ID
    JOIN [HRAdmin].[OnboardingOffboarding] AS o ON e.OnboardingID = o.ID
    WHERE e.ID = @EmployeeID
        AND et.ID = @EmployeeTypeID
        AND o.ID = @OnboardingID;
END;

-- Example of calling the stored procedure
EXEC GetEmployeeTypeOnboarding @EmployeeID = 1, @EmployeeTypeID = 1, @OnboardingID = 32;

-- create a view

--Show each Employee and the related department A view is need to showcase which department each Employee Position is in. It should list the Position, 

CREATE VIEW EmployeeDepartmentPosition
AS
SELECT e.[Name] AS EmployeeName, e.[Email], e.[Phone], d.[Name] AS DepartmentName, p.[Name] AS PositionName
FROM [HRAdmin].[Employee] AS e
JOIN [HRAdmin].[DepartmentPosition] AS dp 
ON dp.EmployeeID = e.ID
JOIN [HRAdmin].[Department] AS d
ON dp.DepartmentID = d.ID
JOIN [HRAdmin].[Position] AS p 
ON p.ID = dp.PositionID;


-- Display view
SELECT * FROM EmployeeDepartmentPosition;

-- payroll searches The Employee table will be the most queried table in the database. Make sure that searches by all foreign keys in the Employee table are fast as possible.
SELECT * FROM [HRAdmin].[Employee];

-- Create Index for all foreign keys
CREATE INDEX idx_Employeeid
ON [HRAdmin].[Employee] (ID);
CREATE INDEX idx_Onboardingid
ON [HRAdmin].[Employee] (OnboardingID);
CREATE INDEX idx_EmployeeTypeid
ON [HRAdmin].[Employee] (EmployeeTypeID);


CREATE TRIGGER HRAdmin.trg_InsertEmployee 
ON [HRAdmin].[Employee]
AFTER INSERT
AS 
BEGIN
    SET NOCOUNT ON;

    -- Check for NULL in the Name column
    IF EXISTS (SELECT * FROM inserted WHERE [Name] IS NULL)
    BEGIN
        -- If invalid data is found, raise an error with a custom message
        -- 16 is the severity level, 1 is the state
        RAISERROR('Invalid data: Name must be NOT NULL', 16, 1);
        -- Roll back the entire transaction to prevent the insertion of invalid data
        ROLLBACK;
        -- Exit the trigger
        RETURN;
    END;

    -- Insert valid data into the [HRAdmin].[Employee] table
    INSERT INTO [HRAdmin].[Employee] ([Name], [Email], [Phone], [OnboardingID], [EmployeeLevelID], [EmployeeTypeID])
    VALUES (NULL, 'meili.zheng@email.com', '123-3456', 70, 26, 56);
END;


SELECT * FROM HRAdmin.Employee;


CREATE TRIGGER HRAdmin.trg_UpdateEmployee
ON HRAdmin.Employee
AFTER UPDATE
AS 
BEGIN
    -- Check if any rows are being updated
    IF UPDATE(Name) OR UPDATE(Email) OR UPDATE(Phone) OR UPDATE(OnboardingID) OR UPDATE(EmployeeLevelID) 
    BEGIN
        -- Insert old values (from deleted) into history table
        INSERT INTO [HRAdmin].[EmployeeHistory] ([ID], [Name], [Email], [Phone], [OnboardingID], [EmployeeLevelID], [EmployeeTypeID])
        SELECT d.Name, d.Email, d.Phone, d.OnboardingID, d.EmployeeLevelID, d.EmployeeTypeID, 'Updated (Old)'
        FROM deleted d
        INNER JOIN inserted i ON d.ID = i.ID;

        -- Insert new values (from inserted) into history table
        INSERT INTO [HRAdmin].[EmployeeHistory] ([ID], [Name], [Email], [Phone], [OnboardingID], [EmployeeLevelID], [EmployeeTypeID])
        SELECT i.Name, i.Email, i.Phone, i.OnboardingID, i.EmployeeLevelID, i.EmployeeTypeID, 'Updated (New)'
        FROM deleted d
        INNER JOIN inserted i ON d.ID = i.ID;
    END
END;

--Create Trigger named Triggers.trg_DeleteVideoGames1 on Triggers.VideoGames table
CREATE TRIGGER HRAdmin.trg_DeleteEmployee
ON HRAdmin.Employee
-- This trigger runs on delete statements
AFTER DELETE
AS 
BEGIN
    -- we are going to insert a new row into the history table with all of the data that was in the deleted object.
    -- We will date the current time and 'UPDATE' as the action that occured.
    INSERT INTO [HRAdmin].[EmployeeHistory]([Name], [Email], [Phone], [OnboardingID], [EmployeeLevelID], [EmployeeTypeID])
    SELECT d.Name, d.Email, d.Phone, d.OnboardingID, d.EmployeeLevelID, d.EmployeeTypeID, GETDATE(), 'DELETE'
    FROM deleted d;
END;

UPDATE HRAdmin.Employee
SET Title = 'New Title'
WHERE ID = 26;


SELECT * FROM HRAdmin.Employee;



-- Servers: csisqlserver0903.database.windows.net,1433
-- Database: HRManagement
-- Login Information: 
-- User name: Loginhr PASSWORD = 'HrManagement@123';
-- User name: Loginhrmanager PASSWORD = 'HrManager@456';