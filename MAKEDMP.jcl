//MAKEDMP JOB (1234),REGION=0M,
//            NOTIFY=&SYSUID,
//            MSGLEVEL=(1,1)
//***************************************************************
//** Use this job to DUMP user datasets
//** Replace @hlq@ with the user id
//** Replace @dump_dsn@ with the the name of the dump dataset
//** Optionally replace @vol@ with the name of the volume
//** on which the dump should be placed
//***************************************************************
//DELETE   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE @dump_dsn@
 SET MAXCC=0
/*
//** Uncomment the PARM to perform the DUMP simulation only
//** Adjust the SPACE to your needs
//DSDUMP   EXEC PGM=ADRDSSU ,PARM='TYPRUN=NORUN'
//OUTDASD  DD DISP=(NEW,CATLG),
//         DSN=@dump_dsn@,
//         UNIT=3390,SPACE=(CYL,(5,5),RLSE) ,VOL=SER=@vol@
//SYSPRINT DD SYSOUT=*
//** Use INCLUDE to select the datasets to be DUMPed and
//** EXCLUDE to exclude those you don't need
//SYSIN    DD *
 DUMP DATASET( -
  INCLUDE( -
   @hlq@.** -
  ) -
  EXCLUDE( -
   @hlq@.HCD.** -
   @hlq@.**.ISPFPROF -
   @hlq@.SPF*.** -
   @hlq@.**.DUMP -
  ) -
 ) -
 OUTDD(OUTDASD) -
 SPHERE -
 COMPRESS -
 WAIT(0,0) -
 TOL(ENQF)
/*