EXEC [dbo].pts_CheckProc 'pts_Moption_Add'
 GO

CREATE PROCEDURE [dbo].pts_Moption_Add ( 
   @MoptionID int OUTPUT,
   @MemberID int,
   @IsActivity bit,
   @ActivityTracks varchar (20),
   @TrackTheme int,
   @MenuColors varchar (200),
   @Portal varchar (100),
   @Options0 varchar (50),
   @Options1 varchar (50),
   @Options2 varchar (50),
   @Options3 varchar (50),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Moption (
            MemberID , 
            IsActivity , 
            ActivityTracks , 
            TrackTheme , 
            MenuColors , 
            Portal , 
            Options0 , 
            Options1 , 
            Options2 , 
            Options3
            )
VALUES (
            @MemberID ,
            @IsActivity ,
            @ActivityTracks ,
            @TrackTheme ,
            @MenuColors ,
            @Portal ,
            @Options0 ,
            @Options1 ,
            @Options2 ,
            @Options3            )

SET @mNewID = @@IDENTITY

SET @MoptionID = @mNewID

GO