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
'/ 2   David Paspa      16-Nov-2018 NA        Add HMI specific trigger.        /
'/ 1   David Paspa      11-Aug-2018 NA        Reboot for S7-1500.              /
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
idxList = SmartTags("interfaceReply.idxSelectedList")
idxMessage = SmartTags("interfaceReply.idxSelectedMessage")

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
        SmartTags("interfaceReply.idxMessage1") = 0
        SmartTags("interfaceReply.numSerial1") = 0

    ElseIf (idxList = 2) Then
        SmartTags("interfaceReply.idxMessage2") = 0
        SmartTags("interfaceReply.numSerial2") = 0

    ElseIf (idxList = 3) Then
        SmartTags("interfaceReply.idxMessage3") = 0
        SmartTags("interfaceReply.numSerial3") = 0
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

    '/-------------------------------------------------------------------------/
    '/ The following should be done in a simple small script but WinCC does    /
    '/ not allow the structure SmartTag to be a variable.                      /
    '/ Set the confirm bit:                                                    /
    '/-------------------------------------------------------------------------/
@@TEMPLATE_BEGIN|pEventPromptAll@@
    If (idxMessage = @@IDXEVENT@@) Then
    	SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.confirmNo") = bNo
    	SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.confirmYes") = bYes
    End If

@@TEMPLATE_END@@

    '/-------------------------------------------------------------------------/
    '/ Reset the message and list selection indices:                           /
    '/-------------------------------------------------------------------------/
    SmartTags("interfaceReply.idxSelectedList") = 0
    SmartTags("interfaceReply.idxSelectedMessage") = 0
End If

End Sub
