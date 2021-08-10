<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PrimerVuelo.aspx.vb" Inherits="src_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dict</title>
    <script language="javascript">
        if (navigator.appName == "Netscape") {
            document.write('<link rel="stylesheet" type="text/css" href="../common/styles_ns.css" />');
        } else {
            document.write('<link rel="stylesheet" type="text/css" href="../common/styles.css" />');
        }
    </script>
    <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
    <script type="text/javascript">
        _uacct = "UA-863973-1";
        urchinTracker();
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table border="0" class="vuelo">
            <tr>
                <td width="145">
                    <img src="../images/vuelo/gargol.gif" width="146" height="191" alt="Gárgola"></td>
                <td width="255" valign="middle">
                    <h1>Diccionario Zurdo de El Primer Vuelo de los Hermanos Wright</h1>
                    <asp:Label runat="server" ID="lblDict" CssClass="CONTENT"></asp:Label>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>