request HB_GT_CGI_DEFAULT

procedure main()
    LOCAL hStdIn  := hb_GetStdIn()
    LOCAL hStdOut := hb_GetStdOut()

    LOCAL nLen    := 0
    LOCAL cBuffer := Space(1024)
    LOCAL cData   := ""
    LOCAL cOutput, nWritten

    // read StdIn

    /* Reading input stream */
    DO WHILE ( nLen := FRead( hStdIn, @cBuffer, hb_BLen( cBuffer ) ) ) > 0
        cData += hb_BLeft( cBuffer, nLen )
    ENDDO

    cData = Trim(cData)
    cOutput := "Hello " + iif(hb_BLen(cData) == 0, "extranger", cData)

    // write stream
    FWrite(hStdOut, cOutput)
return
