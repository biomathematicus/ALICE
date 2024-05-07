<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="html_header">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<meta HTTP-EQUIV="CONTENT-Type" CONTENT="text/html;CHARSET=iso-8859-1" />
		<meta name="description">
			<xsl:attribute name="content"><xsl:value-of select="//T_META_DESCR" /></xsl:attribute>
		</meta>
		<meta name="keywords">
			<xsl:attribute name="content"><xsl:value-of select="//T_META_KEYWRD" /></xsl:attribute>
		</meta>
		<title>
			<xsl:value-of select="//L_LITERATRONIC" /> - <xsl:value-of select="//T_PAGE_TITLE" />
		</title>
		<link rel="SHORTCUT ICON" href="../images/system/BOOK06.ICO" />
		<link rel="stylesheet" type="text/css" href="../common/ALICE.css" />
		<link rel="stylesheet" href="../common/katex/katex.min.css" />
		<script language="JavaScript" type="text/JavaScript" src="../common/katex/katex.min.js" />
		<script language="JavaScript" type="text/JavaScript" src="../common/katex/contrib/auto-render.min.js" />
		<script language="JavaScript" type="text/JavaScript" src="../common/showdown/showdown.min.js" />
		<script language="JavaScript" type="text/JavaScript" src="../common/jquery-3.7.1.min.js" />
			<!-- ***********IMPORTANT: Load the ALICE JS library last in the HTML HEAD section *********** -->
		<script language="JavaScript" type="text/JavaScript" src="../common/ALICE.js" />
		<script language="JavaScript" type="text/JavaScript">
			// Define constants loaded at the top of every page
			ERR_SRCH_LEN = '<xsl:value-of select="//ERR_SRCH_LEN" />';
			L_NUMBER_ASSETS_PART1 = '<xsl:value-of select="//L_NUMBER_ASSETS_PART1" />';
			L_NUMBER_ASSETS_PART2 = '<xsl:value-of select="//L_NUMBER_ASSETS_PART2" />';
		</script>	
	</head>
	</xsl:template>
</xsl:stylesheet>
