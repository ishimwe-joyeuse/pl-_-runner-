Enter user-name: sys as sysdba
Enter password:

Connected to:
Oracle Database 21c Enterprise Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> SHOW USER
USER is "SYS"
SQL> SELECT instance_name FROM v$instance;

INSTANCE_NAME
----------------
orcl

SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 ORCLPDB                        MOUNTED



SQL>
SQL> 

  


SQL>


SQL> SELECT name FROM v$datafile WHERE con_id = (SELECT con_id FROM v$containers WHERE name = 'PDB$SEED');

NAME
--------------------------------------------------------------------------------
C:\ORACLE21C\ORADATA\ORCL\PDBSEED\SYSTEM01.DBF
C:\ORACLE21C\ORADATA\ORCL\PDBSEED\SYSAUX01.DBF
C:\ORACLE21C\ORADATA\ORCL\PDBSEED\UNDOTBS01.DBF






SQL> CREATE PLUGGABLE DATABASE plsql_class2025db
  2  ADMIN USER pdbadmin identified by joyeuse
  3  FILE_NAME_CONVERT = ('C:\ORACLE21C\ORADATA\ORCL\PDBSEED\',
  4                      'C:\ORACLE21C\ORADATA\ORCL\PDBSEED\plsql_class2025db\');

Pluggable database created.







SQL> SELECT pdb_name, status from cdb_pdbs
  2  ;

PDB_NAME
--------------------------------------------------------------------------------
STATUS
----------
ORCLPDB
NORMAL

PDB$SEED
NORMAL

PLSQL_CLASS2025DB
NEW


SQL>  select name, open_mode from v$pdbs;

NAME
--------------------------------------------------------------------------------
OPEN_MODE
----------
PDB$SEED
READ ONLY

ORCLPDB
MOUNTED

PLSQL_CLASS2025DB
MOUNTED


SQL> SELECT NAME, CON_ID FROM v$active_services ORDER BY 1;


NAME
    CON_ID
---------------------------------------------------------------- ----------
SYS$BACKGROUND
 1
SYS$USERS
 1
orcl
 1
orclXDB
 1
orclpdb                                                     3
plsql_class2025db
 4

6 rows selected.

SQL> Show con_name;

CON_NAME
------------------------------
CDB$ROOT
SQL> SELECT name, open_mode from v$pdbs;

NAME
--------------------------------------------------------------------------------
OPEN_MODE
----------
PDB$SEED
READ ONLY

ORCLPDB
MOUNTED

PLSQL_CLASS2025DB
MOUNTED




SQL> ALTER PLUGGABLE DATABASE plsql_class2025db OPEN;

Pluggable database altered.

SQL> ;
  

SQL> ALTER PLUGGABLE DATABASE plsql_class2025db SAVE STATE;


Pluggable database altered.

SQL>  ALTER SESSION SET CONTAINER = plsql_class2025db;

Session altered.

SQL>  CREATE USER de_plsqlauca IDENTIFIED BY 123;

User created.

SQL> GRANT ALL PRIVILEGES TO jo_plsqlauca
  2  ;

Grant succeeded.

SQL> show con_name

CON_NAME
------------------------------
PLSQL_CLASS2025DB
SQL>  ALTER SESSION SET CONTAINER = CDB$ROOT;

Session altered.

SQL>  SELECT DBMS_XDB_CONFIG.GETHTTPPORT() AS HTTP_PORT,
  2  DBMS_XDB_CONFIG.GETHTTPSPORT() AS HTTPS_PORT FROM dual;

 HTTP_PORT HTTPS_PORT
---------- ----------
         0       5500

SQL> BEGIN
  2   DBMS_XDB_CONFIG.SETHTTPPORT(8080);
  3   DBMS_XDB_CONFIG.SETHTTPSPORT(8443);  -- Optional for HTTPS
  4   END;
  5   /

PL/SQL procedure successfully completed.



SQL> 
SQL> SHUTDOWN IMMEDIATE;
Database closed.
Database dismounted.
ORACLE instance shut down.

SQL> STARTUP;
ORACLE instance started.

Total System Global Area 2516581696 bytes
Fixed Size                  9858368 bytes
Variable Size             654311424 bytes
Database Buffers         1845493760 bytes
Redo Buffers                6918144 bytes
Database mounted.
Database opened.
SQL>  select dbms_xdb_config.gethttpsport() from dual;

DBMS_XDB_CONFIG.GETHTTPSPORT()
------------------------------
                          8443


SQL>


//CREATING SECOND PDB//

SQL> CREATE PLUGGABLE DATABASE jo_to_delete_pdb
  2   ADMIN USER pdbadmin IDENTIFIED BY 123
  3   FILE_NAME_CONVERT =('C:\ORACLE21C\ORADATA\ORCL\PDBSEED\',
  4                        'C:\ORACLE21C\ORADATA\ORCL\jo_to_delete_pdb\');

Pluggable database created.


//CHECKING THE STATUS//
SQL> SELECT pdb_name, status from cdb_pdbs
  2  ;

PDB_NAME
--------------------------------------------------------------------------------
STATUS
----------
ORCLPDB
NORMAL

PDB$SEED
NORMAL

PLSQL_CLASS2025DB
NORMAL


PDB_NAME
--------------------------------------------------------------------------------
STATUS
----------
JO_TO_DELETE_PDB
NEW


SQL>


 select name, open_mode from v$pdbs;

NAME
--------------------------------------------------------------------------------
OPEN_MODE
----------
PDB$SEED
READ ONLY

ORCLPDB
MOUNTED

PLSQL_CLASS2025DB
READ WRITE


NAME
--------------------------------------------------------------------------------
OPEN_MODE
----------
IS_TO_DELETE_PDB
MOUNTED

//LIST OF ALL active_services//
 SELECT NAME, CON_ID FROM v$active_services ORDER BY 1;

                        
ALTER PLUGGABLE DATABASE is_to_delete_pdb OPEN;

Pluggable database altered.
 ALTER PLUGGABLE DATABASE jo_to_delete_pdb SAVE STATE;

Pluggable database altered.
SQL> ALTER SESSION SET CONTAINER = jo_to_delete_pdb;

Session altered.

SQL> CREATE USER plsqlauca IDENTIFIED BY 123;

User created.

SQL>  GRANT ALL PRIVILEGES TO plsqlauca
  2  ;

Grant succeeded.



 ALTER PLUGGABLE DATABASE jo_to_delete_pdb CLOSE IMMEDIATE;

Pluggable database altered.

 SELECT directory_name, directory_path FROM dba_directories;
 
DIRECTORY_NAME
--------------------------------------------------------------------------------
DIRECTORY_PATH
--------------------------------------------------------------------------------
DATA_PUMP_DIR
C:\oracle21c\admin\orcl\dpdump/

DBMS_OPTIM_LOGDIR
C:\oracle21c\WINDOWS.X64_213000_db_home/cfgtoollogs

DBMS_OPTIM_ADMINDIR
C:\oracle21c\WINDOWS.X64_213000_db_home/rdbms/admin

 ALTER PLUGGABLE DATABASE is_to_delete_pdb UNPLUG INTO 'C:\oracle21c\admin\orcl\dpdump/is_to_delete_pdb.xml’;

Pluggable database altered.

SQL> DROP PLUGGABLE DATABASE is_to_delete_pdb INCLUDING DATAFILES;

Pluggable database dropped.
![My Image](image1.png)
![My Image](image2.jpg)
![My Image](image3.png) 
![My Image](image4.png)
![My Image](image5.png)