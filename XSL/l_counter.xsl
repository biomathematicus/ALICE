<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="page_counter">
		<xsl:param name="ShowTitle" />
		<xsl:if test="//user_id != ''">
			<div style="padding: 4px;">
				<xsl:if test="$ShowTitle != 'NO'">
					<xsl:choose>
						<xsl:when test="//L_LINK_PENDING[. != '']">
							<xsl:value-of select="ds_opus" />
						</xsl:when>
						<xsl:otherwise>
							<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
								<xsl:attribute name="href">
									javascript:Map('<xsl:value-of select="//language" />','<xsl:value-of select="id_opus" />')
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="//page_code[. = 'P_INDEX']">
										<h1>
											<xsl:value-of select="ds_opus" />
										</h1>
									</xsl:when>
									<xsl:otherwise>
										<b>
											<xsl:value-of select="ds_opus" />
										</b>
									</xsl:otherwise>
								</xsl:choose>
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</div>
			<div class="XSMALL" style="display: inline-block; "> <!--  vertical-align: top; -->
				<xsl:value-of select="percentage_g" />%
				<xsl:value-of select="//L_Graded_" /> | 
				<xsl:value-of select="percentage" />%
				<xsl:value-of select="//L_READ" /> | 
				<xsl:value-of select="perct_incomplete" />%
				<xsl:value-of select="//L_pending" /> 
				<!-- Progress Bar Container -->
				<div style="height: 4px; width: 150px; display: flex; border: 1px solid #ccc;">
					<!-- Graded Progress Segment -->
					<div>
						<xsl:attribute name="style">
							<xsl:text>height: 4px; background-color: #F15A22; display: inline; width:</xsl:text><xsl:value-of select="percentage_g"/><xsl:text>%;</xsl:text>
						</xsl:attribute>
					</div>
					<!-- Ungraded Progress Segment -->
					<div>
						<xsl:attribute name="style">
							<xsl:text>height: 4px; background-color: #495A70; display: inline; width:</xsl:text><xsl:value-of select="perc_diff"/><xsl:text>%;</xsl:text>
						</xsl:attribute>
					</div>
					<!-- Pending Progress Segment -->
					<div >
						<xsl:attribute name="style">
							<xsl:text>height: 4px; background-color: #DBDEE3; display: inline; width: </xsl:text><xsl:value-of select="perct_incomplete"/><xsl:text>%;</xsl:text>
						</xsl:attribute>
					</div>
				</div>
				<xsl:if test="//page_code[. != 'P_TRACTUS']">
					<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
						<xsl:attribute name="href">
							javascript:Map('<xsl:value-of select="//language" />',<xsl:value-of select="id_opus" />);
						</xsl:attribute>
						<span class="SMALL">
							<xsl:value-of select="//P_TRACTUS" />
						</span>
					</a>
				</xsl:if>
				<xsl:if test="//page_code[. != 'P_Nuntius']">
					<xsl:if test="//page_code[. != 'P_TRACTUS']">&#160;|&#160;</xsl:if>
					<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
						<xsl:attribute name="href">
							javascript:About('<xsl:value-of select="//language" />', '<xsl:value-of select="id_opus" />')
						</xsl:attribute>
						<span class="SMALL">
							<xsl:value-of select="//P_INDICIUM" />
						</span>
					</a>
				</xsl:if>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
