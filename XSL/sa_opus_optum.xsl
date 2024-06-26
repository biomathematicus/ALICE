<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="l_html_header.xsl" />
	<xsl:include href="l_menu_top.xsl" />
	<xsl:include href="l_menu_left.xsl" />
	<xsl:include href="l_menu_right.xsl" />
	<xsl:include href="l_footer.xsl" />
	<xsl:template match="/">
		<html>
			<!-- Insert HTML header -->
			<xsl:apply-templates select="//html_header" />
			<body>
				<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
					<table width="800px" align="center" border="0" cellpadding="0" cellspacing="0" id="tblMain" name="tblMain">
						<tr valign="top">
							<td rowspan="3" valign="top" class='BAR_OFF'>
								<!-- Insert left menu -->
								<xsl:apply-templates select="//left_menu" />
							</td>
							<td valign="top" width="100%">
								<!-- Insert header -->
								<xsl:apply-templates select="//top_menu" />
							</td>
							<td rowspan="3" valign="top" class='BAR_OFF'>
								<!-- Insert right menu -->
								<xsl:apply-templates select="//right_menu" />
							</td>
						</tr>
						<tr>
							<td valign="top" height="350" CLASS="CONTENT">
								<!-- ************ BEGINS CONTENT ************ -->
								<!-- Breadcrumbs Begin -->
								<a>
									<xsl:attribute name="href">sa_menu.aspx?lng=<xsl:value-of select="//language" /></xsl:attribute>
									<xsl:value-of select="//user_role_name" />
								</a>
								&#62;
								<!-- xsl:if test="//user_status = 3">
									<a>
										<xsl:attribute name="href">
											sa_artifex_lst.aspx?lng=
											<xsl:value-of select="//language" />
										</xsl:attribute>
										<xsl:value-of select="//sa_artifex_lst" />
									</a>
									&#62;
								</xsl:if -->
								<a>
									<xsl:attribute name="href">javascript:document.frmSession.action='sa_opus_lst.aspx?artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
									<xsl:value-of select="//sa_opus_lst" />
								</a>
								&#62;
								<b>									
									<xsl:value-of select="/doc/sa_opus_lst/opus/title" />
								</b>
								<p />
								<!-- Breadcrumbs End -->
								<!-- ======================================== -->
								<!-- Title Begins -->
								<h1>
									<xsl:value-of select="//id_opus" />. 
									<xsl:value-of select="/doc/sa_opus_lst/opus/title" />
								</h1>
								<!-- Title Ends -->
								<!-- ======================================== -->
								<!-- Course Detail Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_opus_dtl.aspx?opus=<xsl:value-of select="//id_opus" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="/doc/admin_tags/sa_opus_dtl" />
										</a>:
									</b>
									This option allows you to modify in multiple languages the details of each unit, including short and long description, and "About" text.
								</p>
								<!-- Course Detail Ends -->
								<!-- ======================================== -->
								<!-- Lesson List Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_pagina_lst.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="/doc/admin_tags/sa_pagina_lst" />
										</a>: 
									</b>
									This option allows you to edit the list of lessons (lexias), including the content, connections, and student learning outcomes
								</p>
								<!-- Lesson List Ends -->
								<!-- ======================================== -->
								<!-- Map Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_map.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="//L_MAP" />
										</a>:
									</b>
									This option allows you to edit the graph representation of the lessons.
								</p>
								<!-- Map Ends -->
								<!-- ======================================== -->
								<!-- Category Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_Category_lst.aspx?opus=<xsl:value-of select="//id_opus" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="//L_Category" />
										</a>:
									</b>
									This option allows you to enter the areas of interest/emphasis for students.
								</p>
								<!-- Category Ends -->
								<!-- ======================================== -->
								<!-- Student List Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_nauta_lst.aspx?opus=<xsl:value-of select="//id_opus" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />&#38;chorus=<xsl:value-of select="/doc/sa_opus_lst/opus/ds_chorus" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();</xsl:attribute>
											<xsl:value-of select="//sa_nauta_lst" />
										</a>: 
									</b>
									This option allows you to see the progress of students associated with the unit. 
								</p>
								<!-- Student List Ends -->
								<!-- ======================================== -->
								<!-- Calculus Begins -->
								<p>
									<b>
										<a>
											<xsl:attribute name="href">javascript:document.frmSession.action='sa_opus_dtl.aspx?opus=<xsl:value-of select="//id_opus"/>&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value='calcular';document.frmSession.submit();</xsl:attribute>
											CALCULUS
										</a>:
									</b>
									<xsl:value-of select="//T_CALCULUS" disable-output-escaping="yes"/>
								</p>
								<!-- Calculus Ends -->
								<!-- ======================================== -->
								<div style="align: right; display: inline; padding: 10px; width: 150px"  CLASS="TITLE_WARNING">
									<a>
										<xsl:attribute name="href">javascript:var result=confirm("Deletion is irreversible. Are you sure?");if (result){document.frmSession.action='sa_opus_dtl.aspx?opus=<xsl:value-of select="//id_opus" />&#38;artifex=<xsl:value-of select="//artifex_id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit()};</xsl:attribute>
										<xsl:value-of select="//L_DELETE" />
									</a>
								</div>
								<!-- TABLE OF WORKS >
								<table border="0" cellpadding="6" align="center">
									<xsl:for-each select="/doc/sa_opus_lst/opus">
										<tr>
											<td CLASS="TITLE_DARK">
												<xsl:value-of select="id" />
											</td>
											<td CLASS="TITLE_LIGHT">
												<xsl:value-of select="title" />
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_opus_dtl.aspx?opus=
														<xsl:value-of select="id" />
														&#38;artifex=
														<xsl:value-of select="//artifex_id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.hAction.value = 'calcular';document.frmSession.submit();
													</xsl:attribute>
													CALC
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_pagina_lst.aspx?opus=
														<xsl:value-of select="id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="/doc/admin_tags/sa_pagina_lst" />
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_opus_dtl.aspx?opus=
														<xsl:value-of select="id" />
														&#38;artifex=
														<xsl:value-of select="//artifex_id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="/doc/admin_tags/sa_opus_dtl" />
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_nauta_lst.aspx?opus=
														<xsl:value-of select="id" />
														&#38;artifex=
														<xsl:value-of select="//artifex_id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														&#38;chorus=
														<xsl:value-of select="ds_chorus" />
														';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="//sa_nauta_lst" />
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_map.aspx?opus=
														<xsl:value-of select="id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="//L_MAP" />
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">
														javascript:document.frmSession.action='sa_Category_lst.aspx?opus=
														<xsl:value-of select="id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.submit();
													</xsl:attribute>
													<xsl:value-of select="//L_Category" />
												</a>
											</td>
											<td width="20px">&#160;</td>
											<td CLASS="TITLE_WARNING">
												<a>
													<xsl:attribute name="href">
														javascript:var result=confirm("Deletion is irreversible");if (result){document.frmSession.action='sa_opus_dtl.aspx?opus=
														<xsl:value-of select="id" />
														&#38;artifex=
														<xsl:value-of select="//artifex_id" />
														&#38;lng=
														<xsl:value-of select="//language" />
														';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit()};
													</xsl:attribute>
													<xsl:value-of select="//L_DELETE" />
												</a>
											</td>
										</tr>
									</xsl:for-each>
									<tr>
										<td CLASS="TITLE_DARK" ALIGN="right" COLSPAN="8">
											<input type="button">
												<xsl:attribute name="onclick">
													javascript:document.frmSession.action='sa_opus_dtl.aspx?opus=0&#38;artifex=
													<xsl:value-of select="//art

ifex_id" />
													&#38;lng=
													<xsl:value-of select="//language" />
													';document.frmSession.hAction.value = 'ir_agregar';document.frmSession.submit();
												</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="//L_NEW" />
												</xsl:attribute>
											</input>
										</td>
									</tr>
								</table -->
								<!-- ************  ENDS CONTENT  ************ -->
							</td>
						</tr>
						<tr>
							<td align="center">
								<!-- Insert footer -->
								<xsl:apply-templates select="//footer" />
							</td>
						</tr>
					</table>
				</xsl:if>
				<!-- *********************************************************************************************** -->

				<!-- *********************************************************************************************** -->
				<xsl:if test="//user_status = 2">
					<table width="600" align="center" border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td rowspan="3" valign="top" class='BAR_OFF'>
								<!-- Insert left menu -->
								<xsl:apply-templates select="//left_menu" />
							</td>
							<td valign="top" width="100%">
								<!-- Insert header -->
								<xsl:apply-templates select="//top_menu" />
							</td>
							<td rowspan="3" valign="top" class='BAR_OFF'>
								<!-- Insert right menu -->
								<xsl:apply-templates select="//right_menu" />
							</td>
						</tr>
						<tr>
							<td valign="top" height="350" CLASS="CONTENT">
								<!-- ************ BEGINS CONTENT ************ -->
								<!-- Breadcrumbs -->
								<a>
									<xsl:attribute name="href">
										sa_menu.aspx?lng=
										<xsl:value-of select="//language" />
									</xsl:attribute>
									<xsl:value-of select="//sa_menu" />
								</a>
								&#62;
								<xsl:if test="//user_status = 2">
									<a>
										<xsl:attribute name="href">sa_artifex_lst.aspx?lng=<xsl:value-of select="//language" /></xsl:attribute>
										<xsl:value-of select="//sa_artifex_lst" />
									</a>
									&#62;
								</xsl:if>
								<b>
									<xsl:value-of select="//sa_opus_lst" />
								</b>
								<p />

								<!-- TABLE OF WORKS -->
								<table border="0" cellpadding="6" align="center">
									<tr>
										<td colspan="6" CLASS="TITLE_DARK">
											<b>
												<xsl:value-of select="//sa_opus_lst" />
											</b>
										</td>
									</tr>
									<xsl:for-each select="/doc/sa_opus_lst/opus_reader">
										<tr>
											<td CLASS="TITLE_DARK">
												<xsl:value-of select="id" />
											</td>
											<td CLASS="TITLE_LIGHT">
												<xsl:value-of select="title" />
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">javascript:document.frmSession.action='sa_map.aspx?opus=<xsl:value-of select="id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.hAction.value = 'ir_borrar';document.frmSession.submit();</xsl:attribute>
													<xsl:value-of select="//L_MAP" />
												</a>
											</td>
											<td CLASS="TITLE_LIGHT">
												<a>
													<xsl:attribute name="href">javascript:document.frmSession.action='sa_Category_lst.aspx?opus=<xsl:value-of select="id" />&#38;lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
													<xsl:value-of select="//L_Category" />
												</a>
											</td>
											<td width="20px">&#160;</td>
										</tr>
									</xsl:for-each>
									<tr></tr>
								</table>
								<!-- ************  ENDS CONTENT  ************ -->
							</td>
						</tr>
						<tr>
							<td align="center">
								<!-- Insert footer -->
								<xsl:apply-templates select="//footer" />
							</td>
						</tr>
					</table>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
