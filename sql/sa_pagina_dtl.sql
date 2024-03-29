USE [ALICE_DEVELOPMENT]
GO
/****** Object:  StoredProcedure [dbo].[sa_pagina_dtl]    Script Date: 8/16/2021 11:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER   PROCEDURE [dbo].[sa_pagina_dtl] 
	@Language       	varchar(15) = null,
	@OpusType       	varchar(15) = null,
	@PageCode       	varchar(15) = null,
	@PageName       	varchar(20) = null,
	@hAction		varchar(20) = null,
	@UserID			varchar(70) = null,
	@sCapston       varchar(10),
	@sStartLesson       varchar(10),
	@id_opus		integer,
	@id_pagina		integer,
	@am_link		integer,
	@ds_title_his		varchar(100) = null,
	@ds_tag_his		varchar(250) = null,
	@ds_content_his		varchar(7800) = null,
	@ds_title_bri		varchar(100) = null,
	@ds_tag_bri		varchar(250) = null,
	@sPaginaType		varchar(20) = null,
	@sPaginaCat		varchar(20) = null,
	@ds_content_bri		varchar(7800) = null

AS

Begin
set nocount OFF

-- Create XML Table 
Create Table #xml (id int identity(1,1) not null,lines Varchar(8000))	
-- Main tag
Insert Into #xml (lines) Values ('<?xml version="1.0" encoding="iso-8859-1"?><doc>')

   Insert Into #xml (lines) 
	SELECT  '<choose_capstone>'+  cast(id_capstone as varchar(10)) +'</choose_capstone>'
	from LINGUA_PAGINA  
	WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina=@id_pagina	 and LINGUA_PAGINA.cd_lingua= @Language


	   Insert Into #xml (lines) 
	SELECT  '<choose_start_point>'+  cast([ds_StartLesson] as varchar(10)) +'</choose_start_point>'
	from LINGUA_PAGINA  
	WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina=@id_pagina	 and LINGUA_PAGINA.cd_lingua= @Language

-- SPECIFIC ACTIONS IN THIS PAGE
if @hAction = 'Agregar'
	begin
	-- New item at the end. Button New on the list of items was pressed
	if @id_pagina = 0
		begin
		select @id_pagina = max(id_pagina) 
		from PAGINA 
		where id_opus = @id_opus
		if @id_pagina is null 
			select @id_pagina = 0 			
		end
	-- Insert between existing items
	else
		begin
		update PAGINA 
		set id_pagina = id_pagina + 1 
		where id_opus = @id_opus and id_pagina > @id_pagina
		update LINGUA_PAGINA 
		set id_pagina = id_pagina + 1 
		where id_opus = @id_opus and id_pagina > @id_pagina
		update VIA 
		set id_pagina = id_pagina + 1 
		where id_opus = @id_opus and id_pagina > @id_pagina
		update HISTORIA
		set id_pagina = id_pagina + 1 
		where id_opus = @id_opus and id_pagina > @id_pagina
		update MATRIX 
		set i = i + 1 
		where id_opus = @id_opus and i > @id_pagina
		update MATRIX 
		set j = j + 1 
		where id_opus = @id_opus and j > @id_pagina
		end
	-- At this point we have the correct row where the item will be updated
	insert into PAGINA (id_opus, id_pagina, am_link,ds_gui, pagina_type, pagina_cat)
	values (@id_opus, @id_pagina + 1, @am_link,NEWID(), @sPaginaType, @sPaginaCat)
	insert into LINGUA_PAGINA (id_opus, id_pagina, cd_lingua, ds_title, ds_tag, ds_content)
	values (@id_opus, @id_pagina + 1, 'HISPANIA', @ds_title_his, @ds_tag_his, @ds_content_his)
	insert into LINGUA_PAGINA (id_opus, id_pagina, cd_lingua, ds_title, ds_tag, ds_content)
	values (@id_opus, @id_pagina + 1, 'BRITANNIA', @ds_title_bri, @ds_tag_bri, @ds_content_bri)
	end
if @hAction = 'Actualizar'
	begin
	update PAGINA	 
	set		am_link = @am_link, pagina_type = @sPaginaType, pagina_cat = @sPaginaCat
	where	id_opus = @id_opus  and id_pagina = @id_pagina
	-- Español
	update LINGUA_PAGINA 
	set 	id_opus = @id_opus, 
		id_pagina = @id_pagina, 
		cd_lingua = 'HISPANIA', 
		ds_title = @ds_title_his,
		ds_tag = @ds_tag_his,
		ds_content = @ds_content_his
	where id_opus = @id_opus and cd_lingua = 'HISPANIA' and id_pagina = @id_pagina
	-- English
	update LINGUA_PAGINA 
	set 	id_opus = @id_opus, 
		id_pagina = @id_pagina, 
		cd_lingua = 'BRITANNIA', 
		ds_title = @ds_title_bri,
		ds_tag = @ds_tag_bri,
		ds_content = @ds_content_bri
	where id_opus = @id_opus and cd_lingua = 'BRITANNIA' and id_pagina = @id_pagina
	end
if @hAction = 'Borrar'
begin
	-- Delete the record in LINGUA_PAGINA
	delete from LINGUA_PAGINA
	where id_opus = @id_opus and id_pagina = @id_pagina
	-- Correct the page numbering in LINGUA_PAGINA
	update LINGUA_PAGINA 
	set id_pagina = id_pagina - 1 
	where id_opus = @id_opus and id_pagina > @id_pagina
	-- Delete from HISTORIA
	delete from HISTORIA 
	where id_opus = @id_opus and id_pagina = @id_pagina
	-- Correct the page numbering in HISTORIA
	update HISTORIA 
	set id_pagina = id_pagina - 1 
	where id_opus = @id_opus and id_pagina > @id_pagina
	-- Delete VIA
	delete from HISTORIA 
	where id_opus = @id_opus and id_pagina = @id_pagina
	-- Correct the page numbering in VIA
	update VIA 
	set id_pagina = id_pagina - 1 
	where id_opus = @id_opus and id_pagina > @id_pagina
	-- Delete the record in PAGINA
	delete from PAGINA
	where id_opus = @id_opus and id_pagina = @id_pagina
	-- Correct the page numbering in PAGINA
	update PAGINA 
	set id_pagina = id_pagina - 1 
	where id_opus = @id_opus and id_pagina > @id_pagina
	-- Delete the record in MATRIX
	delete from MATRIX
	where id_opus = @id_opus and ( i = @id_pagina or  j = @id_pagina) 
	-- Correct the page sequence in MATRIX
	update MATRIX 
	set i = i - 1 
	where id_opus = @id_opus and i > @id_pagina and cd_matrix_type='MCA'
	update MATRIX 
	set j = j - 1 
	where id_opus = @id_opus and j > @id_pagina and cd_matrix_type='MCA'
	-- Delete from MATRIX entries different to MCA
	delete from MATRIX where id_opus = @id_opus and cd_matrix_type<>'MCA'
end
if rtrim(@hAction) = 'ir_borrar'
	begin
	select @hAction = 'Borrar'
	end
if rtrim(@hAction) = 'ir_actualizar'
	begin
	select @hAction = 'Actualizar'
	end
if rtrim(@hAction) = 'ir_agregar'
	begin
	select @hAction = 'Agregar'
	end
if  rtrim(@sCapston) = 'true'
begin

UPDATE LINGUA_PAGINA
SET LINGUA_PAGINA.id_capstone=1
WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina= @id_pagina
 end

 
 if  rtrim(@sCapston) = 'false'
begin

UPDATE LINGUA_PAGINA
SET LINGUA_PAGINA.id_capstone=0
WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina= @id_pagina

DELETE FROM VIA
WHERE VIA.id_opus=@id_opus and VIA.id_pagina= @id_pagina and VIA.cd_type='capstone'

 end
 ---------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------
 if  rtrim(@sStartLesson) = 'true'
begin


UPDATE LINGUA_PAGINA
SET LINGUA_PAGINA.[ds_StartLesson]=0
WHERE  LINGUA_PAGINA.id_opus=@id_opus 

UPDATE LINGUA_PAGINA
SET LINGUA_PAGINA.[ds_StartLesson]=1
WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina= @id_pagina
 end

 
 if  rtrim(@sStartLesson) = 'false'
begin

UPDATE LINGUA_PAGINA
SET LINGUA_PAGINA.[ds_StartLesson]=0
WHERE  LINGUA_PAGINA.id_opus=@id_opus and LINGUA_PAGINA.id_pagina= @id_pagina

end
 ------------------------------------------------------------------------------------

 ---------------------------------------------------------------------------------------
 
-- Start content of the page

Insert Into #xml(lines)
	Execute litAdminTags @Language	
Insert Into #xml (lines) Values ('<sa_pagina_dtl>')
-- Data for the table header
declare @Artifex_id integer
Select @Artifex_id = id_artifex from OPUS where id_opus = @id_opus
Insert Into #xml (lines) Values 
	('<artifex_id>' + rtrim(cast(@Artifex_id as char(10))) + '</artifex_id>')
Insert Into #xml (lines) Values 
	('<hAction>' + rtrim(@hAction) + '</hAction>')
Insert Into #xml (lines) 
	select '<artifex_name>' + rtrim(nauta.ds_login) + '</artifex_name>' 
	from dbo.nauta
	where nauta.id_nauta = @Artifex_id 

Insert Into #xml (lines) 
	select '<pagina_Type>' + rtrim(pagina_type) + '</pagina_Type>' 
	      +'<pagina_Cat>' + rtrim(pagina_cat) + '</pagina_Cat>'
	from dbo.PAGINA
	where dbo.pagina.id_pagina= @id_pagina and dbo.pagina.id_opus= @id_opus

	




Insert Into #xml (lines) 
	select '<opus_name>' + rtrim(ds_title) + '</opus_name>' 
	from LINGUA_OPUS
	where cd_lingua = @Language and id_opus = @id_opus 
-- Data for the form - language independent
Insert Into #xml (lines) Values ('<id_opus>' + rtrim(cast(@id_opus as varchar(10))) + '</id_opus>')
Insert Into #xml (lines) Values ('<id_pagina>' + rtrim(cast(@id_pagina as varchar(10))) + '</id_pagina>')
Insert Into #xml (lines) select '<am_link>' + rtrim(cast(am_link as varchar(10))) + '</am_link>' from PAGINA where id_opus = @id_opus and id_pagina = @id_pagina
Insert Into #xml (lines) Values ('<cd_lingua>' + @Language + '</cd_lingua>')
-- Data for the form - language dependent - SPANISH
Insert Into #xml(lines)
select 	'<ds_title_his><![CDATA[' + (case when ds_title is null then '' else ds_title end) + 
	']]></ds_title_his>' + 
	'<ds_tag_his><![CDATA[' + (case when ds_tag is null then '' else ds_tag end) + 
	']]></ds_tag_his>' 
	from lingua_pagina 
	where id_opus = @id_opus and cd_lingua = 'HISPANIA' and id_pagina = @id_pagina
Insert Into #xml(lines)
select 	'<ds_content_his><![CDATA[' + (case when ds_content is null then '' else ds_content end) + 
	']]></ds_content_his>' 
	from lingua_pagina 
	where id_opus = @id_opus and cd_lingua = 'HISPANIA' and id_pagina = @id_pagina
-- Data for the form - language dependent - BRITANNIA
Insert Into #xml(lines)
select 	'<ds_title_bri><![CDATA[' + (case when ds_title is null then '' else ds_title end) + 
	']]></ds_title_bri>' + 
	'<ds_tag_bri><![CDATA[' + (case when ds_tag is null then '' else ds_tag end) + 
	']]></ds_tag_bri>' 
	from lingua_pagina 
	where id_opus = @id_opus and cd_lingua = 'BRITANNIA' and id_pagina = @id_pagina
Insert Into #xml(lines)
select 	'<ds_content_bri><![CDATA[' + (case when ds_content is null then '' else ds_content end) + 
	']]></ds_content_bri>' 
	from lingua_pagina 
	where id_opus = @id_opus and cd_lingua = 'BRITANNIA' and id_pagina = @id_pagina
-- Final tag for the page
Insert Into #xml (lines) Values ('</sa_pagina_dtl>')
	


Insert Into #xml(lines)
    select 	'<Lables><id_opus_category>'+rtrim(cast(Id as varchar(10))) +'</id_opus_category>' + '<id_opus_Lable>'+ rtrim(cast(Lable as varchar(30)))+'</id_opus_Lable></Lables>' 
	from Category 
	where Opus = @id_opus 
-- SLOs
Insert Into #xml(lines) Values ('<SLOs>')
Insert Into #xml(lines) 
	select	'<SLO>' + (case when ds_doctrina is null then '' else ds_doctrina end) + '</SLO>' 
	from	LINGUA_DOCTRINA LD join DOCTRINA D  on LD.id_doctrina = D.id_doctrina 
	where	D.id_opus = @id_opus and D.id_pagina = @id_pagina  
Insert Into #xml(lines) Values ('</SLOs>')
-- Session State
Insert Into #xml(lines)
	Execute litSessionState @Language, @OpusType, @PageCode, @PageName, @UserID
-- Top Menu
Insert Into #xml(lines)
	Execute litTopMenu @Language, @PageCode, @UserID
-- Admin Tags
Insert Into #xml(lines)
	Execute litAdmin @Language
-- Footer
Insert Into #xml(lines)
	Execute litFooter @Language









-- Ends main tag
Insert Into #xml (lines) Values ('</doc>')

Select lines From #xml order by id 


END





