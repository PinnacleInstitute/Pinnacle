IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('[dbo].[pts_CheckTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[pts_CheckTable]
GO

CREATE PROCEDURE [dbo].pts_CheckTable (
	@TableName varchar(255)
	)
AS

SET				NOCOUNT ON

DECLARE		@mTableID int ,
				@mTableName varchar(255) ,
				@mOldID int ,
				@mOldName varchar(255) ,
				@mSQL varchar(2048) ,
				@mConstraintName varchar(255) ,
				@mOwnerTable varchar(255)

--GET THE UNIQUE OBJECT ID AND FULLY-QUALIFIED
--NAMES FOR THE NEW AND OLD TABLES
SET				@mTableName = @TableName
SET				@mTableID = ISNULL(OBJECT_ID(@mTableName),0)
SET				@mOldName = 'Old_' + @TableName
SET				@mOldID =  ISNULL(OBJECT_ID(@mOldName),0)

--DROP ALL FOREIGN KEYS RELATED TO THE TABLE
--This includes all foreign keys owned by this table and
--all foreign keys owned by other tables which reference this table
DECLARE	cursorFK	CURSOR READ_ONLY
FOR		SELECT		soc.name , sop.name 
			FROM		sysforeignkeys sf ,
						sysobjects soc ,
						sysobjects sop 
			WHERE		sop.id = sf.fkeyid
			AND		soc.id = sf.constid
			AND		(sf.fkeyid = @mTableID OR sf.rkeyid = @mTableID)

OPEN			cursorFK
FETCH NEXT 	FROM cursorFK INTO @mConstraintName, @mOwnerTable

WHILE			(@@fetch_status = 0)
				BEGIN
				SET		@mSQL = 'ALTER TABLE ' + @mOwnerTable + ' DROP CONSTRAINT ' + @mConstraintName 
				EXEC	(@mSQL)
				FETCH NEXT FROM cursorFK INTO @mConstraintName, @mOwnerTable
				END
CLOSE			cursorFK
DEALLOCATE	cursorFK

--DROP ALL CONSTRAINTS ON THE TABLE
--This includes all defaults, primary keys and index constraints
DECLARE	cursorCNT	CURSOR READ_ONLY
FOR		SELECT		name
			FROM		sysobjects so
			WHERE		parent_obj = @mTableID
			AND		parent_obj <> 0

OPEN			cursorCNT
FETCH NEXT 	FROM cursorCNT INTO @mConstraintName

WHILE			(@@fetch_status = 0)
				BEGIN
				SET		@mSQL = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @mConstraintName 
				EXEC	(@mSQL)
				FETCH NEXT FROM cursorCNT INTO @mConstraintName
				END
CLOSE			cursorCNT
DEALLOCATE	cursorCNT

--DROP ALL INDEXES ON THE TABLE
DECLARE	cursorIDX	CURSOR READ_ONLY
FOR		SELECT		si.name
			FROM		sysindexes si
			WHERE		id = @mTableID
			AND		Keys IS NOT NULL

OPEN			cursorIDX
FETCH NEXT 	FROM cursorIDX INTO @mConstraintName

WHILE			(@@fetch_status = 0)
				BEGIN
				SET		@mSQL = 'DROP INDEX ' + @TableName + '.' + @mConstraintName 
				EXEC	(@mSQL)
				FETCH NEXT FROM cursorIDX INTO @mConstraintName
				END
CLOSE			cursorIDX
DEALLOCATE	cursorIDX

--BACKUP THE TABLE IF IT ISN'T ALREADY THERE
IF (@mTableID > 0)
	BEGIN
	IF (@mOldID = 0)
		BEGIN
		EXEC	SP_RENAME @mTableName,  @mOldName
		END
	ELSE
		BEGIN
		SET		@mSQL = 'DROP TABLE ' + @TableName
		EXEC	(@mSQL)
		END
	END

PRINT '===>>> ' + @TableName + '...'
GO
