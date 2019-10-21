<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%@ Page Language="vb" AutoEventWireup="false" Inherits="Literatronica.Lingua" CodeFile="Lingua.aspx.vb" %>

<%
    'Loads from the cookie
    Dim sUserID As String
    Dim sLastVist As String
    Dim sLinguaCok As String
    Try
        sUserID = Request.Cookies("Forum")("UserID")
        sLastVist = Request.Cookies("ForumVisit")("LastVist")
        sLinguaCok = Request.Cookies("Forum")("Lingua")
        If sLinguaCok = "" Or sLinguaCok Is Nothing Then sLinguaCok = "BRITANNIA"
    Catch
        'Nothing
    End Try

    'Loads from the query string
    Dim sRef As String
    Dim sAction As String
    Dim sLinguaQry As String
    Dim sConnector As String
    If sRef = "cibersociedad" Then sRef = "initium.aspx"
    sAction = Request.QueryString("act")
    sLinguaQry = Request.QueryString("lng")
    If sRef = "" Or sRef = "cibersociedad" Then sRef = "Initium.aspx"

    Select Case sAction
        Case "ln" 'Choose language - Shows the page 
            sRef = "Lingua.aspx?ref=" & sRef & "&act=st"
        Case "st" 'Write the cookie - Redirect to sRef
            Response.Cookies("Forum")("UserID") = sUserID
            Response.Cookies("ForumVisit")("LastVist") = sLastVist
            Response.Cookies("Forum")("Lingua") = sLinguaQry
            Response.Cookies("Forum").Expires = DateAdd("yyyy", 1, Now())
            Response.Redirect(sRef)
        Case "else" 'Ensures at least basic routing
            If sLinguaCok = "HISPANIA" Or sLinguaCok = "BRITANNIA" Then
                Response.Redirect(sRef & "?lng=" & sLinguaCok)
            Else
                Response.Redirect(sRef & "?lng=HISPANIA")
            End If
    End Select

    If sRef.IndexOf("?") > 1 Then sConnector = "&" Else sConnector = "?"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html lang="EN">
<head>
    <title>LITERATRONICA - LINGUA</title>
    <meta http-equiv="CONTENT-Type" content="text/html;CHARSET=iso-8859-1">
    <link rel="SHORTCUT ICON" href="../images/system/BOOK06.ICO">
    <meta name="description" content="Literatr&oacute;nica: Hipertexto Literario Adaptativo / Literatronic: Adaptive Literary Hypertext">
    <meta name="keywords" content="literatronic, hypertext, hypernovel, cibernovel, literatr&oacute;nica, hipernovela, cibernovela, hipertexto, juan b guti&eacute;rrez, juan b gutierrez">

    <script type="text/JavaScript">
		if (top != self) {
		    top.location = self.location;
		}
		if(navigator.appName == "Netscape") {
			document.write('<link rel="stylesheet" type="text/css" href="../common/styles_ns.css" />');
			}
		else {
			document.write('<link rel="stylesheet" type="text/css" href="../common/styles.css" />');
		}
    </script>

    <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>

    <script type="text/javascript">
        _uacct = "UA-863973-1";
        urchinTracker();
    </script>

    <style type="text/css">
        .auto-style1
        {
            width: 233px;
            height: 72px;
        }
    </style>

</head>
<body>
    <p>
        &nbsp;</p>
    <table width="80%" border="0" align="center" cellpadding="3" cellspacing="4" summary="LITERATRONICA">
        <tr>
            <td align="center" class="TAG">
                <a href="<%=sRef & sConnector & "lng=HISPANIA"%>"><span class="BOLD">ALICE</span>
                </a>
            </td>
            <td rowspan="4" align="center">
                <img alt="ALICE" class="auto-style1" longdesc="Logo for the Adaptive Learning for Interdisciplinary Collaborative Environments system" src="../images/system/logo_ALICE.png" />
            </td>
            <td align="center" class="TAG">
                <a href='<%=sRef & sConnector & "lng=BRITANNIA"%>'>ALICE</a></td>
        </tr>
        <tr>
            <td align="center" class="CONTENT">
                <a href="<%=sRef & sConnector & "lng=HISPANIA"%>">
                    <h1>
                        Aprendizaje Adaptative para Entornos Collaborativos Interdisciplinarios</h1>
                </a>
            </td>
            <td align="center" class="CONTENT">
                <a href="<%=sRef & sConnector & "lng=BRITANNIA"%>">
                    <h1>
                        Adaptive Learning for Interdisciplinary Collaborative Environments</h1>
                </a>
            </td>
        </tr>
        <tr>
            <td align="center">
                <p>
                    &nbsp;</p>
                <a href="<%=sRef & sConnector & "lng=HISPANIA"%>">
                    <img src="../images/system/lang_spanish.gif" alt="Castellano" width="17" height="11"
                        border="0" />
                    <span class="SMALL">Castellano</span> </a>
            </td>
            <td align="center">
                <p>
                    &nbsp;</p>
                <a href="<%=sRef & sConnector & "lng=BRITANNIA"%>">
                    <img src="../images/system/lang_english.gif" alt="English" width="17" height="11"
                        border="0" />
                    <span class="SMALL">English</span> </a>
            </td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                <p>
                    <span class="XSMALL">Este sitio requiere cookies. Si usted permanece en esta p&aacute;gina
                        luego de pulsar cualquiera de los v&iacute;nculos anteriores, es porque no ha activado
                        cookies. <a href="https://support.google.com/accounts/answer/61416?hl=es">
                            <span class="XSMALL">Pulse aqu&iacute; para ver instrucciones sobre c&oacute;mo activar
                                cookies</span></a>.</span></p>
            </td>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                <p>
                    <span class="XSMALL">This site requires cookies. If you keep coming back to this pager
                        after clicking on the links above, then you do not have cookies activated. <a href="https://support.google.com/accounts/answer/61416?hl=en">
                            <span class="XSMALL">Click here to see instructions about how to to activate cookies</span></a>.</span></p>
            </td>
        </tr>
        <tr>
            <td align="center">
                <p>
                    &nbsp;</p>
            </td>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                <p>
                    &nbsp;</p>
            </td>
        </tr>
    </table>
</body>
</html>
