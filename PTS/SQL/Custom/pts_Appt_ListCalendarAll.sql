EXEC [dbo].pts_CheckProc 'pts_Appt_ListCalendarAll'
GO

CREATE PROCEDURE [dbo].pts_Appt_ListCalendarAll
   @CalendarID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

DECLARE @wDay1 int, @wDay2 int, @dDay1 int, @dDay2 int, @yDay1 int, @yDay2 int
-- these variables are for calculating recurring appointments
-- They assume the @FromDate and @Todate are a single day or month
SET @wDay1 = DATEPART(dw, @FromDate)
SET @wDay2 = DATEPART(dw, @ToDate)
SET @dDay1 = DATEPART(dd, @FromDate)
SET @dDay2 = DATEPART(dd, @ToDate)
SET @yDay1 = DATEPART(dy, @FromDate)
SET @yDay2 = DATEPART(dy, @ToDate)
-- Set monthly range of days of week
IF @FromDate != @ToDate 
BEGIN
	SET @wDay1 = 1
	SET @wDay2 = 7
END

SELECT app.ApptID, 
       app.ApptName, 
       app.Location, 
       app.Note, 
       app.StartDate, 
       app.StartTime, 
       app.EndDate, 
       app.EndTime, 
       app.IsAllDay, 
       app.Status, 
       app.ApptType, 
       app.Importance, 
       app.Show, 
       app.Recur,
       app.RecurDate,
       app.IsEdit,
       app.IsPlan
FROM Appt AS app (NOLOCK)
WHERE app.CalendarID = @CalendarID
AND ( ( app.StartDate >= @FromDate AND app.StartDate <= @ToDate )
	OR ( app.EndDate   >= @FromDate AND app.EndDate   <= @ToDate )
 	OR ( ( app.Recur != 0 AND app.StartDate < @FromDate AND (app.RecurDate = 0 OR app.RecurDate >= @FromDate) )
		AND ( ( app.Recur = 1 AND DATEPART(dw, app.StartDate) BETWEEN @wDay1 AND @wDay2 )
	  	OR    ( app.Recur = 2 AND DATEPART(dd, app.StartDate) BETWEEN @dDay1 AND @dDay2 )
	  	OR    ( app.Recur = 3 AND DATEPART(dy, app.StartDate) BETWEEN @yDay1 AND @yDay2 ) )
	   ) 
    ) 

ORDER BY   app.StartDate

GO