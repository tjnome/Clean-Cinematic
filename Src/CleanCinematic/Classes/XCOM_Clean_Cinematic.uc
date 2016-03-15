//-----------------------------------------------------------
// tjnome at work...
//-----------------------------------------------------------

class XCOM_Clean_Cinematic extends UIWorldMessageMgr;

simulated function DisplayMessageBox()
{
	local string FlashFunction;
	local Array<ASValue> MessageValues;
	local XComTacticalController LocalController;
	local float time;
	local int i;

	time = 0.1f;
	LocalController = XComTacticalController(`BATTLE.GetALocalPlayerController());

	if(!m_bDelayMessages || m_arrQueuedMessages.Length <= 0)
	{
		ClearTimer('DisplayMessageBox');
	}

	if (LocalController.m_bInCinematicMode)
	{
		SetTimer(time, true, 'DisplayMessageBox');
		return;
	}

	for(i = 0; i < m_arrQueuedMessages.Length; ++i)
	{
		FlashFunction = m_arrQueuedMessages[i].m_sFlashFunctionCall;
		MessageValues = m_arrQueuedMessages[i].m_arrMessageValues;
	
		Invoke(FlashFunction, MessageValues);
		m_arrQueuedMessages.Remove(i--, 1);
	}
}