//ALLOCDMP   JOB (123),NOTIFY=&SYSUID
//***************************************************************
//** Use this job to preallocate the DUMP dataset
//** before uploading the data into it and running the RESTORE
//** Replace @dump_dsn@ withe the name of the dump dataset
//** Optionally replace @vol@ with the name of the volume
//** on which the dataset is to be created
//** FTP commands:
//** > bin
//** > quote stru r
//** > put
//***************************************************************
//DELETE     EXEC PGM=IDCAMS
//SYSPRINT   DD SYSOUT=*
//SYSIN      DD *
 DELETE @dump_dsn@
 SET MAXCC=0
//ALLOC      EXEC PGM=IEFBR14
//DUMPDS     DD DISP=(NEW,CATLG,DELETE),
//           DSN=@dump_dsn@,
//           DSORG=PS,RECFM=U,LRECL=0,
//           SPACE=(TRK,(200,100)), Adjust space to your needs
//           BLKSIZE=27998 ,VOL=SER=@vol@