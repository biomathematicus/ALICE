Imports Literatronica.Global
Imports System.Text
Imports System.Data
Imports System.Reflection
Imports System.Data.SqlClient
Imports System.Diagnostics

Namespace Literatronica

	Public Class Connection
		Private m_oConn As SqlConnection
		Public DB_CONN_STRING As String

		Public Sub New()
			' Get the name of the environment variable from web.config
			Dim envVarName As String = System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STRING")

			If Not String.IsNullOrEmpty(envVarName) Then
				' Retrieve the connection string from the machine environment variables
				DB_CONN_STRING = Environment.GetEnvironmentVariable(envVarName, EnvironmentVariableTarget.Machine)
				If String.IsNullOrEmpty(DB_CONN_STRING) Then
					' If not found at the machine level, check the user level
					DB_CONN_STRING = Environment.GetEnvironmentVariable(envVarName, EnvironmentVariableTarget.User)
				End If
			End If

			If String.IsNullOrEmpty(DB_CONN_STRING) Then
				Throw New InvalidOperationException("Database connection string is not set.")
			End If

			' Initialize the SqlConnection with the retrieved connection string
			m_oConn = New SqlConnection(DB_CONN_STRING)
		End Sub


#Region " Function formatTextInput: Cleans malicious code except HTML brackets. Used in text entry forms "

		Public Function formatTextInput(ByVal sTxtToClean)
			If sTxtToClean Is Nothing Then
				Return ""
			End If
			sTxtToClean = sTxtToClean.ToString.Replace("'", "''")
			'sTxtToClean = sTxtToClean.ToString.Replace("select", "sel&#101;ct")
			'sTxtToClean = sTxtToClean.ToString.Replace("join", "jo&#105;n")
			'sTxtToClean = sTxtToClean.ToString.Replace("union", "un&#105;on")
			'sTxtToClean = sTxtToClean.ToString.Replace("where", "wh&#101;re")
			'sTxtToClean = sTxtToClean.ToString.Replace("insert", "ins&#101;rt")
			'sTxtToClean = sTxtToClean.ToString.Replace("delete", "del&#101;te")
			'sTxtToClean = sTxtToClean.ToString.Replace("update", "up&#100;ate")
			'sTxtToClean = sTxtToClean.ToString.Replace("like", "lik&#101;")
			'sTxtToClean = sTxtToClean.ToString.Replace("drop", "dro&#112;")
			'sTxtToClean = sTxtToClean.ToString.Replace("create", "cr&#101;ate")
			'sTxtToClean = sTxtToClean.ToString.Replace("modify", "mod&#105;fy")
			'sTxtToClean = sTxtToClean.ToString.Replace("rename", "ren&#097;me")
			'sTxtToClean = sTxtToClean.ToString.Replace("alter", "alt&#101;r")
			'sTxtToClean = sTxtToClean.ToString.Replace("cast", "ca&#115;t")
			'sTxtToClean = sTxtToClean.ToString.Replace("pass", "pa&#115;s")
			'sTxtToClean = sTxtToClean.ToString.Replace("code", "co&#100;e")
			'sTxtToClean = sTxtToClean.ToString.Replace("author", "aut&#104;or")
			'sTxtToClean = sTxtToClean.ToString.Replace("username", "usernam&#101;")
			Return sTxtToClean
		End Function

#End Region

#Region " Function formatSQLInput: Cleans malicious code from parameters before they go to the database "

		Public Function formatSQLInput(ByVal sTxtToClean)
			If sTxtToClean Is Nothing Then
				Return ""
			End If
			sTxtToClean = formatTextInput(sTxtToClean)
			sTxtToClean = sTxtToClean.ToString.Replace("<", "&lt;")
			sTxtToClean = sTxtToClean.ToString.Replace(">", "&gt;")
			sTxtToClean = sTxtToClean.ToString.Replace("""", "")
			sTxtToClean = sTxtToClean.ToString.Replace("=", "&#061;")
			Return sTxtToClean
		End Function

#End Region

#Region " Function DataReaderOpen: Returns a DataReader from a SQL query "

		Public Function DataReaderOpen(ByVal sSQL As String) As SqlDataReader
			'Open the data connection
			m_oConn = New SqlConnection(DB_CONN_STRING)
			m_oConn.Open()
			'Create a command object
			Dim oCommand As SqlCommand
			'Load the command object
			oCommand = New SqlCommand(sSQL, m_oConn)
			oCommand.CommandTimeout = 0
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
			Try
				oDataReader = DataReaderOpen(sSQL)
				While oDataReader.Read()
					sXML.Append(oDataReader("lines"))
				End While
				'Close the datareader/db connection
				oDataReader.Close()
				DataConnClose()
			Catch ex As Exception
				'Manage exception
				Return False
			End Try
			Return sXML.ToString
		End Function

#End Region

#Region " Function ManageCookies: Reads and sets user settings in cookies "

		Public Sub ManageCookies(ByRef sLinguaCok As String,
			ByRef sLinguaQry As String,
			ByRef sUserID As String,
			ByRef BasePage As Page)
			'*****************************************************
			Dim sPage As String = "Lingua.aspx"
			Dim oCookie As HttpCookie '= New HttpCookie("Forum")
			Dim User_S, parent_page As String
			User_S = "LOGGED-OFF"
			parent_page = ""
			If sUserID = "secretus" Then
				parent_page = "secretus"
			End If
			sUserID = ""
			'*****************************************************
			oCookie = BasePage.Request.Cookies("Forum")
			'  Dim s As String = BasePage.

			'****************************************************
			If oCookie IsNot Nothing Then
				User_S = oCookie("UserID")
			End If

			If oCookie Is Nothing Then
				oCookie = New HttpCookie("Forum")
				oCookie("Lingua") = "BRITANNIA"
				oCookie("UserID") = "LOGGED-OFF"
				oCookie.Expires = DateAdd("yyyy", 1, Now())
				BasePage.Response.Cookies.Add(oCookie)
				If parent_page <> "secretus" Then
					'  BasePage.Response.Redirect("secretus.aspx")

				End If
			ElseIf User_S = "LOGGED-OFF" Then
				oCookie("UserID") = "LOGGED-OFF"
				oCookie.Expires = DateAdd("yyyy", 1, Now())
				BasePage.Response.Cookies.Set(oCookie)
				If parent_page <> "secretus" Then
					'BasePage.Response.Redirect("secretus.aspx")

				End If

			End If
			'***************************************************************************

			sLinguaCok = oCookie("Lingua")
			sUserID = oCookie("UserID")
			If Right(sUserID, 12) = "LOGGED%2DOFF" Then sUserID = Left(sUserID, Len(sUserID) - 12)
			If sUserID Is Nothing Then sUserID = ""

			sLinguaQry = BasePage.Request.QueryString("lng")
			Try
				'**************************************
				If sLinguaQry <> "HISPANIA" And sLinguaQry <> "BRITANNIA" Then
					If sLinguaCok = "" Or sLinguaCok Is Nothing Then sLinguaCok = "BRITANNIA"
					sLinguaQry = sLinguaCok
				Else
					sLinguaCok = sLinguaQry
				End If
				'**********************************************
				If sUserID <> "" Then
					oCookie("Lingua") = sLinguaCok
					oCookie("UserID") = sUserID
					oCookie.Expires = DateAdd("yyyy", 1, Now())
					BasePage.Response.Cookies.Set(oCookie)
				End If
			Catch ex As Exception
				sUserID = ""
			End Try
			If sLinguaCok <> "HISPANIA" And sLinguaCok <> "BRITANNIA" Then
				sLinguaQry = "BRITANNIA"
			End If
		End Sub

		Public Function GeoIP(ByVal sIP) As String
			If HttpContext.Current.Session("LINGUA") Is Nothing Then
				'Dim dr As SqlDataReader
				'Dim s As String
				'Dim aIP() As String = Split(HttpContext.Current.Request.ServerVariables("remote_addr"), ".")
				'Dim ipnum As String = CStr(16777216 * aIP(0) + 65536 * aIP(1) + 256 * aIP(2) + aIP(3))

				'dr = DataReaderOpen("select country, name from GeoIPCountryWhois where begin_num<='" & ipnum & _
				'                    "' and end_num>='" & ipnum & "'")
				'dr.Read()
				'If dr.HasRows Then s = dr("COUNTRY") Else s = "--"
				'dr.Close()
				'HttpContext.Current.Session("COUNTRY") = s

				'If InStr("AR,BO,BR,CL,CO,CR,CU,DO,EC,SV,GQ,GT,HN,MX,NI,PA,PY,PE,PR,ES,VE", s) > 0 Then
				'    HttpContext.Current.Session("LINGUA") = "HISPANIA"
				'Else
				'    HttpContext.Current.Session("LINGUA") = "BRITANNIA"
				'End If
			End If
			Return HttpContext.Current.Session("LINGUA")
		End Function

#End Region

#Region " Function CalculateBook: Calculates the book's minimal paths using Gomory-Hu algorithm "

		Sub Floyd_Warshal(ByRef graph(,) As Single, ByRef D(,) As Single, ByRef P(,) As Long, ByRef M(,) As String, ByVal numberOfNodes As Integer)

			'  Dim M(numberOfNodes, numberOfNodes) As String
			For i As Integer = 1 To numberOfNodes
				For j As Integer = 1 To numberOfNodes

					If graph(i, j) = 0 Then
						graph(i, j) = 10000
						D(i, j) = graph(i, j)
						P(i, j) = -1
						M(i, j) = "empty"
					Else
						D(i, j) = graph(i, j)
						P(i, j) = j
						M(i, j) = j.ToString

					End If

				Next
			Next
			For k As Integer = 1 To numberOfNodes
				For i As Integer = 1 To numberOfNodes
					For j As Integer = 1 To numberOfNodes
						If D(i, j) > D(i, k) + D(k, j) Then
							'    Debug.WriteLine("  " & i & " ,  " & j & " ,  " & k & " , " & D(i, j) & " , " & D(i, k) & " , " & D(k, j))
							D(i, j) = D(i, k) + D(k, j)
							P(i, j) = k
							M(i, j) = M(i, k) + " , " + M(k, j)

						End If
					Next
				Next
			Next

			For i As Integer = 1 To numberOfNodes
				For j As Integer = 1 To numberOfNodes

					If M(i, j).Equals("empty") Then
					Else
						M(i, j) = i.ToString + "," + M(i, j)

					End If
				Next
			Next

			For i As Integer = 1 To numberOfNodes
				For j As Integer = 1 To numberOfNodes

					Debug.WriteLine("  " & i & " ,  " & j & M(i, j))

				Next
			Next

		End Sub

		Public Sub CalculateBook(ByVal nBookID As Integer, ByVal nCategory As Integer)
			'*********************** Definitions *************************
			'MCA = Matriz de Costos Asociados = Associated Costs Matrix
			'CMR = Costos Mínimos Resultantes = Minimum Resulting Costs
			'MNI = Matriz de Nudos Intermedios = Intermediate Nodes Matrix
			'*************************************************************
			Dim n As Long, i As Long, j As Long, k As Long, l As Long
			Dim rsMCA As SqlDataReader
			Dim sInsert As New StringBuilder
			Const INFINITY = 1 / 0
			If nCategory = 0 Then
				rsMCA = DataReaderOpen("exec matMCA  " & nBookID)
			Else
				rsMCA = DataReaderOpen("exec matMCA_Category   " & " @id_opus=" & nBookID & "," & " @Category=" & nCategory & "")
			End If
			rsMCA.Read()
			n = rsMCA.GetValue(0)
			If n = 0 Then
				Exit Sub
			End If
			Dim MCA(n, n) As Single, CMR(n, n) As Single, MNI(n, n) As Long, Path(n, n) As String
			rsMCA.NextResult()
			While rsMCA.Read()
				MCA(rsMCA!i, rsMCA!j) = rsMCA!am_value
			End While
			rsMCA.Close()

			'-----------------------------------------------------------------------------------------------------------
			Floyd_Warshal(MCA, CMR, MNI, Path, n)
			If nCategory = 0 Then
				sInsert.Append("delete from MATRIX where id_opus= " & nBookID & " and (cd_matrix_type = 'CMR' or cd_matrix_type = 'MNI'); ")
			End If
			For i = 1 To n
				For j = 1 To n
					If CMR(i, j) > 10000 - 1 Then CMR(i, j) = 999999999
					If nCategory = 0 Then

						sInsert.Append("insert into MATRIX (cd_matrix_type, id_opus, i, j, am_value) " &
							"values ('CMR'," & nBookID & "," & i & "," & j & "," &
							CMR(i, j) & "); " &
							"insert into MATRIX (cd_matrix_type, id_opus, i, j, am_value,Path) " &
							"values ('MNI'," & nBookID & "," & i & "," & j & "," &
							MNI(i, j) & "," & " '" & Path(i, j) & "' " & "); ")
					Else
						sInsert.Append(" Update MATRIX set Category_" & nCategory & "='" & Path(i, j) & "'" &
							" where [MATRIX].cd_matrix_type='MNI' and MATRIX.i=" & i & " and MATRIX.j=" & j & ";")
						Dim kkk As String

					End If

				Next j
			Next i
			rsMCA = DataReaderOpen(sInsert.ToString())
			rsMCA.Close()
			DataConnClose()
		End Sub

#End Region

#Region " Function DataSetFromDataReader: Fills a data set from a data reader "

		Public Sub DataSetFromDataReader(ByVal ds As DataSet, ByVal table As String,
		ByVal dr As IDataReader)
			' Create an DataAdapter of the same type as the DataReader
			Dim drType As Type = CObj(dr).GetType
			Dim typename As String = drType.FullName.Replace("DataReader", "DataAdapter")
			Dim daType As Type = drType.Assembly.GetType(typename)
			Dim da As Object = Activator.CreateInstance(daType)
			' invoke the protected Fill method that takes an IDataReader object
			Dim args() As Object = {ds, table, dr, 0, 999999}
			daType.InvokeMember("Fill", BindingFlags.InvokeMethod Or BindingFlags.NonPublic Or
		   BindingFlags.Instance, Nothing, da, args)
			' close the DataReader
			dr.Close()
		End Sub

#End Region

	End Class

End Namespace