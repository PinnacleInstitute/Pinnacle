EXEC [dbo].pts_CheckProc 'pts_Member_CalcMasterPrice'
GO

CREATE PROCEDURE [dbo].pts_Member_CalcMasterPrice
   @MemberID int 
AS

SET         NOCOUNT ON

DECLARE @Price money, @MasterPrice money, @BusAcctPrice money, @BusAccts int, @MasterMembers int

SELECT @Price = Price, @BusAcctPrice = BusAcctPrice, @BusAccts = BusAccts FROM Member WHERE MemberID = @MemberID
SELECT @MasterMembers = 1 + ISNULL(COUNT(*),0) FROM Member WHERE MasterID = @MemberID AND Status = 1 AND Billing = 4 

SET @MasterPrice = 0
IF @MasterMembers > @BusAccts SET @MasterPrice = (@MasterMembers - @BusAccts) * @BusAcctPrice 

UPDATE Member SET MasterPrice = @Price + @MasterPrice, MasterMembers = @MasterMembers WHERE MemberID = @MemberID

GO