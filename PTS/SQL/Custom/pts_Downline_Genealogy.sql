EXEC [dbo].pts_CheckProc 'pts_Member_Genealogy'
GO

--EXEC pts_Member_Genealogy 84, 1,1

CREATE PROCEDURE [dbo].pts_Member_Genealogy
   @MemberID int ,
   @Status int ,
   @Level int 
AS

SET NOCOUNT ON
declare @Line int, @ParentID int
set @Line = 0
set @Parentid = 84

DECLARE @Downline TABLE(
   DownlineID int ,
   ParentID int ,
   ChildID int ,
   Position int ,
   ChildName nvarchar (100),
   EnrollDate datetime,
   Status int,
   Title int,
   Location nvarchar (150)
)

INSERT INTO @Downline
Select A.DownlineID, A.ParentID, A.ChildID, A.Position, me.NameFirst + ' ' + me.NameLast 'ChildName', me.EnrollDate, me.Status, me.Title, ad.city + ', ' + ad.state 'Location' From Downline As A
JOIN Member AS me ON A.ChildID = me.MemberID
LEFT OUTER JOIN Address AS ad ON A.ChildID = ad.OwnerID AND ad.OwnerType = 4 AND AddressType = 2 AND IsActive = 1
Where A.Line = @Line AND A.ParentID = @ParentID

INSERT INTO @Downline
Select B.DownlineID, B.ParentID, B.ChildID, B.Position, me.NameFirst + ' ' + me.NameLast 'ChildName', me.EnrollDate, me.Status, me.Title, ad.city + ', ' + ad.state 'Location' From Downline As A
Join Downline As B On (A.ChildID = B.ParentID AND B.Line = @Line)
JOIN Member AS me ON B.ChildID = me.MemberID
LEFT OUTER JOIN Address AS ad ON B.ChildID = ad.OwnerID AND ad.OwnerType = 4 AND AddressType = 2 AND IsActive = 1
Where A.Line = @Line AND A.ParentID = @ParentID

INSERT INTO @Downline
Select C.DownlineID, C.ParentID, C.ChildID, C.Position, me.NameFirst + ' ' + me.NameLast 'ChildName', me.EnrollDate, me.Status, me.Title, ad.city + ', ' + ad.state 'Location' From Downline As A
Join Downline As B On (A.ChildID = B.ParentID AND B.Line = @Line)
Join Downline As C On (B.ChildID = C.ParentID AND C.Line = @Line)
JOIN Member AS me ON C.ChildID = me.MemberID
LEFT OUTER JOIN Address AS ad ON C.ChildID = ad.OwnerID AND ad.OwnerType = 4 AND AddressType = 2 AND IsActive = 1
Where A.Line = @Line AND A.ParentID = @ParentID

INSERT INTO @Downline
Select D.DownlineID, D.ParentID, D.ChildID, D.Position, me.NameFirst + ' ' + me.NameLast 'ChildName', me.EnrollDate, me.Status, me.Title, ad.city + ', ' + ad.state 'Location' From Downline As A
Join Downline As B On (A.ChildID = B.ParentID AND B.Line = @Line)
Join Downline As C On (B.ChildID = C.ParentID AND C.Line = @Line)
Join Downline As D On (C.ChildID = D.ParentID AND D.Line = @Line)
JOIN Member AS me ON D.ChildID = me.MemberID
LEFT OUTER JOIN Address AS ad ON D.ChildID = ad.OwnerID AND ad.OwnerType = 4 AND AddressType = 2 AND IsActive = 1
Where A.Line = @Line AND A.ParentID = @ParentID

SELECT DISTINCT DownlineID, ParentID, ChildID, Position, ChildName, EnrollDate, Status, Title, Location 
FROM @Downline
ORDER BY Position

GO