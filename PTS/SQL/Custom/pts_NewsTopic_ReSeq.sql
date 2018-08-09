EXEC [dbo].pts_CheckProc 'pts_NewsTopic_ReSeq'
GO

--EXEC pts_NewsTopic_ReSeq 12, 200, 100

CREATE PROCEDURE [dbo].pts_NewsTopic_ReSeq
   @CompanyID int ,
   @Seq int ,
   @NewSeq int
AS

SET NOCOUNT ON

UPDATE NewsTopic SET Seq = @NewSeq + (Seq % 100 )
WHERE CompanyID = @CompanyID
AND   Seq > @Seq
AND   Seq < (@Seq + 100)

GO
