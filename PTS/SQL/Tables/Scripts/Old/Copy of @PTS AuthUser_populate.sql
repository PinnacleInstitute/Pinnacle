--Declare
DECLARE	@mNow datetime 
 
--Add a default sysadmin
SET	@mNow = GETDATE()

--SET IDENTITY_INSERT to ON.
SET	IDENTITY_INSERT AuthUser ON

--Add the default sysadmin record
INSERT INTO	AuthUser
 				(
				AuthUserID ,
 				Logon ,
 				Password ,
 				Email ,
 				NameLast ,
 				NameFirst ,
 				UserGroup ,
 				UserStatus ,
 				CreateDate ,
 				CreateID ,
 				ChangeDate ,
 				ChangeID
 				)
VALUES
 				(
				1 ,
 				'bob' ,
 				'bob' ,
 				'bob@pinnaclep.com' ,
 				'Admin' ,
 				'Sys' ,
 				1 ,
 				1 ,
 				@mNow ,
 				1 ,
 				@mNow ,
 				1
 				)

SET IDENTITY_INSERT AuthUser OFF
GO