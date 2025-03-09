; 定义短按的时间阈值(毫秒)
SHORT_PRESS_TIME := 250

~LShift::
{
	KeyWait "LShift"
	; 检查在Shift按下期间是否有其他键被按下
	if (A_TimeSinceThisHotkey <= SHORT_PRESS_TIME && A_PriorKey == "LShift") {
		Send "{LShift down}{LShift up}"
		Send "{LWin down}{Space down}{Space up}{LWin up}"
	}
}

; 我希望按下shift时触发win+space切换输入法，但问题时使用~会导致发送shift,如果此时用了中文输入法，会切换中文输入法切换中英文，如何解决这一问题。

; 防止连续快速点击
~LShift Up::
{
	if (A_TimeSincePriorHotkey < SHORT_PRESS_TIME) {
		KeyWait "LShift", "T0.1"
	}
}
