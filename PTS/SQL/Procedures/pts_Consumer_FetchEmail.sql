EXEC [dbo].pts_CheckProc 'pts_Consumer_FetchEmail'
GO

CREATE PROCEDURE [dbo].pts_Consumer_FetchEmail
   @Email nvarchar (80) ,
   @ConsumerID int OUTPUT
AS

DECLARE @mConsumerID int

SET NOCOUNT ON

SELECT      @mConsumerID = csm.ConsumerID
FROM Consumer AS csm (NOLOCK)
WHERE (csm.Email = @Email)


SET @ConsumerID = ISNULL(@mConsumerID, 0)
GO