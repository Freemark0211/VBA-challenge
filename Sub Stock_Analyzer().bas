Sub Stock_Analyzer()

    For Each WS In Worksheets 'loops through each worksheet in workbook
        WS.Activate
                
        
        Dim i, j, p As Integer
        Dim YC, PC, TSV, Vol, LC, FO, HSV, HPV, LPV, PV As Double
        Dim Check, STS, HSVTicker, HPVTicker, LPVTicker As String
        
        
        'Initializes Starting Values
         p = 1
         i = 1
         HSV = 0
         FO = Cells(2, "C").Value
         Range("I1") = "Ticker"
         Range("J1") = "Yearly Change"
         Range("K1") = "Percent Change"
         Range("L1") = "Total Stock Volume"
         Range("O2") = "Greatest Percent Increase"
         Range("O3") = "Greatest Percent Decrease"
         Range("O4") = "Greatest Total Volume"
         Range("P1") = "Ticker"
         Range("Q1") = "Value"
         
         row_count = Cells(Rows.Count, "A").End(xlUp).Row 'finds total number of rows
         
         
         'Consolidates information for all stocks by Ticker
         Do While i < row_count
        
        
            Check = "True"
            TSV = 0 'resets total stock volume to 0
            Vol = 0 'resets daily vol to 0
            p = p + 1
            
        
            'Gets info for each individual stock
            Do While Check <> "False"
                i = i + 1 'CELL POINTER
                Vol = Cells(i, "G").Value
                TSV = TSV + Vol          'Gives total stock volume
                
                'Consolidates info of stock before moving onto next stock
                If Cells(i, "A").Value <> Cells(i + 1, "A").Value Then
                    LC = Cells(i, "F").Value
                    STS = Cells(i, "A").Value
                    YC = LC - FO
                    PV = (LC - FO) / FO
                    Cells(p, "I").Value = STS
                    Cells(p, "J").Value = LC - FO
                    Cells(p, "J").NumberFormat = "#.00"
                    Cells(p, "K").Value = FormatPercent(PV)
                    Cells(p, "L").Value = TSV
                    
                    'Sets color values for percent change cells
                    If YC < 0 Then
                        Cells(p, "J").Interior.Color = RGB(250, 0, 0)
                    Else
                        Cells(p, "J").Interior.Color = RGB(0, 255, 0)
                    End If
                    
                    Check = "False" 'Stops loop
                    
                End If
            Loop
            
            'Finds Highest Stock Volume
            If HSV < TSV Then
                HSV = TSV
                HSVTicker = STS
            End If
            
            'Finds Highest Percentage Increase
            If HPV < PV Then
                HPV = PV
                HPVTicker = STS
            End If
            
            'Finds Greatest Percentage Decrease
            If LPV > PV Then
                LPV = PV
                LPVTicker = STS
            End If
                      
            
            FO = Cells(i + 1, "C") 'Sets First Open Value
                      
        Loop
        
        'Prints out highest and lowest percent change. Prints out highest stock volume
        Range("Q2") = FormatPercent(HPV)
        Range("P2") = HPVTicker
        Range("Q3") = FormatPercent(LPV)
        Range("P3") = LPVTicker
        Range("Q4") = HSV
        Range("P4") = HSVTicker
                
               
    Next WS

    

End Sub