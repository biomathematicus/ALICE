<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="footer">
    <p>&#160;</p>
	  <div class="line" />
	  <br />
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
	  <!-- script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-1091512-8"></script -->
    <script>
      /*
	  window.dataLayer = window.dataLayer || [];
      function gtag() { dataLayer.push(arguments); }
      gtag('js', new Date());
      gtag('config', 'UA-1091512-8');
	  */
    </script>
  </xsl:template>
</xsl:stylesheet>