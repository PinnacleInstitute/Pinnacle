EXEC [dbo].pts_CheckProc 'pts_Folder_EnumFolderAllList'
GO
--EXEC pts_Folder_EnumFolderAllList 9,0,7164,22,1 

CREATE PROCEDURE [dbo].pts_Folder_EnumFolderAllList
   @CompanyID int ,
   @GroupID int ,
   @MemberID int ,
   @Entity int ,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @List TABLE(
   ID int ,
   Name nvarchar (62),
   s1 int,
   s2 int,
   s3 int,
   s4 int
)

INSERT INTO @List
SELECT f1.FolderID, f1.FolderName + CASE f1.DripCampaignID WHEN 0 THEN '' ELSE '*' END, f1.seq, -99999, -99999, -99999
FROM Folder AS f1 (NOLOCK)
WHERE (f1.CompanyID=0 OR f1.CompanyID=@CompanyID) AND (f1.Entity=@Entity) AND f1.ParentID=0
AND (((f1.MemberID=0) AND (f1.IsShare<>0)) OR (f1.MemberID=@MemberID) OR ((f1.MemberID=@GroupID) AND (f1.IsShare<>0)))

INSERT INTO @List
SELECT f2.FolderID, '.....'+f2.FolderName + CASE f2.DripCampaignID WHEN 0 THEN '' ELSE '*' END, f1.seq, f2.seq, -99999, -99999
FROM Folder AS f1 (NOLOCK)
JOIN Folder AS f2 ON f1.FolderID = f2.ParentID
WHERE (f2.CompanyID=0 OR f2.CompanyID=@CompanyID) AND (f2.Entity=@Entity) AND f1.ParentID=0
AND (((f2.MemberID=0) AND (f2.IsShare<>0)) OR (f2.MemberID=@MemberID) OR ((f2.MemberID=@GroupID) AND (f2.IsShare<>0)))

INSERT INTO @List
SELECT f3.FolderID, '..........'+f3.FolderName + CASE f3.DripCampaignID WHEN 0 THEN '' ELSE '*' END, f1.seq, f2.seq, f3.seq, -99999
FROM Folder AS f1 (NOLOCK)
JOIN Folder AS f2 ON f1.FolderID = f2.ParentID
JOIN Folder AS f3 ON f2.FolderID = f3.ParentID
WHERE (f3.CompanyID=0 OR f3.CompanyID=@CompanyID) AND (f3.Entity=@Entity) AND f1.ParentID=0
AND (((f3.MemberID=0) AND (f3.IsShare<>0)) OR (f3.MemberID=@MemberID) OR ((f3.MemberID=@GroupID) AND (f3.IsShare<>0)))

INSERT INTO @List
SELECT f4.FolderID, '...............'+f4.FolderName + CASE f4.DripCampaignID WHEN 0 THEN '' ELSE '*' END, f1.seq, f2.seq, f3.seq, f4.seq
FROM Folder AS f1 (NOLOCK)
JOIN Folder AS f2 ON f1.FolderID = f2.ParentID
JOIN Folder AS f3 ON f2.FolderID = f3.ParentID
JOIN Folder AS f4 ON f3.FolderID = f4.ParentID
WHERE (f4.CompanyID=0 OR f4.CompanyID=@CompanyID) AND (f4.Entity=@Entity) AND f1.ParentID=0
AND (((f4.MemberID=0) AND (f4.IsShare<>0)) OR (f4.MemberID=@MemberID) OR ((f4.MemberID=@GroupID) AND (f4.IsShare<>0)))

SELECT ID, Name FROM @List ORDER BY s1,s2,s3,s4

GO