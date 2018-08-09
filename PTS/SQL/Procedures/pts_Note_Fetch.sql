EXEC [dbo].pts_CheckProc 'pts_Note_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Note_Fetch ( 
   @NoteID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @AuthUserID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @UserName nvarchar (62) OUTPUT,
   @NoteDate datetime OUTPUT,
   @Notes varchar (1000) OUTPUT,
   @IsLocked bit OUTPUT,
   @IsFrozen bit OUTPUT,
   @IsReminder bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = nt.OwnerType ,
   @OwnerID = nt.OwnerID ,
   @AuthUserID = nt.AuthUserID ,
   @NameLast = au.NameLast ,
   @NameFirst = au.NameFirst ,
   @UserName = LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) ,
   @NoteDate = nt.NoteDate ,
   @Notes = nt.Notes ,
   @IsLocked = nt.IsLocked ,
   @IsFrozen = nt.IsFrozen ,
   @IsReminder = nt.IsReminder
FROM Note AS nt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
WHERE nt.NoteID = @NoteID

GO