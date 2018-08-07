#require "hbpgsql"

#include "dbstruct.ch"

PROCEDURE Main()
   LOCAL oServer, oQuery, oRow, a

   Set( _SET_DATEFORMAT, "yyyy-mm-dd" )

   oServer := TPQServer():New( "10.9.100.111", "harbour", "postgres", "secret" )

   IF oServer:NetErr()
      Alert( oServer:Error() )
   ENDIF

   oServer:SetVerbosity( 2 )
   oServer:traceon( "simple.log" )


   ? "Tables..."
   FOR x := 1 TO 1
      aTables := oServer:ListTables()

      FOR i := 1 TO Len( aTables )
         ? aTables[ i ]
      NEXT
   NEXT

   oQuery := oServer:Query( "SELECT * from country limit 10" )
   for a := 1 to oQuery:LastRec()
      oRow = oQuery:GetRow(a)
      ? oRow:FieldGet( oRow:FieldPos( "CODE" ) ), " ", ;
	padr(trim(oRow:FieldGet( oRow:FieldPos( "NAME" ) )), 25), " ", ;
	STR(oRow:FieldGet( oRow:FieldPos( "RESIDENTS" ) ))
   next

   oQuery:Destroy()
   oServer:Destroy()
RETURN
