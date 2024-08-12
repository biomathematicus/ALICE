<%@ Page Language="VB" AutoEventWireup="false" CodeFile="folio.aspx.vb" Inherits="Folio" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Folio File Manager</title>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm('Are you sure you want to delete this file? This action cannot be undone!') && 
                   confirm('Please confirm again if you really want to delete this file.');
        }

		function copyToClipboard(text) {
			navigator.clipboard.writeText(text).then(function () {
				alert('Link copied to clipboard!');
			}, function (err) {
				alert('Error in copying text: ', err);
			});
		}
	</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="FileUploadControl" runat="server" />
            <asp:Button ID="UploadButton" runat="server" Text="Upload" OnClick="UploadFile" />
            <asp:Label ID="StatusLabel" runat="server" Text="" ForeColor="Green" />
        </div>
        <hr />
        <div>
			<asp:GridView ID="FilesGrid" runat="server" AutoGenerateColumns="false"
						  OnRowCommand="FilesGrid_RowCommand" CellPadding ="5" CellSpacing="5" BorderWidth="1">
				<Columns>
					<asp:BoundField DataField="FileName" HeaderText="File Name" />
					<asp:TemplateField HeaderText="File Link">
						<ItemTemplate>
							<a href='<%# "../docs/" + Eval("FileName") %>' target="_blank">
								../docs/<%# Eval("FileName") %>
							</a>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Copy Link">
						<ItemTemplate>
							<button type="button" onclick="copyToClipboard('<%# "../docs/" + Eval("FileName") %>'); return false;">Copy</button>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField>
						<ItemTemplate>
							<asp:Button ID="DeleteButton" runat="server" CommandName="DeleteFile"
										CommandArgument='<%# Eval("FilePath") %>' Text="Delete"
										OnClientClick="return confirmDelete();" />
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
        </div>
    </form>
</body>
</html>
