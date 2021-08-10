Imports Literatronica
Imports System.Text
Imports System.Data
Imports System.Reflection
Imports System.Data.SqlClient
Imports System.Diagnostics

#Region " Assembly information "

< _
    Assembly: AssemblyTitle("DBService"), _
    Assembly: AssemblyDescription("Data Services for Literatronic"), _
    Assembly: AssemblyConfiguration(""), _
    Assembly: AssemblyCompany("Literatronic©"), _
    Assembly: AssemblyProduct("Literatronic©"), _
    Assembly: AssemblyCopyright("Literatronic©.  All rights reserved."), _
    Assembly: AssemblyTrademark("Literatronic©"), _
    Assembly: AssemblyCulture(""), _
    Assembly: AssemblyVersion("1.0.*"), _
    Assembly: AssemblyDelaySign(False), _
    Assembly: AssemblyKeyFile(""), _
    Assembly: AssemblyKeyName("") _
> 

#End Region

Namespace DBService

    Public Class Connection
        Private m_oConn As SqlConnection
        Private DB_CONN_STRING As String = System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STRING")

#Region " Function formatTextInput: Cleans malicious code except HTML brackets. Used in text entry forms "

        Public Function formatTextInput(ByVal sTxtToClean)
            If sTxtToClean Is Nothing Then Exit Function
            sTxtToClean = sTxtToClean.ToString.Replace("'", "''")
            sTxtToClean = sTxtToClean.ToString.Replace("select", "sel&#101;ct")
            sTxtToClean = sTxtToClean.ToString.Replace("join", "jo&#105;n")
            sTxtToClean = sTxtToClean.ToString.Replace("union", "un&#105;on")
            sTxtToClean = sTxtToClean.ToString.Replace("where", "wh&#101;re")
            sTxtToClean = sTxtToClean.ToString.Replace("insert", "ins&#101;rt")
            sTxtToClean = sTxtToClean.ToString.Replace("delete", "del&#101;te")
            sTxtToClean = sTxtToClean.ToString.Replace("update", "up&#100;ate")
            sTxtToClean = sTxtToClean.ToString.Replace("like", "lik&#101;")
            sTxtToClean = sTxtToClean.ToString.Replace("drop", "dro&#112;")
            sTxtToClean = sTxtToClean.ToString.Replace("create", "cr&#101;ate")
            sTxtToClean = sTxtToClean.ToString.Replace("modify", "mod&#105;fy")
            sTxtToClean = sTxtToClean.ToString.Replace("rename", "ren&#097;me")
            sTxtToClean = sTxtToClean.ToString.Replace("alter", "alt&#101;r")
            sTxtToClean = sTxtToClean.ToString.Replace("cast", "ca&#115;t")
            sTxtToClean = sTxtToClean.ToString.Replace("pass", "pa&#115;s")
            sTxtToClean = sTxtToClean.ToString.Replace("code", "co&#100;e")
            sTxtToClean = sTxtToClean.ToString.Replace("author", "aut&#104;or")
            sTxtToClean = sTxtToClean.ToString.Replace("username", "usernam&#101;")
            formatTextInput = sTxtToClean
        End Function

#End Region

#Region " Function formatSQLInput: Cleans malicious code from parameters before they go to the database "

        Public Function formatSQLInput(ByVal sTxtToClean)
            Dim n As Integer
            If sTxtToClean Is Nothing Then Exit Function
            sTxtToClean = formatTextInput(sTxtToClean)
            sTxtToClean = sTxtToClean.ToString.Replace("<", "&lt;")
            sTxtToClean = sTxtToClean.ToString.Replace(">", "&gt;")
            sTxtToClean = sTxtToClean.ToString.Replace("""", "")
            sTxtToClean = sTxtToClean.ToString.Replace("=", "&#061;")
            formatSQLInput = sTxtToClean
        End Function

#End Region

#Region " Function DataReaderOpen: Returns a DataReader from a SQL query "

        Public Function DataReaderOpen(ByVal sSQL As String) As SqlDataReader
            'Open the data connection
            m_oConn = New SqlConnection(DB_CONN_STRING)
            m_oConn.Open()
            'Create a command object
            Dim oCommand As SqlCommand
            'Create a datareader
            Dim oDataReader As SqlDataReader
            'Load the command object
            oCommand = New SqlCommand(sSQL, m_oConn)
            'Load the datareader
            DataReaderOpen = oCommand.ExecuteReader()
        End Function

#End Region

#Region " Function DataConnClose: Closes the data connection "

        Public Function DataConnClose() As Boolean
            'Closes the connection
            Try
                m_oConn.Close()
                DataConnClose = True
            Catch ex As Exception
                DataConnClose = False
            End Try
        End Function

#End Region

#Region " Function DBXML: Returns an XML string from a SQL query "

        Public Function DBXML(ByVal sSQL As String) As String
            Dim sXML As New StringBuilder
            'Create a datareader
            Dim oDataReader As SqlDataReader
            'Load the datareader
            oDataReader = DataReaderOpen(sSQL)
            While oDataReader.Read()
                sXML.Append(oDataReader("lines"))
            End While
            'Close the datareader/db connection
            oDataReader.Close()
            DataConnClose()
            Return sXML.ToString
        End Function

#End Region

#Region " Function ManageCookies: Reads and sets user settings in cookies "

        Public Shared Function ManageCookies(ByRef sLinguaCok As String, _
                ByRef sLinguaQry As String, _
                ByRef sUserID As String, _
                ByRef BasePage As Page) As String
            Dim sPage As String = "Lingua.aspx"
            sLinguaQry = BasePage.Request.QueryString("lng")
            Try
                If sLinguaQry <> "HISPANIA" And sLinguaQry <> "BRITANNIA" Then
                    sLinguaCok = BasePage.Request.Cookies("Forum")("Lingua")
                    If sLinguaCok = "" Or sLinguaCok Is Nothing Then sLinguaCok = "BRITANNIA"
                    sLinguaQry = sLinguaCok
                Else
                    sLinguaCok = sLinguaQry
                    sUserID = BasePage.Request.Cookies("Forum")("UserID")
                    BasePage.Response.Cookies("Forum")("Lingua") = sLinguaQry
                    BasePage.Response.Cookies("Forum")("UserID") = sUserID
                    BasePage.Response.Cookies("Forum").Expires = DateAdd("yyyy", 1, Now())
                End If
                sUserID = BasePage.Request.Cookies("Forum")("UserID")
                If sUserID Is Nothing Then sUserID = ""
                'The following line is needed because of the forum
                If Right(sUserID, 12) = "LOGGED%2DOFF" Then sUserID = ""
            Catch
                sUserID = ""
                sLinguaQry = "BRITANNIA"
                BasePage.Response.Redirect(sPage & "?ref=Tractus.aspx&act=ln&lng=")
            End Try
            If sLinguaCok <> "HISPANIA" And sLinguaCok <> "BRITANNIA" Then
                sLinguaQry = "BRITANNIA"
                BasePage.Response.Redirect("Lingua.aspx?ref=initium.aspx&act=ln&lng=" & sLinguaQry)
            End If
        End Function

#End Region

#Region " Function CalculateBook: Calculates the book's minimal paths using Gomory-Hu algorithm "

        Public Function CalculateBook(ByVal nBookID As Integer)
            '*********************** Definitions *************************
            'MCA = Matriz de Costos Asociados = Associated Costs Matrix
            'CMR = Costos Mínimos Resultantes = Minimum Resulting Costs
            'MNI = Matriz de Nudos Intermedios = Intermediate Nodes Matrix
            '*************************************************************
            Dim n As Long, i As Long, j As Long, k As Long, sSQL As String, l As Long
            Dim rsMCA As SqlDataReader
            Dim sInsert As New StringBuilder
            Const INFINITY = 1 / 0
            Debug.WriteLine(Now())
            'Retrieve MCA matrix from databse
            rsMCA = DataReaderOpen("exec matMCA " & nBookID)
            rsMCA.Read()
            n = rsMCA.GetValue(0)
            Debug.WriteLine("Retrieve records - " & n)
            Dim MCA(n, n) As Single, CMR(n, n) As Single, MNI(n, n) As Long
            rsMCA.NextResult()
            While rsMCA.Read()
                MCA(rsMCA!i, rsMCA!j) = rsMCA!am_value
            End While
            rsMCA.Close()
            'Complete MCA with INFINITY
            Debug.WriteLine("Complete MCA with INFINITY - " & n)
            For i = 1 To n
                For j = 1 To n
                    MCA(i, j) = IIf(MCA(i, j) = 0 And i <> j, INFINITY, MCA(i, j))
                    CMR(i, j) = MCA(i, j)
                    MNI(i, j) = IIf(MCA(i, j) = INFINITY, 0, j)
                Next j
            Next i
            'Calculate CMR basedo on MCA
            Debug.WriteLine("Calculate CMR basedo on MCA - " & n)
            'The algorithm must be executed twice
            'Gomory & Hu algorithm
            For k = 1 To n
                For i = 1 To n
                    For j = 1 To n
                        If CMR(i, k) > CMR(i, j) + CMR(j, k) Then CMR(i, k) = CMR(i, j) + CMR(j, k)
                    Next
                Next
            Next
            'Calculate MNI based on MCA & CMR
            Debug.WriteLine("Calculate MNI based on MCA & CMR - " & n)
            For i = 1 To n
                For j = 1 To n
                    For k = 1 To n
                        If CMR(i, j) >= CMR(i, k) + CMR(k, j) And MCA(i, k) < INFINITY And i <> k And j <> k Then
                            If CMR(i, j) = 1 / 0 Then MNI(i, j) = j Else MNI(i, j) = k
                        End If
                    Next
                Next j
            Next i
            'Print results in debugging window
            Debug.WriteLine("MCA")
            For i = 1 To n
                For j = 1 To n
                    Debug.Write(MCA(i, j) & ",")
                Next j
                Debug.Write(Chr(10))
            Next i
            Debug.WriteLine("CMR")
            For i = 1 To n
                For j = 1 To n
                    Debug.Write(CMR(i, j) & ",")
                Next j
                Debug.Write(Chr(10))
            Next i
            Debug.WriteLine("MNI")
            For i = 1 To n
                For j = 1 To n
                    Debug.Write(MNI(i, j) & ",")
                Next j
                Debug.Write(Chr(10))
            Next i
            'Update database
            Debug.WriteLine("Update database - " & n)
            sInsert.Append("delete from MATRIX where id_opus= " & nBookID & " and (cd_matrix_type = 'CMR' or cd_matrix_type = 'MNI'); ")
            For i = 1 To n
                For j = 1 To n
                    If CMR(i, j) > 999999999 Then CMR(i, j) = 999999999
                    sInsert.Append("insert into MATRIX (cd_matrix_type, id_opus, i, j, am_value) " & _
                            "values ('CMR'," & nBookID & "," & i & "," & j & "," & _
                            CMR(i, j) & "); " & _
                            "insert into MATRIX (cd_matrix_type, id_opus, i, j, am_value) " & _
                            "values ('MNI'," & nBookID & "," & i & "," & j & "," & _
                            MNI(i, j) & "); ")
                Next j
            Next i
            rsMCA = DataReaderOpen(sInsert.ToString())
            rsMCA.Close()
            DataConnClose()
        End Function

#End Region

#Region " Function DataSetFromDataReader: Fills a data set from a data reader "

        Public Sub DataSetFromDataReader(ByVal ds As DataSet, ByVal table As String, _
            ByVal dr As IDataReader)
            ' Create an DataAdapter of the same type as the DataReader
            Dim drType As Type = CObj(dr).GetType
            Dim typename As String = drType.FullName.Replace("DataReader", "DataAdapter")
            Dim daType As Type = drType.Assembly.GetType(typename)
            Dim da As Object = Activator.CreateInstance(daType)
            ' invoke the protected Fill method that takes an IDataReader object
            Dim args() As Object = {ds, table, dr, 0, 999999}
            daType.InvokeMember("Fill", BindingFlags.InvokeMethod Or BindingFlags.NonPublic Or _
               BindingFlags.Instance, Nothing, da, args)
            ' close the DataReader
            dr.Close()
        End Sub

#End Region

    End Class

End Namespace