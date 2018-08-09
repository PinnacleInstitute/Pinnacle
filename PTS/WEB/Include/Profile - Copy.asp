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

'PUBLIC CONST Main = 0
'PUBLIC CONST Disregard = 1
'PUBLIC CONST Inattentive = 2
'PUBLIC CONST Balanced = 3
'PUBLIC CONST Attentive = 4
'PUBLIC CONST OverlyAttentive = 5

'PUBLIC CONST CHART_BACKGROUND = "report_empathy_line_bg.png"
'PUBLIC CONST CHART_BACKGROUND_VERTICAL = "report_empathy_line_bg_vertical.png"
'PUBLIC CONST CHART_BACKGROUND_EXTERNAL = "report_external_bg.png"
'PUBLIC CONST CHART_BACKGROUND_INTERNAL = "report_internal_bg.png"

'PUBLIC CONST INDICATOR_OUTSTANDING = "report_indicator_outstanding.png"
'PUBLIC CONST INDICATOR_EXCELLENT = "report_indicator_excellent.png"
'PUBLIC CONST INDICATOR_VERYGOOD = "report_indicator_verygood.png"
'PUBLIC CONST INDICATOR_GOOD = "report_indicator_good.png"
'PUBLIC CONST INDICATOR_FAIR = "report_indicator_fair.png"
'PUBLIC CONST INDICATOR_UNCLEAR = "report_indicator_unclear.png"

'PUBLIC CONST EMPATHY = 0
'PUBLIC CONST PRACTICAL = 1
'PUBLIC CONST PLANNING = 2
'PUBLIC CONST SELFTESTEEM = 3
'PUBLIC CONST ROLEAWARENESS = 4
'PUBLIC CONST SELFDIRECTION = 5

'**********************************************************************************************************
Function ReportAnalysis( byRef p )
	On Error Resume Next

    VQresponse = Split(p.VQResponse, ",")
    SQresponse = Split(p.SQResponse, ",")
    
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

'	VQadjustBiasI = 0
'	VQadjustBiasE = 0
'	VQadjustBiasS = 0
'	SQadjustBiasI = 0
'	SQadjustBiasE = 0
'	SQadjustBiasS = 0

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
    With p
	    Clarity = .VQDimPos_I + .VQDimNeg_I
	    If Clarity <> 0 Then  			
            Bias = 20 * .VQDimPos_I / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .VQClarity_I = GetClarityCalibration( Clarity )
	    .VQBias_I = GetBiasCalibration( Bias )
	End With
    'VQLabelMini_I = "Mini-VQ_I-" & p.VQClarity_I & "-" & p.VQBias_I
    'VQLabelBias_I = "Bias-VQ_I-" & p.VQClarity_I & "-" & p.VQBias_I
    'VQLabelStrg_I = "Strg-VQ_I-" & p.VQClarity_I & "-" & p.VQBias_I
    'VQLabelWeak_I = "Weak-VQ_I-" & p.VQClarity_I & "-" & p.VQBias_I

	'$img = $this->buildChartImage(EMPATHY, $VQDimPos['I'], $VQDimNeg['I'], $capacity);
	'$path = pathinfo($img);
	'$rptData['empathy']['image'] 	= $path['basename'];
		
    ' Practical Options (VQ Extrinsic)
    With p
	    Clarity = .VQDimPos_E + .VQDimNeg_E
	    If Clarity <> 0 Then  			
            Bias = 20 * .VQDimPos_E / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .VQClarity_E = GetClarityCalibration( Clarity )
	    .VQBias_E = GetBiasCalibration( Bias )
	End With
    'VQLabelMini_E = "Mini-VQ_E-" & p.VQClarity_E & "-" & p.VQBias_E
    'VQLabelBias_E = "Bias-VQ_E-" & p.VQClarity_E & "-" & p.VQBias_E
    'VQLabelStrg_E = "Strg-VQ_E-" & p.VQClarity_E & "-" & p.VQBias_E
    'VQLabelWeak_E = "Weak-VQ_E-" & p.VQClarity_E & "-" & p.VQBias_E
			
	'$img = $this->buildChartImage(PRACTICAL, $VQDimPos['E'], $VQDimNeg['E'], $capacity);
	'$path = pathinfo($img);
	'$rptData['practical']['image'] 	= $path['basename'];
			
	' Planning (VQ Systemic)
    With p
	    Clarity = .VQDimPos_S + .VQDimNeg_S
	    If Clarity <> 0 Then  			
            Bias = 20 * .VQDimPos_S / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .VQClarity_S = GetClarityCalibration( Clarity )
	    .VQBias_S = GetBiasCalibration( Bias )
	End With
    'VQLabelMini_S = "Mini-VQ_S-" & p.VQClarity_S & "-" & p.VQBias_S
    'VQLabelBias_S = "Bias-VQ_S-" & p.VQClarity_S & "-" & p.VQBias_S
    'VQLabelStrg_S = "Strg-VQ_S-" & p.VQClarity_S & "-" & p.VQBias_S
    'VQLabelWeak_S = "Weak-VQ_S-" & p.VQClarity_S & "-" & p.VQBias_S

	'$img = $this->buildChartImage(PLANNING, $VQDimPos['S'], $VQDimNeg['S'], $capacity);
	'$path = pathinfo($img);
	'$rptData['planning']['image'] 	= $path['basename'];

	' Self_Esteem (SQ Intrinsic)
    With p
	    Clarity = .SQDimPos_I + .SQDimNeg_I
	    If Clarity <> 0 Then  			
            Bias = 20 * .SQDimPos_I / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .SQClarity_I = GetClarityCalibration( Clarity )
	    .SQBias_I = GetBiasCalibration( Bias )
	End With
    'SQLabelMini_I = "Mini_SQ_I-" & p.SQClarity_I & "-" & p.SQBias_I
    'SQLabelBias_I = "Bias_SQ_I-" & p.SQClarity_I & "-" & p.SQBias_I
    'SQLabelStrg_I = "Strg_SQ_I-" & p.SQClarity_I & "-" & p.SQBias_I
    'SQLabelWeak_I = "Weak_SQ_I-" & p.SQClarity_I & "-" & p.SQBias_I

	'$img = $this->buildChartImage(SELFTESTEEM, $SQDimPos['I'], $SQDimNeg['I'], $capacity);
	'$path = pathinfo($img);
	'$rptData['selfesteem']['image'] = $path['basename'];
			
	' Role Awareness (SQ Extrinsic)
    With p
	    Clarity = .SQDimPos_E + .SQDimNeg_E
	    If Clarity <> 0 Then  			
            Bias = 20 * .SQDimPos_E / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .SQClarity_E = GetClarityCalibration( Clarity )
	    .SQBias_E = GetBiasCalibration( Bias )
    End With
    'SQLabelMini_E = "Mini_SQ_E-" & p.SQClarity_E & "-" & p.SQBias_E
    'SQLabelBias_E = "Bias_SQ_E-" & p.SQClarity_E & "-" & p.SQBias_E
    'SQLabelStrg_E = "Strg_SQ_E-" & p.SQClarity_E & "-" & p.SQBias_E
    'SQLabelWeak_E = "Weak_SQ_E-" & p.SQClarity_E & "-" & p.SQBias_E
		
	'$img = $this->buildChartImage(ROLEAWARENESS, $SQDimPos['E'], $SQDimNeg['E'], $capacity);
	'$path = pathinfo($img);
	'$rptData['roleawareness']['image'] = $path['basename'];
			
	' Self Direction (SQ Systemic)
    With p
	    Clarity = .SQDimPos_S + .SQDimNeg_S
	    If Clarity <> 0 Then  			
            Bias = 20 * .SQDimPos_S / Clarity - 10 	
	    Else 
	        Bias = 1
		    Clarity = 1
        End If
	    .SQClarity_S = GetClarityCalibration( Clarity )
	    .SQBias_S = GetBiasCalibration( Bias )
    End With
    'SQLabelMini_S = "Mini_SQ_S-" & p.SQClarity_S & "-" & p.SQBias_S
    'SQLabelBias_S = "Bias_SQ_S-" & p.SQClarity_S & "-" & p.SQBias_S
    'SQLabelStrg_S = "Strg_SQ_S-" & p.SQClarity_S & "-" & p.SQBias_S
    'SQLabelWeak_S = "Weak_SQ_S-" & p.SQClarity_S & "-" & p.SQBias_S

	'$img = $this->buildChartImage(SELFDIRECTION, $SQDimPos['S'], $SQDimNeg['S'], $capacity);
	'$path = pathinfo($img);
	'$rptData['selfdirection']['image'] = $path['basename'];
			
	'$this->getCapacity($VQDiff, $VQInt, $SQDiff, $SQInt, $maintext);
'    p.VQCapacity = CapacityScoreSheet( VQDiff + VQInt )
'    p.SQCapacity = CapacityScoreSheet( SQDiff + SQInt )
	'$rptData['capacity']['biastext'] = $maintext;

	'$this->getClarity($VQadjustIbias, $VQadjustEbias, $VQadjustSbias, $SQadjustI, $SQadjustE, $SQadjustS, $maintext);
'    p.VQClarity = ClarityScoreSheet( VQadjustBiasI + VQadjustBiasE + VQadjustBiasS )
'    p.SQClarity = ClarityScoreSheet( SQadjustBiasI + SQadjustBiasE + SQadjustBiasS )
	'$rptText .= '<p>' . $maintext . '</p>';
	'$rptData['clarity']['biastext'] = $maintext;

	'$this->getBalance($VQDimention, $SQDimention, $maintext);
'    p.VQBalance = BalanceScoreSheet( VQDimention )
'    p.SQBalance = BalanceScoreSheet( SQDimention )
	'$rptData['balance']['biastext'] = $maintext;
			
	'$rptData['chart_external'] = $p_clientid . '_external.png';
	'$rptData['chart_internal'] = $p_clientid . '_internal.png';
		
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

	tmpStaticRank = Array(6, 9, 10, 11, 13, 5, 17, 16, 12, 4, 1, 18, 2, 14, 8, 15, 3, 7)
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
	brDiff = 0
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
'Function CapacityScoreSheet(byVal bvScore )
'	On Error Resume Next
'	If bvScore >= 7 And bvScore <= 18 Then
'        CapacityScoreSheet = OUTSTANDING
'	ElseIf bvScore >= 19 And bvScore <= 22 Then
'		CapacityScoreSheet = EXCELLENT
'	ElseIf bvScore >= 23 And bvScore <= 32 Then
'		CapacityScoreSheet = VERYGOOD
'	ElseIf bvScore >= 33 And bvScore <= 42 Then
'		CapacityScoreSheet = GOOD
'	ElseIf bvScore >= 43 And bvScore <= 52 Then
'		CapacityScoreSheet = FAIR
'	ElseIf bvScore >= 53 Then
'		CapacityScoreSheet = UNCLEAR
'    End If
'End Function

'**********************************************************************************************************
'Function ClarityScoreSheet(byVal bvScore )
'	On Error Resume Next
'	If bvScore >= 0 And bvScore <= 4 Then
'        ClarityScoreSheet = OUTSTANDING
'	ElseIf bvScore >= 5 And bvScore <= 6 Then
'		ClarityScoreSheet = EXCELLENT
'	ElseIf bvScore >= 7 And bvScore <= 9 Then
'		ClarityScoreSheet = VERYGOOD
'	ElseIf bvScore >= 10 And bvScore <= 12 Then
'		ClarityScoreSheet = GOOD
'	ElseIf bvScore >= 13 And bvScore <= 15 Then
'		ClarityScoreSheet = FAIR
'	ElseIf bvScore >= 16 Then
'		ClarityScoreSheet = UNCLEAR
'    End If
'End Function

'**********************************************************************************************************
'Function BalanceScoreSheet(byVal bvScore )
'	On Error Resume Next
'	If bvScore >= 0 And bvScore <= 2 Then
'        BalanceScoreSheet = OUTSTANDING
'	ElseIf bvScore >= 3 And bvScore <= 6 Then
'		BalanceScoreSheet = EXCELLENT
'	ElseIf bvScore >= 7 And bvScore <= 10 Then
'		BalanceScoreSheet = VERYGOOD
'	ElseIf bvScore >= 11 And bvScore <= 14 Then
'		BalanceScoreSheet = GOOD
'	ElseIf bvScore >= 15 And bvScore <= 18 Then
'		BalanceScoreSheet = FAIR
'	ElseIf bvScore >= 19 Then
'		BalanceScoreSheet = UNCLEAR
'    End If
'End Function

%>

