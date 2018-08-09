<%
'***********************************************************************
' Custom Fields Class
'***********************************************************************

Class CustomFields
    Public CustomFields()

    '======================================================================
    Function Load( ByVal bvFieldDef, ByVal bvFieldVal, ByVal bvIsValues )

        Dim aFlds, total, pos, pos2, x, FieldDef, FieldName, Item, ChoiceID, ChoiceName, ChoicePrice, str 

        aFlds = Split( bvFieldDef, vbCrLf )
        total = UBOUND( aFlds )   
        Redim CustomFields( total )
        For x = 0 to total
            If InStr( aFlds(x), ":") = 0 Then
                Redim Preserve CustomFields ( UBOUND(CustomFields)-1 )
            Else
                SET CustomFields(x) = New CustomField
                With CustomFields(x)
                    FieldDef = aFlds(x)
                    FieldName = NextStreamElement( FieldDef, ":" )
                    'Check for all Fieldname options
                    While FieldName <> ""
                        str = Left(FieldName, 1)
                        Select Case str
                        Case "*"  'required field
                            .Required = True
                            FieldName = MID(FieldName, 2)
                        Case "-"  'private field
                            .Secure = 1
                            FieldName = MID(FieldName, 2)
                        Case "_"  'readonly field 
                            .Secure = 2
                            FieldName = MID(FieldName, 2)
                        Case "?"  'search field
                            .Search = True
                            FieldName = MID(FieldName, 2)
                        Case "+"  'combine field
                            .Combine = True
                            FieldName = MID(FieldName, 2)
                        Case "{"  'field ID
                            pos = InStr(FieldName, "}")
                            If pos > 0 Then .ID = MID(FieldName, 2, pos-2)
                            FieldName = Mid(FieldName, pos+1)
                        Case Else
                            pos = InStr(FieldName, "[")
                            If pos > 0 Then
                                pos2 = InStr(FieldName, "]")
                                If pos2 > 0 Then .Prompt = mID(FieldName, pos + 1, pos2 - pos - 1)
                                FieldName = Left(FieldName, pos - 1)
                            End If
                            .Name = FieldName
                            FieldName =  ""
                        End Select
                    Wend

                    '*** check if this option has a list of choices
                    If InStr(FieldDef, ";") Then
                        .DataType = 1
                        '*** process each choice
                        ChoiceID = 0
                        While FieldDef <> ""
                            Item = NextStreamElement(FieldDef, ";")
                            ChoiceID = ChoiceID + 1
                            ChoiceName = ""
                            ChoicePrice = 0
                            '*** check for a price
                            pos = InStr(Item, "(")
                            If pos > 0 Then
                                str = mID(Item, pos + 1)
                                If Len(str) > 2 Then
                                    str = mID(str, 1, Len(str) - 1)
                                    If IsNumeric(str) Then
                                        ChoicePrice = str
                                    End If
                                End If
                                '*** remove price from choice name
                                Item = Left(Item, pos - 1)
                            End If
                            '*** check if this choice is the default
                            If Left(Item, 1) = "*" Then
                                Item = mID(Item, 2)
                                .Value = CSTR(ChoiceID)
                            End If
                            pos = InStr(Item, "=")
                            If pos = 0 Then       
                                ChoiceName = Item
                                .AddChoice ChoiceID, ChoiceName, ChoicePrice 
                            Else
                                Select Case Left(Item, pos - 1)
                                Case "align": .Align = mID(Item, pos + 1)
                                End Select
                            End If
                        Wend
                    Else
                        '*** this option has no choices
                        '*** process all attributes for this choice
                        While FieldDef <> ""
                            Item = NextStreamElement(FieldDef, " ")
                            '*** check for an assigned attributed
                            pos = InStr(Item, "=")
                            If pos > 0 Then
                                Select Case Left(Item, pos - 1)
                                Case "type"
                                    str = mID(Item, pos + 1)
                                    Select Case str
                                    Case "text":   .DataType = 2
                                    Case "memo":   .DataType = 3
                                    Case "number": .DataType = 4
                                    Case "date":   .DataType = 5
                                    Case "yesno":  .DataType = 6
                                    End Select
                                Case "min":  .Min = mID(Item, pos + 1)
                                Case "max":  .Max = mID(Item, pos + 1)
                                Case "size": .Size = mID(Item, pos + 1)
                                Case "align": .Align = mID(Item, pos + 1)
                                Case "value"
                                    .Value = mID(Item, pos + 1)
                                    If .DataType = 5 And UCase(.Value) = "NOW" Then .Value = CStr(Date)
                                End Select
                            Else
                                '*** check for a price
                                If Left(Item, 1) = "(" Then
                                    If Len(Item) > 2 Then
                                        str = mID(Item, 2, Len(Item) - 2)
                                        If IsNumeric(str) Then .Price = str
                                    End If
                                Else
                                    If bvIsValues Then
                                        pos = InStr(Item, "(")
                                        If pos > 0 Then
                                            pos2 = InStr(Item, ")")
                                            If pos2 > 0 Then .Price = mID(Item, pos + 1, pos2 - pos - 1)
                                            Item = Left(Item, pos - 1)
                                        End If
                                        .Value = Item
                                    End If
                                End If
                            End If
                        Wend
                    End If
                    If .ID <> "" Then ValName = .ID Else ValName = .Name
                    If bvIsValues = True Then .Value = GetValue( bvFieldVal, ValName, .Value )

                End With
            End If
        Next
    End Function
    
    '======================================================================
    Private Function NextStreamElement( ByRef brDataStream, ByVal bvDelim )
        Dim Position
       '-----get the position of the next delimiter
       Position = InStr(brDataStream, bvDelim)
       If Position = Len(bvDelim) Then
          '-----no next element
          NextStreamElement = ""
          '-----strip off the delimiter and return the rest of the stream
          If Len(brDataStream) > Len(bvDelim) Then
             brDataStream = mID(brDataStream, Len(bvDelim) + 1)
          Else
             brDataStream = ""
          End If
          '-----else, there is a next element
       ElseIf Position >= Len(bvDelim) + 1 Then
          NextStreamElement = Trim(mID(brDataStream, 1, Position - 1))
          brDataStream = mID(brDataStream, Position + Len(bvDelim))
       Else
          '-----no more delimiters, so the whole stream is the element
          NextStreamElement = Trim(brDataStream)
          brDataStream = ""
       End If
    End Function

    '======================================================================
    Private Function GetValue( ByVal bvValues, ByVal bvName, bvValue )
        Dim val, pos, pos2
   
        pos = InStr(bvValues, bvName)
        If pos > 0 Then
            pos = InStr(pos + Len(bvName), bvValues, ":")
            If pos > 0 Then
                val = Mid(bvValues, pos + 1)
                pos2 = InStr(val, "(")
                If pos2 > 0 Then val = Left(val, pos2 - 1)
                pos = InStr(val, vbCrLf)
                If pos > 0 Then val = Left(val, pos - 1)
            End If
        End If
        If val = "" Then
            GetValue = bvValue
        Else
            GetValue = val
        End If
    End Function

    '=============================================================
    Private Sub Class_Terminate()
'        Dim x, total
'        total = UBOUND(CustomFields)
'        For x = 0 to total
'            Set CustomFields(x) = Nothing
'        Next
    End Sub

    '=============================================================
    Function XML()
        Dim x, total, combine, subfld : subfld = False
        XML = "<FIELDS>"
        total = UBOUND(CustomFields)
        For x = 0 to total
            If x < total Then combine = CustomFields(x+1).Combine 
            If combine Then
                If subfld = False Then
                    subfld = True
                    If CustomFields(x).Align = "" Then tmpAlign = "center" Else tmpAlign = CustomFields(x).Align
                    XML = XML +  "<FIELD align=""" + tmpAlign + """>"
                End If
            End If

            XML = XML + CustomFields(x).XML

            If Not combine Or x = total Then
                If subfld = True Then
                    subfld = False
                    XML = XML +  "</FIELD>"
                End If
            End If
        Next
        XML = XML + "</FIELDS>"
    End Function

    '=============================================================
    Function Validate()
        Dim x, total, valid
        total = UBOUND(CustomFields)
        For x = 0 to total
            valid = CustomFields(x).Validate
            If Not valid Then x = total
        Next
    End Function

    '=============================================================
    Function GetValues()
        Dim x, total, id
        total = UBOUND(CustomFields)
        For x = 0 to total
            id = CustomFields(x).ID
            CustomFields(x).Value = Request.Form.Item(id)
        Next
    End Function

    '=============================================================
    Function Values(byVal bvDelim)
        Dim x, total, s
        s = ""
        total = UBOUND(CustomFields)
        For x = 0 to total
            s = s + "Field #" + CSTR(CustomFields(x).ID) + " (" + CustomFields(x).Name + ") = " + CustomFields(x).Value + bvDelim
        Next
        Values = s
    End Function

End Class

'*************************************************************************
Class CustomField
    Public ID
    Public Name
    Public Prompt
    Public DataType
    Public Min
    Public Max
    Public Required
    Public Secure
    Public Price
    Public Size
    Public Align
    Public Value
    Public Combine
    Public Search
    Public Choices()

    '=============================================================
    Private Sub Class_Initialize()
        ID = ""
        Name = ""
        Prompt = ""
        DataType = 2
        Min = ""
        Max = ""
        Required = False
        Secure = 0
        Price = 0
        Size = 0
        Align = ""
        Value = ""
        Combine = False
        Search = False
    End Sub

    '=============================================================
    Function AddChoice(byVal bvID, byVal bvName, byVal bvPrice)
        Dim x : x = 0
        If IsInitialized(Choices) Then x = UBOUND(Choices) + 1
        Redim Preserve Choices( x )
        Set Choices(x) = New FieldChoice
        With Choices(x)
            .ID = bvID
            .Name = bvName
            .Price = bvPrice
        End With
    End Function

    Function IsInitialized(a)    
        Err.Clear
        On Error Resume Next
        UBound(a)
        If (Err.Number = 0) Then 
            IsInitialized = True
        Else
            IsInitialized = False
            Err.Clear
        End If
    End Function

    '=============================================================
    Private Sub Class_Terminate()
'        Dim x
'        For x = 0 to UBOUND(Choices)
'            Set Choices(x) = Nothing
'        Next
    End Sub

    '=============================================================
    Function XML()
        Dim x, tmpValue

        If DataType = 2 Then tmpValue = CleanXML(Value) Else tmpValue = CStr(Value)
        
        XML = "<FIELD"
        If ID <> ""      Then XML = XML + " id=""" + CSTR(ID) + """"
        If Name <> ""    Then XML = XML + " name=""" + Name + """"
        If Prompt <> ""  Then XML = XML + " prompt=""" + Prompt + """"
        If DataType <> 0 Then XML = XML + " datatype=""" + CSTR(DataType) + """"
        If Min <> ""     Then XML = XML + " min=""" + CSTR(Min) + """"
        If Max <> ""     Then XML = XML + " max=""" + CSTR(Max) + """"
        If Required      Then XML = XML + " required=""" + CSTR(Required) + """"
        If Secure <> 0   Then XML = XML + " secure=""" + CSTR(Secure) + """"
        If Price <> 0    Then XML = XML + " price=""" + FormatCurrency(Price, "$##,##0.00", 2) + """"
        If Size <> 0     Then XML = XML + " size=""" + CSTR(Size) + """"
        If Value <> ""   Then XML = XML + " value=""" + tmpValue + """"
        If Align <> ""   Then XML = XML + " align=""" + Align + """"
        XML = XML + ">"

        If DataType = 1 Then
            XML = XML + "<CHOICES>"
            For x = 0 to UBOUND(Choices)
                XML = XML + Choices(x).XML
            Next
            XML = XML + "</CHOICES>"
        End If

        XML = XML + "</FIELD>"
    End Function

    '=============================================================
    Function Validate()
        Dim oUtil
        Validate = True
        Set oUtil = server.CreateObject("wtSystem.CUtility")
        If oUtil Is Nothing Then
            Response.write "Error Creating Object - wtSystem.CUtility"
        Else
            Err.Clear
            With oUtil
                Select Case DataType
                Case 1:
                    .EditString Value, Name, Required
                Case 2, 3:
                    .EditString Value, Name, Required, , .MinString(Min), .MaxString(Max)
                Case 4:
                    .EditDouble Value, Name, Required, , .MinDouble(Min), .MaxDouble(Max)
                Case 5:
                    .EditDate Value, Name, Required, , .MinDate(Min), .MaxDate(Max)
                Case 6:
                    .EditInteger Value, Name, Required, , 0, 1
                 End Select
            End With
    	    Validate = (Err.Number = 0)
        End If
        Set oUtil = Nothing
    End Function
 
End Class

'*************************************************************************
Class FieldChoice
    Public ID
    Public Name
    Public Price
    Private Sub Class_Initialize()
        ID = ""
        Name = ""
        Price = 0
    End Sub
    '=============================================================
    Function XML()
        XML = "<CHOICE"
        If ID <> ""   Then XML = XML + " id=""" + CSTR(ID) + """"
        If Name <> "" Then XML = XML + " name=""" + CSTR(Name) + """"
        If Price <> 0 Then XML = XML + " price=""" + FormatCurrency(Price, "$##,##0.00", 2) + """"
        XML = XML + "/>"
    End Function
End Class

%>
