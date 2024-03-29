USE [ALICE_DEVELOPMENT]
GO
/****** Object:  StoredProcedure [dbo].[litAdmin]    Script Date: 8/14/2021 1:00:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[litAdmin]
    @Language         varchar(15) = null

AS

Begin
set nocount OFF

-- Create XML Table
Create Table #xml (lines Varchar(100))	

-- STARTS GENERAL TAG
Insert Into #xml (lines) Values ('<admin>')

Insert Into #xml(lines)
	Select '<L_SA_UPDATE>' + rtrim(ds_nuntius) + '</L_SA_UPDATE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_UPDATE'
Insert Into #xml(lines)
	Select '<L_SA_TYPE>' + rtrim(ds_nuntius) + '</L_SA_TYPE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_TYPE'
Insert Into #xml(lines)
	Select '<L_SA_TITLE>' + rtrim(ds_nuntius) + '</L_SA_TITLE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_TITLE'
Insert Into #xml(lines)
	Select '<L_SA_TAG>' + rtrim(ds_nuntius) + '</L_SA_TAG>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_TAG'
Insert Into #xml(lines)
	Select '<L_SA_PAGE>' + rtrim(ds_nuntius) + '</L_SA_PAGE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_PAGE'
Insert Into #xml(lines)
	Select '<L_SA_DELETE>' + rtrim(ds_nuntius) + '</L_SA_DELETE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_DELETE'
Insert Into #xml(lines)
	Select '<L_SA_CONTENT>' + rtrim(ds_nuntius) + '</L_SA_CONTENT>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_CONTENT'
Insert Into #xml(lines)
	Select '<L_SA_BOOK>' + rtrim(ds_nuntius) + '</L_SA_BOOK>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_BOOK'
Insert Into #xml(lines)
	Select '<L_SA_AUTHOR>' + rtrim(ds_nuntius) + '</L_SA_AUTHOR>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_AUTHOR'
Insert Into #xml(lines)
	Select '<L_SA_ADD>' + rtrim(ds_nuntius) + '</L_SA_ADD>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_ADD'
Insert Into #xml(lines)
	Select '<L_SA_ABOUT>' + rtrim(ds_nuntius) + '</L_SA_ABOUT>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_SA_ABOUT'

Insert Into #xml(lines)
	Select '<L_CAPSTONE>' + rtrim(ds_nuntius) + '</L_CAPSTONE>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_CAPSTONE'
Insert Into #xml(lines)
	Select '<L_COUNT>' + rtrim(ds_nuntius) + '</L_COUNT>'
	from LINGUA_NUNTIUS where cd_lingua = @Language and cd_nuntius = 'L_COUNT'


-- ENDS GENERAL TAG
Insert Into #xml (lines) Values ('</admin>')

SELECT LINES FROM #XML

end