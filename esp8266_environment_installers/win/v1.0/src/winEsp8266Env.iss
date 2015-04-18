#define MyAppName "ESP8266 Environment"
#define MyAppVersion "1.0"

[Setup]
AppId={{2F174E48-CC02-4D46-AB07-65FB859F753F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
DisableDirPage=no

[Files]
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\python-2.7.msi"; Flags: dontcopy
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\pyserial-2.7.win32.exe"; Flags: dontcopy
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\unzipper.dll"; Flags: dontcopy

Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\ESP8266Flasher.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\esptool.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\admin\Google Drive\Uni 2015\STP\downloads\ESPlorer.zip"; DestDir: "{app}"; AfterInstall: ExtractMe('{app}\ESPlorer.zip', '{app}');

[code]
#define MinJRE "1.6"

function InitializeSetup: Boolean;
var
  ErrorCode: Integer;
  PythonInstalled: Boolean;
  Result1: Boolean;
  WebJRE: string;
  psd: string;
begin
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
  end   
end;

procedure unzip(src, target: AnsiString);
external 'unzip@files:unzipper.dll stdcall delayload';

procedure ExtractMe(src, target : AnsiString);
begin
  unzip(ExpandConstant(src), ExpandConstant(target));
end;