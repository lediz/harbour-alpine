#require "hbpgsql"

#include "dbstruct.ch"

PROCEDURE Main()
   LOCAL oServer, oQuery, oRow, a, x, i, aTables

   Set( _SET_DATEFORMAT, "yyyy-mm-dd" )

   oServer := TPQServer():New( "10.9.100.111", "visionbanco", "postgres", "secret" )

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

   oQuery := oServer:Query( "SELECT * from products limit 10" )
   for a := 1 to oQuery:LastRec()
      oRow = oQuery:GetRow(a)
      ? padr(trim(str(oRow:FieldGet( oRow:FieldPos( "product_no" ) ))), 6), " ", ;
	padr(trim(oRow:FieldGet( oRow:FieldPos( "name" ) )), 25), " ", ;
	STR(oRow:FieldGet( oRow:FieldPos( "price" ) ))
   next

   oQuery:Destroy()
   oServer:Destroy()
RETURN
