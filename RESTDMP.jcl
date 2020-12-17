//RESTDMP JOB (1234),REGION=0M,
//            NOTIFY=&SYSUID,
//            MSGLEVEL=(1,1)
//***************************************************************
//** Use this job to RESTORE the user datasets which were
//** previously DUMPed with the MAKEDMP job to a dump dataset
//** Replace @dump_dsn@ with the the name of the dump dataset
//** Replace @src_hlq@ with the id of the original user for which
//** the datasets were DUMPed
//** Replace @tgt_hlq@ with the id of the target user for which
//** the datasets will be RESTOREd
//** During the RESTORE the HLQ of the datasets will be replaced
//** with @tgt_hlq@
//** Uncomment the PARM to perform the DUMP simulation only
//***************************************************************
//RST      EXEC PGM=ADRDSSU ,PARM='TYPRUN=NORUN'
//INDASD   DD DISP=SHR,
//         DSN=@dump_dsn@
//SYSPRINT DD SYSOUT=*
//** Use INCLUDE to select the datasets to be RESTORed and
//** EXCLUDE to exclude those you don't need
//SYSIN    DD *
 RESTORE DATASET( -
  INCLUDE( -
   @src_hlq@.** -
  ) -
  EXCLUDE( -
   @src_hlq@.**.DUMP -
  ) -
 ) -
 INDDNAME(INDASD) -
 SPHERE -
 CATALOG -
 RENAMEU(@tgt_hlq@)
/*