<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="html_header">		
		<HEAD>
			<META HTTP-EQUIV="CONTENT-Type" CONTENT="text/html;CHARSET=iso-8859-1" />
			<LINK REL="SHORTCUT ICON" HREF="../images/system/BOOK06.ICO" />
			<META http-equiv="expires" content="0" />
			<META name="description">
				<xsl:attribute name="content"><xsl:value-of select="//T_META_DESCR"/></xsl:attribute>
			</META>
			<META name="keywords">
				<xsl:attribute name="content"><xsl:value-of select="//T_META_KEYWRD"/></xsl:attribute>
			</META>
			<TITLE>
				<xsl:value-of select="//L_LITERATRONIC" /> - <xsl:value-of select="//T_PAGE_TITLE" />
			</TITLE>
      <META http-equiv="Pragma" content="no-cache" />
      <script language="JavaScript" type="text/JavaScript" src="../common/Script.js"/>	  
      <script language="JavaScript" type="text/JavaScript">
      /*********************************************************
      
      Function	: Search()
      Purpose		: Sends a search string to the search engine
      Parameters	: None
      Returns		: if error FALSE, otherwise REDIRECT
      JBG - 03/2004
      *********************************************************/
      function Search() {
        if(document.frmQuaestio.txtSearch.value.length &lt; 4) {
          alert('<xsl:value-of select="//ERR_SRCH_LEN" />');
        return false;
        } else {
        document.frmQuaestio.submit();
        return;
        }
        }
        /**********************************************/

      </script>
      <script src="//code.jquery.com/jquery-1.10.2.js"></script>
		</HEAD>
	</xsl:template>
</xsl:stylesheet>