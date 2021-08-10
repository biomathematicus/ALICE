Imports System
Imports System.Web

Public Class SessionState : Inherits Page

    Public Sub CheckLanguage()
        'Dim sUserID As New HttpCookie("Forum")("UserID")
        Dim sPrForum As New HttpCookie("PrForum")
        'Dim sLastVist As New HttpCookie("ForumVisit")("LastVist")
        Dim sShowActive As New HttpCookie("showActive")
        Dim sShow As New HttpCookie("show")

        'Response.Write("sUserID: " & sUserID.value & "<br>")
        Response.Write("sPrForum: " & sPrForum.Value & "<br>")
        'Response.Write("sLastVist:" & sLastVist.value & "<br>")
        Response.Write("sShowActive: " & sShowActive.Value & "<br>")
        Response.Write("sShow:" & sShow.Value & "<br>")
    End Sub

End Class