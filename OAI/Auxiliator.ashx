<%@ WebHandler Language="VB" Class="Auxiliator" %>

Imports System
Imports System.Web
Imports System.Data.SqlClient
Imports System.Web.Script.Serialization

Public Class Auxiliator : Implements IHttpHandler

    Private connStr As String = System.Configuration.ConfigurationManager.ConnectionStrings("ALICEConnectionString").ConnectionString

    Public Sub ProcessRequest(context As HttpContext) Implements IHttpHandler.ProcessRequest
        context.Response.ContentType = "application/json"
        Dim serializer As New JavaScriptSerializer()
        Dim response As Object = New With {Key .success = False, Key .message = "", Key .state = ""}

        Try
            Dim action As String = context.Request("action")
            Dim id_opus As Integer = Integer.Parse(context.Request("id_opus"))
            Dim id_pagina As Integer = Integer.Parse(context.Request("id_pagina"))
            Dim ds_symbolum As String = context.Request("ds_symbolum")

            If String.IsNullOrEmpty(action) OrElse String.IsNullOrEmpty(ds_symbolum) Then
                Throw New ArgumentException("Missing parameters.")
            End If

            Select Case action.ToLower()
                Case "getstate"
                    response = GetState(id_opus, id_pagina, ds_symbolum)

                Case "updatestate"
                    Dim state_json As String = context.Request("state_json")
                    response = UpdateState(id_opus, id_pagina, ds_symbolum, state_json)

                Case Else
                    response = New With {Key .success = False, Key .message = "Unknown action."}
            End Select

        Catch ex As Exception
            response = New With {Key .success = False, Key .message = ex.Message}
        End Try

        context.Response.Write(serializer.Serialize(response))
    End Sub

    Private Function GetState(id_opus As Integer, id_pagina As Integer, ds_symbolum As String) As Object
        Using conn As New SqlConnection(connStr)
            conn.Open()
            Using cmd As New SqlCommand("getAuxiliator", conn)
                cmd.CommandType = System.Data.CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@id_opus", id_opus)
                cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
                cmd.Parameters.AddWithValue("@ds_symbolum", ds_symbolum)

                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.Read() Then
                        Dim json As String = If(Not IsDBNull(reader("ds_state_json")), reader("ds_state_json").ToString(), "")
                        Return New With {Key .success = True, Key .state = json}
                    Else
                        Return New With {Key .success = True, Key .state = ""}
                    End If
                End Using
            End Using
        End Using
    End Function

    Private Function UpdateState(id_opus As Integer, id_pagina As Integer, ds_symbolum As String, state_json As String) As Object
        Using conn As New SqlConnection(connStr)
            conn.Open()
            Using cmd As New SqlCommand("updateAuxiliator", conn)
                cmd.CommandType = System.Data.CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@id_opus", id_opus)
                cmd.Parameters.AddWithValue("@id_pagina", id_pagina)
                cmd.Parameters.AddWithValue("@ds_symbolum", ds_symbolum)
                cmd.Parameters.AddWithValue("@ds_state_json", If(state_json, ""))

                cmd.ExecuteNonQuery()
                Return New With {Key .success = True}
            End Using
        End Using
    End Function

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class
