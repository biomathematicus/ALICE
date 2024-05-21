<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
        <body>
            <h1>Test</h1>
            <p>XML is connected: <xsl:value-of select="//sa_artifex_dtl"/></p>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
