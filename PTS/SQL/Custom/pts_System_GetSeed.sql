EXEC [dbo].pts_CheckProc 'pts_System_GetSeed'
GO
--declare @Seed int exec pts_System_GetSeed @Seed OUTPUT print @Seed

CREATE PROCEDURE [dbo].pts_System_GetSeed (
	@Seed int OUTPUT 
	)
AS

SET			NOCOUNT ON

SET			@Seed = RIGHT(CAST(CAST(LEFT(CAST(NEWID( ) as varbinary),4) as varbinary) as int),4)
GO
