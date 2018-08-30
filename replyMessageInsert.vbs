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
'/ 1   David Paspa      11-Aug-2019 NA        Reboot for S7-1500.              /
'/-----------------------------------------------------------------------------/
'/ Declare local variables:                                                    /
'/-----------------------------------------------------------------------------/
Const ERR_PROC = "replyMessageInsert: "
Dim iErr ' Global error
Dim bInserted
Dim i

'/-----------------------------------------------------------------------------/
'/ Deselect any selected row:                                                  /
'/-----------------------------------------------------------------------------/

'/-----------------------------------------------------------------------------/
'/ Shuffle any existing messages to have the oldest at the top:                /
'/-----------------------------------------------------------------------------/
If (SmartTags("replyMessage.idxMessage1") = 0) Then
    If (SmartTags("replyMessage.idxMessage2") = 0) Then
        If (SmartTags("replyMessage.idxMessage3") = 0) Then
        Else
            SmartTags("replyMessage.idxSelectedList") = 0
            SmartTags("replyMessage.idxMessage1") = SmartTags("replyMessage.idxMessage3")
            SmartTags("replyMessage.idxMessage3") = 0
        End If
    Else
        SmartTags("replyMessage.idxSelectedList") = 0
        SmartTags("replyMessage.idxMessage1") = SmartTags("replyMessage.idxMessage2")
        If (SmartTags("replyMessage.idxMessage3") = 0) Then
            SmartTags("replyMessage.idxMessage2") = 0
        Else
            SmartTags("replyMessage.idxSelectedList") = 0
            SmartTags("replyMessage.idxMessage2") = SmartTags("replyMessage.idxMessage3")
            SmartTags("replyMessage.idxMessage3") = 0
        End If
    End If
Else
    If (SmartTags("replyMessage.idxMessage2") = 0) Then
        If (SmartTags("replyMessage.idxMessage3") = 0) Then
        Else
            SmartTags("replyMessage.idxSelectedList") = 0
            SmartTags("replyMessage.idxMessage2") = SmartTags("replyMessage.idxMessage3")
            SmartTags("replyMessage.idxMessage3") = 0
        End If
    End If
End If

@@TEMPLATE_BEGIN|pEventPromptAll@@
'/-----------------------------------------------------------------------------/
'/ The following should be done in a for-next loop to process all of the events/
'/ in a simple small script but the brain dead WinCC does not allow the        /
'/ structure SmartTag to be a variable :(                                      /
'/                                                                             /
'/ Check if the event is already raised in the message list:                   /
'/-----------------------------------------------------------------------------/
If (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active")) Then

'/-----------------------------------------------------------------------------/
'/ The message is not in the list. Check if it has now been triggered:         /
'/-----------------------------------------------------------------------------/
ElseIf (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.trigger")) Then
    '/-------------------------------------------------------------------------/
    '/ Insert the event message into the first available message box slot.     /
    '/ Messages are display in symbolic I/O fields linked to a Text List by    /
    '/ the list index HMI tag:                                                 /
    '/-------------------------------------------------------------------------/
    bInserted = False
    If (SmartTags("replyMessage.idxMessage1") = 0) Then
        SmartTags("replyMessage.idxMessage1") = @@IDXEVENT@@
        SmartTags("replyMessage.numSerial1") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True

    ElseIf (SmartTags("replyMessage.idxMessage2") = 0) Then
        SmartTags("replyMessage.idxMessage2") = @@IDXEVENT@@
        SmartTags("replyMessage.numSerial2") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True

    ElseIf (SmartTags("replyMessage.idxMessage3") = 0) Then
        SmartTags("replyMessage.idxMessage3") = @@IDXEVENT@@
        SmartTags("replyMessage.numSerial3") = SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.numSerial")
        bInserted = True
    End If

    '/---------------------------------------------------------------------/
    '/ Flag it was inserted if there was a message slot available:         /
    '/---------------------------------------------------------------------/
    If (bInserted) Then
        SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active") = True
    End If
End If

@@TEMPLATE_END@@

End Sub
