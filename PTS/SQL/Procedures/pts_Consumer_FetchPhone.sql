EXEC [dbo].pts_CheckProc 'pts_Consumer_FetchPhone'
GO

CREATE PROCEDURE [dbo].pts_Consumer_FetchPhone
   @Phone nvarchar (20) ,
   @ConsumerID int OUTPUT
AS

DECLARE @mConsumerID int

SET NOCOUNT ON

SELECT      @mConsumerID = csm.ConsumerID
FROM Consumer AS csm (NOLOCK)
WHERE (csm.Phone = @Phone)


SET @ConsumerID = ISNULL(@mConsumerID, 0)
GO