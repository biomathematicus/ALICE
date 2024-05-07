<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:include href="l_counter.xsl" />
	<xsl:template match="/">
		<html lang="EN">
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<body>
				<table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
					<tr valign="top">
						<td rowspan="3" valign="top">
							<!-- Insert left menu -->
							<xsl:apply-templates select="//left_menu" />
						</td>
						<td valign="top" width="100%">
							<!-- Insert header -->
							<xsl:apply-templates select="//top_menu" />
						</td>
						<td rowspan="3" valign="top">
							<!-- Insert right menu -->
							<xsl:apply-templates select="//right_menu" />
						</td>
					</tr>
					<tr>
						<td valign="top" height="350" align="left">
							<!-- ************ CONTENT BEGINS HERE ************ -->
							<table width="100%" border="0" cellpadding="4" cellspacing="0">
								<tr>
									<td id="ALICE" width="50%" valign="top">
										<!-- ******************* Area for "What is ALICE?" *******************  -->
										<div id="T_DEFINITION">
											<xsl:value-of select="//T_DEFINITION" disable-output-escaping="yes" />
										</div>
										<script>MarkdownToHtml('T_DEFINITION');</script>
									</td>
									<td width="50%" valign="top">
										<!-- ******************* Area for "Introduction" ******************* -->
										<div id="T_INTRODUCTION">
											<xsl:value-of select="//T_INTRODUCTION" disable-output-escaping="yes" />
										</div>
										<script>MarkdownToHtml('T_INTRODUCTION');</script>
									</td>
								</tr>
								<xsl:if test="//user_logon != 'LOGGED-OFF'">
									<tr>
										<td valign="top">
											<!-- ******************* Area for "Last Course Visited" ******************* -->
											<xsl:if test ="//opus_long != ''" >
											<H1>
												<xsl:value-of select="//L_RECOMMENDED" />
											</H1>
											<!-- Page Status-->
											<xsl:apply-templates select="/doc/recommended/page_counter" />
											<div id="RECOMMENDED_READING">
												<xsl:value-of select="/doc/recommended/page_counter/opus_long" />
												<!-- disable-output-escaping="yes"  -->
											</div>
											<script>MarkdownToHtml('RECOMMENDED_READING');</script>
											&#160;
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">
													javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="/doc/recommended/page_counter/id_opus" />','<xsl:value-of select="/doc/recommended/id_pagina" />');
												</xsl:attribute>
												<xsl:value-of select="//L_MORE" />
											</a>
											</xsl:if>
										</td>
										<td  valign="top">
											<!-- ******************* Area for "Last Page Visited" ******************* -->
											<xsl:if test ="//pagina_tag != ''" >
											<h1>
												<xsl:value-of select="//L_LAST_VISITED" />
											</h1>
											<!-- Page Status-->
											<!-- xsl:apply-templates select="/doc/recommended/page_counter" / -->
											<!--b>
												<xsl:value-of select="//ds_opus" />
											</b>
											<br / -->
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">
													javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="/doc/recommended/page_counter/id_opus" />','<xsl:value-of select="/doc/recommended/page_counter/id_pagina" />');
												</xsl:attribute>
												<b>
													<xsl:value-of select="/doc/recommended/ds_pagina" />
												</b>
												<!-- xsl:if test="last[. = 'true']"></xsl:if -->
											</a>
											<br />
											<div id="LAST_PAGE_VISITED">
												<xsl:value-of select="/doc/recommended/pagina_tag" />
											</div>
											<script>MarkdownToHtml('LAST_PAGE_VISITED');</script>
											&#160;
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">
													javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="/doc/recommended/page_counter/id_opus" />','<xsl:value-of select="/doc/recommended/page_counter/id_pagina" />');
												</xsl:attribute>
												<xsl:value-of select="//L_MORE" />
											</a>
											</xsl:if>
										</td>
									</tr>
								</xsl:if>
							</table>
							<!-- ************   CONTENT  ENDS  HERE ************ -->
						</td>
					</tr>
					<tr>
						<td align="center">
							<!-- Insert footer -->
							<xsl:apply-templates select="//footer" />
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
