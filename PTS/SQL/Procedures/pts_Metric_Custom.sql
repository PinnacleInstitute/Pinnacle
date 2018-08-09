EXEC [dbo].pts_CheckProc 'pts_Metric_Custom'
GO

CREATE PROCEDURE [dbo].pts_Metric_Custom
   @MemberID int ,
   @Event int ,
   @Note nvarchar (100) ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO