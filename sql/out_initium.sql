USE [ALICE_DEVELOPMENT]
GO
/****** Object:  StoredProcedure [dbo].[out_Initium]    Script Date: 8/17/2021 9:08:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER   PROCEDURE [dbo].[out_Initium] 
@Language        varchar(15) = null,
@OpusType        varchar(15) = null,
@PageCode        varchar(15) = null,
@PageName        varchar(20) = null,
@UserID varchar(70) = null
AS

Begin
set nocount OFF

-- Create XML Table 
Create Table #xml (id int identity(1,1) not null,lines Varchar(8000)) 

-- Main tag
Insert Into #xml (lines) Values ('<?xml version="1.0" encoding="iso-8859-1"?><doc>')

-- SPECIFIC CONTENT FOR THIS PAGE
declare @id_nauta integer
select  @id_nauta = NAUTA.id_nauta from NAUTA where NAUTA.ds_login=@UserID

-- "Recommended" section: First, the last read page
if exists (select * from VIA where id_nauta = @id_nauta)  
begin
Insert Into #xml(lines)
	Select top 1 '<recommended><last>true</last>' + 
	'<id_pagina>' + rtrim(LINGUA_PAGINA.id_pagina) + '</id_pagina>' + 
	'<ds_title><![CDATA[' + rtrim(LINGUA_PAGINA.ds_title) + ']]></ds_title>' + 
	'<ds_tag><![CDATA[' + rtrim(LINGUA_PAGINA.ds_tag) + ']]></ds_tag>' + 
	'<page_counter>' + 
	'<id_pagina>' + rtrim(LINGUA_PAGINA.id_pagina) + '</id_pagina>' + 
/*	'<id_opus>' + rtrim(LINGUA_OPUS.id_opus) + '</id_opus>' + */
'<id_opus>' + rtrim(LINGUA_OPUS.id_opus) + '</id_opus>' + 
	'<cd_opus>' + rtrim(OPUS.cd_opus_type) + '</cd_opus>' + 
	'<ds_opus><![CDATA[' + rtrim(LINGUA_OPUS.ds_title) + ']]></ds_opus>' + 
	'<total_read>' + 
	rtrim(
		cast(
			Cast(
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR 
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</total_read>' + 
	'<perct_incomplete>' + 
	rtrim(
		cast( 
			Cast(   100 - 
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</perct_incomplete>' + 
		'<percentage_g>' + 
	rtrim(
		cast(
			Cast(
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR 
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus and Grade!='' 
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</percentage_g>' +
	
	'<percentage>' + 
	rtrim(
		cast(
			Cast(
				(( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)-				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  and Grade!=''
				))
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</percentage>' + 




	'</page_counter>' + 
	'</recommended>'
	from	LINGUA_PAGINA, VIA, LINGUA_OPUS, OPUS 
	where	LINGUA_PAGINA.id_pagina = VIA.id_pagina and
			LINGUA_PAGINA.id_opus = LINGUA_OPUS.id_opus and
			LINGUA_PAGINA.id_opus = VIA.id_opus and
			LINGUA_OPUS.cd_lingua = @Language and 
			LINGUA_PAGINA.cd_lingua = @Language and 
			in_visible = 1 and
			VIA.id_nauta = @id_nauta and
			OPUS.id_opus = LINGUA_OPUS.id_opus  
	order by VIA.dt_created DESC
end

----------------------------------------------------------------------------------------------------------------
-- "Recommended" section: A random book
Insert Into #xml(lines)
	Select top 1 '<randombook>' + 
	'<content><![CDATA[' + Char(9) + rtrim(ds_content) + Char(9) + ']]></content>' +
	'<page_counter>' + 
	'<id_pagina>' + case when (select top 1 id_pagina from VIA where id_nauta=@id_nauta and id_opus=LINGUA_OPUS.id_opus) is not null then cast((select top 1 id_pagina from VIA where id_nauta=@id_nauta and id_opus=LINGUA_OPUS.id_opus order by dt_created desc) as varchar(3)) else '1' end + '</id_pagina>' + 
	'<id_opus>' + rtrim(LINGUA_OPUS.id_opus) + '</id_opus>' + 
	'<cd_opus>' + rtrim(OPUS.cd_opus_type) + '</cd_opus>' + 
	'<ds_opus><![CDATA[' + rtrim(LINGUA_OPUS.ds_title) + ']]></ds_opus>' + 

	'<total_read>' + 
	rtrim(
		cast(
			Cast(
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</total_read>' + 
	'<perct_incomplete>' + 
	rtrim(
		cast( 
			Cast(   100 - 
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</perct_incomplete>' + 
	'</page_counter>' + 
	'</randombook>'
	from	LINGUA_OPUS, OPUS 
	where	LINGUA_OPUS.id_opus =  OPUS.id_opus  and
			cd_lingua = @Language and
			in_visible = 1 and LINGUA_OPUS.id_opus=28 and
			OPUS.cd_opus_type = 'LITERATRONIC' --and OPUS.id_opus = 1
	--order by NEWID()


---------------------------------------------------------------------------------------------------------------

-- "Recommended" section: A random book
Insert Into #xml(lines)
	Select top 1 '<randombook>' + 
	'<content><![CDATA[' + Char(9) + rtrim(ds_content) + Char(9) + ']]></content>' +
	'<page_counter>' + 
	'<id_pagina>' + case when (select top 1 id_pagina from VIA where id_nauta=@id_nauta and id_opus=LINGUA_OPUS.id_opus) is not null then cast((select top 1 id_pagina from VIA where id_nauta=@id_nauta and id_opus=LINGUA_OPUS.id_opus order by dt_created desc) as varchar(3)) else '1' end + '</id_pagina>' + 
	'<id_opus>' + rtrim(LINGUA_OPUS.id_opus) + '</id_opus>' + 
	'<cd_opus>' + rtrim(OPUS.cd_opus_type) + '</cd_opus>' + 
	'<ds_opus><![CDATA[' + rtrim(LINGUA_OPUS.ds_title) + ']]></ds_opus>' + 

	'<total_read>' + 
	rtrim(
		cast(
			Cast(
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</total_read>' + 
	'<perct_incomplete>' + 
	rtrim(
		cast( 
			Cast(   100 - 
				( -- Pages read
				select 	count(*) * 100
				from	dbo.LABOR  
				where	id_nauta = @id_nauta and
					id_opus = OPUS.id_opus  
				)
				/
				(-- Total number of pages in book
				select 	count(*) 
				from	LINGUA_PAGINA 
				where	cd_lingua = @Language and
					id_opus = OPUS.id_opus  
				)
				as integer
			) as char(3)
		)
	) + 
	'</perct_incomplete>' + 
	'</page_counter>' + 
	'</randombook>'
	from	LINGUA_OPUS, OPUS 
	where	LINGUA_OPUS.id_opus =  OPUS.id_opus  and
			cd_lingua = @Language and
			in_visible = 1 and LINGUA_OPUS.id_opus=33 and
			OPUS.cd_opus_type = 'LITERATRONIC' --and OPUS.id_opus = 1
	--order by NEWID()








-- Tags
Insert Into #xml(lines) exec litLabel @Language, 'L_MORE'
Insert Into #xml(lines) exec litLabel @Language, 'T_WHY_REGISTER'
Insert Into #xml(lines) exec litLabel @Language, 'T_INTRODUCTION'
Insert Into #xml(lines) exec litLabel @Language, 'T_DEFINITION'
Insert Into #xml(lines) exec litLabel @Language, 'T_DEFINITION_SAIL'
Insert Into #xml(lines) exec litLabel @Language, 'L_BOOK'
Insert Into #xml(lines) exec litLabel @Language, 'L_PAGE'
Insert Into #xml(lines) exec litLabel @Language, 'L_READ'
Insert Into #xml(lines) exec litLabel @Language, 'L_RECOMMENDED'
Insert Into #xml(lines) exec litLabel @Language, 'L_MORE'
Insert Into #xml(lines) exec litLabel @Language, 'L_LAST_VISITED'
Insert Into #xml(lines) exec litLabel @Language, 'L_Graded_'
Insert Into #xml(lines) exec litLabel @Language, 'L_pending'


-- Session State
Insert Into #xml(lines)
Execute litSessionState @Language, @OpusType, @PageCode, @PageName, @UserID, 1
print 'exec litSessionState ''' + @Language + ''',''' + @OpusType + ''',''' + @PageCode + ''',''' + @PageName + ''',''' + @UserID + ''', 1'

-- Top Menu
Insert Into #xml(lines)
Execute litTopMenu @Language, @PageCode, @UserID
-- Footer
Insert Into #xml(lines)
Execute litFooter @Language
-- Ends main tag
Insert Into #xml (lines) Values ('</doc>')

Select lines From #xml order by id 


END


