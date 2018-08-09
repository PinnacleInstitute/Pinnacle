<%
'**********************************************************************************************************
' Hartman Value Profile
'**********************************************************************************************************
PUBLIC CONST OUTSTANDING = 5
PUBLIC CONST EXCELLENT = 4
PUBLIC CONST VERYGOOD = 3
PUBLIC CONST GOOD = 2
PUBLIC CONST FAIR = 1
PUBLIC CONST UNCLEAR = 0
PUBLIC CONST NOT_RELEVENT = -1

PUBLIC CONST VeryNegativeBias = 1
PUBLIC CONST NegativeBias = 2
PUBLIC CONST BalancedBias = 3
PUBLIC CONST PositiveBias = 4
PUBLIC CONST VeryPositiveBias = 5

PUBLIC CONST EXTRINSIC = 0
PUBLIC CONST SYSTEMIC = 1
PUBLIC CONST INTRINSIC = 2

'**********************************************************************************************************
Function ReportAnalysis( byRef p )
	On Error Resume Next
    Error = 0

	tmpVQ = Split(p.VQResponse, "|")
	tmpSQ = Split(p.SQResponse, "|")

    If UBound( tmpVQ ) <> 17 Then Error = 1
    If UBound( tmpSQ ) <> 17 Then Error = 2

    If Error = 0 Then  
        'We need to flip the array values
	    VQresponse = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	    SQresponse = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

        For i = 0 To 17
            VQresponse(tmpVQ(i)-1) = i+1
        Next

        For i = 0 To 17
            SQresponse(tmpSQ(i)-1) = i+1
        Next

        VQDimPos = Array(0,0,0)
        VQDimNeg = Array(0,0,0)
        VQSubDim = Array(0,0,0)
        VQIntCate = Array(0,0,0)
        VQDimention = 0
        VQDiff = 0
        VQInt = 0
        VQLeft = 0
        VQRight = 0
        VQAIPerc = 0
        VQDis = 0
        VQPositive = 0
        VQNegative = 0
        VQDimentionPerc = 0
        VQIntPerc = 0
        VQDI = 0
        RQLeft = 0

        SQDimPos = Array(0,0,0)
        SQDimNeg = Array(0,0,0)
        SQSubDim = Array(0,0,0)
        SQIntCate = Array(0,0,0)
        SQDimention = 0
        SQDiff = 0
        SQInt = 0
        SQLeft = 0
        SQRight = 0
        SQAIPerc = 0
        SQDis = 0
        SQPositive = 0
        SQNegative = 0
        SQDimentionPerc = 0
        SQIntPerc = 0
        SQDI = 0
        RQRight = 0

        BQrLeft = 0
        BQrRight = 0
        BQaLeft = 0
        BQaRight = 0
        CQLeft = 0
        CQRight = 0

        Clarity = 0
        Bias = 0	
        	
        CalcPreliminary VQresponse, VQDimPos, VQDimNeg, VQSubDim, VQIntCate, VQDimention, VQDiff, VQInt, VQLeft, VQRight, VQAIPerc, VQDis, VQPositive, VQNegative, VQDimentionPerc, VQIntPerc, VQDI, RQLeft

        CalcPreliminary SQresponse, SQDimPos, SQDimNeg, SQSubDim, SQIntCate, SQDimention, SQDiff, SQInt, SQLeft, SQRight, SQAIPerc, SQDis, SQPositive, SQNegative, SQDimentionPerc, SQIntPerc, SQDI, RQRight
        						
        If VQLeft <> 0 Then BQrLeft = Round(SQLeft / VQLeft, 1) Else BQrLeft = 0
        If VQRight <> 0 Then BQrRight = Round(SQRight / VQRight, 1 ) Else BQrRight = 0

        BQaLeft = Round( (SQLeft + VQLeft) / 2 )
        BQaRight = Round( (SQRight + VQRight) / 2 )
        CQLeft = Round( BQrLeft * BQaLeft )  
        CQRight = round( BQrRight * BQaRight )

        With p
	        .VQDiff = VQDiff
	        .VQDimPerc = Round( VQDimentionPerc * 100 )
	        .VQDimPos_E = VQDimPos(EXTRINSIC)
	        .VQDimPos_S = VQDimPos(SYSTEMIC)
	        .VQDimPos_I = VQDimPos(INTRINSIC)
	        .VQDimNeg_E = VQDimNeg(EXTRINSIC)
	        .VQDimNeg_S = VQDimNeg(SYSTEMIC)
	        .VQDimNeg_I = VQDimNeg(INTRINSIC)
	        .VQIntCate_E = VQIntCate(EXTRINSIC)
	        .VQIntCate_S = VQIntCate(SYSTEMIC)
	        .VQIntCate_I = VQIntCate(INTRINSIC)
	        .VQInt = VQInt
	        .VQIntPerc = Round( VQIntPerc * 100 )
	        .VQDI = VQDI
	        .VQDIS = VQDis
	        .VQLeft = VQLeft
	        .VQRight = VQRight
	        .VQAI = Round( VQAIPerc * 100 )

	        .SQDiff = SQDiff
	        .SQDimPerc = Round( SQDimentionPerc * 100 )
	        .SQDimPos_E = SQDimPos(EXTRINSIC)
	        .SQDimPos_S = SQDimPos(SYSTEMIC)
	        .SQDimPos_I = SQDimPos(INTRINSIC)
	        .SQDimNeg_E = SQDimNeg(EXTRINSIC)
	        .SQDimNeg_S = SQDimNeg(SYSTEMIC)
	        .SQDimNeg_I = SQDimNeg(INTRINSIC)
	        .SQIntCate_E = SQIntCate(EXTRINSIC)
	        .SQIntCate_S = SQIntCate(SYSTEMIC)
	        .SQIntCate_I = SQIntCate(INTRINSIC)
	        .SQInt = SQInt
	        .SQIntPerc = Round( SQIntPerc * 100 )
	        .SQDI = SQDI
	        .SQDIS = SQDis
	        .SQLeft = SQLeft
	        .SQRight = SQRight
	        .SQAI = Round( SQAIPerc * 100 )

	        .BQrLeft = BQrLeft
	        .BQrRight = BQrRight
	        .BQaLeft = BQaLeft
	        .BQaRight = BQaRight
	        .CQLeft = CQLeft
	        .CQRight = CQRight
	        .RQLeft = RQLeft
	        .RQRight = RQRight
        End With
        
        '***************************
	    ' 02_Secondary Calculations
        '***************************
	    ' Empathy (VQ Intrinsic)
        '*************************************************
        Clarity = VQDimPos(INTRINSIC) + VQDimNeg(INTRINSIC)
        If Clarity <> 0 Then  			
            Bias = 20 * VQDimPos(INTRINSIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xVQClarity_I = Clarity
	    p.xVQBias_I = Bias
	    p.VQClarity_I = GetClarityCalibration( Clarity )
	    p.VQBias_I = GetBiasCalibration( Bias )

        ' Practical Options (VQ Extrinsic)
        '*************************************************
        Clarity = VQDimPos(EXTRINSIC) + VQDimNeg(EXTRINSIC)
        If Clarity <> 0 Then  			
            Bias = 20 * VQDimPos(EXTRINSIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xVQClarity_E = Clarity
	    p.xVQBias_E = Bias
        p.VQClarity_E = GetClarityCalibration( Clarity )
        p.VQBias_E = GetBiasCalibration( Bias )
    			
	    ' Planning (VQ Systemic)
        '*************************************************
        Clarity = VQDimPos(SYSTEMIC) + VQDimNeg(SYSTEMIC)
        If Clarity <> 0 Then  			
            Bias = 20 * VQDimPos(SYSTEMIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xVQClarity_S = Clarity
	    p.xVQBias_S = Bias
        p.VQClarity_S = GetClarityCalibration( Clarity )
        p.VQBias_S = GetBiasCalibration( Bias )

	    ' Self_Esteem (SQ Intrinsic)
        '*************************************************
        Clarity = SQDimPos(INTRINSIC) + SQDimNeg(INTRINSIC)
        If Clarity <> 0 Then  			
            Bias = 20 * SQDimPos(INTRINSIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xSQClarity_I = Clarity
	    p.xSQBias_I = Bias
        p.SQClarity_I = GetClarityCalibration( Clarity )
        p.SQBias_I = GetBiasCalibration( Bias )
    			
	    ' Role Awareness (SQ Extrinsic)
        '*************************************************
        Clarity = SQDimPos(EXTRINSIC) + SQDimNeg(EXTRINSIC)
        If Clarity <> 0 Then  			
            Bias = 20 * SQDimPos(EXTRINSIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xSQClarity_E = Clarity
	    p.xSQBias_E = Bias
        p.SQClarity_E = GetClarityCalibration( Clarity )
        p.SQBias_E = GetBiasCalibration( Bias )
    			
	    ' Self Direction (SQ Systemic)
        '*************************************************
        Clarity = SQDimPos(SYSTEMIC) + SQDimNeg(SYSTEMIC)
        If Clarity <> 0 Then  			
            Bias = 20 * SQDimPos(SYSTEMIC) / Clarity - 10 	
        Else 
            Bias = 1
            Clarity = 1
        End If
	    p.xSQClarity_S = Clarity
	    p.xSQBias_S = Bias
        p.SQClarity_S = GetClarityCalibration( Clarity )
        p.SQBias_S = GetBiasCalibration( Bias )
    		
    End If
    
    ReportAnalysis = Error
    
End Function

'**********************************************************************************************************
' DimPos[]: DIM Positive, eg: DimPos['E'], DIM 'E' Positive. 
' DimNeg[]: DIM Negative, eg: DimNeg['E'], DIM 'E' Negative
' IntCate[]: total of Integration column for category.
' IntInt: INT (Integration)
' IntDimention: INT Dimension
' SubDim[]: Absolute value of SUM of DIM Positive and DIM Negative
' Dimention: DIM (Dimension) = Sum of the difference b/w the highest DIM score and two lower DIM scores
' Diff: DIF (Differentiation) = Sum of DIM scores
' IntPerc: INT % = INT total / DIF
' DimPerc[]: DIM % = DIM score / Differentiation
' Dis: DIS (Distortion)
' AIPerc: AI % (Attitude Index) = SUM of absolute value of DIM Negative / DIF
' PositiveBias: Positive Bias
' NnegativeBias: Negative Bias
' Left: = SUM of DIF + DIM + INT
' Right: = SUM of DIM + INT
'**********************************************************************************************************
Function CalcPreliminary(byVal bvUserResponse(), byRef brDimPos(), byRef brDimNeg(), byRef brSubDim(), byRef brIntCate(), byRef brDimention, _
                         byRef brDiff, byRef brIntInt, byRef brLeft, byRef brRight, byRef brAIPerc, byRef brDis, byRef brPositiveBias, _
                         byRef brNegativeBias, byRef brDimentionPerc, byRef brIntPerc, byRef brIntDimention, byRef brRQ)
	On Error Resume Next
	
'	                      0   3   4   9  9  5   16  0 16  0  0  4  4   0   0  4  1  5
'                         11  10  13   1 17  6   2  15 18  3  4  5  9  14  16 12  8  7
'  	 tmpStaticRank = Array(11, 13, 17, 10, 6, 1, 18, 15, 2, 3, 4, 9, 5, 14, 16, 8, 7, 12)

'     bvUserResponse = Array(4, 7, 10, 11, 12, 6, 18, 17, 13, 2, 1, 16, 3, 14, 8, 15, 5, 9)
'This old array is the placement of the item in the defalt list.  e.g. the first item should be #6, the 11th item should be #1
	tmpStaticRank = Array(6, 9, 10, 11, 13, 5, 17, 16, 12, 4, 1, 18, 2, 14, 8, 15, 3, 7)
'	                      1  2   3   4   5  6   7   8   9 10 11  12 13  14 15  16 17 18
	tmpQuesCategory = Array(EXTRINSIC,SYSTEMIC,SYSTEMIC,EXTRINSIC,EXTRINSIC,INTRINSIC,EXTRINSIC,SYSTEMIC,SYSTEMIC, _
	                        INTRINSIC,INTRINSIC,INTRINSIC,EXTRINSIC,INTRINSIC,EXTRINSIC,INTRINSIC,SYSTEMIC,SYSTEMIC)

	tmpBias = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	tmpIntegration = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	tmpDimPerc = Array(0,0,0)

	tmpRQ = 0
	brDis = 0
	brPositiveBias = 0
	brNegativeBias = 0
	
	brDimention = 0
	f = 0
	brIntInt = 0
	tmpAbsDimNeg = 0
		
	For i = 0 To 17

        'Get the Bias for this item (compare user response to standard)
		If tmpStaticRank(i) <= 9 Then 
			tmpBias(i) = tmpStaticRank(i) - bvUserResponse(i)				
		Else 
			tmpBias(i) = bvUserResponse(i) - tmpStaticRank(i)				
		End If
		
        'Accumulate each bias raised to the 2nd power to calculate intensity of biases
		tmpRQ = tmpRQ + tmpBias(i) ^ 2
		
        'Get the total pos. and neg. biases for each category (I,E,S)
		For c = 0 To 2
			If tmpQuesCategory(i) = c Then
    			If tmpBias(i) > 0 Then brDimPos(c) = brDimPos(c) + tmpBias(i) 
	    		If tmpBias(i) < 0 Then brDimNeg(c) = brDimNeg(c) + Abs(tmpBias(i)) 
			End If
		Next
		
        'Get the total real biases (>2 from standard) for each category (I,E,S)
		tmpIntegration(i) = Abs(tmpBias(i)) - 2			
		If tmpIntegration(i) < 0 Then tmpIntegration(i) = 0 
		If tmpIntegration(i) > 0 Then
			For c = 0 To 2
				If tmpQuesCategory(i) = c Then
				    brIntCate(c) = brIntCate(c) + tmpIntegration(i) 
				End If
			Next
		End If
        'Get the total user responses that are in a different top or bottom half from the standard
		If (bvUserResponse(i) > 9 And tmpStaticRank(i) < 10) Or (bvUserResponse(i) < 10 And tmpStaticRank(i) > 9) Then brDis = brDis + 1
        'Get the total user responses that are in the same top or bottom half as the standard
		If (bvUserResponse(i) > 9 And tmpStaticRank(i) > 9) Or (bvUserResponse(i) < 10 And tmpStaticRank(i) < 10) Then brPositiveBias = brPositiveBias + 1
        'Get the total user responses that are lower than the standard OR both are in bottom half
		If (tmpStaticRank(i) < 10 And tmpStaticRank(i) < bvUserResponse(i)) Or (tmpStaticRank(i) > 9 And bvUserResponse(i) > 9) Then brNegativeBias = brNegativeBias + 1

	Next

    'Get percentage of bias intensity (100% - completely unbais)
	brRQ = Round( (1000 - tmpRQ) / 1000, 2)
	tmpMaxSubDim = 0		
	tmpMaxInt = 0
	tmpMaxIntCate = 0
	tmpMaxSubDimCate = 0

	For c = 0 To 2
        'Get total real biases
		brIntInt = brIntInt + brIntCate(c)
        'Get total all biases
		brSubDim(c) = brDimPos(c) + Abs(brDimNeg(c))
        'Get category with highest real biases 
		If brIntCate(c) > tmpMaxInt Then 
			tmpMaxInt = brIntCate(c)
			tmpMaxIntCate = c
		End If
        'Get category with highest all biases 
		If brSubDim(c) > tmpMaxSubDim Then
			tmpMaxSubDim = brSubDim(c)
			tmpMaxSubDimCate = c
		End If
        'Get total all biases
		brDiff = brDiff + brSubDim(c)
	Next

	brIntDimention = 0
	For c = 0 To 2
        'Get the sum(highest real biases - category real biases) of the 2 lower categories 
		If tmpMaxIntCate <> c Then brIntDimention = brIntDimention + (tmpMaxInt - brIntCate(c)) 
        'Get the sum(highest all biases - category all biases) of the 2 lower categories 
		If tmpMaxSubDimCate <> c Then brDimention = brDimention + (tmpMaxSubDim - brSubDim(c)) 
        'Get percent of each category all biases of total all biases
		If brDiff <> 0 Then tmpDimPerc(c) = brSubDim(c) / brDiff Else tmpDimPerc(c) = 0
        'Get Total negative biases
		tmpAbsDimNeg = tmpAbsDimNeg + brDimNeg(c)
	Next

	If brDiff <> 0 Then
	    'Get percent (bias variance) of total biases
	    brDimentionPerc = brDimention / brDiff 
	    'Get percent (all biases) of total biases
	    brIntPerc = brIntInt / brDiff
	    'Get percent (negative biases) of total biases
	    brAIPerc = tmpAbsDimNeg / brDiff
    Else 
        brDimentionPerc = 0
        brIntPerc = 0
        brAIPerc = 0
    End If        
	    
	brLeft = brDimention + brIntInt + brDis + brDiff
	brRight= brDimention + brIntInt + brDis	

End Function

'**********************************************************************************************************
Function GetClarityCalibration(byVal bvScore )
	On Error Resume Next
	If bvScore >= 1 And bvScore <= 5 Then
		GetClarityCalibration = OUTSTANDING
	ElseIf bvScore >= 6 And bvScore <= 10 Then
		GetClarityCalibration = EXCELLENT
	ElseIf bvScore >= 11 And bvScore <= 15 Then
		GetClarityCalibration = VERYGOOD
	ElseIf bvScore >= 16 And bvScore <= 20 Then
		GetClarityCalibration = GOOD
	ElseIf bvScore >= 21 And bvScore <= 25 Then
		GetClarityCalibration = FAIR
	ElseIf bvScore >= 26 And bvScore <= 30 Then
		GetClarityCalibration = UNCLEAR
	Else
		GetClarityCalibration = UNCLEAR
    End If
End Function

'**********************************************************************************************************
Function GetBiasCalibration(byVal bvScore )
	On Error Resume Next
	If bvScore <= -8.1 Then
		GetBiasCalibration = VeryNegativeBias
	ElseIf bvScore <= -4.1 Then
		GetBiasCalibration = NegativeBias
	ElseIf	bvScore <= 4 Then 
		GetBiasCalibration = BalancedBias
	ElseIf bvScore <= 8 Then
		GetBiasCalibration = PositiveBias
	Else
		GetBiasCalibration = VeryPositiveBias
    End If
End Function

'**********************************************************************************************************
Function CreateProfilePDF(byVal bvProfileID, byVal bvDetail )
	On Error Resume Next

	Set oDoc = server.CreateObject("ABCpdf9.Doc")
	If oDoc Is Nothing Then
	    CreateProfilePDF = 1
	Else
		With oDoc
            .Rect.Inset 25, 25

            URL = "http://www.peopleedge.com/13710.asp?ProfileID=" + CStr(bvProfileID) + "&print=1"
            IF bvDetail <> 0 Then URL = URL + "&detail=1"

            ID = .AddImageUrl( URL )

            Do While True
              .FrameRect()
              If Not .Chainable(ID) Then Exit Do

              .Page = .AddPage()
              ID = .AddImageToChain(ID)
            Loop

            For i = 1 To .PageCount
              .PageNumber = i
              .Flatten()
            Next

            FileName = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Profile/" + CStr(bvProfileID)
            If bvDetail = 0 Then FileName = FileName + "S.pdf" Else FileName = FileName + "D.pdf"

            .Save FileName
            .Clear()
		End With
	    CreateProfilePDF = 0
	End If

	Set oDoc = Nothing

End Function

%>

