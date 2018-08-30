Sub replyMessageCallback(ByVal confirmCallback)
'/-----------------------------------------------------------------------------/
'/            Copyright 2018 Rieckermann Engineering Operations                /
'/-----------------------------------------------------------------------------/
'/ Title:       replyMessageCallback                                           /
'/                                                                             /
'/ Description: Raises any operator reply SFC message if the trigger bit is    /
'/              set high. The messages are displayed on the bottom slide-in    /
'/              panel on symbolic I/O fields linked to the replyMessage Text   /
'/              List. Completion of the reply is handled by the Yes and No     /
'/              confirm buttons which call the replyMessageCallback handler.   /
'/-----------------------------------------------------------------------------/
'/ Calling parameters:                                                         /
'/                                                                             /
'/ confirmCallback      The Yes or No button callback value defined as:        /
'/                      No  = 1                                                /
'/                      Yes = 2                                                /
'/-----------------------------------------------------------------------------/
'/ Revision history:                                                           /
'/ Rev By               Date        CC        Note                             /
'/ 1   David Paspa      11-Aug-2019 NA        Reboot for S7-1500.              /
'/-----------------------------------------------------------------------------/
'/ Declare local variables:                                                    /
'/-----------------------------------------------------------------------------/
Const ERR_PROC = "replyMessageCallback: "
Dim bNo
Dim bYes
Dim iErr ' Global error
Dim idxList
Dim idxMessage

'/-----------------------------------------------------------------------------/
'/ Get the selected message index number saved by the list item click events:  /
'/-----------------------------------------------------------------------------/
idxList = SmartTags("replyMessage.idxSelectedList")
idxMessage = SmartTags("replyMessage.idxSelectedMessage")

'/-----------------------------------------------------------------------------/
'/ Check if there is no current active reply message:                          /
'/-----------------------------------------------------------------------------/
If (idxMessage = 0) Then
    '/-------------------------------------------------------------------------/
    '/ Nothing to do:                                                          /
    '/-------------------------------------------------------------------------/
    ShowSystemAlarm ERR_PROC & "No message callback"

'/-----------------------------------------------------------------------------/
'/ Check if an invalid reply:                                                  /
'/-----------------------------------------------------------------------------/
ElseIf (confirmCallback <> 1 And confirmCallback <> 2) Then
    '/-------------------------------------------------------------------------/
    '/ Error value:                                                            /
    '/-------------------------------------------------------------------------/
	ShowSystemAlarm ERR_PROC & "Invalid reply message index " & CStr(idxMessage)
Else
    '/-------------------------------------------------------------------------/
    '/ Reset the symbolic I/O field index to clear the message:                /
    '/-------------------------------------------------------------------------/
    If (idxList = 1) Then
        SmartTags("replyMessage.idxMessage1") = 0
        SmartTags("replyMessage.numSerial1") = 0

    ElseIf (idxList = 2) Then
        SmartTags("replyMessage.idxMessage2") = 0
        SmartTags("replyMessage.numSerial2") = 0

    ElseIf (idxList = 3) Then
        SmartTags("replyMessage.idxMessage3") = 0
        SmartTags("replyMessage.numSerial3") = 0
    End If

    '/-------------------------------------------------------------------------/
    '/ If No reply set the confirmYes and confirmNo response bits:             /
    '/-------------------------------------------------------------------------/
    If (confirmCallback = 1) Then
        bNo = True
        bYes = False

    '/-------------------------------------------------------------------------/
    '/ If Yes reply set the confirmYes and confirmNo response bits:            /
    '/-------------------------------------------------------------------------/
    ElseIf (confirmCallback = 2) Then
        bNo = False
        bYes = True
    End If

@@TEMPLATE_BEGIN|pEventPromptAll@@
    '/-------------------------------------------------------------------------/
    '/ The following should be done in a simple small script but WinCC does    /
    '/ not allow the structure SmartTag to be a variable.                      /
    '/                                                                         /
    '/ Check if this is the selected message:                                  /
    '/-------------------------------------------------------------------------/
    If (idxMessage = @@IDXEVENT@@) Then
        '/---------------------------------------------------------------------/
        '/ Set the message confirm bit and clear the selected message index:   /
        '/---------------------------------------------------------------------/
    	SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.confirmNo") = bNo
    	SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.confirmYes") = bYes
        SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active") = False
    End If

@@TEMPLATE_END@@

    '/-------------------------------------------------------------------------/
    '/ Reset the message and list selection indices:                           /
    '/-------------------------------------------------------------------------/
    SmartTags("replyMessage.idxSelectedList") = 0
    SmartTags("replyMessage.idxSelectedMessage") = 0
End If

End Sub
