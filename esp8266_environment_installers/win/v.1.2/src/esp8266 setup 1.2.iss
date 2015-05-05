#define MyAppName "ESP8266 Environment"
#define MyAppVersion "1.2"

[Setup]
AppId={{865E8B0D-9735-4977-A717-5C2130DED092}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
DisableDirPage=no

[Files]
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\python-2.7.msi"; Flags: dontcopy
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\pyserial-2.7.win32.exe"; Flags: dontcopy
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\unzipper.dll"; Flags: dontcopy
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\LuaForWindows_v5.1.4-46.exe";Flags: dontcopy

Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\ESP8266Flasher.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\esptool.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\installer\included_files\extract.zip"; DestDir: "{app}"; AfterInstall: ExtractMe('{app}\extract.zip', '{app}');

[code]

//; Both DecodeVersion and CompareVersion functions where taken from the wiki
procedure DecodeVersion (verstr: String; var verint: array of Integer);
var
  i,p: Integer; s: string;
begin
  // initialize array
  verint := [0,0,0,0];
  i := 0;
  while ((Length(verstr) > 0) and (i < 4)) do
  begin
    p := pos ('.', verstr);
    if p > 0 then
    begin
      if p = 1 then s:= '0' else s:= Copy (verstr, 1, p - 1);
      verint[i] := StrToInt(s);
      i := i + 1;
      verstr := Copy (verstr, p+1, Length(verstr));
    end
    else
    begin
      verint[i] := StrToInt (verstr);
      verstr := '';
    end;
  end;
end;

function CompareVersion (ver1, ver2: String) : Integer;
var
  verint1, verint2: array of Integer;
  i: integer;
begin

  SetArrayLength (verint1, 4);
  DecodeVersion (ver1, verint1);

  SetArrayLength (verint2, 4);
  DecodeVersion (ver2, verint2);

  Result := 0; i := 0;
  while ((Result = 0) and ( i < 4 )) do
  begin
    if verint1[i] > verint2[i] then
      Result := 1
    else
      if verint1[i] < verint2[i] then
        Result := -1
      else
        Result := 0;
    i := i + 1;
  end;

end;

procedure unzip(src, target: AnsiString);
external 'unzip@files:unzipper.dll stdcall delayload';

procedure ExtractMe(src, target : AnsiString);
begin
  MsgBox('unzipping', mbInformation, MB_OK);
  unzip(ExpandConstant(src), ExpandConstant(target));
end;


#define MinJRE "1.6"
function InitializeSetup: Boolean;
var
  ErrorCode: Integer;
  PythonInstalled: Boolean;
  Result1: Boolean;
  WebJRE: string;
  psd: string;
  JavaVer : String;
begin
  RegQueryStringValue(HKLM, 'SOFTWARE\JavaSoft\Java Runtime Environment', 'CurrentVersion', JavaVer);
  Result := false;
  if Length( JavaVer ) > 0 then
  begin
    if CompareVersion(JavaVer,'1.6') >= 0 then
    begin
      Result := true;
    end;
  end;
  if Result = false then
  begin
    Result1 := MsgBox('This tool requires Java Runtime Environment v1.6 or older to run. Please download and install JRE and run this setup again.' + #13 + #10 + 'Do you want to download it now?',
      mbConfirmation, MB_YESNO) = idYes;
    if Result1 = true then
    begin
      ShellExec('open',
        'http://www.java.com/en/download/manual.jsp#win',
        '','',SW_SHOWNORMAL,ewNoWait,ErrorCode);
    end;
  end;

  PythonInstalled := RegKeyExists(HKLM, 'SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath');
  if PythonInstalled then
  begin
    MsgBox('python installed', mbInformation, MB_OK);
  end
  else
  begin
    Result1 := MsgBox('This tool requires python Runtime Environment  to run.  Do you want to install it now ?', mbConfirmation, MB_YESNO) = IDYES;
    if not Result1 then
    begin    
      Result := False;
    end 
    else
    begin
      MsgBox('python 2.7 will be installed', mbInformation, MB_OK);
      ExtractTemporaryFile('python-2.7.msi')
      WebJRE:='"'+Expandconstant('{tmp}\python-2.7.msi')+'"'
      Exec('cmd.exe ','/c'+WebJRE,'', SW_HIDE,ewWaituntilterminated, Errorcode);
    end;
  end;

  PythonInstalled := RegKeyExists(HKLM, 'SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath');
  if PythonInstalled then
  begin
    if RegQueryStringValue(HKLM, 'SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath', '', psd) then
    begin
      psd:=psd + '\Lib\site-packages\serial'
    end
    else
    begin
      MsgBox('python not installed, exiting', mbInformation, MB_OK);
      Result := False;
    end
    if Direxists(psd) then
    begin
        MsgBox('pyserial installed', mbInformation, MB_OK);
        Result := True;
    end
    else
    begin
      MsgBox('pyserial will be installed', mbInformation, MB_OK);
      ExtractTemporaryFile('pyserial-2.7.win32.exe')
      WebJRE:='"'+Expandconstant('{tmp}\pyserial-2.7.win32.exe')+'"'
      Exec('cmd.exe ','/c'+WebJRE,'', SW_HIDE,ewWaituntilterminated, Errorcode);
      Result := True;
    end

    Result1 := MsgBox('NodeMCU firmware uses the lua scripting language.  Do you want to install lua and an IDE for lua now ?', mbConfirmation, MB_YESNO) = IDYES;
    if Result1 then
    begin
      MsgBox('lua for windows will be installed(LuaForWindows_v5.1.4-46.exe)', mbInformation, MB_OK);
      ExtractTemporaryFile('LuaForWindows_v5.1.4-46.exe')
      WebJRE:='"'+Expandconstant('{tmp}\LuaForWindows_v5.1.4-46.exe')+'"'
      Exec('cmd.exe ','/c'+WebJRE,'', SW_HIDE,ewWaituntilterminated, Errorcode);
    end
  end
end;