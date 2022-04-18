;Chequeo de Lenguaje activo del teclado

Lenguajeactivo := DllCall("GetKeyboardLayout", "UInt", 0)
If (lenguajeactivo != 134874121) 
{
    MsgBox, Verifique que el lenguaje del su Windows sea ENG LAA y Reinicie el Script (F3).
    return
}

;Variables de conteo
documentos := 0
tiempoacumulado := 0
tiempoacumuladoeo := 0
tiempoacumuladoto := 0
tiempoacumuladotd := 0
tiempoacumuladoad := 0
tiempoacumuladoeb := 0
tiempoacumuladosl := 0
tiempoacumuladosb := 0
Counteo := 0
Countto := 0
Counttd := 0
Countad := 0 
Countsb := 0
Countsl := 0
Counteb := 0
tiempoeoref := 40.8
tiemposbref := 55.4
tiempoadref := 49.7
tiempotoref := 41.1
tiempoebref := 38.8
tiempotdref := 38.7
tiemposlref := 32.4

;Creacion y revision del archivo de conteo
if FileExist("C:\InfoNax\NaxControl")
{
    if FileExist("C:\InfoNax\NaxControl")
	{
		FileGetTime, actualizacion, C:\InfoNax\NaxControl
		fecha_recortada := SubStr(actualizacion, 1, 8)
		FormatTime, hoy, A_now, yyyyMMdd
		comparacion := fecha_recortada - hoy
		if (comparacion = 0)
		{
			Loop, read, C:\InfoNax\NaxControl
            last_line := A_LoopReadLine
            word := StrSplit(last_line, ";")
            documentos := word[1]
            tiempoacumulado := word[2]
            tiempoacumuladoeo := word[4]
            tiempoacumuladoto := word[6]
            tiempoacumuladotd := word[8]
            tiempoacumuladoad := word[10]
            tiempoacumuladoeb := word[14]
            tiempoacumuladosl := word[16]
            tiempoacumuladosb := word[12]
            Counteo := word[3]
            Countto := word[5]
            Counttd := word[7]
            Countad := word[9]
            Countsb := word[11]
            Countsl := word[15]
            Counteb := word[13]
            MsgBox, 
			(
			Ctrl + NumPad1: Abrir ventana para indexar
			
			
Nota: Si SOU está lento no usar el Script.
			)
			return
		}
		else
		{
            Sleep, 300
			FileDelete, C:\InfoNax\NaxControl
            Sleep, 1000
			FileAppend, 0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;`n, C:\InfoNax\NaxControl
             MsgBox, 
			(
			Ctrl + NumPad1: Abrir ventana para indexar
			
			
Nota: Si SOU está lento no usar el Script.
			)
			return
		}
	}
	else
	{
        Sleep, 300
		FileAppend, 0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;`n, C:\InfoNax\NaxControl
         MsgBox, 
			(
			Ctrl + NumPad1: Abrir ventana para indexar
			
			
Nota: Si SOU está lento no usar el Script.
			)
        return
	}
}
else
{
FileCreateDir, C:\InfoNax
FileAppend, 0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;`n, C:\InfoNax\NaxControl
 MsgBox, 
			(
			Ctrl + NumPad1: Abrir ventana para indexar
			
			
Nota: Si SOU está lento no usar el Script.
			)
return
}

Return

;Abrir ventana para indexar
^NumPad1::
Gui, Add, Text, x12 y9 w300 h20 , Haga doble click sobre el SLD inicial y presione
Gui, Add, Text, x12 y24 w300 h20 , Ctrl + NumPad0: Copiar Date y Location
Gui, Add, Text, x12 y59 w100 h20 , Ingrese la referencia
Gui, Add, Edit, x12 y79 w270 h20 vreference, 
Gui, Add, Button, x12 y119 w100 h30 gGuiIndexar, Indexar
Gui, Add, Button, x102 y299 w100 h30 gGuiCancelar, Cancelar
Gui, Add, Button, x12 y189 w180 h30 gGuiIndexarB, Indexar Borescope
Gui, Add, Button, x12 y239 w180 h30 gGuiIndexarR, Indexar Damage and Repairs
Gui, Add, Text, x122 y129 w100 h20 , (Ctrl + I)
Gui, Add, Text, x202 y199 w100 h20 , (Ctrl + B)
Gui, Add, Text, x202 y249 w100 h20 , (Ctrl + R)
Gui, Add, Text, x12 y369 w270 h30 , 
(
Al terminar la asigacion dirijase al Doc Count. y presione 
Ctrl + T en la casilla Time
)
Gui, Add, Text, x12 y420 w270 h30 , F4: Salir de la aplicacion
; Generated using SmartGUI Creator for SciTE
Gui, Show, w299 h445, Indexing Level 2
return

;Salir de AHK
GuiClose:
ExitApp
return

;Salir de GUI
GuiCancelar:
Gui, Destroy
return

;Copiar Date y Location
^NumPad0::

StartTime := A_TickCount

Send, ^C
Sleep, 1000
Fecha := clipboard

	;Correccion de fecha
fecha := StrSplit(Fecha, "/")
mes:= fecha[1]
dia:= fecha[2]
year:= fecha[3]
LengthM := StrLen(mes)
LengthD := StrLen(dia)

if (LengthM < 2)
	{
	mesc:= "0"mes
	}	
	else
	{
	mesc:= mes
	}
	
	
if (LengthD < 2)
	{
	diac:= "0"dia
	}	
	else
	{
	diac:= dia
	}
	
date:= mesc "/" diac "/" year

Clipboard=
Send, {Tab 3}
Send, ^C
Sleep, 1000
location := clipboard
Clipboard=
Send, {Escape}

ElapsedTime := A_TickCount - StartTime
segundos := ElapsedTime / 1000
tiempoacumulado := segundos + tiempoacumulado

		  gosub Append

return

;Indexar
^I::
GuiIndexar:

StartTime := A_TickCount

Gui, Submit, NoHide
StringUpper, reference, reference
Loop, read, C:\Users\%A_UserName%\AIRCRAFT DIGITAL COMPANY SAS\IT - Scripts_Data_Base\References - lvl2.txt

If (reference="")
{
return
}
else
IfInString, A_LoopReadLine, %reference%
{
	palabra := StrSplit(A_LoopReadLine, "@")
    EO := palabra[1]
    DescEO := palabra[2]
    SL := palabra[3]
    DescSL := palabra[4]
    AD := palabra[5]
    DescAD := palabra[6]
    SB := palabra[7]
    DescSB := palabra[8]
    EB := palabra[9]
    DescEB := palabra[10]
    TO := palabra[11]
    DescTO := palabra[12]
    TD := palabra[13]
    DescTD := palabra[14]
    MODS := palabra[15]
    DescMODS := palabra[16]  
	
	EO1 := "EO"
	SL1 := "SL"
	AD1 := "AD"
	SB1 := "SB"
	TO1 := "TO"	
	TD1 := "TD"
	EB1 := "EB"
	FA1 := "FAA"	
	Slash := "/"
	WO :=
	
	IndexCorrect := true
	IfVar := false
	
	ifNotInString, reference, %EO1%
	{
		ifNotInString, reference, %SL1%
		{
			ifNotInString, reference, %AD1%
			{
				ifNotInString, reference, %SB1%
				{
					ifNotInString, reference, %TO1%
					{
						ifNotInString, reference, %TD1%
						{
							ifNotInString, reference, %EB1%
							{
								ifNotInString, reference, %FA1%
								{
								MsgBox Ingrese el prefijo (EO, SL, AD, SB, TO, TD, EB o FAA)
								return
								}
							}
						}
					}
				}
			}
		}
	}
	
	
	ifInString, reference, %EO1%
	{
		gosub Inicio
		gosub EO2
		
		gosub ifSL
		gosub ifAD
		gosub ifSB
		gosub ifEB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
	
	ifInString, reference, %SL1%
	{
		gosub Inicio
		gosub SL2
		
		gosub ifEO
		gosub ifAD
		gosub ifSB
		gosub ifEB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
		
	ifInString, reference, %AD1%
	{
		gosub Inicio
		gosub AD2
		
		gosub ifEO
		gosub ifSL
		gosub ifSB
		gosub ifEB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
		
	ifInString, reference, %SB1%
	{
		gosub Inicio
		gosub SB2
		
		gosub ifEO
		gosub ifSL
		gosub ifAD
		gosub ifEB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
		
	ifInString, reference, %TO1%
	{
		gosub Inicio
		gosub TO2
		
		gosub ifEO
		gosub ifSL
		gosub ifAD
		gosub ifSB
		gosub ifEB
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
		
	ifInString, reference, %TD1%
	{
		gosub Inicio
		gosub TD2
		
		gosub ifEO
		gosub ifSL
		gosub ifAD
		gosub ifSB
		gosub ifEB
		gosub ifTO
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else

	ifInString, reference, %EB1%
	{
		gosub Inicio
		gosub EB2
		
		gosub ifEO
		gosub ifSL
		gosub ifAD
		gosub ifSB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
	else
	
	ifInString, reference, %FA1%
	{
		gosub Inicio
		gosub AD2
		
		gosub ifEO
		gosub ifSL
		gosub ifSB
		gosub ifEB
		gosub ifTO
		gosub ifTD
		
		if (IndexCorrect = true)
		{
		
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			Send, {Tab}
			Sleep 100
			if (IfVar = true)
			{
				Send, {Tab}
			}
		}
		
	}
		
		
	WO :=	
		
	return
}
MsgBox, Referencia no encontrada.
return


;Borescope
^B::
GuiIndexarB:

WinActivate, Stream - \\Remote
Send {F10}
WinWaitActive, Multi SLD/IML Creator - \\Remote
sleep 500
Send, {Tab 2}
send Borescope
send {Enter}
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 3}
send %location%
Send, {Tab 1}
Send, 2
Send, {Tab 8}
Return


;Damage and Repairs
^R::
GuiIndexarR:

WinActivate, Stream - \\Remote
Send {F10}
WinWaitActive, Multi SLD/IML Creator - \\Remote
sleep 500
Send, {Tab 2}
send Damage/Repair Details
send {Enter}
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 3}
send %location%
Send, {Tab 1}
Send, 2
Send, {Tab 2}
send 1002.0 - Structural Repairs
send {Enter}
Send, {Tab 6}
Return

;Ingresar tiempo en el Doc Count.
^T::
Loop, read, C:\InfoNax\NaxControl
last_line := A_LoopReadLine
word := StrSplit(last_line, ";")
cobroeo := word[3] * tiempoeoref
cobrosb := word[11] * tiemposbref
cobroad := word[9] * tiempoadref
cobroto := word[5] * tiempotoref
cobroeb := word[13] * tiempoebref
cobrotd := word[7] * tiempotdref
cobrosl := word[15] * tiemposlref
cobroreal := word[2]
cobrototalmodificado := cobroeo + cobrosb + cobroad + cobroto + cobroeb + cobrotd + cobrosl
alexcel := cobrototalmodificado - cobroreal 
Sleep, 300
SendRaw, %alexcel%
return



;LABELS

Inicio:
WinActivate, Stream - \\Remote
Send {F10}
WinWaitActive, Multi SLD/IML Creator - \\Remote
sleep 500
Send, {Tab 2}
return
	

EO2:
send Engineering Order
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %EO%
Send, {Tab 1}
description := DescEO
gosub Desc
gosub Continuacion
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Counteo += 1
segundos := ElapsedTime / 1000
tiempoacumuladoeo := segundos + tiempoacumuladoeo
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return
	
SL2:
send Mods
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %SL%
Send, {Tab 1}
description := DescSL
gosub Desc
gosub Continuacion
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Countsl += 1
segundos := ElapsedTime / 1000
tiempoacumuladosl := segundos + tiempoacumuladosl
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}
return
	
AD2:
send AD
send {Enter}
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %AD%
Send, {Tab 1}
description := DescAD
gosub ReplaceX
Send %description%
send {Backspace}
send {Up}
send {Home}
send {Delete}
send {Right 7}
gosub WO
send %WO%
gosub Continuacion
send 0303.0 - AD DFP
send {Enter}
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Countad += 1
segundos := ElapsedTime / 1000
tiempoacumuladoad := segundos + tiempoacumuladoad
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return
		
SB2:
send SB
send {Enter}
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %SB%
Send, {Tab 1}
description := DescSB
gosub ReplaceX
Send %description%
send {Backspace}
send {Up}
send {Home}
send {Delete}
send {Right 7}
gosub WO
send %WO%
gosub Continuacion
send 0401.2 - Boeing Service Bulletins & Letters DFP
send {Enter}
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Countsb += 1
segundos := ElapsedTime / 1000
tiempoacumuladosb := segundos + tiempoacumuladosb
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return
		
TO2:
send Technical Order
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %TO%
Send, {Tab 1}
description := DescTO
gosub Desc
gosub Continuacion
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Countto += 1
segundos := ElapsedTime / 1000
tiempoacumuladoto := segundos + tiempoacumuladoto
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return
		
TD2:
send Technical Order
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %TD%
Send, {Tab 1}
description := DescTD
gosub Desc
gosub Continuacion
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Counttd += 1
segundos := ElapsedTime / 1000
tiempoacumuladotd := segundos + tiempoacumuladotd
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return

EB2:
send Engineering Bulletin
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %EB%
Send, {Tab 1}
description := DescEB
gosub Desc
gosub Continuacion
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Counteb += 1
segundos := ElapsedTime / 1000
tiempoacumuladoeb := segundos + tiempoacumuladoeb
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return
	
FA2:
send AD
send {Enter}
sleep 100
Send, {Tab 1}
send %date%
Send, {Tab 1}
send %AD%
Send, {Tab 1}
description := DescAD
gosub ReplaceX
Send %description%
send {Backspace}
send {Up}
send {Home}
send {Delete}
gosub Continuacion
send 0303.0 - AD DFP
send {Enter}
Send, {Tab 2}

ElapsedTime := A_TickCount - StartTime
MsgBox, 4, Funcionamiento, ¿Se indexó correctamente?
IfMsgBox, yes
{
Sleep, 200
documentos += 1
Countad += 1
segundos := ElapsedTime / 1000
tiempoacumuladoad := segundos + tiempoacumuladoad
tiempoacumulado := segundos + tiempoacumulado
Sleep, 300
          gosub Append
return
}
else 
{
	IfMsgBox, no
	IndexCorrect := false
	WinActivate, Multi SLD/IML Creator - \\Remote
	Sleep, 100
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	Send, {Tab}
	Sleep 100
	if (IfVar = true)
	{
		Send, {Tab}
	}
	return
}

return


Desc:
IfInString, description, %Slash% 
{
InputBox, selec, 1: Parte IZQUIERDA / 2: Parte DERECHA o 3: Descripcion completa, %description%, , 600, 160
if (selec = 1)
  {
  gosub,Label
  }
  else if (selec = 2)
		{
			gosub, Label2
		}
  else if (selec = 3)
		{
			Sleep 500
			send %description%
		}
  }
else
Send %description%
return

Continuacion:
Send, {Tab 1}
send %location%
Send, {Tab 1}
Send, 2
Send, {Tab 2}
return


;IF

ifEO:
if (IndexCorrect = true)
{
IfNotEqual, EO,
{
	MsgBox, 4, Indexing, ¿Indexar EO?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub EO2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return	

ifSL:
if (IndexCorrect = true)
{
IfNotEqual, SL,
{
	MsgBox, 4, Indexing, ¿Indexar SL?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub SL2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return	

ifAD:
if (IndexCorrect = true)
{
IfNotEqual, AD,
{
	MsgBox, 4, Indexing, ¿Indexar AD?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub AD2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return	

ifSB:
if (IndexCorrect = true)
{
IfNotEqual, SB,
{
	MsgBox, 4, Indexing, ¿Indexar SB?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub SB2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return

ifEB:
if (IndexCorrect = true)
{
IfNotEqual, EB,
{
	MsgBox, 4, Indexing, ¿Indexar EB?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub EB2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return

ifTO:
if (IndexCorrect = true)
{
IfNotEqual, TO,
{
	MsgBox, 4, Indexing, ¿Indexar TO?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub TO2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return

ifTD:
if (IndexCorrect = true)
{
IfNotEqual, TD,
{
	MsgBox, 4, Indexing, ¿Indexar TD?
	IfMsgBox Yes
	{
		IfVar := true
		WinActivate, Multi SLD/IML Creator - \\Remote
		Sleep, 100
		Send, {Enter}	
		Send, +{Tab 9}
		gosub TD2
		return
	}
	else
	IfMsgBox No
	{
		return
	}
return
}
}
else
{
	return
}
return


ReplaceX:
StringCaseSense, On
StringReplace description, description, X, , All
return

WO:
IfEqual, WO,
{
	InputBox, WO, Indexing, Ingrese la referencia de la WO:, , 250, 130
	WinActivate, Multi SLD/IML Creator - \\Remote
	return
}
return

;Matriz de NaxControl
;|Documentos | Tiempo Acumulado | EOs | Tiempo EO | TOs | Tiempo TO | TDs | Tiempo TD | ADs | Tiempo AD | SBs | Tiempo SB | EBs | Tiempo EB | SLs | Tiempo SL |
;|           |                  |     |           |     |           |     |           |     |           |     |           |     |           |     |           |

Append:
FileAppend, %documentos%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumulado%;, C:\InfoNax\NaxControl
FileAppend, %Counteo%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladoeo%;, C:\InfoNax\NaxControl
FileAppend, %Countto%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladoto%;, C:\InfoNax\NaxControl
FileAppend, %Counttd%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladotd%;, C:\InfoNax\NaxControl
FileAppend, %Countad%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladoad%;, C:\InfoNax\NaxControl
FileAppend, %Countsb%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladosb%;, C:\InfoNax\NaxControl
FileAppend, %Counteb%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladoeb%;, C:\InfoNax\NaxControl
FileAppend, %Countsl%;, C:\InfoNax\NaxControl
FileAppend, %tiempoacumuladosl%; `n, C:\InfoNax\NaxControl
return


Label:
Needle := "/"
StringGetPos, posi, description, %Needle%
Sleep, 300
StringLeft, out, description, %posi%
Send, {Down 1} 
Send, %out%
return


Label2:
Needle := "/"
StringGetPos, posis, description, %Needle%
Sleep, 200
lenth := StrLen(description)
Sleep, 500
rest := lenth - posis
Sleep, 300
resta := rest - 1
sleep, 300
StringRight, out, description, %resta%
sleep, 300
Send, %out%
return



;Reload AHK
F3::
Reload

;Salir de AHK
F4::
exitapp