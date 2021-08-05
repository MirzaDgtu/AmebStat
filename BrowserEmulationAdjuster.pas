unit BrowserEmulationAdjuster;

interface

uses
  Winapi.Windows, System.IOUtils, System.SysUtils, System.Classes, Winapi.Messages,  System.Win.Registry;

type TBrowserEmulationAdjuster = class
  private
      class function GetExeName(): String; inline;
   public const
      // Quelle: https://msdn.microsoft.com/library/ee330730.aspx, Stand: 2017-04-26
      IE11_default   = 11000;
      IE11_Quirks    = 11001;
      IE10_force     = 10001;
      IE10_default   = 10000;
      IE9_Quirks     = 9999;
      IE9_default    = 9000;
      /// <summary>
      /// Webpages containing standards-based !DOCTYPE directives are displayed in IE7
      /// Standards mode. Default value for applications hosting the WebBrowser Control.
      /// </summary>
      IE7_embedded   = 7000;
   public
      class procedure SetBrowserEmulationDWORD(const value: DWORD);
end platform;

implementation

class function TBrowserEmulationAdjuster.GetExeName(): String;
begin
    Result := TPath.GetFileName( ParamStr(0) );
end;

class procedure TBrowserEmulationAdjuster.SetBrowserEmulationDWORD(const value: DWORD);
const registryPath = 'Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION';
var
    registry:   TRegistry;
    exeName:   String;
begin
    exeName := GetExeName();

    registry := TRegistry.Create(KEY_SET_VALUE);
    try
       registry.RootKey := HKEY_CURRENT_USER;
       Win32Check( registry.OpenKey(registryPath, True) );
       registry.WriteInteger(exeName, value)
    finally
       registry.Destroy();
    end;
end;
end.
