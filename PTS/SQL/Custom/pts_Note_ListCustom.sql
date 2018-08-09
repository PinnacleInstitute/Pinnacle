EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom'
GO

CREATE PROCEDURE [dbo].pts_Note_ListCustom
   @Num int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

--Prospect Lists
IF @Num = 1 EXEC pts_Note_ListCustom_1 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 2 EXEC pts_Note_ListCustom_2 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 3 EXEC pts_Note_ListCustom_3 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 4 EXEC pts_Note_ListCustom_4 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 5 EXEC pts_Note_ListCustom_5 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 6 EXEC pts_Note_ListCustom_6 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 7 EXEC pts_Note_ListCustom_7 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 8 EXEC pts_Note_ListCustom_8 @FromDate, @ToDate, @Data1, @Data2, @Data3

--Project Lists
IF @Num = 11 EXEC pts_Note_ListCustom_11 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 12 EXEC pts_Note_ListCustom_12 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 13 EXEC pts_Note_ListCustom_13 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 14 EXEC pts_Note_ListCustom_14 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 15 EXEC pts_Note_ListCustom_15 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 16 EXEC pts_Note_ListCustom_16 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 17 EXEC pts_Note_ListCustom_17 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 18 EXEC pts_Note_ListCustom_18 @FromDate, @ToDate, @Data1, @Data2, @Data3

--User Project Lists
IF @Num = 21 EXEC pts_Note_ListCustom_21 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 22 EXEC pts_Note_ListCustom_22 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 23 EXEC pts_Note_ListCustom_23 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 24 EXEC pts_Note_ListCustom_24 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 25 EXEC pts_Note_ListCustom_25 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 26 EXEC pts_Note_ListCustom_26 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 27 EXEC pts_Note_ListCustom_27 @FromDate, @ToDate, @Data1, @Data2, @Data3
IF @Num = 28 EXEC pts_Note_ListCustom_28 @FromDate, @ToDate, @Data1, @Data2, @Data3

GO