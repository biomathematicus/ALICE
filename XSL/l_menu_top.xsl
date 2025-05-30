<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="top_menu">
		<xsl:variable name="separator">
			<td class='BAR_OFF'>
				<div class='BAR_MENU'>|</div>
			</td>
			<!-- xsl:copy-of select="$separator" / -->
		</xsl:variable>
		<!-- Session Forms -->

		<script></script>
		<form id="frmSession" method="post" name="frmSession" action="">
			<!-- User ID -->
			<input type="hidden" name="user_logon">
				<xsl:attribute name="value">
					<xsl:value-of select="//user_logon" />
				</xsl:attribute>
			</input>
			<!-- Cohort -->
			<input type="hidden" name="id_chorus">
				<xsl:attribute name="value">
					<xsl:value-of select="//id_chorus" />
				</xsl:attribute>
			</input>
			<!-- Language -->
			<input type="hidden" name="language">
				<xsl:attribute name="value">
					<xsl:value-of select="//language" />
				</xsl:attribute>
			</input>
			<!-- Opus_type -->
			<input type="hidden" name="opus_type">
				<xsl:attribute name="value">
					<xsl:value-of select="//opus_type" />
				</xsl:attribute>
			</input>
			<!-- Opus_id -->
			<input type="hidden" name="opus_id">
				<xsl:attribute name="value">
					<xsl:value-of select="//opus_id" />
				</xsl:attribute>
			</input>
			<!-- collaboratorium_id -->
			<input type="hidden" name="collaboratorium_id">
				<xsl:attribute name="value">
					<xsl:value-of select="//collaboratorium_id" />
				</xsl:attribute>
			</input>
			<!-- ACTION -->
			<input type="hidden" name="hAction" />
		</form>

		<!-- Begins header table -->
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
			<tr valign="middle">
				<td width="1%" valign="top">
					<img alt="Logo" border="0" width="240" id="Logo_id" src="../images/system/logo_ALICE.png" />
				</td>
				<td align="right" valign="middle" class="MEDIUM">
					<form method="post" name="frmQuaestio" id="frmQuaestio">
						<xsl:attribute name="action">
							quaestio.aspx?lng=
							<xsl:value-of select="//language" />
						</xsl:attribute>
						<input type="hidden" name="language">
							<xsl:attribute name="value">
								<xsl:value-of select="//language" />
							</xsl:attribute>
						</input>
						<input type="hidden" name="user_logon">
							<xsl:attribute name="value">
								<xsl:value-of select="//user_logon" />
							</xsl:attribute>
						</input>
						<input size="10" maxlength="50" type="text" id="txtSearch" name="txtSearch" />
						<input type="button" name="cmdSubmit" id="cmdSubmit">
							<xsl:attribute name="onClick">Search()</xsl:attribute>
							<xsl:attribute name="onKeyPress">Search()</xsl:attribute>
							<xsl:attribute name="value">
								<xsl:value-of select="//L_SEARCH" />
							</xsl:attribute>
						</input>
						<BR />
						<!-- User information -->
						<xsl:choose>
							<!--<xsl:when test="//user_logon[. != '']">-->
							<xsl:when test="//user_logon !='LOGGED-OFF'">
								<span class="BOLDMEDIUM">
									<xsl:value-of select="//L_USER" />
									:
								</span>
								<xsl:value-of select="//user_name" />
								&#160;
								(
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href">../src/secretus.aspx?logout=1</xsl:attribute>
									<span class="MEDIUM"><xsl:value-of select="//L_LOGOUT" /></span>
								</a>
								)<BR />
							</xsl:when>
							<xsl:otherwise>
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href">javascript:document.frmSession.action='../src/Secretus.aspx?lng=<xsl:value-of select="/doc/param/language" />&amp;FPage=../src/<xsl:value-of select="//page_name" />';document.frmSession.submit();</xsl:attribute>
									<span class="MEDIUM"  id="exist1"><xsl:value-of select="//L_OLD_USER" /></span>
								</a>
								<!-- |
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href">javascript:document.frmSession.action='../src/register.aspx';document.frmSession.submit();</xsl:attribute>
									<span class="MEDIUM"  id="new1"><xsl:value-of select="//L_NEW_USER" /></span>
								</a>
								-->
								<BR />
							</xsl:otherwise>
						</xsl:choose>
						<!-- Change Language -->
						<xsl:choose>
							<xsl:when test="//language[. != 'HISPANIA']">
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href"><xsl:value-of select="//page_name" />?lng=HISPANIA&#38;opus=<xsl:value-of select="//id_opus" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;nuntius=<xsl:value-of select="//cd_nuntius" />&#38;artifex=<xsl:value-of select="//artifex_id" /></xsl:attribute>
									<img src="../images/system/lang_spanish.gif" alt="Castellano" width="17" height="11" border="0" />
									&#160;
									<span CLASS="MEDIUM">Castellano</span>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
									<xsl:attribute name="href"><xsl:value-of select="//page_name" />?lng=BRITANNIA&#38;opus=<xsl:value-of select="//id_opus" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;nuntius=<xsl:value-of select="//cd_nuntius" />&#38;artifex=<xsl:value-of select="//artifex_id" /></xsl:attribute>
									<img src="../images/system/lang_english.gif" alt="English" width="17" height="11" border="0" />
									&#160;
									<span class="MEDIUM">English</span>
								</a>
							</xsl:otherwise>
						</xsl:choose>
					</form>
					<xsl:if test="//L_OLD_USER = ''">
						<form id="frmLogin" method="post" action="">
							<table border="0" cellpadding="2" width="100%" align="left">
								<input type="hidden" name="hAction" value="logout" />
								<input type="submit" name="btnSubmit" value="logout" />
							</table>
						</form>
					</xsl:if>
				</td>
			</tr>
			<!-- Ends Header Table -->
		</table>
		<!-- Toolbar Table Starts -->
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td>&#160;</td>
				<!-- P_INITIUM -->
				<xsl:choose>
					<xsl:when test="//P_INITIUM[@selected[. = 'true']]">
						<td class='BAR_OFF' align="center" nowrap="true" width="20%">
							<span class='BAR_MENU'>
								<span class="MEDIUM">
									<xsl:value-of select="//P_INITIUM" />
								</span>
							</span>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class='TAG' align="center" nowrap="true" width="20%">
							<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
								<xsl:attribute name="href">javascript:document.frmSession.action='../src/Initium.aspx?lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
								<span class='MEDIUM'><xsl:value-of select="//P_INITIUM" /></span>
							</a>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td>&#160;</td>
				<!-- P_INDEX -->
				<xsl:if test="//user_logon != 'LOGGED-OFF'">
				<xsl:choose>
					<xsl:when test="//P_INDEX[@selected[. = 'true']]">
						<td class='BAR_OFF' align="center" nowrap="true" width="20%">
							<span class='BAR_MENU'>
								<span class="MEDIUM">
									<xsl:value-of select="//P_INDEX" />
								</span>
							</span>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class='TAG' align="center" nowrap="true" width="20%">
							<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
								<xsl:attribute name="href">javascript:document.frmSession.action='../src/Index.aspx?lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
								<span class='MEDIUM'><xsl:value-of select="//P_INDEX" /></span>
							</a>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:if>
				<!-- sa_menu -->
				<xsl:if test="//user_logon != ''">
				<td>&#160;</td>
					<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
						<xsl:choose>
							<xsl:when test="//sa_menu[@selected[. = 'true']]">
								<td class='BAR_OFF' align="center" nowrap="true" width="20%">
									<span class='BAR_MENU'>
										<span class="MEDIUM">
											<xsl:value-of select="//user_role_name" />
										</span>
									</span>
								</td>
							</xsl:when>
							<xsl:otherwise>
								<td class='TAG' align="center" nowrap="true" width="20%">
									<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
										<xsl:attribute name="href">javascript:document.frmSession.action='../admin/sa_menu.aspx?lng=<xsl:value-of select="//language" />';document.frmSession.submit();</xsl:attribute>
										<span class='MEDIUM'><xsl:value-of select="//user_role_name" /></span>
									</a>
								</td>
							</xsl:otherwise>
						</xsl:choose>
						<td>&#160;</td>
					</xsl:if>
				</xsl:if>
				<!-- P_INDICIUM -->
				<xsl:choose>
					<xsl:when test="//P_INDICIUM[@selected[. = 'true']]">
						<td class='BAR_OFF' align="center" nowrap="true" width="20%">
							<span class='BAR_MENU'>
								<span class="MEDIUM">
									<xsl:value-of select="//P_INDICIUM" />
								</span>
							</span>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class='TAG' align="center" nowrap="true" width="20%">
							<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
								<xsl:attribute name="href">javascript:document.frmSession.action='../src/Nuntius.aspx?lng=<xsl:value-of select="//language" />&#38;nuntius=T_ABOUT';document.frmSession.submit();</xsl:attribute>
								<span class='MEDIUM'><xsl:value-of select="//P_INDICIUM" /></span>
							</a>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td>&#160;</td>
			</tr>
			<!-- Ends Tabs Table-->
		</table>
		<div class="line" />
	</xsl:template>
</xsl:stylesheet>
