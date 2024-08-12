Imports System.IO

Partial Class Folio
	Inherits System.Web.UI.Page

	Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		If Not IsPostBack Then
			LoadFiles()
		End If
	End Sub

	Protected Sub UploadFile(sender As Object, e As EventArgs)
		If FileUploadControl.HasFile Then
			Try
				Dim filename As String = Path.GetFileName(FileUploadControl.FileName)
				FileUploadControl.SaveAs(Server.MapPath("~/docs/") & filename)
				StatusLabel.Text = "File uploaded successfully."
				LoadFiles()
			Catch ex As Exception
				StatusLabel.Text = "Error: " & ex.Message
			End Try
		Else
			StatusLabel.Text = "Please select a file to upload."
		End If
	End Sub

	Private Sub xLoadFiles()
		Dim filePaths As String() = Directory.GetFiles(Server.MapPath("~/docs/"))
		Dim files As New List(Of ListItem)
		For Each filePath As String In filePaths
			files.Add(New ListItem(Path.GetFileName(filePath), filePath))
		Next
		FilesGrid.DataSource = files
		FilesGrid.DataBind()
	End Sub

	Private Sub LoadFiles()
		Dim filePaths As String() = Directory.GetFiles(Server.MapPath("~/docs/"))
		Dim files As New List(Of FileInfoItem)
		For Each filePath As String In filePaths
			files.Add(New FileInfoItem() With {.FileName = Path.GetFileName(filePath), .FilePath = filePath})
		Next
		FilesGrid.DataSource = files
		FilesGrid.DataBind()
	End Sub


	Protected Sub FilesGrid_RowCommand(sender As Object, e As GridViewCommandEventArgs)
		If e.CommandName = "DeleteFile" Then
			Dim filePath As String = e.CommandArgument.ToString()
			File.Delete(filePath)
			LoadFiles()
			StatusLabel.Text = "File deleted successfully."
		End If
	End Sub
End Class

Public Class FileInfoItem
	Public Property FileName As String
	Public Property FilePath As String
End Class

' Namespace Literatronica
' End Namespace'