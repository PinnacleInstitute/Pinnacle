<% 
On Error Resume Next

Sub DoError(ByVal bvErrorMsg)
   reqChartTitle = Err.Description
End Sub

Function Ceiling(ByVal bvValue)
	If bvValue = CInt(bvValue) Then Ceiling = CInt(bvValue) Else Ceiling = CInt(bvValue) + 1
End Function

Function Quarter(ByVal bvDate)
	Quarter = DatePart("q", bvDate)
End Function

Sub GroupByDateUnit(ByRef dates, ByRef values, ByVal unit, ByVal startDate, ByVal endDate)
	Dim dateInterval
	Dim tmpAdd
	Dim dateRange
	Dim tmpValues()
	Dim tmpDates()
	Dim tmpDate
	Dim tmpValue
	Dim tmpOldDate
	Dim tmpUnitSum
	Dim tmpIndex
	
	Select Case LCase(unit)
	Case "day", "d":
		dateInterval = "D"
		tmpAdd = 0
	Case "month", "m":	
		dateInterval = "M"
		tmpAdd = 1
	Case "week", "w", "ww":	
		dateInterval = "WW"
		tmpAdd = 1
	Case "quarter", "q":
		dateInterval = "q"
		tmpAdd = 1
	Case "year", "y":
		dateInterval = "y"
		tmpAdd = 1
	Case Else:
		'Default to day
		dateInterval = "D"
		tmpAdd = 0
	End Select
	
	'calculate the size of the date range
	dateRange = DateDiff(dateInterval, startDate, endDate) + tmpAdd
	
	'initialize the data arrays
	ReDim tmpValues(dateRange)
	ReDim tmpDates(dateRange)

	'Generate the labels for the data set
	tmpDate = startDate
	For x = LBound(tmpDates) To UBound(tmpDates)
		Select Case tmpDate
		Case "D":
			tmpDates(x) = WeekdayName(Weekday(tmpDate), true) & " " & Month(tmpDate) & "/" & Day(tmpDate)
		Case "M":	
			tmpDates(x) = MonthName(Month(tmpDate), true) & " " & Year(tmpDate)
		Case "WW":	
			tmpDates(x) = CDate(tmpDate) - (Weekday(tmpDate)-1)
		Case "q":
			tmpDates(x) = "Q" & Quarter(tmpDate) & " " & Year(tmpDate)
		Case "y":
			tmpDates(x) = Year(tmpDate)
		End Select
		tmpDate = DateAdd(dateInterval, 1, tmpDate)
	Next

	'loop through the raw values passed, sum by unit, store in the data array	
	tmpUnitSum = 0	
	tmpOldDate = values(LBound(values))
	For x = LBound(values) To UBound(values)
		tmpValue = values(x)
		tmpDate = CDate(dates(x))
		tmpIndex = DateDiff(dateInterval, startDate, tmpOldDate) + LBound(values)	
				
		If tmpIndex >= LBound(values) And tmpIndex <= UBound(values) Then			
			If (DateDiff(dateInterval, tmpOldDate, tmpDate) <> 0) Or (x = UBound(values)) Then
				If (x = UBound(values)) Then
					tmpUnitSum = tmpUnitSum + tmpValue
				End If
				
				values( tmpIndex ) = tmpUnitSum			
				tmpUnitSum = 0
			End If
			
			tmpUnitSum = tmpUnitSum + tmpValue
		End If
		
		tmpOldDate = tmpDate
	Next
	
	dates = Nothing
	values = Nothing
	
	dates = tmpDates
	values = tmpValues
End Sub

Sub SpaceLabels(ByRef labels, ByVal chartWidth)
	' find the longest label
	Dim barWidth
	Dim labelMax
	Dim numLabels
	Dim spacing
	Dim avgCharWidth
	
	'Best guess at average character width
	avgCharWidth = 9
	numLabels = UBound(labels) - LBound(labels)
	If (numLabels > 2) And (chartWidth > 0) Then
		barWidth = chartWidth/numLabels
		labelMax = 1
		
		'calculate the longest label size
		For x = LBound(labels) To UBound(labels)
			If Len(labels(x)) > labelMax Then
				labelMax = Len(labels(x))
			End If
		Next
		
		If barWidth = 0 Then barWidth = 1	
		spacing = CInt((labelMax*avgCharWidth)/barWidth)
	
		'apply the spacing
		For x = LBound(labels) To UBound(labels)
			If (x Mod spacing) <> 0 Then
				labels(x) = ""
			End If
		Next
	End If
End Sub

Function CreateChart(	ByRef data, ByRef data2, ByRef data3, _
						ByRef legend, _
						ByRef labels, _
						ByVal chartType, _
						ByVal chartWidth, _
						ByVal chartHeight, _
						ByVal chartTitle, _
						ByVal xTitle, _
						ByVal yTitle)
						 
	On Error Resume Next

	Dim oChartDirector
	Dim oChart
	Dim plotHeight, plotWidth, plotMarginTop, plotMarginLeft
	Dim textbox
	Dim layer
	
	'create the chart object
	Set oChartDirector = CreateObject("ChartDirector.API")
	If oChartDirector Is Nothing Then
	   CreateChart = Nothing
	   Exit Function
	End If
	
	With oChartDirector
		Select Case chartType
		Case "pie":
			Set oChart = .PieChart(chartWidth, chartHeight, .metalColor(&Hccccff, 0), .Transparent, 1)
			With oChart
				Call .setRoundedFrame( &Hffffff, 20)
				Call .setDropShadow()
			End With
		Case "bar", "hbar", "line", "area":
			Set oChart = .XYChart(chartWidth, chartHeight, .metalColor(&Hccccff, 0), .Transparent, 1)
			With oChart
				Call .setRoundedFrame( &Hffffff, 20)
				Call .setDropShadow()
			End With
		Case "meter":
            Set oChart = .AngularMeter(chartWidth, chartHeight, .metalColor(&Hccccff, 0), .Transparent, 1)
			With oChart
				Call .setRoundedFrame( &Hffffff, 20)
				Call .setDropShadow()
			End With
		Case Else: 
			Set oChart = .XYChart(chartWidth, chartHeight)
		End Select
		
		'set all empty values to the defined NoValue state
		If chartType <> "meter" Then
			For x = LBound(data) To UBound(data)
				If( data(x) = NULL OR data(x) = 0 ) Then data(x) = .NoValue
			Next
		End If
	End With
		
	With oChart
		'Calculate the plot area size
		Select Case chartType
		Case "pie":
			plotWidth = chartWidth * 0.85
			plotMarginLeft = chartWidth * 0.15
			
		Case "meter":
			plotWidth = chartWidth * 0.70
			plotMarginLeft = chartWidth * 0.25
			
		Case "hbar":
			plotWidth = chartWidth * 0.70
			plotMarginLeft = chartWidth * 0.25

		Case Else:
			plotWidth = chartWidth * 0.90
			plotMarginLeft = chartWidth * 0.06
		End Select

		If chartTitle <> "" Then
			'set the title
			.addTitle(chartTitle)
		
			'Set the plotarea
			plotHeight = chartHeight * 0.80
			plotMarginTop = chartHeight * 0.10			
		Else
			'Set the plotarea
			Select Case chartType
			Case "meter":
				plotHeight = chartHeight * 0.90
				plotMarginTop = chartHeight * 0.05
			Case Else:
				plotHeight = chartHeight * 0.85
				plotMarginTop = chartHeight * 0.05
			End Select
		End If
	
        'Adjust plot area for top legend
	    If chartType = "line" And uBound(legend) >= 0 Then	
			plotHeight = plotHeight - 25
			plotMarginTop = plotMarginTop + 25			
	    End If
	

		'Set attributes of the 2 axis charts
		If chartType <> "pie" Then
			'Set the plot area
			Call .setPlotArea (plotMarginLeft, plotMarginTop, plotWidth, plotHeight, &Hffffff, -1, -1, &Hcccccc, &Hcccccc)
		
			Select Case chartType
			Case "bar":
				'Add a bar chart layer using the given data.
				Set layer = .addBarLayer(data)
				
				'Set the bar gap to 10%
				Call layer.setBarGap(0.1)
				
				'Set 3D
				Call layer.set3D()
				
			Case "hbar":
				'Add a bar chart layer using the given data.
'				Set layer = .addBarLayer(data)
				Set layer = .addBarLayer(data, .gradientColor(100, 0, chartWidth, 0, &Hff0000, &Hffffff))				

				'Set the bar gap to 10%
				Call layer.setBarGap(0.20)
				'Call .xAxis().setAutoScale(0.2)

				'Set 3D
				Call layer.set3D(3)

				'Swap the axis so that the bars are drawn horizontally
				Call .swapXY(True)

			Case "line":
				If uBound(data2) >= 0 Then
					Set layer = .addLineLayer2()
					If uBound(data) >= 0 Then Call layer.addDataSet(data, &Hff0000, legend(0) )
					If uBound(data2) >= 0 Then Call layer.addDataSet(data2, &H00ff00, legend(1) )
					If uBound(data3) >= 0 Then Call layer.addDataSet(data3, &H0000ff, legend(2) )
				Else
					Set layer = .addLineLayer(data)
				End If    
				layer.set3D(10)
'				layer.setLineWidth(2)

				If uBound(legend) >= 0 Then	
					Call .addLegend(60, 5, False, "arialbd.ttf", 9).setBackground(oChartDirector.Transparent)
				End If
				
			Case "meter":

		val  = data(0)
		val1 = data(1)
		val2 = data(2)
		val3 = data(3)
		val4 = data(4)
		val5 = data(5)
		lab1 = labels(0)
		lab2 = labels(1)
		lab3 = labels(2)
		lab4 = labels(3)
		lab5 = labels(4)

                Call .setMeter(plotMarginLeft + (plotWidth/2), plotMarginTop + (plotHeight/2), plotHeight/2, -135, 135)
		Call .setLineWidth(0, 2, 1)
                Call .setScale(0, val5, 100, 25, 5)

                Call .addZone(0, val1, 0, plotHeight/2, &H78c5d6)
                Call .addZone(val1, val2, 0, plotHeight/2, &H79c267)
                Call .addZone(val2, val3, 0, plotHeight/2, &Hf5d63d)
                Call .addZone(val3, val4, 0, plotHeight/2, &Hf28c33)
                Call .addZone(val4, val5, 0, plotHeight/2, &Hbf62a6)


		' Set the circular meter surface as metallic blue (9999DD)
		Call .addRing(0, (plotHeight/2)-20, oChartDirector.metalColor(&H9999dd))

		' Add a gray (CECEDB) ring between radii 88 - 90 as decoration
		Call .addRing( (plotHeight/2)+3, (plotHeight/2)+5, &Hc6c6f4)

		'Add a text label centered at (100, 135) with 15 pts Arial Bold font
		Call .addText(plotMarginLeft + (plotWidth/2), plotMarginTop + (plotHeight*.65), "POINTS", "arialbd.ttf", 15,oChartDirector.TextColor, oChartDirector.Center)

		MarginLeft = chartWidth * 0.05

		Set textbox = .addText(MarginLeft, plotMarginTop + (plotHeight*.15), lab1, "arialbd.ttf", 12, &Hffffff, oChartDirector.TopLeft)
		textbox.setBackground &H78c5d6, &H78c5d6, -1
		textbox.setAlignment 5
		textbox.setWidth 175
		textbox.setRoundedCorners 10
		Set textbox = Nothing	
		Set textbox = .addText(MarginLeft, plotMarginTop + (plotHeight*.30), lab2, "arialbd.ttf", 12, &Hffffff, oChartDirector.TopLeft)
		textbox.setBackground &H79c267, &H79c267, -1
		textbox.setAlignment 5
		textbox.setWidth 175
		textbox.setRoundedCorners 10
		Set textbox = Nothing	
		Set textbox = .addText(MarginLeft, plotMarginTop + (plotHeight*.45), lab3, "arialbd.ttf", 12, &Hffffff, oChartDirector.TopLeft)
		textbox.setBackground &Hf5d63d, &Hf5d63d, -1
		textbox.setAlignment 5
		textbox.setWidth 175
		textbox.setRoundedCorners 10
		Set textbox = Nothing	
		Set textbox = .addText(MarginLeft, plotMarginTop + (plotHeight*.60), lab4, "arialbd.ttf", 12, &Hffffff, oChartDirector.TopLeft)
		textbox.setBackground &Hf28c33, &Hf28c33, -1
		textbox.setAlignment 5
		textbox.setWidth 175
		textbox.setRoundedCorners 10
		Set textbox = Nothing	
		Set textbox = .addText(MarginLeft, plotMarginTop + (plotHeight*.75), lab5, "arialbd.ttf", 12, &Hffffff, oChartDirector.TopLeft)
		textbox.setBackground &Hbf62a6, &Hbf62a6, -1
		textbox.setAlignment 5
		textbox.setWidth 175
		textbox.setRoundedCorners 10
		Set textbox = Nothing	

		CALL .addText(plotMarginLeft + (plotWidth/2), plotMarginTop + (plotHeight*.75), .formatValue(val, "0"), "arial.ttf", 14, &Hffffff, oChartDirector.Center).setBackground( &H000000, &H000000, -1)
                Call .addPointer(val, &H40666699, &H000000)
				
			'Case "Scatter":
				'Add an orange (0xff9933) scatter chart layer, using 13 pixel diamonds as symbols
				'Call c.addScatterLayer(dataX0, dataY0, "Genetically Engineered", cd.DiamondSymbol, 13, &Hff9933)

				'Add a green (0x33ff33) scatter chart layer, using 11 pixel triangles as symbols
				'Call c.addScatterLayer(dataX1, dataY1, "Natural", cd.TriangleSymbol, 11, &H33ff33)
			case "area":
				Set layer = .addAreaLayer(data)
			Case Else:
				Set layer = .addLineLayer(data)
			End Select
			
			'Set the labels on the x axis
			Set textbox = .xAxis().setLabels(labels)
			Call .xAxis().setLabelStep(1,1,1)
			
			'Set the x axis label font to 10pt Arial Bold Italic
			Call textbox.setFontStyle("arialbi.ttf")
			Call textbox.setFontSize(8)
			
			'set titles
			If xTitle <> "" Then
				Call .xAxis().setTitle(xTitle)
			End If
		
			If yTitle <> "" Then
				Call .yAxis().setTitle(yTitle)
			End If
			
			'Use the format passed in
			Call layer.setAggregateLabelFormat("{value} ({gpercent|0.}%)")
		
			'Set the bar label font to 10 pts Times Bold Italic/dark red (0x663300)
'			Call layer.setAggregateLabelStyle("timesbi.ttf", 8, &H663300)
			
		Else 'Pie chart attributes
			Dim radius
			If plotWidth > plotHeight Then radius = (plotHeight/2) Else radius = (plotWidth/2)
				
			'Set the center of the pie
			Call .setPieSize((plotWidth/2)+plotMarginLeft, (plotHeight/2)+plotMarginTop, radius)
		
			'Draw the pie in 3D
			Call .set3D()
				
			'Set the pie data and the pie labels
			Call .setData(data, labels)
			
			Dim pieLegend
			Set pieLegend = .addLegend(5, 5)
			Call pieLegend.setText("{label} {value|,} ({percent|0.}%)")
			'Call pieLegend.setText("{label}")
			Call pieLegend.setBackground(&Hffffff, &H444444)
			Call pieLegend.setRoundedCorners()
				
			Call .setLabelFormat("{label}<*br*>{value|,} ({percent|0.}%)")
			'Call .setLabelFormat("{value|,} ({percent|0.}%)")

		End If
	End With
		
	Set oChartDirector = Nothing		
	Set textbox = Nothing	
	Set layer = Nothing
				
	Set CreateChart = oChart	
	
End Function
%>  