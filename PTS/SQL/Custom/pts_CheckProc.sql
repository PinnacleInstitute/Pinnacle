IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('[dbo].[pts_CheckProc]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[pts_CheckProc]
GO

CREATE PROCEDURE [dbo].pts_CheckProc (
	@ProcName varchar(255)
	)
	AS

DECLARE	@mTemp varchar(255),
			@mTempOld varchar(255),
			@mSql varchar(255)

SET	NOCOUNT ON

SET			@mTemp = '[dbo].[' + @ProcName + ']'
SET			@mTempOld = 'Old_' + @ProcName 
SET			@mSql = 'DROP PROCEDURE ' + @mTemp

-- first back up the existing stored procedure if necessary
-- if there isn't already a stored procedure named Old...

--IF NOT EXISTS (	SELECT		*
--			FROM		sysobjects
--			WHERE		id = OBJECT_ID(N'[dbo].[' +@mTempOld +']')
--			AND		OBJECTPROPERTY(id,N'IsProcedure') = 1
--		 	)
--			BEGIN
--			IF EXISTS (	SELECT		*
--					FROM		sysobjects
--					WHERE		id = OBJECT_ID(N'[dbo].[' + @ProcName + ']')
--					AND		OBJECTPROPERTY(id, N'IsProcedure') = 1
--					)
--					EXEC		sp_rename
--							@mTemp,
--							@mTempOld
--			END

-- drop the existing stored procedure
IF EXISTS (		SELECT		*
			FROM		sysobjects
			WHERE		id = OBJECT_ID(N'[dbo].[' + @ProcName + ']')
			AND		OBJECTPROPERTY(id, N'IsProcedure') = 1
			)
			BEGIN
			EXEC		(@mSql)
			END

PRINT '===>>> ' + @ProcName + '...'
GO
