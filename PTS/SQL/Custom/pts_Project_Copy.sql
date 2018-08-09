EXEC [dbo].pts_CheckProc 'pts_Project_Copy'
GO

CREATE PROCEDURE [dbo].pts_Project_Copy
   @ProjectID int ,
   @CompanyID int ,
   @MemberID int ,
   @ProjectName nvarchar (60) ,
   @Description nvarchar (1000) ,
   @ParentID int ,
   @UserID int ,
   @NewProjectID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @AssignID int
SET @AssignID = @ParentID

DECLARE @Now datetime, @ProjectStartDate datetime
DECLARE @ProjectTypeID int, @ProjName nvarchar (60), @Descript nvarchar (1000),
   @IsChat bit, @IsForum bit, @Secure int, @EstStartDate datetime, @EstEndDate datetime, @ActStartDate datetime

SET @Now = dbo.wtfn_DateOnly(GETDATE())

-- Get all the fields to copy from the existing project
SELECT @ProjectTypeID = ProjectTypeID, @ProjName = ProjectName, @Descript = [Description],
   @IsChat = IsChat, @IsForum = IsForum, @Secure = Secure, @EstStartDate = EstStartDate, @EstEndDate = EstEndDate, @ActStartDate = ActStartDate
FROM Project WHERE ProjectID = @ProjectID

-- Calculate new estimated end date if we have original projected start and end dates
IF @EstStartDate > 0 AND @EstEndDate > 0
	SET @EstEndDate = DATEADD( day, DATEDIFF(day, @EstStartDate, @EstEndDate ), @Now )
ELSE
	SET @EstEndDate = 0

-- Save the original project's projected start date to adjust all other dates
SET @ProjectStartDate = @EstStartDate
IF @ProjectStartDate = 0 SET @ProjectStartDate = @ActStartDate

-- set the new project projected start date to now
SET @EstStartDate = @Now
IF @ProjectName = ''
	SET @ProjectName = 'Copy of ' + @ProjName

-- ProjectID OUTPUT, CompanyID, MemberID, ParentID, ForumID, ProjectTypeID, ProjectName, Description, Status, Seq
-- IsChat, IsForum, Secure, EstStartDate, ActStartDate, VarStartDate, EstEndDate, ActEndDate, VarEndDate,
-- EstCost, TotCost, VarCost, Cost, Hrs, TotHrs, Hierarchy, ChangeDate, RefType, RefID, UserID
EXEC pts_Project_Add @NewProjectID OUTPUT, @CompanyID, @MemberID, 0, 0, @ProjectTypeID, @ProjectName, @Descript, 1, 0, 
   @IsChat, @IsForum, @Secure, @EstStartDate, @EstStartDate, 0, @EstEndDate, 0, 0,
   0, 0, 0, 0, 0, 0, '', 0, 0, 0, @UserID

--PRINT 'Project: ' + @ProjectName + ' - ' + CAST(@ProjectID AS varchar(10))

-- Add all Tasks for this project
EXEC pts_Task_CopyTasks @ProjectID, 0, @NewProjectID, 0, @Description, @ProjectStartDate, @AssignID, @UserID 

-- Add all Sub-projects for this project
EXEC pts_Project_CopyProjects @ProjectID, @NewProjectID, @CompanyID, @Description, @ProjectStartDate, @AssignID, @UserID 

GO
