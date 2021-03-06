Sub Macro8()
'Contract Logistic JAS
'主要檔案
'跑各分頁
'跳出input，手動輸入acct number


Dim ws As Worksheet
Dim Report As String
Dim lastRow, lastCol, row, col, lenString As Long
Report = ActiveSheet.Name
Set dataSht = Worksheets(Report)
Dim i As Integer
Dim YYY As String
Dim MMM As String
'Dim Invnum As String
'Dim Acctnum As Variant
'Dim Acctnum As String



For Each ws In ActiveWorkbook.Worksheets
ws.Range("T7").Value = Trim(ws.Range("T7"))
' Get Last Row
lastRow = ws.Cells(Rows.Count, 1).End(xlUp).row

' Get Month of this invoice
MMM = Format(ws.Range("AM11").Value, "mmm")

' Get Year of this invoice
YYY = Format(ws.Range("AM11").Value, "yyyy")

Invnum = ws.Range("AM8").Value

'---- Upper Area Start ----



' Merge Cells Vendor Information


   
If Len(ws.Range("T9").Value) = 0 Then
    'ws.Range("T9").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$A:$A,MATCH(""T7"",'[LG Vendor Info.xlsx]JAS'!$C:$C))"
    'ws.Range("T9").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$A:$A,MATCH(" & Acctnum & ",'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
    ws.Range("T9").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$A:$A,MATCH(T7,'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
End If
      
If Len(ws.Range("T12").Value) = 0 Then
    ws.Range("T12").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$E:$E,MATCH(T7,'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
    'ws.Range("T12").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$E:$E,MATCH(" & Acctnum & ",'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
End If

If Len(ws.Range("T15").Value) = 0 Then
    ws.Range("T15").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$F:$F,MATCH(T7,'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
    'ws.Range("T15").Formula = "=INDEX('[LG Vendor Info.xlsx]JAS'!$F:$F,MATCH(" & Acctnum & ",'[LG Vendor Info.xlsx]JAS'!$C:$C,))"
    
End If

'---- Upper Area End ----

'---- Below Area Start ----

i = 24

    Do While i <= lastRow

'Get Product/Function Code
        If Len(ws.Range("O" & i).Value) = 0 Then
            Debug.Print ws.Range("O" & i).Address
            ws.Range("O" & i).Formula = "=INDEX(Mapping.xlsx!$D:$D,MATCH((A" & i & "),Mapping.xlsx!$A:$A,0))"
        End If

'Get Reference Number/Client Code
        If Len(ws.Range("X" & i).Value) = 0 Then
            Debug.Print ws.Range("X" & i).Address
            ws.Range("X" & i).Formula = "=INDEX(Mapping.xlsx!$C:$C,MATCH((A" & i & "),Mapping.xlsx!$A:$A,0))"
        End If

'Get Shipment Number
        If Len(ws.Range("AE" & i).Value) = 0 Then
            Debug.Print ws.Range("AE" & i).Address
            ws.Range("AE" & i).Formula = "=INDEX('[Shipment Register.xlsx]" & MMM & YYY & "'!$V:$V,MATCH(A" & i & ",'[Shipment Register.xlsx]" & MMM & YYY & "'!$U:$U,))"
        End If
        
'Replace Account/Oracle Code
        If ws.Range("R" & i).Value = "474011" Then
            ws.Range("R" & i).Replace What:="474011", Replacement:="758199"
        ElseIf ws.Range("S" & i).Value = "474011" Then
            ws.Range("S" & i).Replace What:="474011", Replacement:="758199"
        End If
            
        
        If ws.Range("R" & i).Value = "476020" Then
            ws.Range("R" & i).Replace What:="476020", Replacement:="476101"
        ElseIf ws.Range("S" & i).Value = "476020" Then
            ws.Range("S" & i).Replace What:="476020", Replacement:="476101"
        End If
        
        If ws.Range("R" & i).Value = "476021" Then
            ws.Range("R" & i).Replace What:="476021", Replacement:="476101"
        ElseIf ws.Range("S" & i).Value = "476021" Then
            ws.Range("S" & i).Replace What:="476021", Replacement:="476101"
        End If
        
        
        i = i + 2
        'Debug.Print i - 2
        Debug.Print "---"
    Loop
Next ws

End Sub


Sub Test1()

Dim ws As Worksheet
Dim Report As String
Dim lastRow, lastCol, row, col, lenString As Long
Report = ActiveSheet.Name
Set dataSht = Worksheets(Report)
Dim YYY As String
Dim DDD As String
Dim MMM As String

'Range("AM11") = Format(Date, "mmm")
DDD = Range("AM11").Value
'Debug.Print Format(Range("AM11"), "mmm")
Debug.Print Format(DDD, "mmm")


MMM = Format(Range("AM11").Value, "mmm")
Debug.Print MMM

YYY = Format(Range("AM11").Value, "yyyy")
Debug.Print YYY


End Sub


Sub Test2()
Dim ws As Worksheet
Dim Report As String
Dim lastRow, lastCol, row, col, lenString As Long
Report = ActiveSheet.Name
Set dataSht = Worksheets(Report)

'Replace(Range("R24").Value,474011,758199)


Range("A1").Value = "AAAAA"

    

End Sub


Sub Test3()
 '...
' 這個可以直接把檔案放在資料夾，選擇資料夾後會自動run macro on each file in the folder
' 可能會要求select mapping file & Shipment register file

Dim folderName As String, eApp As Excel.Application, fileName As String
Dim wb As Workbook, ws As Worksheet, currWs As Worksheet, currWb As Workbook
Dim fDialog As Object: Set fDialog = Application.FileDialog(msoFileDialogFolderPicker)
Set currWb = ActiveWorkbook: Set currWs = ActiveSheet

'Select folder in which all files are stored
fDialog.Title = "Select a folder"
fDialog.InitialFileName = currWb.Path
If fDialog.Show = -1 Then
  folderName = fDialog.SelectedItems(1)
End If

fileName = Dir(folderName & "\*.xlsx")
Do While fileName <> ""
    'Update status bar to indicate progress
    Application.StatusBar = "Processing " & folderName & "\" & fileName

    Set wb = Workbooks.Open(folderName & "\" & fileName)

    Call Macro8
    
    wb.Close True 'save changes

    fileName = Dir()
Loop
'...
End Sub
