<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="footer">
    <p>&#160;</p>
    <xsl:text disable-output-escaping="yes">
		<!-- Blue line -->
		<![CDATA[<table width="800px" cellpadding="0" cellspacing="0" border="0" align="center"><tr><td height="1" class="BAR_OFF" colspan="15"><img src="../images/system/px_alpha.gif" height="1" width="" /></td></tr></table>]]>
		</xsl:text>
    <div class="CONTENT" align="center">
      <div class="XSMALL">
        <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">
          <img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" />
        </a><br />
        <xsl:value-of select="//L_COPYRIGHT" /><br />
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