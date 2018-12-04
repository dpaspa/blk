Sub replyMessageCancel()
'/-----------------------------------------------------------------------------/
'/            Copyright 2018 Rieckermann Engineering Operations                /
'/                Automatically Generated File - Do Not Edit                   /
'/-----------------------------------------------------------------------------/
'/ Title:       replyMessageCancel                                             /
'/                                                                             /
'/ Description: Deletes any operator reply SFC message if cancel command.      /
'/-----------------------------------------------------------------------------/
'/ Revision history:                                                           /
'/ Rev By               Date        CC        Note                             /
'/ 1   David Paspa      17-Nov-2018 NA        Initial design.                  /
'/-----------------------------------------------------------------------------/
'/ Declare local variables:                                                    /
'/-----------------------------------------------------------------------------/
Const ERR_PROC = "replyMessageCancel: "
Dim iErr ' Global error

'/-----------------------------------------------------------------------------/
'/ The following should be done in a for-next loop to process all of the events/
'/ in a simple small script but the brain dead WinCC does not allow the        /
'/ structure SmartTag to be a variable :(                                      /
'/-----------------------------------------------------------------------------/

@@TEMPLATE_BEGIN|pEventPromptAll@@
'/-----------------------------------------------------------------------------/
'/ Check if the event is to be canceled:                                       /
'/-----------------------------------------------------------------------------/
If (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.cancel3") And SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active3")) Then
    '/-------------------------------------------------------------------------/
    '/ Delete any active event message:                                        /
    '/-------------------------------------------------------------------------/
    SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active3") = False
    If (SmartTags("interfaceReply.idxMessage1") = @@IDXEVENT@@) Then
        SmartTags("interfaceReply.idxMessage1") = 0
        SmartTags("interfaceReply.numSerial1") = 0

    ElseIf (SmartTags("interfaceReply.idxMessage2") = @@IDXEVENT@@) Then
        SmartTags("interfaceReply.idxMessage2") = 0
        SmartTags("interfaceReply.numSerial2") = 0

    ElseIf (SmartTags("interfaceReply.idxMessage3") = @@IDXEVENT@@) Then
        SmartTags("interfaceReply.idxMessage3") = 0
        SmartTags("interfaceReply.numSerial3") = 0
    End If
End If

'/-----------------------------------------------------------------------------/
'/ The event is cancelled:                                                     /
'/-----------------------------------------------------------------------------/
If (SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.cancel3") And Not SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.active3")) Then
    SmartTags("dbEVENT_eventPrompt_event{@@IDXEVENT@@}.cancel3") = False
End If

@@TEMPLATE_END@@

End Sub
