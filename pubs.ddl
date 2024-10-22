
CREATE TYPE [id]
	FROM VARCHAR(11) NOT NULL
go

CREATE TYPE [tid]
	FROM VARCHAR(6) NOT NULL
go

CREATE TYPE [empid]
	FROM CHAR(9) NOT NULL
go

CREATE TABLE [Auth]
( 
	[Auth_Id]            char(9) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Auth_Lst_Nam]       varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Auth_Frst_Nam]      varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Auth_Phn_Nbr]       int  NULL ,
	[Auth_Addr]          varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Auth_Cty]           varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Auth_St]            varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Auth_Zip_Cd]        varchar(9) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Cntrct]             smallint  NULL 
)
go

CREATE TABLE [authors]
( 
	[au_id]              [id]  NOT NULL ,
	[au_lname]           varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[au_fname]           varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[phone]              char(12) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF__authors__phone__117F9D94]
		 DEFAULT  'UNKNOWN',
	[address]            varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[city]               varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[state]              char(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[zip]                char(5) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[contract]           bit  NOT NULL 
)
go

ALTER TABLE [authors]
	 WITH CHECK ADD CONSTRAINT [CK__authors__au_id__108B795B] CHECK  ( [au_id] like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]' )
go

ALTER TABLE [authors]
	 WITH CHECK ADD CONSTRAINT [CK__authors__zip__1273C1CD] CHECK  ( [zip] like '[0-9][0-9][0-9][0-9][0-9]' )
go

CREATE TABLE [discounts]
( 
	[discounttype]       varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[stor_id]            char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[lowqty]             smallint  NULL ,
	[highqty]            smallint  NULL ,
	[discount]           decimal(4,2)  NOT NULL 
)
go

CREATE TABLE [employee]
( 
	[emp_id]             [empid]  NOT NULL ,
	[fname]              varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[lname]              varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[job_id]             smallint  NOT NULL 
	CONSTRAINT [DF__employee__job_id__33D4B598]
		 DEFAULT  1,
	[job_lvl]            tinyint  NULL 
	CONSTRAINT [DF__employee__job_lv__35BCFE0A]
		 DEFAULT  10,
	[pub_id]             char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF__employee__pub_id__36B12243]
		 DEFAULT  '9952',
	[hire_date]          datetime  NOT NULL 
	CONSTRAINT [DF__employee__hire_d__38996AB5]
		 DEFAULT  getdate(),
	[email]              char(18) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[minit]              varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [employee]
	 WITH CHECK ADD CONSTRAINT [CK_emp_id] CHECK  ( [emp_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [emp_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]' )
go

CREATE TABLE [jobs]
( 
	[job_id]             smallint  IDENTITY ( 1,1 )  NOT NULL ,
	[job_desc]           varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF__jobs__job_desc__2B3F6F97]
		 DEFAULT  'New Position - title not formalized yet',
	[min_lvl]            tinyint  NOT NULL ,
	[max_lvl]            tinyint  NOT NULL 
)
go

ALTER TABLE [jobs]
	 WITH CHECK ADD CONSTRAINT [CK__jobs__min_lvl__2C3393D0] CHECK  ( min_lvl >= 10 )
go

ALTER TABLE [jobs]
	 WITH CHECK ADD CONSTRAINT [CK__jobs__max_lvl__2D27B809] CHECK  ( max_lvl <= 250 )
go

CREATE TABLE [pub_info]
( 
	[pub_id]             char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[logo]               image  NULL ,
	[pr_info]            text COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [publishers]
( 
	[pub_id]             char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[pub_name]           varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[city]               varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[state]              char(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[country]            varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
	CONSTRAINT [DF__publisher__count__164452B1]
		 DEFAULT  'USA'
)
go

ALTER TABLE [publishers]
	 WITH CHECK ADD CONSTRAINT [CK__publisher__pub_i__15502E78] CHECK  ( [pub_id]='1756' OR [pub_id]='1622' OR [pub_id]='0877' OR [pub_id]='0736' OR [pub_id]='1389' OR [pub_id] like '99[0-9][0-9]' )
go

CREATE TABLE [roysched]
( 
	[title_id]           [tid]  NOT NULL ,
	[lorange]            int  NULL ,
	[hirange]            int  NULL ,
	[royalty]            int  NULL 
)
go

CREATE TABLE [sales]
( 
	[stor_id]            char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ord_num]            varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ord_date]           datetime  NOT NULL ,
	[qty]                smallint  NOT NULL ,
	[payterms]           varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[title_id]           [tid]  NOT NULL 
)
go

CREATE TABLE [stores]
( 
	[stor_id]            char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[stor_name]          varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[stor_address]       varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[city]               varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[state]              char(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[zip]                char(5) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

CREATE TABLE [titleauthor]
( 
	[title_id]           [tid]  NOT NULL ,
	[au_ord]             tinyint  NULL ,
	[royaltyper]         int  NULL ,
	[au_id]              [id]  NOT NULL 
)
go

CREATE TABLE [titles]
( 
	[title_id]           [tid]  NOT NULL ,
	[title]              varchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[type]               char(12) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
	CONSTRAINT [DF__titles__type__1920BF5C]
		 DEFAULT  'UNDECIDED',
	[pub_id]             char(4) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[price]              money  NULL ,
	[advance]            money  NULL ,
	[royalty]            int  NULL ,
	[ytd_sales]          int  NULL ,
	[notes]              varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[pubdate]            datetime  NOT NULL 
	CONSTRAINT [DF__titles__pubdate__1B0907CE]
		 DEFAULT  getdate()
)
go

ALTER TABLE [authors]
	ADD CONSTRAINT [UPKCL_auidind] PRIMARY KEY  CLUSTERED ([au_id] ASC)
go

CREATE NONCLUSTERED INDEX [aunmind] ON [authors]
( 
	[au_lname]            ASC,
	[au_fname]            ASC
)
go

ALTER TABLE [jobs]
	ADD CONSTRAINT [PK__jobs__6E32B6A59A93FACA] PRIMARY KEY  CLUSTERED ([job_id] ASC)
go

ALTER TABLE [pub_info]
	ADD CONSTRAINT [UPKCL_pubinfo] PRIMARY KEY  CLUSTERED ([pub_id] ASC)
go

ALTER TABLE [publishers]
	ADD CONSTRAINT [UPKCL_pubind] PRIMARY KEY  CLUSTERED ([pub_id] ASC)
go

ALTER TABLE [sales]
	ADD CONSTRAINT [UPKCL_sales] PRIMARY KEY  CLUSTERED ([stor_id] ASC,[ord_num] ASC,[title_id] ASC)
go

ALTER TABLE [stores]
	ADD CONSTRAINT [UPK_storeid] PRIMARY KEY  CLUSTERED ([stor_id] ASC)
go

ALTER TABLE [titleauthor]
	ADD CONSTRAINT [UPKCL_taind] PRIMARY KEY  CLUSTERED ([title_id] ASC,[au_id] ASC)
go

ALTER TABLE [titles]
	ADD CONSTRAINT [UPKCL_titleidind] PRIMARY KEY  CLUSTERED ([title_id] ASC)
go

CREATE NONCLUSTERED INDEX [titleind] ON [titles]
( 
	[title]               ASC
)
go

CREATE VIEW [titleview]([title],[au_ord],[au_lname],[price],[ytd_sales],[pub_id])
AS
SELECT [titles].[title],[titleauthor].[au_ord],[authors].[au_lname],[titles].[price],[titles].[ytd_sales],[titles].[pub_id]
	FROM [authors],[titles],[titleauthor]
		WHERE authors.au_id = titleauthor.au_id AND titles.title_id = titleauthor.title_id
go


ALTER TABLE [discounts] WITH CHECK 
	ADD CONSTRAINT [FK__discounts__stor___286302EC] FOREIGN KEY ([stor_id]) REFERENCES [stores]([stor_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [discounts]
	  WITH CHECK CHECK CONSTRAINT [FK__discounts__stor___286302EC]
go


ALTER TABLE [employee] WITH CHECK 
	ADD CONSTRAINT [FK__employee__job_id__34C8D9D1] FOREIGN KEY ([job_id]) REFERENCES [jobs]([job_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [employee]
	  WITH CHECK CHECK CONSTRAINT [FK__employee__job_id__34C8D9D1]
go

ALTER TABLE [employee] WITH CHECK 
	ADD CONSTRAINT [FK__employee__pub_id__37A5467C] FOREIGN KEY ([pub_id]) REFERENCES [publishers]([pub_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [employee]
	  WITH CHECK CHECK CONSTRAINT [FK__employee__pub_id__37A5467C]
go


ALTER TABLE [pub_info] WITH CHECK 
	ADD CONSTRAINT [FK__pub_info__pub_id__300424B4] FOREIGN KEY ([pub_id]) REFERENCES [publishers]([pub_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [pub_info]
	  WITH CHECK CHECK CONSTRAINT [FK__pub_info__pub_id__300424B4]
go


ALTER TABLE [roysched] WITH CHECK 
	ADD CONSTRAINT [FK__roysched__title___267ABA7A] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [roysched]
	  WITH CHECK CHECK CONSTRAINT [FK__roysched__title___267ABA7A]
go


ALTER TABLE [sales] WITH CHECK 
	ADD CONSTRAINT [FK__sales__stor_id__239E4DCF] FOREIGN KEY ([stor_id]) REFERENCES [stores]([stor_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [sales]
	  WITH CHECK CHECK CONSTRAINT [FK__sales__stor_id__239E4DCF]
go

ALTER TABLE [sales] WITH CHECK 
	ADD CONSTRAINT [FK__sales__title_id__24927208] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [sales]
	  WITH CHECK CHECK CONSTRAINT [FK__sales__title_id__24927208]
go


ALTER TABLE [titleauthor] WITH CHECK 
	ADD CONSTRAINT [FK__titleauth__au_id__1DE57479] FOREIGN KEY ([au_id]) REFERENCES [authors]([au_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [titleauthor]
	  WITH CHECK CHECK CONSTRAINT [FK__titleauth__au_id__1DE57479]
go

ALTER TABLE [titleauthor] WITH CHECK 
	ADD CONSTRAINT [FK__titleauth__title__1ED998B2] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [titleauthor]
	  WITH CHECK CHECK CONSTRAINT [FK__titleauth__title__1ED998B2]
go


ALTER TABLE [titles] WITH CHECK 
	ADD CONSTRAINT [FK__titles__pub_id__1A14E395] FOREIGN KEY ([pub_id]) REFERENCES [publishers]([pub_id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [titles]
	  WITH CHECK CHECK CONSTRAINT [FK__titles__pub_id__1A14E395]
go

CREATE PROCEDURE [byroyalty] @percentage int   
   
 AS select au_id from titleauthor
where titleauthor.royaltyper = @percentage
go

CREATE PROCEDURE [reptq1]   
   
 AS select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(price) as avg_price
from titles
where price is NOT NULL
group by pub_id with rollup
order by pub_id
go

CREATE PROCEDURE [reptq2]   
   
 AS select 
	case when grouping(type) = 1 then 'ALL' else type end as type, 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(ytd_sales) as avg_ytd_sales
from titles
where pub_id is NOT NULL
group by pub_id, type with rollup
go

CREATE PROCEDURE [reptq3] @lolimit money , @hilimit money , @type char(12)   
   
 AS select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	case when grouping(type) = 1 then 'ALL' else type end as type, 
	count(title_id) as cnt
from titles
where price >@lolimit AND price <@hilimit AND type = @type OR type LIKE '%cook%'
group by pub_id, type with rollup
go


CREATE TRIGGER tD_authors ON authors FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on authors */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* authors  titleauthor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011971", PARENT_OWNER="", PARENT_TABLE="authors"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__au_id__1DE57479", FK_COLUMNS="au_id" */
    IF EXISTS (
      SELECT * FROM deleted,titleauthor
      WHERE
        /*  %JoinFKPK(titleauthor,deleted," = "," AND") */
        titleauthor.au_id = deleted.au_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete authors because titleauthor exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_authors ON authors FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on authors */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insau_id id,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* authors  titleauthor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012f69", PARENT_OWNER="", PARENT_TABLE="authors"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__au_id__1DE57479", FK_COLUMNS="au_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(au_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,titleauthor
      WHERE
        /*  %JoinFKPK(titleauthor,deleted," = "," AND") */
        titleauthor.au_id = deleted.au_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update authors because titleauthor exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_discounts ON discounts FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on discounts */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* stores  discounts on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014b71", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="discounts"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__discounts__stor___286302EC", FK_COLUMNS="stor_id" */
    IF EXISTS (SELECT * FROM deleted,stores
      WHERE
        /* %JoinFKPK(deleted,stores," = "," AND") */
        deleted.stor_id = stores.stor_id AND
        NOT EXISTS (
          SELECT * FROM discounts
          WHERE
            /* %JoinFKPK(discounts,stores," = "," AND") */
            discounts.stor_id = stores.stor_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last discounts because stores exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_discounts ON discounts FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on discounts */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* stores  discounts on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00018b6b", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="discounts"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__discounts__stor___286302EC", FK_COLUMNS="stor_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(stor_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,stores
        WHERE
          /* %JoinFKPK(inserted,stores) */
          inserted.stor_id = stores.stor_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.stor_id IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update discounts because stores does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_employee ON employee FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on employee */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* publishers  employee on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00025f49", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__pub_id__37A5467C", FK_COLUMNS="pub_id" */
    IF EXISTS (SELECT * FROM deleted,publishers
      WHERE
        /* %JoinFKPK(deleted,publishers," = "," AND") */
        deleted.pub_id = publishers.pub_id AND
        NOT EXISTS (
          SELECT * FROM employee
          WHERE
            /* %JoinFKPK(employee,publishers," = "," AND") */
            employee.pub_id = publishers.pub_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last employee because publishers exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* jobs  employee on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="jobs"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__job_id__34C8D9D1", FK_COLUMNS="job_id" */
    IF EXISTS (SELECT * FROM deleted,jobs
      WHERE
        /* %JoinFKPK(deleted,jobs," = "," AND") */
        deleted.job_id = jobs.job_id AND
        NOT EXISTS (
          SELECT * FROM employee
          WHERE
            /* %JoinFKPK(employee,jobs," = "," AND") */
            employee.job_id = jobs.job_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last employee because jobs exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_employee ON employee FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on employee */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* publishers  employee on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002b8d5", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__pub_id__37A5467C", FK_COLUMNS="pub_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,publishers
        WHERE
          /* %JoinFKPK(inserted,publishers) */
          inserted.pub_id = publishers.pub_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update employee because publishers does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* jobs  employee on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="jobs"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__job_id__34C8D9D1", FK_COLUMNS="job_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(job_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,jobs
        WHERE
          /* %JoinFKPK(inserted,jobs) */
          inserted.job_id = jobs.job_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update employee because jobs does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_jobs ON jobs FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on jobs */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* jobs  employee on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010864", PARENT_OWNER="", PARENT_TABLE="jobs"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__job_id__34C8D9D1", FK_COLUMNS="job_id" */
    IF EXISTS (
      SELECT * FROM deleted,employee
      WHERE
        /*  %JoinFKPK(employee,deleted," = "," AND") */
        employee.job_id = deleted.job_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete jobs because employee exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_jobs ON jobs FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on jobs */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insjob_id smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* jobs  employee on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012e2c", PARENT_OWNER="", PARENT_TABLE="jobs"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__job_id__34C8D9D1", FK_COLUMNS="job_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(job_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,employee
      WHERE
        /*  %JoinFKPK(employee,deleted," = "," AND") */
        employee.job_id = deleted.job_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update jobs because employee exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_pub_info ON pub_info FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on pub_info */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* publishers  pub_info on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015615", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="pub_info"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__pub_info__pub_id__300424B4", FK_COLUMNS="pub_id" */
    IF EXISTS (SELECT * FROM deleted,publishers
      WHERE
        /* %JoinFKPK(deleted,publishers," = "," AND") */
        deleted.pub_id = publishers.pub_id AND
        NOT EXISTS (
          SELECT * FROM pub_info
          WHERE
            /* %JoinFKPK(pub_info,publishers," = "," AND") */
            pub_info.pub_id = publishers.pub_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last pub_info because publishers exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_pub_info ON pub_info FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on pub_info */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @inspub_id char(4),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* publishers  pub_info on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00017472", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="pub_info"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__pub_info__pub_id__300424B4", FK_COLUMNS="pub_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,publishers
        WHERE
          /* %JoinFKPK(inserted,publishers) */
          inserted.pub_id = publishers.pub_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update pub_info because publishers does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_publishers ON publishers FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on publishers */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* publishers  titles on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002e8be", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="titles"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titles__pub_id__1A14E395", FK_COLUMNS="pub_id" */
    IF EXISTS (
      SELECT * FROM deleted,titles
      WHERE
        /*  %JoinFKPK(titles,deleted," = "," AND") */
        titles.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete publishers because titles exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* publishers  pub_info on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="pub_info"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__pub_info__pub_id__300424B4", FK_COLUMNS="pub_id" */
    IF EXISTS (
      SELECT * FROM deleted,pub_info
      WHERE
        /*  %JoinFKPK(pub_info,deleted," = "," AND") */
        pub_info.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete publishers because pub_info exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* publishers  employee on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__pub_id__37A5467C", FK_COLUMNS="pub_id" */
    IF EXISTS (
      SELECT * FROM deleted,employee
      WHERE
        /*  %JoinFKPK(employee,deleted," = "," AND") */
        employee.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete publishers because employee exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_publishers ON publishers FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on publishers */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @inspub_id char(4),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* publishers  titles on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000341cf", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="titles"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titles__pub_id__1A14E395", FK_COLUMNS="pub_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,titles
      WHERE
        /*  %JoinFKPK(titles,deleted," = "," AND") */
        titles.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update publishers because titles exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* publishers  pub_info on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="pub_info"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__pub_info__pub_id__300424B4", FK_COLUMNS="pub_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,pub_info
      WHERE
        /*  %JoinFKPK(pub_info,deleted," = "," AND") */
        pub_info.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update publishers because pub_info exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* publishers  employee on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="employee"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__employee__pub_id__37A5467C", FK_COLUMNS="pub_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,employee
      WHERE
        /*  %JoinFKPK(employee,deleted," = "," AND") */
        employee.pub_id = deleted.pub_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update publishers because employee exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_roysched ON roysched FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on roysched */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* titles  roysched on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001442a", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="roysched"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__roysched__title___267ABA7A", FK_COLUMNS="title_id" */
    IF EXISTS (SELECT * FROM deleted,titles
      WHERE
        /* %JoinFKPK(deleted,titles," = "," AND") */
        deleted.title_id = titles.title_id AND
        NOT EXISTS (
          SELECT * FROM roysched
          WHERE
            /* %JoinFKPK(roysched,titles," = "," AND") */
            roysched.title_id = titles.title_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last roysched because titles exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_roysched ON roysched FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on roysched */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* titles  roysched on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000175a1", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="roysched"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__roysched__title___267ABA7A", FK_COLUMNS="title_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,titles
        WHERE
          /* %JoinFKPK(inserted,titles) */
          inserted.title_id = titles.title_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update roysched because titles does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_sales ON sales FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on sales */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* titles  sales on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002613e", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__title_id__24927208", FK_COLUMNS="title_id" */
    IF EXISTS (SELECT * FROM deleted,titles
      WHERE
        /* %JoinFKPK(deleted,titles," = "," AND") */
        deleted.title_id = titles.title_id AND
        NOT EXISTS (
          SELECT * FROM sales
          WHERE
            /* %JoinFKPK(sales,titles," = "," AND") */
            sales.title_id = titles.title_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last sales because titles exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* stores  sales on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__stor_id__239E4DCF", FK_COLUMNS="stor_id" */
    IF EXISTS (SELECT * FROM deleted,stores
      WHERE
        /* %JoinFKPK(deleted,stores," = "," AND") */
        deleted.stor_id = stores.stor_id AND
        NOT EXISTS (
          SELECT * FROM sales
          WHERE
            /* %JoinFKPK(sales,stores," = "," AND") */
            sales.stor_id = stores.stor_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last sales because stores exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_sales ON sales FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on sales */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insstor_id char(4), 
           @insord_num varchar(20), 
           @institle_id tid,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* titles  sales on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002aae2", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__title_id__24927208", FK_COLUMNS="title_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,titles
        WHERE
          /* %JoinFKPK(inserted,titles) */
          inserted.title_id = titles.title_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update sales because titles does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* stores  sales on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__stor_id__239E4DCF", FK_COLUMNS="stor_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(stor_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,stores
        WHERE
          /* %JoinFKPK(inserted,stores) */
          inserted.stor_id = stores.stor_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update sales because stores does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_stores ON stores FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on stores */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* stores  sales on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020078", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__stor_id__239E4DCF", FK_COLUMNS="stor_id" */
    IF EXISTS (
      SELECT * FROM deleted,sales
      WHERE
        /*  %JoinFKPK(sales,deleted," = "," AND") */
        sales.stor_id = deleted.stor_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete stores because sales exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* stores  discounts on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="discounts"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__discounts__stor___286302EC", FK_COLUMNS="stor_id" */
    IF EXISTS (
      SELECT * FROM deleted,discounts
      WHERE
        /*  %JoinFKPK(discounts,deleted," = "," AND") */
        discounts.stor_id = deleted.stor_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete stores because discounts exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_stores ON stores FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on stores */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insstor_id char(4),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* stores  sales on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000229bc", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__stor_id__239E4DCF", FK_COLUMNS="stor_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(stor_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,sales
      WHERE
        /*  %JoinFKPK(sales,deleted," = "," AND") */
        sales.stor_id = deleted.stor_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update stores because sales exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* stores  discounts on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="stores"
    CHILD_OWNER="", CHILD_TABLE="discounts"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__discounts__stor___286302EC", FK_COLUMNS="stor_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(stor_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,discounts
      WHERE
        /*  %JoinFKPK(discounts,deleted," = "," AND") */
        discounts.stor_id = deleted.stor_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update stores because discounts exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_titleauthor ON titleauthor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on titleauthor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* titles  titleauthor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00027e18", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__title__1ED998B2", FK_COLUMNS="title_id" */
    IF EXISTS (SELECT * FROM deleted,titles
      WHERE
        /* %JoinFKPK(deleted,titles," = "," AND") */
        deleted.title_id = titles.title_id AND
        NOT EXISTS (
          SELECT * FROM titleauthor
          WHERE
            /* %JoinFKPK(titleauthor,titles," = "," AND") */
            titleauthor.title_id = titles.title_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last titleauthor because titles exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* authors  titleauthor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="authors"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__au_id__1DE57479", FK_COLUMNS="au_id" */
    IF EXISTS (SELECT * FROM deleted,authors
      WHERE
        /* %JoinFKPK(deleted,authors," = "," AND") */
        deleted.au_id = authors.au_id AND
        NOT EXISTS (
          SELECT * FROM titleauthor
          WHERE
            /* %JoinFKPK(titleauthor,authors," = "," AND") */
            titleauthor.au_id = authors.au_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last titleauthor because authors exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_titleauthor ON titleauthor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on titleauthor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @institle_id tid, 
           @insau_id id,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* titles  titleauthor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c066", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__title__1ED998B2", FK_COLUMNS="title_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,titles
        WHERE
          /* %JoinFKPK(inserted,titles) */
          inserted.title_id = titles.title_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update titleauthor because titles does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* authors  titleauthor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="authors"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__au_id__1DE57479", FK_COLUMNS="au_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(au_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,authors
        WHERE
          /* %JoinFKPK(inserted,authors) */
          inserted.au_id = authors.au_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update titleauthor because authors does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_titles ON titles FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on titles */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* titles  titleauthor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004171e", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__title__1ED998B2", FK_COLUMNS="title_id" */
    IF EXISTS (
      SELECT * FROM deleted,titleauthor
      WHERE
        /*  %JoinFKPK(titleauthor,deleted," = "," AND") */
        titleauthor.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete titles because titleauthor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* titles  sales on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__title_id__24927208", FK_COLUMNS="title_id" */
    IF EXISTS (
      SELECT * FROM deleted,sales
      WHERE
        /*  %JoinFKPK(sales,deleted," = "," AND") */
        sales.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete titles because sales exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* titles  roysched on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="roysched"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__roysched__title___267ABA7A", FK_COLUMNS="title_id" */
    IF EXISTS (
      SELECT * FROM deleted,roysched
      WHERE
        /*  %JoinFKPK(roysched,deleted," = "," AND") */
        roysched.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete titles because roysched exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* publishers  titles on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="titles"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titles__pub_id__1A14E395", FK_COLUMNS="pub_id" */
    IF EXISTS (SELECT * FROM deleted,publishers
      WHERE
        /* %JoinFKPK(deleted,publishers," = "," AND") */
        deleted.pub_id = publishers.pub_id AND
        NOT EXISTS (
          SELECT * FROM titles
          WHERE
            /* %JoinFKPK(titles,publishers," = "," AND") */
            titles.pub_id = publishers.pub_id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last titles because publishers exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_titles ON titles FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on titles */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @institle_id tid,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* titles  titleauthor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004b479", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="titleauthor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titleauth__title__1ED998B2", FK_COLUMNS="title_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,titleauthor
      WHERE
        /*  %JoinFKPK(titleauthor,deleted," = "," AND") */
        titleauthor.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update titles because titleauthor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* titles  sales on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="sales"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__sales__title_id__24927208", FK_COLUMNS="title_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,sales
      WHERE
        /*  %JoinFKPK(sales,deleted," = "," AND") */
        sales.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update titles because sales exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* titles  roysched on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="titles"
    CHILD_OWNER="", CHILD_TABLE="roysched"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__roysched__title___267ABA7A", FK_COLUMNS="title_id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(title_id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,roysched
      WHERE
        /*  %JoinFKPK(roysched,deleted," = "," AND") */
        roysched.title_id = deleted.title_id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update titles because roysched exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* publishers  titles on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="publishers"
    CHILD_OWNER="", CHILD_TABLE="titles"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK__titles__pub_id__1A14E395", FK_COLUMNS="pub_id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(pub_id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,publishers
        WHERE
          /* %JoinFKPK(inserted,publishers) */
          inserted.pub_id = publishers.pub_id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.pub_id IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update titles because publishers does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


