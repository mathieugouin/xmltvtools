Imports System.IO
Imports System.Xml
Imports System.Xml.Xsl
Imports System.Xml.XmlReader
Imports System.Xml.XPath

Module TransformXPathDoc
    '===========================================================
    ' TransformXPathDoc:
    ' Author: Timothy Alosi (timalosi.com)
    ' Revision 0.1.B
    ' Revision Date: December 11, 2004
    ' 
    ' This software is provided under the MIT License.
    ' Please see http://opensource.org/licenses/mit-license.php
    ' for more information
    '===========================================================



    Sub Main()


        Dim xPathDoc As XPathDocument
        Dim xslDoc As New XslTransform()
        Dim outDoc As StreamWriter

        Dim strArg As String = Microsoft.VisualBasic.Command()
        Dim straArg() As String = Split(strArg, " ")


        ' This program takes up to three arguments
        ' 1. The XML Source File (required)
        ' 2. The XSL File (required)
        ' 3. The Output File to be created (optional)
        '
        ' Program Flow
        ' 1. Open XMLFile
        ' 2. Transform the XML Document
        ' 3. If Output File passed, saves as new file, otherwise save file

        '==================================================================
        If UBound(straArg) < 1 Then
            'Missing some of the required arguments
            Console.WriteLine("Usage: TransformXPathDoc XMLFile XSLFile [OutputXMLFile]")
        Else
            ' Open the XML File
            Try
                Console.WriteLine("Opening XML File  (" & straArg(1) & ") ")
                xPathDoc = New XPathDocument(straArg(0))
            Catch
                Console.WriteLine("Error: Unable to open XML File")
                Exit Sub
            End Try

            'Open the stylesheet
            Try
                Console.WriteLine("Opening Stylesheet (" & straArg(1) & ") ")
                xslDoc.Load(straArg(1))
            Catch
                Console.WriteLine("Error: Unable to open Stylesheet")
            End Try


            'Transform the document
            If UBound(straArg) = 2 Then
                'Write out the file to the Output File if passed
                Try
                    Console.WriteLine("Createing Filestream Object")
                    Dim fs As New FileStream(straArg(2), FileMode.Create, FileAccess.Write)
                    Console.WriteLine("setting stream")
                    outDoc = New StreamWriter(fs)
                    Console.WriteLine("setting xmlwriter")
                    Dim xmlOut As New XmlTextWriter(outDoc)
                    Console.WriteLine("Transforming Document")
                    xslDoc.Transform(xPathDoc, Nothing, xmlOut)
                    Console.WriteLine("closing file")
                    outDoc.Close()
                Catch
                    Console.WriteLine("Error: Unable to write file " & straArg(2))
                End Try

            Else
                'Transform to the console 
                Try
                    Console.WriteLine("Transforming Document")
                    xslDoc.Transform(xPathDoc, Nothing, Console.Out)
                Catch
                    Console.WriteLine("Error: Unable to transform document")
                End Try

            End If

        End If
        '==================================================================


    End Sub

End Module
