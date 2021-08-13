<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="footer">
    <p>&#160;</p>
    <xsl:text disable-output-escaping="yes">
		<!-- Blue line -->
		<![CDATA[<table width="100%" cellpadding="0" cellspacing="0" border="0"><tr><td height="1" class="BAR_OFF" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width="" /></td></tr></table>]]>
		</xsl:text>
    <div class="CONTENT">
      <div class="XSMALL">
        <xsl:value-of select="//L_COPYRIGHT" /><br />
        The content and opinions expressed on this Web page do not necessarily reflect the views of
        nor are they endorsed by the University of Georgia or the University System of Georgia.
      </div>
      <a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
        <xsl:attribute name="href">
          javascript:document.frmSession.action='../src/Nuntius.aspx?lng=<xsl:value-of select="//language" />&#38;nuntius=T_PRIVACY';document.frmSession.submit();
        </xsl:attribute>
        <span class='XSMALL'>
          <xsl:value-of select="//L_PRIVACY" />
        </span>
      </a>
    </div>
    <script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-1091512-8"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag() { dataLayer.push(arguments); }
      gtag('js', new Date());

      gtag('config', 'UA-1091512-8');
    </script>
  </xsl:template>
</xsl:stylesheet>