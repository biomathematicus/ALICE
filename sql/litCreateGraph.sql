USE [ALICE_DEVELOPMENT]
GO
/****** Object:  StoredProcedure [dbo].[litCreateGraph]    Script Date: 8/13/2021 3:37:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/*********************************************************
Procedure	: [litGetPath]
Purpose		: Generates XMl tree of pre-requsites per lesson
Parameters	: @cd_language, @id_opus, @id_nauta, @id_ini, @id_end
Returns		: Record set with XML entries of a trail
Example		: exec [litGetPath] 'BRITANNIA',28,11,73,2 
			  exec [litGetPath] 'BRITANNIA',28,11,8,57 
			  exec [litCreateGraph] 'BRITANNIA',28,11,55,63 
JBG - 01/2017
*********************************************************/
ALTER    PROCEDURE [dbo].[litCreateGraph]
	@Language   varchar(15),
	@id_opus	integer,
	@id_nauta 	integer

AS

Begin
set nocount OFF
-- Create XML Table 
Create Table #xml (id int identity(1,1) not null,lines Varchar(4000))	
-- Main tag




---------------------------------------------------------------------------------------------------
declare @results varchar(3500)

select @results = coalesce(@results + ',', '') +  convert(varchar(4),i)+','+convert(varchar(4),j)+','+convert(varchar(4),[am_value])+' '
  FROM [MATRIX]
  where id_opus=@id_opus and cd_matrix_type='MCA' and [am_value] !=0 and [am_value] !=1E+09 
  order by i
Insert Into #xml (lines) 
	select '<matrix_edges>' + rtrim(@results ) + '</matrix_edges>'


	/*----------------------------------------------------------------------*/
DECLARE @tbl TABLE
(
   sour int,
   mid int,
   mid1 int,
   des_ int
);
INSERT INTO 
    @tbl 
SELECT 
    M.i,  M.j,M1.i,M1.j
FROM 
    [MATRIX] M
	join [MATRIX] M1 on M.j=M1.i
WHERE   M.id_opus=@id_opus and M.cd_matrix_type='MCA' and M.[am_value] !=0 and M.[am_value] !=1E+09 and M.i<M.j
 and M1.[am_value] !=0 and M1.[am_value] !=1E+09 and M1.i<M1.j and M1.cd_matrix_type='MCA'
  order by M.i




  /*---------------------------------------------------------------------------*/
  
DECLARE @all_edges TABLE
(
   sour int,
   des_ int
);
INSERT INTO 
    @all_edges 
SELECT 
    M.i,M.j
  FROM [MATRIX] M
  where M.id_opus=@id_opus and M.cd_matrix_type='MCA' and M.[am_value] !=0 and M.[am_value] !=1E+09 and M.i<M.j
  order by M.i

  /**************************************************************************/

  DECLARE @read_nodes TABLE
(
   pagina_nod int
);
INSERT INTO 
    @read_nodes 
SELECT L.id_pagina
    
  FROM LABOR L
  where L.id_opus=@id_opus and L.id_nauta=@id_nauta
  order by L.id_pagina

  DECLARE @node_spe integer

  while( ( select count(*) from  @read_nodes ) >0   )
  begin
  select top 1 @node_spe=pagina_nod from  @read_nodes

   DELETE FROM @all_edges WHERE sour=@node_spe or des_=@node_spe

   INSERT INTO 
    @all_edges 
SELECT 
    tb.sour,tb.des_
  FROM @tbl tb
  where tb.mid=@node_spe
  order by tb.sour
 

	    DELETE FROM @tbl WHERE mid=@node_spe
	 DELETE FROM @tbl WHERE sour=@node_spe
	  DELETE FROM @tbl WHERE des_=@node_spe
	DELETE FROM @read_nodes WHERE pagina_nod=@node_spe
  /*---------------------------------------------------------------------------*/

  end




  ---------------------------------------------------------------------------------------------------
declare @results_per varchar(1000)

select @results_per = coalesce(@results_per + ',', '') +  convert(varchar(4),sour)+','+convert(varchar(4),des_)+','+convert(varchar(4),'99')+' '
  FROM @all_edges
   order by sour
Insert Into #xml (lines) 
	select '<matrix_personalize>' + rtrim(@results_per ) + '</matrix_personalize>'


	/*----------------------------------------------------------------------*/

/***************************************************************************************************/  
select @results = ''
select @results = coalesce(@results + ',', '') +  convert(varchar(4),i)+','+convert(varchar(4),j)+','+convert(varchar(4),[am_value])+' '
  FROM [MATRIX]
  where id_opus=@id_opus and cd_matrix_type='MNI' and [am_value] !=0 and [am_value] !=1E+09 and i<j
  order by i
Insert Into #xml (lines) 
	select '<matrix_mni>' + rtrim(@results ) + '</matrix_mni>'
  
--------------------------------------------------------------------------------------------------------------
Insert Into #xml (lines) 
	SELECT	'<pagina_name>'
			+ '<id>' + rtrim(cast(LP.id_pagina as char(10))) + '</id>'
				+ '<name><![CDATA[' + rtrim(cast(LP.ds_title as char(100))) + ']]></name>'
				+ '<pagina_type>' + rtrim(cast(P.pagina_type as char(20))) + '</pagina_type>'
				+ '<pagina_cat>' + rtrim(cast(P.pagina_cat as char(20))) + '</pagina_cat>'
  				+ '<capstone>' + (case when LP.id_capstone = 0 then 'false' else 'true' end) + '</capstone>'
				+ '<submit>' + (case  when LA.ds_file is null then 'false' else 'true' end) + '</submit>'
				+ '<color>' + (case   when LA.Grade >= 80  then 'green'  when LA.Grade < 80  then 'yellow'  else 'red' end) + '</color>'
			+'</pagina_name>' 
	from	LINGUA_PAGINA  LP
			join PAGINA P 
				on LP.id_pagina=P.id_pagina and LP.id_opus = P.id_opus
			left join LABOR LA 
				on LP.id_pagina=LA.id_pagina and LP.id_opus = LA.id_opus and LA.id_nauta=@id_nauta
			left join Via V 
				on LP.id_pagina=V.id_pagina and LP.id_opus = V.id_opus and V.id_nauta=@id_nauta and V.cd_type='capstone'
	where	LP.cd_lingua = @Language and LP.id_opus = @id_opus   
	order by LP.id_pagina 
---------------------------------------------------------------------------------------------------------------
/*
Insert Into #xml (lines) 
	SELECT   '<pagina_node><source>' + rtrim(cast(i as char(4))) + '</source>'+
	'<des>' + rtrim(cast(j as char(4))) + '</des>'+
	'<weight>' + rtrim(cast([am_value] as char(4))) + '</weight>'+
	'</pagina_node>' 
  FROM [MATRIX]
  where id_opus=@id_opus and cd_matrix_type='MNI' and [am_value] !=0 and [am_value] !=1E+09 and i<j
  order by i



*/
------------------------------------------------------------------------------------------------
Insert Into #xml (lines) 
	SELECT   '<positions_graph>' +rtrim(cast(op.ds_graph as varchar(2000))) + '</positions_graph>'
	from opus  op
	where id_opus=@id_opus






------------------------------------------------------------------------------------------------

Select lines From #xml order by id 


END


