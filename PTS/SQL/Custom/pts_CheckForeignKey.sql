IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('[dbo].[pts_CheckForeignKey]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[pts_CheckForeignKey]
GO

CREATE PROCEDURE [dbo].pts_CheckForeignKey (
	@KeyName varchar(255)
	)
AS

SET				NOCOUNT ON

DECLARE		@mOwnerTable varchar(255) ,
				@mSQL varchar(255)

--get the name of the owner of the foreign key
SELECT			@mOwnerTable = 	sop.name 
FROM			sysforeignkeys sf ,
				sysobjects soc ,
				sysobjects sop 
WHERE			sop.id = sf.fkeyid
AND			soc.id = sf.constid
AND			soc.name = @KeyName

SET				@mOwnerTable = ISNULL(@mOwnerTable,'')

--drop the constraint
IF (@mOwnerTable <> '')
	BEGIN	
	SET			@mSQL = 'ALTER TABLE ' + @mOwnerTable + ' DROP CONSTRAINT ' + @KeyName 
	EXEC		(@mSQL)
	END

PRINT '===>>> ' + @KeyName + '...'
GO

