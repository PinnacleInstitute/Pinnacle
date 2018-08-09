EXEC [dbo].pts_CheckProc 'pts_Msg_ListMsgs'
GO

CREATE PROCEDURE [dbo].pts_Msg_ListMsgs
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

SELECT      mg.MsgID, 
         mg.AuthUserID, 
         mg.MsgDate, 
         mg.Subject, 
         mg.Message, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName'
FROM Msg AS mg (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mg.AuthUserID = au.AuthUserID)
WHERE (mg.OwnerType = @OwnerType)
 AND (mg.OwnerID = @OwnerID)

ORDER BY   mg.MsgDate DESC , mg.MsgID DESC

GO