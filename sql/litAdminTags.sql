USE [ALICE_DEVELOPMENT]
GO
/****** Object:  StoredProcedure [dbo].[litAdminTags]    Script Date: 8/14/2021 12:49:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




ALTER PROCEDURE [dbo].[litAdminTags] 
	@Language        varchar(15) = null
AS
-- example: exec [litAdminTags] 'BRITANNIA'
Begin
set nocount OFF
-- Create XML Table 
Create Table #xml (id int identity(1,1) not null,lines Varchar(4000))	
-- Main tag
Insert Into #xml (lines) Values ('<admin_tags>')
-- SPECIFIC CONTENT FOR THIS PAGE
Insert Into #xml(lines)
	Select '<sa_artifex_dtl>' + rtrim(ds_nuntius) + '</sa_artifex_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_artifex_dtl'
Insert Into #xml(lines)
	Select '<sa_artifex_lst>' + rtrim(ds_nuntius) + '</sa_artifex_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_artifex_lst'

	Insert Into #xml(lines)
	Select '<sa_nauta_lst>' + rtrim(ds_nuntius) + '</sa_nauta_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nauta_lst'



Insert Into #xml(lines)
	Select '<sa_menu>' + rtrim(ds_nuntius) + '</sa_menu>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_menu'
Insert Into #xml(lines)
	Select '<sa_nuntius_dtl>' + rtrim(ds_nuntius) + '</sa_nuntius_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nuntius_dtl'
Insert Into #xml(lines)
	Select '<sa_nuntius_lst>' + rtrim(ds_nuntius) + '</sa_nuntius_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nuntius_lst'
Insert Into #xml(lines)
	Select '<sa_opus_dtl>' + rtrim(ds_nuntius) + '</sa_opus_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_opus_dtl'
Insert Into #xml(lines)
	Select '<sa_opus_lst>' + rtrim(ds_nuntius) + '</sa_opus_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_opus_lst'
Insert Into #xml(lines)
	Select '<sa_pagina_dtl>' + rtrim(ds_nuntius) + '</sa_pagina_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_pagina_dtl'
Insert Into #xml(lines)
	Select '<sa_pagina_lst>' + rtrim(ds_nuntius) + '</sa_pagina_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_pagina_lst'
Insert Into #xml(lines)
	Select '<sa_doctrina_lst>' + rtrim(ds_nuntius) + '</sa_doctrina_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_doctrina_lst'
Insert Into #xml(lines)
	Select '<sa_doctrina_dtl>' + rtrim(ds_nuntius) + '</sa_doctrina_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_doctrina_dtl'
Insert Into #xml(lines)
	Select '<sa_reticulum_dtl>' + rtrim(ds_nuntius) + '</sa_reticulum_dtl>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_reticulum_dtl'
	--------------------------------------------------------------------------------------
Insert Into #xml(lines)
	Select '<sa_nautaCommunicatio_lst>' + rtrim(ds_nuntius) + '</sa_nautaCommunicatio_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nautaCommunicatio_lst'

Insert Into #xml(lines)
	Select '<sa_nautaVia_lst>' + rtrim(ds_nuntius) + '</sa_nautaVia_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nautaVia_lst'

Insert Into #xml(lines)
	Select '<sa_nautaLaborio_lst>' + rtrim(ds_nuntius) + '</sa_nautaLaborio_lst>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'sa_nautaLaborio_lst'



-- Ends main tag
Insert Into #xml (lines) Values ('</admin_tags>')

Select lines From #xml order by id 


END


