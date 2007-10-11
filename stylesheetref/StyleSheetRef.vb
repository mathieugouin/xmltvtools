Imports System.IO
Imports System.Xml
Imports System.Xml.Xsl
Imports System.Xml.XmlReader

Module StyleSheetRef
    '===========================================================
    ' StyleSheetRef:
    ' Author: Timothy Alosi (timalosi.com)
    ' Revision 0.1.B
    ' Revision Date: November 20, 2004
    ' 
    ' This software is provided under the MIT License.
    ' Please see http://opensource.org/licenses/mit-license.php
    ' for more information
    '===========================================================


    Sub Main()

        Dim strArg As String = Microsoft.VisualBasic.Command()
        Dim straArg() As String = Split(strArg, " ")

        Dim xmlDoc As New XmlDocument()


        ' This program takes up to three arguments
        ' 1. The XML Source File (required)
        ' 2. The HREF to the XSL File (required)
        ' 3. The Output File to be created (optional)
        '
        ' Program Flow
        ' 1. Open XMLFile
        ' 2. Add Processing Instruction
        ' 3. If Output File passed, saves as new file, otherwise save file

        If UBound(straArg) < 1 Then
            'Missing some of the required arguments
            Console.WriteLine("Usage: StyleSheetRef XMLFile HREF_to_XSLFile [OutputXMLFile]")
        Else
            ' Open the XML File
            Try
                xmlDoc.Load(straArg(0))
            Catch
                Console.WriteLine("Error: Unable to open XML File")
                Exit Sub
            End Try

            'Add the reference to the style sheet
            Try
                Console.WriteLine("Adding style sheet reference (" & straArg(1) & ") to " & straArg(0))
                xmlDoc.InsertBefore(xmlDoc.CreateProcessingInstruction("xml:stylesheet", "type=""text/xsl"" href=""" & straArg(1) & """"), xmlDoc.DocumentElement)
            Catch
                Console.WriteLine("Error: Unable to Create Processing Instruction")
            End Try

            'Save the Resulting File
            If UBound(straArg) = 2 Then
                'Write out the file to the Output File if passed
                Try
                    Console.WriteLine("Saving new Output File: " & straArg(2))
                    xmlDoc.Save(straArg(2))
                Catch
                    Console.WriteLine("Error: Unable to write file " & straArg(2))
                End Try

            Else
                'Overwrite the original file 
                Try
                    Console.WriteLine("Saving File: " & straArg(0))
                    xmlDoc.Save(straArg(0))
                Catch
                    Console.WriteLine("Error: Unable to write file " & straArg(0))
                End Try

            End If

        End If



    End Sub

End Module
