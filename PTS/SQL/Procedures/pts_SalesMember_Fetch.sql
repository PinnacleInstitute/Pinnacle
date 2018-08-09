EXEC [dbo].pts_CheckProc 'pts_SalesMember_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesMember_Fetch ( 
   @SalesMemberID int,
   @SalesAreaID int OUTPUT,
   @MemberID int OUTPUT,
   @SalesAreaName nvarchar (40) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (61) OUTPUT,
   @Status int OUTPUT,
   @StatusDate datetime OUTPUT,
   @FTE int OUTPUT,
   @Assignment varchar (40) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SalesAreaID = slm.SalesAreaID ,
   @MemberID = slm.MemberID ,
   @SalesAreaName = sla.SalesAreaName ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @Status = slm.Status ,
   @StatusDate = slm.StatusDate ,
   @FTE = slm.FTE ,
   @Assignment = slm.Assignment
FROM SalesMember AS slm (NOLOCK)
LEFT OUTER JOIN SalesArea AS sla (NOLOCK) ON (slm.SalesAreaID = sla.SalesAreaID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (slm.MemberID = me.MemberID)
WHERE slm.SalesMemberID = @SalesMemberID

GO