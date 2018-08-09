EXEC [dbo].pts_CheckProc 'pts_GCR_StatsSupport'
GO

--DECLARE @Result varchar(1000) EXEC pts_GCR_StatsSupport 0, 129, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_GCR_StatsSupport
   @Days int ,
   @OrgID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Support Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @StartDate datetime, @EndDate datetime, @EndDate2 datetime, @AssignedTo varchar(15), @Total float, @tmpTotal float  

SET @CompanyID = 17
SET @AssignedTo = ''
IF @OrgID > 0 SELECT @AssignedTo = NameFirst FROM Org WHERE OrgID = @OrgID

-- ********* SUPPORT TICKETS *****************************************************
-- 1.Submitted  2.Assigned  3.InProcess 7.Total Unresolved
-- a.1hr  b.4hr  c.12hr  d.1day  e.2day  f.3day  g.7day  h.14day i.>14day t.total
-- *******************************************************************************
DECLARE @Z1a int, @Z1b int, @Z1c int, @Z1d int, @Z1e int, @Z1f int, @Z1g int, @Z1h int, @Z1i int, @Z1t int
DECLARE @Z2a int, @Z2b int, @Z2c int, @Z2d int, @Z2e int, @Z2f int, @Z2g int, @Z2h int, @Z2i int, @Z2t int
DECLARE @Z3a int, @Z3b int, @Z3c int, @Z3d int, @Z3e int, @Z3f int, @Z3g int, @Z3h int, @Z3i int, @Z3t int
DECLARE @Z7a int, @Z7b int, @Z7c int, @Z7d int, @Z7e int, @Z7f int, @Z7g int, @Z7h int, @Z7i int, @Z7t int
DECLARE @ZD1 int, @ZD2 int, @ZD3 int, @ZD4 int, @ZD5 int, @ZD6 int, @ZD7 int, @ZD8 int
DECLARE @ZR1 int, @ZR2 int, @ZR3 int, @ZR4 int, @ZR5 int, @ZR6 int, @ZR7 int, @ZR8 int
DECLARE @ZP1 int, @ZP2 int, @ZP3 int, @ZP4 int, @ZP5 int, @ZP6 int, @ZP7 int, @ZP8 int
SET	@Z1a=0 SET @Z1b=0 SET @Z1c=0 SET @Z1d=0 SET @Z1e=0 SET @Z1f=0 SET @Z1g=0 SET @Z1h=0 SET @Z1i=0 SET @Z1t=0  
SET	@Z2a=0 SET @Z2b=0 SET @Z2c=0 SET @Z2d=0 SET @Z2e=0 SET @Z2f=0 SET @Z2g=0 SET @Z2h=0 SET @Z2i=0 SET @Z2t=0  
SET	@Z3a=0 SET @Z3b=0 SET @Z3c=0 SET @Z3d=0 SET @Z3e=0 SET @Z3f=0 SET @Z3g=0 SET @Z3h=0 SET @Z3i=0 SET @Z3t=0  
SET	@Z7a=0 SET @Z7b=0 SET @Z7c=0 SET @Z7d=0 SET @Z7e=0 SET @Z7f=0 SET @Z7g=0 SET @Z7h=0 SET @Z7i=0 SET @Z7t=0  
SET @ZD1=0 SET @ZD2=0 SET @ZD3=0 SET @ZD4=0 SET @ZD5=0 SET @ZD6=0 SET @ZD7=0 SET @ZD8=0 
SET @ZR1=0 SET @ZR2=0 SET @ZR3=0 SET @ZR4=0 SET @ZR5=0 SET @ZR6=0 SET @ZR7=0 SET @ZR8=0 
SET @ZP1=0 SET @ZP2=0 SET @ZP3=0 SET @ZP4=0 SET @ZP5=0 SET @ZP6=0 SET @ZP7=0 SET @ZP8=0 

SET @EndDate = GETDATE()
IF @Days > 0 SET @EndDate = DATEADD(d, @Days * -1, @EndDate)

-- ****** SUPPORT TICKETS  < 1 HR ******
SET @StartDate = DATEADD(hh, -1, @EndDate)
SELECT @Z1a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7a = @Z1a + @Z2a + @Z3a

-- ****** SUPPORT TICKETS  1 - 4 HR ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -4, @EndDate)
SELECT @Z1b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7b = @Z1b + @Z2b + @Z3b

-- ****** SUPPORT TICKETS 4 - 12 HR ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -12, @EndDate)
SELECT @Z1c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7c = @Z1c + @Z2c + @Z3c

-- ****** SUPPORT TICKETS 12 - 24 HR ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -24, @EndDate)
SELECT @Z1d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7d = @Z1d + @Z2d + @Z3d

-- ****** SUPPORT TICKETS 24 - 48 HR (2 DAYS) ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -48, @EndDate)
SELECT @Z1e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7e = @Z1e + @Z2e + @Z3e

-- ****** SUPPORT TICKETS 48 - 72 HR (3 DAYS) ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -72, @EndDate)
SELECT @Z1f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7f = @Z1f + @Z2f + @Z3f

-- ****** SUPPORT TICKETS 72 - 168 HR (7 DAYS) ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -168, @EndDate)
SELECT @Z1g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7g = @Z1g + @Z2g + @Z3g

-- ****** SUPPORT TICKETS 168 - 336 HR (14 DAYS) ******
SET @EndDate2 = @StartDate
SET @StartDate = DATEADD(hh, -336, @EndDate)
SELECT @Z1h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7h = @Z1h + @Z2h + @Z3h

-- ****** SUPPORT TICKETS > 336 HR (14 DAYS) ******
SET @EndDate2 = @StartDate
SELECT @Z1i = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2i = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3i = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate < @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7i = @Z1i + @Z2i + @Z3i

-- ****** SUPPORT TICKETS TOTAL ******
SELECT @Z1t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z2t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SELECT @Z3t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate < @EndDate AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET	@Z7t = @Z1t + @Z2t + @Z3t

-- ****** DAILY SUPPORT TICKETS ******
SET @EndDate2 = dbo.wtfn_DateOnly(@EndDate)
SELECT @ZD1 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD2 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD3 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD4 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD5 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD6 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD7 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)
SET @EndDate2 = DATEADD(d, -1, @EndDate2)
SELECT @ZD8 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DoneDate = @EndDate2 AND ( @OrgID = 0 OR AssignedTo = @AssignedTo)

-- ****** SUPPORT TICKET DAYS ******
SET @EndDate = DATEADD(d, -30, @EndDate)
SELECT @ZR1 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 1 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR2 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 2 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR3 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 3 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR4 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 4 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR5 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 5 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR6 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 6 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR7 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) = 7 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate
SELECT @ZR8 = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND DATEDIFF(d, IssueDate, DoneDate) > 7 AND (@OrgID = 0 OR AssignedTo = @AssignedTo) AND DoneDate >= @EndDate

-- ****** SUPPORT TICKET DAYS PERCENTAGE ******
SET @Total = @ZR1 + @ZR2 + @ZR3 + @ZR4 + @ZR5 + @ZR6 + @ZR7 + @ZR8
SET @tmpTotal = @Total
IF @tmpTotal = 0 SET @tmpTotal = 1
SET @ZP1 = (@ZR1 / @tmpTotal) * 100
SET @ZP2 = (@ZR2 / @tmpTotal) * 100
SET @ZP3 = (@ZR3 / @tmpTotal) * 100
SET @ZP4 = (@ZR4 / @tmpTotal) * 100
SET @ZP5 = (@ZR5 / @tmpTotal) * 100
SET @ZP6 = (@ZR6 / @tmpTotal) * 100
SET @ZP7 = (@ZR7 / @tmpTotal) * 100
SET @ZP8 = (@ZR8 / @tmpTotal) * 100

SET @Result = '<PTSSTATS ' + 
'z1a="'  + CAST(@Z1a AS VARCHAR(10)) + '" ' +
'z1b="'  + CAST(@Z1b AS VARCHAR(10)) + '" ' +
'z1c="'  + CAST(@Z1c AS VARCHAR(10)) + '" ' +
'z1d="'  + CAST(@Z1d AS VARCHAR(10)) + '" ' +
'z1e="'  + CAST(@Z1e AS VARCHAR(10)) + '" ' +
'z1f="'  + CAST(@Z1f AS VARCHAR(10)) + '" ' +
'z1g="'  + CAST(@Z1g AS VARCHAR(10)) + '" ' +
'z1h="'  + CAST(@Z1h AS VARCHAR(10)) + '" ' +
'z1i="'  + CAST(@Z1i AS VARCHAR(10)) + '" ' +
'z1t="'  + CAST(@Z1t AS VARCHAR(10)) + '" ' +
'z2a="'  + CAST(@Z2a AS VARCHAR(10)) + '" ' +
'z2b="'  + CAST(@Z2b AS VARCHAR(10)) + '" ' +
'z2c="'  + CAST(@Z2c AS VARCHAR(10)) + '" ' +
'z2d="'  + CAST(@Z2d AS VARCHAR(10)) + '" ' +
'z2e="'  + CAST(@Z2e AS VARCHAR(10)) + '" ' +
'z2f="'  + CAST(@Z2f AS VARCHAR(10)) + '" ' +
'z2g="'  + CAST(@Z2g AS VARCHAR(10)) + '" ' +
'z2h="'  + CAST(@Z2h AS VARCHAR(10)) + '" ' +
'z2i="'  + CAST(@Z2i AS VARCHAR(10)) + '" ' +
'z2t="'  + CAST(@Z2t AS VARCHAR(10)) + '" ' +
'z3a="'  + CAST(@Z3a AS VARCHAR(10)) + '" ' +
'z3b="'  + CAST(@Z3b AS VARCHAR(10)) + '" ' +
'z3c="'  + CAST(@Z3c AS VARCHAR(10)) + '" ' +
'z3d="'  + CAST(@Z3d AS VARCHAR(10)) + '" ' +
'z3e="'  + CAST(@Z3e AS VARCHAR(10)) + '" ' +
'z3f="'  + CAST(@Z3f AS VARCHAR(10)) + '" ' +
'z3g="'  + CAST(@Z3g AS VARCHAR(10)) + '" ' +
'z3h="'  + CAST(@Z3h AS VARCHAR(10)) + '" ' +
'z3i="'  + CAST(@Z3i AS VARCHAR(10)) + '" ' +
'z3t="'  + CAST(@Z3t AS VARCHAR(10)) + '" ' +
'z7a="'  + CAST(@Z7a AS VARCHAR(10)) + '" ' +
'z7b="'  + CAST(@Z7b AS VARCHAR(10)) + '" ' +
'z7c="'  + CAST(@Z7c AS VARCHAR(10)) + '" ' +
'z7d="'  + CAST(@Z7d AS VARCHAR(10)) + '" ' +
'z7e="'  + CAST(@Z7e AS VARCHAR(10)) + '" ' +
'z7f="'  + CAST(@Z7f AS VARCHAR(10)) + '" ' +
'z7g="'  + CAST(@Z7g AS VARCHAR(10)) + '" ' +
'z7h="'  + CAST(@Z7h AS VARCHAR(10)) + '" ' +
'z7i="'  + CAST(@Z7i AS VARCHAR(10)) + '" ' +
'z7t="'  + CAST(@Z7t AS VARCHAR(10)) + '" ' +
'zd1="'  + CAST(@ZD1 AS VARCHAR(10)) + '" ' +
'zd2="'  + CAST(@ZD2 AS VARCHAR(10)) + '" ' +
'zd3="'  + CAST(@ZD3 AS VARCHAR(10)) + '" ' +
'zd4="'  + CAST(@ZD4 AS VARCHAR(10)) + '" ' +
'zd5="'  + CAST(@ZD5 AS VARCHAR(10)) + '" ' +
'zd6="'  + CAST(@ZD6 AS VARCHAR(10)) + '" ' +
'zd7="'  + CAST(@ZD7 AS VARCHAR(10)) + '" ' +
'zd8="'  + CAST(@ZD8 AS VARCHAR(10)) + '" ' +
'zr1="'  + CAST(@ZR1 AS VARCHAR(10)) + '" ' +
'zr2="'  + CAST(@ZR2 AS VARCHAR(10)) + '" ' +
'zr3="'  + CAST(@ZR3 AS VARCHAR(10)) + '" ' +
'zr4="'  + CAST(@ZR4 AS VARCHAR(10)) + '" ' +
'zr5="'  + CAST(@ZR5 AS VARCHAR(10)) + '" ' +
'zr6="'  + CAST(@ZR6 AS VARCHAR(10)) + '" ' +
'zr7="'  + CAST(@ZR7 AS VARCHAR(10)) + '" ' +
'zr8="'  + CAST(@ZR8 AS VARCHAR(10)) + '" ' +
'zp1="'  + CAST(@ZP1 AS VARCHAR(10)) + '%" ' +
'zp2="'  + CAST(@ZP2 AS VARCHAR(10)) + '%" ' +
'zp3="'  + CAST(@ZP3 AS VARCHAR(10)) + '%" ' +
'zp4="'  + CAST(@ZP4 AS VARCHAR(10)) + '%" ' +
'zp5="'  + CAST(@ZP5 AS VARCHAR(10)) + '%" ' +
'zp6="'  + CAST(@ZP6 AS VARCHAR(10)) + '%" ' +
'zp7="'  + CAST(@ZP7 AS VARCHAR(10)) + '%" ' +
'zp8="'  + CAST(@ZP8 AS VARCHAR(10)) + '%" ' +
'/>'

GO

