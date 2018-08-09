EXEC [dbo].pts_CheckProc 'pts_Downline_QualifyDownline'
GO

CREATE PROCEDURE [dbo].pts_Downline_QualifyDownline
   @MemberID int , 
   @Title int , 
   @MinPerLeg int , 
   @Cnt int OUTPUT ,
   @Legs int OUTPUT 
AS

SET NOCOUNT ON
SET @Cnt = 0
SET @Legs = 0

SELECT @Cnt = SUM(Cnt), @Legs = COUNT(Leg) 
FROM 
(
	SELECT Leg, SUM(Cnt) 'Cnt' FROM downtitle 
	WHERE MemberID = @MemberID AND Title >= @Title
	GROUP BY Leg
) AS tmp
WHERE Cnt >= @MinPerLeg

GO

