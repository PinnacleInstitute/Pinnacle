<%
Function TimeZone( byval reqNumber)
	On Error Resume Next
	If IsNumeric(reqNumber) Then 
		num = CLng(Left(reqNumber, 3))
		Select Case num
		Case 201,202,203,207,212,215,216,226,229,231,234,239,240,248,252,260,267,269,276,289,301,302,304,305,313,315,317,321,330,336,339,347,351,352,401,404,407,410,412,413,416,418,419,434,438,440,443,450,470,478,484,508,513,514,516,517,518,519,540,551,561,567,570,571,585,586,603,607,609,610,613,614,616,617,631,646,647,678,703,704,705,706,716,717,718,724,727,732,734,740,754,757,762,765,770,772,774,781,786,802,803,804,807,810,813,814,819,828,843,845,848,856,857,859,860,862,863,864,865,878,904,905,908,910,912,914,917,919,937,941,947,954,973,978,980,989,219,386,423,574,606,812,906
			TimeZone = "EST"
		Case 204,205,210,214,217,218,224,225,228,251,254,256,262,281,309,312,314,316,318,319,320,325,337,361,405,409,414,417,430,432,469,479,501,504,507,512,515,563,573,580,601,608,612,615,618,630,636,641,651,660,662,682,708,712,713,715,731,763,769,773,806,815,816,817,830,832,847,870,901,903,913,918,920,931,936,940,952,956,972,979,985,270,308,334,402,502,605,620,701,785,850,915
			TimeZone = "CST"
		Case 303,306,307,403,406,435,480,505,520,602,623,719,720,780,801,928,970,208
			TimeZone = "MST"
		Case 206,209,213,250,253,310,323,360,408,415,424,425,503,509,510,530,559,562,604,619,626,650,661,702,707,714,760,775,778,805,818,831,858,867,909,916,925,949,951,971,541
			TimeZone = "PST"
		Case 340,506,902,709
			TimeZone = "ATL"
		Case 907
			TimeZone = "ALA"
		Case 242
			TimeZone = "HAW"
		Case Else	
			TimeZone = ""
		End Select
	End If
End Function
%>
