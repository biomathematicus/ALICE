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
    <link href="../common/vis-network.min.css" rel="stylesheet" type="text/css" />
	<style>
		.hidden {
		visibility: hidden;
		display: none;
		}
		.visible {
		visibility: visible;
		display: block;
		}
		#container img {
		display: block;
		margin-left: auto;
		margin-right: auto;
		}
	</style>
	<body>
		<script language="JavaScript" type="text/JavaScript" src="../src/Pagina_Top.js"></script>
		<xsl:if test="//user_logon !='LOGGED-OFF'">
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
				<td valign="top" height="350" CLASS="MEDIUM" align="left">
					<!-- ************ BEGINS CONTENT ************ -->
					<!-- Breadcrumbs Begin -->
					<table>
						<tr>
							<td style="white-space: nowrap">
								<a>
									<xsl:attribute name="href">initium.aspx?lng=<xsl:value-of select="//language" /></xsl:attribute>
									<span class="MEDIUM">
										<xsl:value-of select="//P_INITIUM" />
									</span>
								</a>
								<B>&#62;</B>
								<a>
									<xsl:attribute name="href">index.aspx?lng=<xsl:value-of select="//language" /></xsl:attribute>
									<span class="MEDIUM">
										<xsl:value-of select="//P_INDEX" />
									</span>
								</a>
								<B>&#62;</B>
								<a>
									<xsl:attribute name="href">
										javascript:Map('<xsl:value-of select="//language" />',<xsl:value-of select="//id_opus" />);
									</xsl:attribute>
									<span class="MEDIUM">
										<xsl:value-of select="//ds_opus" />
									</span>
								</a>
								<B>&#62;</B>
								<span class="BOLDMEDIUM">
									<xsl:value-of select="//pag_title" />
									<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
										<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
											<xsl:attribute name="href">
												javascript:document.frmSession.action='../admin/sa_pagina_dtl.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
											</xsl:attribute>
											&#x1F58D; <!-- Edit icon: &#9998 (U+270E) or &#9999 (U+270F) or red crayo   &#x1F58D (U+1F58D) -->
										</a>
									</xsl:if>
								</span>								
							</td>
							<td width="80%"></td>
						</tr>
					</table>
					<!-- Breadcrumbs End -->
					<form name="p_pagina" id ="p_pagina" method="post" action="">
						<xsl:variable name="id_user_login" select="//user_logon" />
						<xsl:variable name="log_off" select="iob" />
						<!-- xsl:if test="//user_logon = 'LOGGED-OFF'"><h2><xsl:value-of select="//pag_title" /></h2></xsl:if -->
						<table border="0" cellpadding="2" width="100%">
							<tr>
								<td colspan="2">
									<!-- Begin tabulated menu  -->
									<div class="container">
										<div class="table-wrapper">
											<table border="0" cellspacing="3" cellpadding="3" id="tblTab" name="tblTab" style="table-layout: fixed;">
												<tr>
												<!-- background="../images/system/bgd_tab_80x20.gif"  &#160;  -->
													<td id="tabIntro" class="TabOn" width="74" background="../images/system/bgd_tab_80x20.gif" >
														<a href="javascript:LoadTab('Intro')"><xsl:value-of select="//TAB_INTRO" /></a>
													</td>
													<!-- _____________________ -->
													<xsl:if test="//ds_wiki != ''">
													<td id="tabWiki" class="TabOff" width="74" background="../images/system/bgd_tab_80x20.gif"  >
														<a href="javascript:LoadTab('Wiki');"><xsl:value-of select="//TAB_WIKI" /></a>
													</td>
													</xsl:if>
													<!-- _____________________ -->
													<xsl:if test="//ds_pdf != ''">										
													<td width="74" id="tabPDF" class="TabOff" background="../images/system/bgd_tab_80x20.gif"  >
														<a href="javascript:LoadTab('PDF');"><xsl:value-of select="//TAB_PDF" /></a>
													</td>
													</xsl:if>
													<!-- _____________________ -->
													<xsl:if test="//ds_youtube != ''">
														<td width="74" id="tabMedia" class="TabOff" background="../images/system/bgd_tab_80x20.gif"  >
														<a href="javascript:LoadTab('Media');"><xsl:value-of select="//TAB_MEDIA" /></a>
													</td>
													</xsl:if>
													<!-- _____________________ -->
													<!-- td width="74" id="tabGraph" class="TabOff" background="../images/system/bgd_tab_80x20.gif" >
														<a href="javascript:LoadTab('mynetwork');"><xsl:value-of select="//TAB_MAPPA"/></a>
													</td -->
													<!-- _____________________ -->
													<td width="74" id="tabGenAI" class="TabOff" background="../images/system/bgd_tab_80x20.gif"  >
														<a href="javascript:LoadTab('GenAI');">GenAI</a>
													</td>
													<!-- _____________________ -->
													<td width="74" id="tabTest" class="TabOff" background="../images/system/bgd_tab_80x20.gif"  >
														<a href="javascript:LoadTab('Test');"><xsl:value-of select="//TAB_SCRUTINIUM"/></a>
													</td>
												</tr>
											</table>
										</div>
										<div class="counter">
											<xsl:apply-templates select="//page_counter" >
												<xsl:with-param name="ShowTitle" select="'NO'" />
											</xsl:apply-templates>
										</div>
									</div>
									<div class="line" />
									<!-- End tabulated menu -->
									<div id="material" style="width: 800px;">
										<div id="container"></div>
										<div id="Wiki" style="visibility:hidden; display:none; width: 800px;"></div>
										<div id="PDF" style="visibility:hidden; display:none; width: 800px;"></div>
										<div id="LiveScribe" style="visibility:hidden; display:none; width: 800px;"></div>
										<div id="Media" style="visibility:hidden; display:none; width: 800px;"></div>
										<div id="Source" style="visibility:hidden; display:none; width: 800px;"></div>
										<div id="PDF1" style="width: 800px;"></div>
										<div id="GenAI"  style="visibility:hidden; display:none; width: 800px;">
											<iframe id="GenAIFrame" style="width: 100%; height: 450px; border: none;">
												<xsl:attribute name="src">../OAI/agents.html?opus=<xsl:value-of select="//id_opus" />&#38;pagina=<xsl:value-of select="/doc/id_pagina"/>&#38;symbolum=<xsl:value-of select="//symbolum"/></xsl:attribute>
											</iframe>
											<a>
												<xsl:attribute name="href">../OAI/agents.html?opus=<xsl:value-of select="//id_opus"/>&#38;pagina=<xsl:value-of select="/doc/id_pagina"/>&#38;symbolum=<xsl:value-of select="//symbolum"/></xsl:attribute>
												../OAI/oaiAgent.html?opus=<xsl:value-of select="//id_opus" />&#38;pagina=<xsl:value-of select="/doc/id_pagina"/>	
											</a>
										</div>	
										<div id="Intro"  style="visibility:hidden; display:none; width: 800px;">
											<br />
											<!-- 
											<The next lesson is :
											<a id="herf_next_lesson">
												<xsl:attribute name="href">javascript:redirect_pagina('<xsl:value-of select="//language" />', '<xsl:value-of select="//id_opus" />',next_lesson_)</xsl:attribute>
												<xsl:value-of select="//next_lesson" />
											</a>
											<br />			
											-->								
											<xsl:for-each select="/doc/syllabus/prereq">
												<xsl:choose>
													<xsl:when test="(am_grade &gt; 79)">
														<img src="../images/system/ico_visited_grad.gif"  width="16">
															<xsl:attribute name="alt">
																<xsl:value-of select="//L_VISITED" />
															</xsl:attribute>
														</img>
													</xsl:when>
													<xsl:when test="(am_grade &gt; 0) and (am_grade &lt; 80)">
														<img src="../images/system/ico_visited.gif" width="16">
															<xsl:attribute name="alt">
																<xsl:value-of select="//L_VISITED" />
															</xsl:attribute>
														</img>
													</xsl:when>
													<xsl:otherwise>
														<img src="../images/system/ico_visited_not.gif"  width="14">
															<xsl:attribute name="alt">
																<xsl:value-of select="//L_VISITED_NOT" />
															</xsl:attribute>
														</img>
													</xsl:otherwise>
												</xsl:choose>
												&#160;&#160;
												<xsl:value-of select="id_prereq" />
												-
												<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
													<xsl:attribute name="href">javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="id_prereq" />')
													</xsl:attribute>
													<xsl:value-of select="ds_prereq" />
												</a>
												<br />
											</xsl:for-each>
											<!-- =========================================== -->
											<div id="divLESSON">
												<xsl:value-of select="//pag_content"  disable-output-escaping="yes" />
											</div>
											<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
											<textarea name="txtLESSON" cols="90" rows="10" wrap="VIRTUAL">
												<xsl:value-of select="//pag_content" />
											</textarea>
											<br />
											<button id="saveLESSON"  style="display:none;">
												<xsl:attribute name="onclick">
													javascript:setAJAXAction('LESSON');LESSON('<xsl:value-of select="//id_opus"/>', '<xsl:value-of select="/doc/id_pagina"/>', '<xsl:value-of select="//language" />', 'LESSON');renderMarkdown('txtLESSON','divLESSON','renderLESSON','editLESSON');;hideButton('saveLESSON');
												</xsl:attribute>
												Save
											</button>
											<button id="renderLESSON" type="button"  onclick="renderMarkdown('txtLESSON','divLESSON','renderLESSON','editLESSON');hideButton('saveLESSON');">Render markdown</button>
											<button id="editLESSON" type="button"  onclick="editMarkdown('txtLESSON','divLESSON','renderLESSON','editLESSON');showButton('saveLESSON');" >Edit markdown</button>
											</xsl:if>
											<script>
												MarkdownToHtml('divLESSON');
												<xsl:if test="//ds_pdf != ''">
													LoadPDF('<xsl:value-of select="//ds_pdf"/>');
												</xsl:if>
												<xsl:if test="//ds_wiki != ''">
													LoadWiki('<xsl:value-of select="//ds_wiki"/>');
												</xsl:if>
												<xsl:if test="//ds_youtube != ''">
													LoadMedia('<xsl:value-of select="//ds_youtube"/>');
												</xsl:if>
											</script>
										</div>
										<xsl:if test="//user_logon !='LOGGED-OFF'">
											<div id="Test" style="visibility:hidden; display:none;">
												<form id="frmUpload" runat="server">
													<input type="hidden" name="id_chorus" id ="id_chorus">
														<xsl:attribute name="value"><xsl:value-of select="//id_chorus" /></xsl:attribute>
													</input>
													<input type="hidden" name="id_opus" id ="id_opus">
														<xsl:attribute name="value"><xsl:value-of select="//id_opus" /></xsl:attribute>
													</input>
													<input type="hidden" name="id_pagina" id ="id_pagina">
														<xsl:attribute name="value"><xsl:value-of select="//id_pagina" /></xsl:attribute>
													</input>
													<input type="hidden" name="id_nauta" id ="id_nauta">
														<xsl:attribute name="value"><xsl:value-of select="//user_id" /></xsl:attribute>
													</input>
													<input id="state" type="hidden">
														<xsl:attribute name="value"><xsl:value-of select="//language" /></xsl:attribute>
													</input>
													<input id="actionAJAX" type="hidden" />
													<br />
													<!-- =========================================== -->
													<h2>Student Learning Outcomes:</h2>
													<div id="divSLO">
														<xsl:value-of select="//ds_slo"  disable-output-escaping="yes" />
													</div>
													<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
													<textarea name="txtSLO" cols="90" rows="10" wrap="VIRTUAL">
														<xsl:value-of select="//ds_slo" />
													</textarea>
													<br />
													<button id="saveSLO" style="display:none;">
														<xsl:attribute name="onclick">
															javascript:setAJAXAction('SLO');SLO('<xsl:value-of select="//id_opus"/>', '<xsl:value-of select="/doc/id_pagina"/>', '<xsl:value-of select="//language" />','SLO');renderMarkdown('txtSLO','divSLO','renderSLO','editSLO');hideButton('saveSLO');
														</xsl:attribute>
														Save
													</button>
													<button id="renderSLO" type="button"  onclick="renderMarkdown('txtSLO','divSLO','renderSLO','editSLO');hideButton('saveSLO');">Render markdown</button>
													<button id="editSLO" type="button"  onclick="editMarkdown('txtSLO','divSLO','renderSLO','editSLO');showButton('saveSLO');">Edit markdown</button>
													</xsl:if>
													<br />

													<!-- =========================================== -->
													<h2>Assessment:</h2>
													<div id="divASSESS">
														<xsl:value-of select="//ds_assess"  disable-output-escaping="yes" />
													</div>
													<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
													<textarea name="txtASSESS" cols="90" rows="10" wrap="VIRTUAL">
													<xsl:value-of select="//ds_assess" />
													</textarea>
													<br />
													<button id="saveASSESS"  style="display:none;">
														<xsl:attribute name="onclick">
															javascript:setAJAXAction('ASSESS');ASSESS('<xsl:value-of select="//id_opus"/>', '<xsl:value-of select="/doc/id_pagina"/>', '<xsl:value-of select="//language" />', 'ASSESS');renderMarkdown('txtASSESS','divASSESS','renderASSESS','editASSESS');;hideButton('saveASSESS');
														</xsl:attribute>
														Save
													</button>
													<button id="renderASSESS" type="button"  onclick="renderMarkdown('txtASSESS','divASSESS','renderASSESS','editASSESS');hideButton('saveASSESS');">Render markdown</button>
													<button id="editASSESS" type="button"  onclick="editMarkdown('txtASSESS','divASSESS','renderASSESS','editASSESS');showButton('saveASSESS');" >Edit markdown</button>
													</xsl:if>
													<br />
													<xsl:if test="//ds_survey[. != '']">
													<h2>Survey:</h2>
													<a>
														<xsl:attribute name="href">
															<xsl:value-of select="//ds_survey" />?userID=<xsl:value-of select="//user_id"/></xsl:attribute>
														<xsl:attribute name="target">_blank</xsl:attribute>
														Survey for this lesson
													</a>
													</xsl:if>
													<!-- =========================================== -->
													<h2>Student:</h2>
													<!-- Upload File Section -->
													(Bug: Upload works, but the control is not waiting till the upload finishes. Give it a few seconds and reload the page.)<br/>
													<input type="file" accept=".pdf" id="fileUploadButton"></input>
													<button id="btnUpload"  value="Upload PDF maximum 10 MB">
														<xsl:attribute name="onclick">javascript:setAJAXAction('UPLOAD');Upload('<xsl:value-of select="//id_chorus"/>', '<xsl:value-of select="//id_opus"/>', '<xsl:value-of select="/doc/id_pagina"/>', '<xsl:value-of select="//user_id"/>','UPLOAD');</xsl:attribute>
														Upload PDF maximum 10 MB
													</button> <br/>
													<!--input type="button" id="btnUpload" value="Upload Files">
														<xsl:attribute name="onclick">
															javascript:show(<xsl:value-of select="/doc/id_pagina" />,'<xsl:value-of select="//user_name" />',' ', '  ','<xsl:value-of select="//user_id" />','<xsl:value-of select="//id_opus" />' ,'<xsl:value-of select="/doc/cd_new_id" />' )
														</xsl:attribute>
													</input-->
													<div id="UploadMessage">
														<xsl:for-each select="//files/file">
															<div class="uploaded-file-entry"
																 data-url="{.}"
																 data-chorus="{//id_chorus}"
																 data-opus="{//id_opus}"
																 data-pagina="{/doc/id_pagina}"
																 data-user="{//user_id}">
																<a href="{.}" target="_blank">There is a document uploaded for this lesson</a>
																<button type="button">Delete</button>
															</div>
														</xsl:for-each>
													</div>

													<textarea name="txtSTUDENT" cols="90" rows="10" wrap="VIRTUAL">
														<xsl:value-of select="//ds_labor" />
													</textarea>

													<script type="text/javascript">
														document.querySelector('textarea[name="txtSTUDENT"]').addEventListener('keydown', function(event) {
														console.log('Key pressed:', event.key);
														});

														document.addEventListener('keydown', function(event) {
														if (event.target.name === 'txtSTUDENT') {
														console.log('Key pressed in textarea:', event.key);
														}
														});
													</script>

													<div id="divSTUDENT" style="display:none;">
														<xsl:value-of select="//ds_labor" />
													</div>
													<br />
													<button id="saveSTUDENT">
														<xsl:attribute name="onclick">
															javascript:setAJAXAction('STUDENT');Labor('<xsl:value-of select="//id_opus"/>', '<xsl:value-of select="/doc/id_pagina"/>', '<xsl:value-of select="//user_id"/>','STUDENT');renderMarkdown('txtSTUDENT','divSTUDENT','renderSTUDENT','editSTUDENT');
														</xsl:attribute>
														Save
													</button>
													<button id="renderSTUDENT" type="button"  onclick="renderMarkdown('txtSTUDENT','divSTUDENT','renderSTUDENT','editSTUDENT');">Render markdown</button>
													<button id="editSTUDENT" type="button"  onclick="editMarkdown('txtSTUDENT','divSTUDENT','renderSTUDENT','editSTUDENT');" style="display:none;">Edit markdown</button>
													<br />
	
													<!-- <xsl:choose><xsl:when test="//take='0'">  -->
													<!-- </xsl:when> </xsl:choose>   -->

													<!-- =========================================== -->
													<h2>Instructor: </h2>
													<xsl:choose>
														<xsl:when test="//take &gt;'0'">
															<!-- div>
																<a id="myLink" href="#"><xsl:attribute name="onclick">produce_add('<xsl:value-of select="//link_homework" />')</xsl:attribute>
																	<xsl:value-of select="//L_SEE_HM" />
																</a>
																<p>
																	<xsl:value-of select="//L_UPLOADED_HM" />
																</p>
															</div-->
														</xsl:when>
													</xsl:choose>
													<xsl:choose>
														<xsl:when test="//Grade_ &gt;'0'">
															<div>
																<p>
																	Grade :
																	<xsl:value-of select="//Grade_" />
																</p>
															</div>
														</xsl:when>
													</xsl:choose>
													<xsl:choose>
														<xsl:when test="//Comments_ !='false'">
															<div>
																<p>
																	Feedback :
																	<div id="InstructorComments">
																		<xsl:value-of select="//Comments_" />
																	</div>
																	<script>
																		MarkdownToHtml('InstructorComments');
																	</script>

																</p>
															</div>
														</xsl:when>
													</xsl:choose>

													<!--upload homework-->
													<!-- a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														<xsl:attribute name="href">
															javascript:document.frmSession.action='../src/upload.aspx?lng=<xsl:value-of select="//language" />&#38;pagina=<xsl:value-of select="//id_pagina" />&#38;opus=<xsl:value-of select="//id_opus" />';document.frmSession.hAction.value = 'ir_actualizar';document.frmSession.submit();
														</xsl:attribute>
														<xsl:value-of select="//L_SEE_SB_HM" />
													</a -->
													<!--upload homework-->
												</form>
											</div>
										</xsl:if>
									</div>
								</td>
							</tr>
						</table>
						<div id="adaptive">
							<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="2">
										<p>&#160;</p>
									</td>
								</tr>
								<xsl:if test="//pending_prereq = '0'">
									<xsl:if test="/doc/pending/link[. != '']">
										<tr>
											<td align="left" CLASS="TITLE_LIGHT" colspan="2">
												<span class="BOLDMEDIUM">
													<xsl:value-of select="//L_LINK_PENDING" disable-output-escaping="yes" />
												</span>
											</td>
										</tr>
										<tr>
											<td align="left"  CLASS="MEDIUM" colspan="2">
												<xsl:for-each select="/doc/pending/link">
													<xsl:value-of select="score" />
													%&#160;
													<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
														<xsl:attribute name="href">
															javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="id_pagina" />');
														</xsl:attribute>
														<xsl:value-of select="ds_title" />
													</a>
													<br />
													<xsl:value-of select="ds_tag" />
													<br />
													<br />
												</xsl:for-each>
											</td>
										</tr>
									</xsl:if>
								</xsl:if>
								<xsl:if test="//cd_opus != 'LITERATRONIC'">
									<tr>
										<td align="left" CLASS="TITLE_LIGHT" width="50%">
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">
													javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_prv" />');
												</xsl:attribute>
												<xsl:value-of select="//L_PREVIOUS" />
											</a>
										</td>
										<td align="right" CLASS="TITLE_LIGHT" width="50%">
											<a onFocus="window.status=''; return true;"  onBlur="window.status=''; return true;">
												<xsl:attribute name="href">
													javascript:Page('<xsl:value-of select="//language" />','<xsl:value-of select="//id_opus" />','<xsl:value-of select="//pag_nxt" />');
												</xsl:attribute>
												<xsl:value-of select="//L_NEXT" />
											</a>
										</td>
									</tr>
								</xsl:if>
							</table>
						</div>
						<div id="choose_category">
							<xsl:variable name="selectedCategory" select="//id_category_interest_base" />
							<p>Select your area of emphasis:
								<select name ="pagina_cat" title="Area of emphasis" id="pagina_cat_id" onchange="update_map()">
									<xsl:for-each select="/doc/labels/label">
										<option value="{id_opus_category}">
											<xsl:if test="string($selectedCategory) = string(id_opus_category)">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="id_opus_label"/>
										</option>
									</xsl:for-each>
								<xsl:attribute name="onclick"></xsl:attribute>
							</select>
							</p>
						</div>
						<div id="mynetwork"></div>
					</form>
					<div id="captions1">
						<xsl:for-each select="/doc/pagina_sec">
							<input type="hidden">
								<xsl:attribute name="value">
									<xsl:value-of select="pagina_title" />
								</xsl:attribute>
								<xsl:attribute name="name">
									<xsl:value-of select="id" />
								</xsl:attribute>
								<xsl:attribute name="id">
									<xsl:value-of select="id_cap" />
								</xsl:attribute>
							</input>
						</xsl:for-each>
					</div>
					<p />
					<!-- =========================================== -->
					<script  type="text/javascript">
						<xsl:if test="//user_role_code = 'ADMIN' or //user_role_code = 'AUTHOR' or //user_role_code = 'UNIT'">
							renderMarkdown('txtLESSON','divLESSON','renderLESSON','editLESSON');
							renderMarkdown('txtSLO','divSLO','renderSLO','editSLO');
							renderMarkdown('txtASSESS','divASSESS','renderASSESS','editASSESS');
						</xsl:if>
						<xsl:if test="//user_role_code = 'READER'">
							MarkdownToHtml('divSLO');
							MarkdownToHtml('divASSESS');
						</xsl:if>
						//document.write('<p>' + sHW + '</p>');
					</script>
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
	<xsl:if test="//user_logon ='LOGGED-OFF'">
		<script>
			window.location.href = 'Nuntius.aspx?lng=<xsl:value-of select="//language" />&#38;nuntius=T_UNAUTHORIZED'
		</script>
	</xsl:if>

	<script language="JavaScript" type="text/JavaScript" src="../src/Pagina_Bottom.js"></script>
	<script>LoadTab("Intro");</script>

	</body>
</html>
</xsl:template>
</xsl:stylesheet>
