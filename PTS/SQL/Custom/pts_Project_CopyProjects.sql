EXEC [dbo].pts_CheckProc 'pts_Project_CopyProjects'
GO
CREATE PROCEDURE [dbo].pts_Project_CopyProjects
   @ProjectID int ,
   @NewProjectID int , 
   @CompanyID int , 
   @Exclude nvarchar (1000) ,
   @ProjectStartDate datetime ,
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @Now datetime, @PID int
DECLARE @ID int, @ProjectTypeID int, @ProjectName nvarchar (60), @Description nvarchar (1000), @Seq int,
   @IsChat bit, @IsForum bit, @Secure int, @EstStartDate datetime, @EstEndDate datetime

SET @Now = dbo.wtfn_DateOnly(GETDATE())

DECLARE Project_cursor CURSOR LOCAL STATIC FOR 
SELECT ProjectID, ProjectTypeID, ProjectName, [Description], Seq, IsChat, IsForum, Secure, EstStartDate, EstEndDate
FROM Project WHERE ParentID = @ProjectID 
ORDER BY Seq

OPEN Project_cursor
FETCH NEXT FROM Project_cursor INTO @ID, @ProjectTypeID, @ProjectName, @Description, @Seq, @IsChat, @IsForum, @Secure, @EstStartDate, @EstEndDate
WHILE @@FETCH_STATUS = 0
BEGIN
	IF CHARINDEX('P' + CAST(@ID AS VARCHAR(10)) + '~', @Exclude) = 0
	BEGIN
-- 		Calculate new estimated start date
		IF @EstStartDate > 0
			SET @EstStartDate = DATEADD( day, DATEDIFF(day, @ProjectStartDate, @EstStartDate ), @Now )
-- 		Calculate new estimated end date
		IF @EstEndDate > 0
			SET @EstEndDate = DATEADD( day, DATEDIFF(day, @ProjectStartDate, @EstEndDate ), @Now )

-- 		ProjectID OUTPUT, CompanyID, MemberID, ParentID, ForumID, ProjectTypeID, ProjectName, Description, Status, Seq
-- 		IsChat, IsForum, Secure, EstStartDate, ActStartDate, VarStartDate, EstEndDate, ActEndDate, VarEndDate,
-- 		EstCost, TotCost, VarCost, Cost, Hrs, TotHrs, Hierarchy, ChangeDate, RefType, RefID, UserID
		EXEC pts_Project_Add @PID OUTPUT, @CompanyID, @MemberID, @NewProjectID, 0, @ProjectTypeID, @ProjectName, @Description, 0, @Seq, 
	   		@IsChat, @IsForum, @Secure, @EstStartDate, 0, 0, @EstEndDate, 0, 0,
			   0, 0, 0, 0, 0, 0, '', 0, 0, 0, @UserID

--PRINT 'Project: ' + @ProjectName + ' - ' + CAST(@ID AS varchar(10))

-- 		Add all Tasks for this project
		EXEC pts_Task_CopyTasks @ID, 0, @PID, 0, @Exclude, @ProjectStartDate, @MemberID, @UserID 

-- 		Add all Sub-projects for this project
		EXEC pts_Project_CopyProjects @ID, @PID, @CompanyID, @Exclude, @ProjectStartDate, @MemberID, @UserID 
	END
	FETCH NEXT FROM Project_cursor INTO @ID, @ProjectTypeID, @ProjectName, @Description, @Seq, @IsChat, @IsForum, @Secure, @EstStartDate, @EstEndDate
END
CLOSE Project_cursor
DEALLOCATE Project_cursor

GO
