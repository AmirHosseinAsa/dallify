; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Dallify"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Zodipa"
#define MyAppExeName "dallify.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{54519B18-B114-4FEF-A2FD-0C6479E1D767}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
OutputDir=C:\Users\Amirhossein\StudioProjects\dallify\installer
OutputBaseFilename=DallifySetup
SetupIconFile=C:\Users\Amirhossein\StudioProjects\dallify\installer\icon.ico
Compression=lzma
SolidCompression=yes
Uninstallable=no
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Amirhossein\StudioProjects\dallify\installer\VC_redist.x86.exe"; DestDir: {tmp}
Source: "C:\Users\Amirhossein\StudioProjects\dallify\installer\VC_redist.x64.exe"; DestDir: {tmp}
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\bitsdojo_window_windows_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\dallify.exp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\dallify.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\msvcp140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\screen_retriever_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\window_manager_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\vcruntime140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\Amirhossein\StudioProjects\dallify\build\windows\runner\Release\python\*"; DestDir: "{app}\python"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{tmp}\VC_redist.x86.exe"; Parameters: "/q /norestart"; \
    Check: Is64BitInstallMode; \
    Flags: waituntilterminated; \
    StatusMsg: "Installing VC++ 2015-2022 redistributables..."
Filename: "{tmp}\VC_redist.x64.exe"; Parameters: "/q /norestart"; \
    Check: (not Is64BitInstallMode); \
    Flags: waituntilterminated; \
    StatusMsg: "Installing VC++ 2015-2022 redistributables..."
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

