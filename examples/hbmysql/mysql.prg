#require "hbmysql"

#include "dbstruct.ch"

PROCEDURE Main()
   LOCAL oServer, oQuery, oRow, a

   Set( _SET_DATEFORMAT, "yyyy-mm-dd" )

   oServer := TMySQLServer():New( "10.9.100.111", "usuario", "secr3t" )

   IF oServer:NetErr()
      Alert( oServer:Error() )
   ENDIF

   oServer:SelectDB( "visionbanco" )

   oQuery := oServer:Query( "SELECT * from country limit 10" )
   for a := 1 to oQuery:LastRec()
      oRow = oQuery:GetRow(a)
      ? oRow:FieldGet( oRow:FieldPos( "CODE" ) ), " ", ;
	padr(trim(oRow:FieldGet( oRow:FieldPos( "NAME" ) )), 25), " ", ;
	STR(oRow:FieldGet( oRow:FieldPos( "RESIDENTS" ) ))
   next
    
   oQuery:Destroy()
   // https://harbour.edu.pl/clipper/es/ng3b0ae.html
   // dbUseArea( .T.,, cArg, "wn", .F. )


   oServer:Destroy()
RETURN
