use edutronica 
go 

INSERT INTO NUNTIUS (cd_type,cd_nuntius,ds_description,id_created,dt_created)
VALUES ('LABEL', 'TAB_INTRO', 'TAB_INTRO',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('HISPANIA','TAB_INTRO', 'Introducción',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('BRITANNIA','TAB_INTRO', 'Introduction',1,getdate())
GO

INSERT INTO NUNTIUS (cd_type,cd_nuntius,ds_description,id_created,dt_created)
VALUES ('LABEL', 'TAB_WIKI', 'TAB_WIKI',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('HISPANIA','TAB_WIKI', 'Wiki',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('BRITANNIA','TAB_WIKI', 'Wiki',1,getdate())
GO

INSERT INTO NUNTIUS (cd_type,cd_nuntius,ds_description,id_created,dt_created)
VALUES ('LABEL', 'TAB_PDF', 'TAB_PDF',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('HISPANIA','TAB_PDF', 'PDF',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('BRITANNIA','TAB_PDF', 'PDF',1,getdate())
GO

INSERT INTO NUNTIUS (cd_type,cd_nuntius,ds_description,id_created,dt_created)
VALUES ('LABEL', 'TAB_LIVESCRIBE', 'TAB_LIVESCRIBE',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('HISPANIA','TAB_LIVESCRIBE', 'LiveScribe',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('BRITANNIA','TAB_LIVESCRIBE', 'LiveScribe',1,getdate())
GO

INSERT INTO NUNTIUS (cd_type,cd_nuntius,ds_description,id_created,dt_created)
VALUES ('LABEL', 'TAB_MEDIA', 'TAB_MEDIA',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('HISPANIA','TAB_MEDIA', 'Multimedios',1,getdate())
INSERT INTO dbo.LINGUA_NUNTIUS (cd_lingua,cd_nuntius,ds_nuntius,id_created,dt_created)
VALUES ('BRITANNIA','TAB_MEDIA', 'Multimedia',1,getdate())
GO

