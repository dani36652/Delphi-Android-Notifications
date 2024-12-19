unit Unit1;

interface

uses
  {$IFDEF ANDROID}
  Androidapi.JNI.Webkit, FMX.VirtualKeyboard,
  Androidapi.JNI.Print, Androidapi.JNI.Util,
  fmx.Platform.Android, System.Android.Notification,
  Androidapi.jni,fmx.helpers.android, Androidapi.Jni.app,
  Androidapi.Jni.GraphicsContentViewText, Androidapi.JniBridge,
  Androidapi.JNI.Os, Androidapi.Jni.Telephony,
  Androidapi.JNI.JavaTypes,Androidapi.Helpers,
  Androidapi.JNI.Widget,System.Permissions, Androidapi.Jni.Embarcadero,
  FMX.DialogService,Androidapi.Jni.Provider,Androidapi.Jni.Net,
  fmx.TextLayout,AndroidAPI.JNI.Support,
 {$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.DateUtils,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Notification, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    NotificationC: TNotificationCenter;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Borra_Notifi(Id : String; FH : String);
    procedure Crear_Notificacion(Sujeto, Ir_A, Motivo , Dia, Hora, Notif_ID : String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  System.RegularExpressions;

{$R *.fmx}

procedure TForm1.Borra_Notifi(Id, FH: String);

  function DateTimeLocalToUnixMSecGMT(const ADateTime: TDateTime): Int64;
  begin
    Result := DateTimeToUnix(ADateTime) * MSecsPerSec - Round(TTimeZone.Local.UtcOffset.TotalMilliseconds);
  end;
begin
  NotificationC.CancelNotification(Id);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Crear_Notificacion('blah, blah', 'okok', 'no lo sé', '19/12/2024', '12:41', 'noti1');
  Crear_Notificacion('blah, blah', 'okok', 'no lo sé', '19/12/2024', '12:42', 'noti2');
  Crear_Notificacion('blah, blah', 'okok', 'no lo sé', '19/12/2024', '12:43', 'noti3');
  Crear_Notificacion('blah, blah', 'okok', 'no lo sé', '19/12/2024', '12:44', 'noti4');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Borra_Notifi('noti2', '18/12/2024 12:42');
  Borra_Notifi('noti3', '18/12/2024 12:43');
  Borra_Notifi('noti4', '18/12/2024 12:44');
end;

procedure TForm1.Crear_Notificacion(Sujeto, Ir_A, Motivo, Dia, Hora,
  Notif_ID: String);
var
  vNotification : TNotification;
  Fecha : TdateTime;
begin
  try
    // Borra_Notifi(Notif_ID,Dia+' '+Hora); No es necesario si no cambia vNotification.Name
    vNotification := NotificationC.CreateNotification;

    vNotification.Title := Sujeto;
    vNotification.AlertBody := Motivo+Ir_A;
    vNotification.EnableSound := true;
    vNotification.Name := Notif_ID;
    Fecha := strToDateTime(Dia+' '+Hora);

    vNotification.FireDate:= Fecha;
    NotificationC.ScheduleNotification(vNotification);

  finally
    vNotification.Free;
  end;

end;

end.
