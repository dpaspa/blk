Sub replyMessageInsert()
'/-----------------------------------------------------------------------------/
'/            Copyright 2018 Rieckermann Engineering Operations                /
'/                Automatically Generated File - Do Not Edit                   /
'/-----------------------------------------------------------------------------/
'/ Title:       replyMessageInsert                                             /
'/                                                                             /
'/ Description: Raises any operator reply SFC message if the trigger bit is    /
'/              set high. The messages are displayed on the bottom slide-in    /
'/              panel on symbolic I/O fields linked to the replyMessage Text   /
'/              List. Completion of the reply is handled by the Yes and No     /
'/              confirm buttons which call the replyMessageCallback handler.   /
'/-----------------------------------------------------------------------------/
'/ Revision history:                                                           /
'/ Rev By               Date        CC        Note                             /
'/ 2   David Paspa      16-Nov-2018 NA        Add HMI specific trigger.        /
'/ 1   David Paspa      11-Aug-2018 NA        Reboot for S7-1500.              /
'/-----------------------------------------------------------------------------/
'/ Declare local variables:                                                    /
'/-----------------------------------------------------------------------------/
Const ERR_PROC = "replyMessageInsert: "
Dim iErr ' Global error
Dim bInserted
Dim i

'/-----------------------------------------------------------------------------/
'/ Shuffle any existing messages to have the oldest at the top:                /
'/-----------------------------------------------------------------------------/
If (SmartTags("interfaceReply.idxMessage1") = 0) Then
    If (SmartTags("interfaceReply.idxMessage2") = 0) Then
        If (SmartTags("interfaceReply.idxMessage3") = 0) Then
        Else
            SmartTags("interfaceReply.idxSelectedList") = 0
            SmartTags("interfaceReply.idxMessage1") = SmartTags("interfaceReply.idxMessage3")
            SmartTags("interfaceReply.numSerial1") = SmartTags("interfaceReply.numSerial3")
            SmartTags("interfaceReply.idxMessage3") = 0
            SmartTags("interfaceReply.numSerial3") = 0
        End If
    Else
        SmartTags("interfaceReply.idxSelectedList") = 0
        SmartTags("interfaceReply.idxMessage1") = SmartTags("interfaceReply.idxMessage2")
        SmartTags("interfaceReply.numSerial1") = SmartTags("interfaceReply.numSerial2")
        If (SmartTags("interfaceReply.idxMessage3") = 0) Then
            SmartTags("interfaceReply.idxMessage2") = 0
            SmartTags("interfaceReply.numSerial2") = 0
        Else
            SmartTags("interfaceReply.idxSelectedList") = 0
            SmartTags("interfaceReply.idxMessage2") = SmartTags("interfaceReply.idxMessage3")
            SmartTags("interfaceReply.numSerial2") = SmartTags("interfaceReply.numSerial3")
            SmartTags("interfaceReply.idxMessage3") = 0
            SmartTags("interfaceReply.numSerial3") = 0
        End If
    End If
Else
    If (SmartTags("interfaceReply.idxMessage2") = 0) Then
        If (SmartTags("interfaceReply.idxMessage3") = 0) Then
        Else
            SmartTags("interfaceReply.idxSelectedList") = 0
            SmartTags("interfaceReply.idxMessage2") = SmartTags("interfaceReply.idxMessage3")
            SmartTags("interfaceReply.numSerial2") = SmartTags("interfaceReply.numSerial3")
            SmartTags("interfaceReply.idxMessage3") = 0
            SmartTags("interfaceReply.numSerial3") = 0
        End If
    End If
End If

'/-----------------------------------------------------------------------------/
'/ The following should be done in a for-next loop to process all of the events/
'/ in a simple small script but the brain dead WinCC does not allow the        /
'/ structure SmartTag to be a variable :(                                      /
'/ Messages are display in symbolic I/O fields linked to a Text List by        /
'/ the list index HMI tag:                                                     /
'/-----------------------------------------------------------------------------/

@@TEMPLATE_BEGIN|pEventPromptAll@@
'/-----------------------------------------------------------------------------/
'/ Check if the event is already raised in the message list:                   /
'/-----------------------------------------------------------------------------/
If (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active3")) Then

'/-----------------------------------------------------------------------------/
'/ The message is not in the list. Check if it has now been triggered:         /
'/-----------------------------------------------------------------------------/
ElseIf (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.trigger3")) Then
    '/-------------------------------------------------------------------------/
    '/ Insert the event message into the first available message box slot:     /
    '/-------------------------------------------------------------------------/
    bInserted = False
    If (SmartTags("interfaceReply.idxMessage1") = 0) Then
        SmartTags("interfaceReply.idxMessage1") = @@IDXEVENT@@
        SmartTags("interfaceReply.numSerial1") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True

    ElseIf (SmartTags("interfaceReply.idxMessage2") = 0) Then
        SmartTags("interfaceReply.idxMessage2") = @@IDXEVENT@@
        SmartTags("interfaceReply.numSerial2") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True

    ElseIf (SmartTags("interfaceReply.idxMessage3") = 0) Then
        SmartTags("interfaceReply.idxMessage3") = @@IDXEVENT@@
        SmartTags("interfaceReply.numSerial3") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True
    End If

    '/-------------------------------------------------------------------------/
    '/ Flag it was inserted if there was a message slot available:             /
    '/-------------------------------------------------------------------------/
    If (bInserted) Then
        SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active3") = True
        SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.trigger3") = False
    End If
End If

@@TEMPLATE_END@@

End Sub
