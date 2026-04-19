; Ventary Remote Client — Inno Setup script (MVP, unsigned)
; Installs ventary-remote.exe, registers the ventary-remote:// URI handler,
; and creates shortcuts. Run via:
;   "C:\Program Files (x86)\Inno Setup 6\iscc.exe" res\ventary-setup.iss

#define MyAppName        "Ventary Remote Client"
#define MyAppVersion     "1.4.6"
#define MyAppPublisher   "Ventary GmbH"
#define MyAppURL         "https://www.ventary.org/"
#define MyAppExeName     "ventary-remote.exe"
#define MyAppId          "{{A7F2E3C1-4B9D-4F8E-B1C6-VENTARY00REM}"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\Ventary Remote Client
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=..\..\dist
OutputBaseFilename=ventary-remote-client-setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
SetupIconFile=icon.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
PrivilegesRequired=admin

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german";  MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Main executable — expected at repo\target\release\ventary-remote.exe
Source: "..\target\release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion
; Sciter UI engine (dynamic, x64)
Source: "..\..\branding\dll\sciter.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\icon.ico"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\icon.ico"; Tasks: desktopicon

[Registry]
; Register the ventary-remote:// URI handler
Root: HKCR; Subkey: "ventary-remote"; ValueType: string; ValueName: ""; ValueData: "URL:Ventary Remote Protocol"; Flags: uninsdeletekey
Root: HKCR; Subkey: "ventary-remote"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKCR; Subkey: "ventary-remote\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKCR; Subkey: "ventary-remote\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{app}\{#MyAppExeName}"; Parameters: "--uninstall"; RunOnceId: "VentaryUninstall"; Flags: skipifdoesntexist
