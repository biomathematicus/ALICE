<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="page_counter">
		<table border="0" cellpadding="1" cellspacing="0" width="100%">
			<tr>
  			<td class="CONTENT" align="left" style="white-space: nowrap">
          <!-- xsl:value-of select="//L_BOOK"/ -->
					<span class="BOLD">
					<xsl:choose>
						<xsl:when test="//L_LINK_PENDING[. != '']">
							<xsl:value-of select="ds_opus" />
						</xsl:when>
						<xsl:otherwise>
							<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
						<!--		<xsl:attribute name="href">javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="id_opus" />','<xsl:value-of select="id_pagina" />')</xsl:attribute> -->

                <xsl:attribute name="href">javascript:Map('<xsl:value-of select="//language" />','<xsl:value-of select="id_opus" />')</xsl:attribute>
                <xsl:value-of select="ds_opus" />
							</a>
						</xsl:otherwise>
					</xsl:choose>
					</span>
				</td>
        <td width="80%"></td>
        <xsl:if test="//user_id != ''">
          <td valign="bottom" class="XSMALL" style="white-space: nowrap">
            <xsl:value-of select="//percentage_g" />% <xsl:value-of select="//L_Graded_" />   &#160;&#160;&#160;
            <xsl:value-of select="//percentage" />%  <xsl:value-of select="//L_READ" />   &#160;&#160;&#160;
            <xsl:value-of select="//perct_incomplete" />% <xsl:value-of select="//L_pending" />  &#160;&#160;&#160;
          </td>
          <td align="left" valign="top" style="white-space: nowrap">
            <div class="XSMALL">
              &#160;
              <table width="100px" height="4px" border="0" cellpadding="0" cellspacing="0" ID="Table2">
                <tr>
                  <td align="right" class="BAR_OFF">
                    <img height="4px" src="../images/system/px_green.gif">
                      <xsl:attribute name="width">
                        <xsl:value-of select="//percentage_g" />
                      </xsl:attribute>
                    </img>
                  </td>
                  <td align="right" class="BAR_OFF">
                    <img height="4px" src="../images/system/px_yellow.gif">
                      <xsl:attribute name="width">
                        <xsl:value-of select="//percentage" />
                      </xsl:attribute>
                    </img>
                  </td>
                  <td align="right" class="BAR_OFF">
                    <img height="4px" src="../images/system/px_red.gif">
                      <xsl:attribute name="width">
                        <xsl:value-of select="//perct_incomplete" />
                      </xsl:attribute>
                    </img>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </xsl:if>
				<td class="XSMALL" valign="bottom"  align="left" style="white-space: nowrap">
					&#160;
					<xsl:if test="//page_code[. != 'P_TRACTUS']">
						<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
							<xsl:attribute name="href">javascript:Map('<xsl:value-of select="//language" />',<xsl:value-of select="id_opus" />);</xsl:attribute>
							<span class="XSMALL"><xsl:value-of select="//P_TRACTUS" /></span>
						</a>
					</xsl:if>
					<xsl:if test="//page_code[. != 'P_Nuntius']">
						<xsl:if test="//page_code[. != 'P_TRACTUS']">&#160;|&#160;</xsl:if>
						<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
							<xsl:attribute name="href">javascript:About('<xsl:value-of select="//language" />', '<xsl:value-of select="id_opus" />')</xsl:attribute>
							<span class="XSMALL"><xsl:value-of select="//P_INDICIUM" /></span>
						</a>
					</xsl:if>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>