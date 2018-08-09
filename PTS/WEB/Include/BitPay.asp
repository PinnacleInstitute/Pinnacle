<%
' BitPay Bitcoin Payment Processing

'***********************************************************************
Function BP_GetCode(ByVal bvCompanyID, ByVal bvProduct)
    On Error Resume Next
    Product = ""
    If bvCompanyID = 17 Then  'GCR
        Select Case bvProduct
            Case 103,203: Product = "/21cH2NKKjRsBgU6BNsetBX8ueTqbWCTtena37UXdFJdQsz4VClACedX/yjydBEyUIYQBrRckL5//sLLdGRTu9lZdd1QgB8BM0GuoGR4qkCCfy4gH6CWfrHWhpGIYfq7CLm1uhdRXcT8S3oveWoJBcU6d/ADgINvpZeEWZGUX9jN1uVo6pSxx7HN9hcHirFrbqSV6zCCFRkj+YdzPnImSFSIxHNufrIixnLu69RQCTKvLdhZsXUEsPdXXKcgKM8Mq9cHZPEeuaLyt1CWjoLkqPJIawWMaBfWom/SS0LIJqrB8dYvXsrMLiEJFPZotjgJ"
            Case 104,204: Product = "/21cH2NKKjRsBgU6BNsetBX8ueTqbWCTtena37UXdFJdQsz4VClACedX/yjydBEym9X4zlL0mhnFhtejs7AUviBAeSYNDChZSG/CsEvW2DpGIDHPvql8T1iJCkR2cAXN1kh5WPyC3R5VxModwPgoqWu2Ym7IP0hNsrw/SluFqK7LVvSM9XDlPIk0pP3rwZ0XeDUeOn3/N4tw4x4bLA3cyKfA8trZE6ZBHY7vcq9cpupyKF4zS9MDXhmvSoqZTxhYEDXnMFqPoqLQlgmk5nfw+HuUBYzfUa15xH6wQ2HK0j0WI9/BRFx3EqNVH9oWm8kH"
            Case 105,205: Product = "/21cH2NKKjRsBgU6BNsetBX8ueTqbWCTtena37UXdFJdQsz4VClACedX/yjydBEyjH7PH9HPCUcB0AhgdDdLzwk94guI28Q+jieGrusKPwgiXyhVkxXoV0NCULH4O6ctuf9uzKFR3fueTCvSa5LJXxuQcUkdhANY5sx0eT+frmxxRLOU1+CHhZ0VOC/Mow3EJDL0V3ZjISaAaXTxdy/bFCobIr9leZNWCar2QNMy6puIAvdP9lDLK60V/p2r90lflS5+KLWQ90EqmyajFDQLbf0kpcrgFHdRsrnFL3Mw/EYfRUY5iF+rDdnLrcBjqu08"
            Case 107,207: Product = "/21cH2NKKjRsBgU6BNsetBX8ueTqbWCTtena37UXdFJdQsz4VClACedX/yjydBEyxbj2sW+9zsweFKdK1D3pMM/vZwQdiTeu0SMUX/4OrNqTmO7U1ykL3IksMWnzMHN062xaCcg2wOHJOCOrz4Wu35sf7kjPGMhJA7oov8el7a+CWdUIVMBhrD2IWuo3akIEtkizUpVsSpK8irCjpSNzBXoRzB5/Y7KARpvxkefpkc7v04H7Bw3s3AnyCs1wGOMBjYvSfvcTuuKY5ncK3ku/uq0ainDogSCJCsAMl2xVk1r7ZDWXnR698FgjFRymgy/A"
            Case 108,208: Product = "/21cH2NKKjRsBgU6BNsetBX8ueTqbWCTtena37UXdFJdQsz4VClACedX/yjydBEyfDGsAYKFqZ+24fEAlfrZOjDngMqdfIXmA3Nmd6EQDcYSy6UhB0iWX7ZPHPtx2WaG+inCxLBRlBSMG69oDWtiIVxDw6vNxbb7wSEimlX5yQ5+sNORQdqc3Xt4bsHKr3ZV4ot1Z5p6xw/0IUQjAugfTqhM9vubZrdrKrwKmGXiM+Sql9jVhCoZsGZJzerdswKQwW6r0S5/fq2Inz8gMngRxB6o/yxZ/tDIt4wg0Og3pEwTgQBnz4syuSqZEAIIKTDSRRFNQVZiM0jsnRMvptcXBw=="
        End Select
    End If
    BP_GetCode = Product
End Function

%>
