unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.ComCtrls, Vcl.ExtCtrls, TlHelp32, ShellApi, Vcl.Menus, IdAuthentication;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    HotKey1: THotKey;
    TrayIcon1: TTrayIcon;
    Label5: TLabel;
    Timer1: TTimer;
    Edit2: TEdit;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    Info1: TMenuItem;
    showForm11: TMenuItem;
    Exit1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Exit1Click(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure showForm11Click(Sender: TObject);
    procedure TrayIcon1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    hk1: Integer;
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
  if Msg.HotKey = hk1 then
  begin
    SpeedButton2.Click;
    TrayIcon1.BalloonTitle := 'IP:' + Edit1.text;;
    TrayIcon1.BalloonFlags := bfInfo;
    TrayIcon1.BalloonHint := Label1.caption + ' ' + Label3.Caption;
    TrayIcon1.ShowBalloonHint;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  idhttp1.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
 VK_Q = $51;
begin
  Memo1.Clear;
  Memo1.Visible := false;
  hk1 := GlobalAddAtom('Hotkey1');
  RegisterHotKey(Handle, hk1, MOD_CONTROL, VK_Q);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnRegisterHotKey(Handle, hk1);
  GlobalDeleteAtom(hk1);
end;

procedure TForm1.FormResize(Sender: TObject);
var
  hwndOwner: HWnd;
begin
  if Form1.WindowState = wsMinimized then
  begin
    Application.ProcessMessages;
    TrayIcon1.Visible := True;
    TrayIcon1.Animate := True;
    Timer1.Enabled := true;

    hwndOwner := GetWindow(Handle, GW_OWNER);
    ShowWindow(hwndOwner, SW_HIDE);
    ShowWindowAsync(hwndOwner, SW_HIDE);
    ShowWindowAsync(Self.Handle, SW_HIDE);
  end else TrayIcon1.Visible:= False;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Edit1.CopyToClipboard;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  anzahl, anzahl_land, anzahl_region: byte;
  ps, ps1, psl, psl1, psr, psr1: cardinal;
begin
  idhttp1.HandleRedirects:= False;
  idHttp1.Request.UserAgent:= 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0';
  Memo1.Text:= idHttp1.get('http://www.ip-secrets.info/');

  //ip
  ps:= Pos('Ihre aktuelle IP-Adresse: <font color="#FFFF33">', Memo1.Text);
  ps1:= Pos('</font> <font color="', Memo1.Text);
  anzahl:= ps1 - ps -13 - length('Ihre aktuelle IP-Adresse: <font color="#FFFF33">');
  Edit1.Text:= copy(Memo1.Text, ps + length('Ihre aktuelle IP-Adresse: <font color="#FFFF33">'), anzahl);

  //land
  psl:= Pos('Ihr Herkunftsland: <font color="#FFFF33">', Memo1.Text) +1;
  psl1:= Pos('</font><br />', Memo1.Text);
  anzahl_land:= psl1 - psl - length('Ihr Herkunftsland: <font color="#FFFF33"');
  Label3.Caption:= copy(Memo1.Text, psl + length('Ihr Herkunftsland: <font color="#FFFF33"'), anzahl_land);


  //region
  if Pos('Ihre Region:',Memo1.Text) <> 0 then
  begin
    psr:= Pos('Ihre Region:', Memo1.Text) +1;
    psr1:= Pos('<br>				</font>', Memo1.Text);
    anzahl_region:= psr1 - psr - length('Ihre Region:');
    Label4.Caption:= copy(Memo1.Text, psr + length('Ihre Region:'), anzahl_region);
  end
  else Label4.Caption:= 'Not Recognizable';

  if Timer1.Interval < 59999 then IdHttp1.Free;                //socket freigeben, wenn timer groeser gleich 10min
 end;


procedure TForm1.SpeedButton3Click(Sender: TObject);           //timer intervall setzen
begin
  Timer1.Interval := strtoint(Edit2.Text) * 60000;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    SpeedButton2.Click;
    TrayIcon1.BalloonTitle := 'IP:' + Edit1.text;;
    TrayIcon1.BalloonFlags := bfInfo;
    TrayIcon1.BalloonHint := Label1.caption + ' ' + Label3.Caption;
    TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  WindowState := wsNormal;
  Application.BringToFront;
  TrayIcon1.Visible := False;
  Timer1.Enabled := False;
end;

procedure TForm1.TrayIcon1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Pos: TSmallPoint;
begin
  Pos := TSmallPoint(GetMessagePos());

  if Button = TMouseButton.mbLeft then;
  if Button = TMouseButton.mbRight then
    begin
      PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      PostMessage(Handle, WM_NULL, 0, 0);
    end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);    //nur zahlen im edit2
begin
  if not (Key in ['0'..'9', Char(VK_BACK)]) then Key := #0;
end;


procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
  Application.ProcessMessages;
end;

procedure TForm1.Info1Click(Sender: TObject);
begin
    SpeedButton2.Click;
    TrayIcon1.BalloonTitle := 'IP:' + Edit1.text;;
    TrayIcon1.BalloonFlags := bfInfo;
    TrayIcon1.BalloonHint := Label1.caption + ' ' + Label3.Caption;
    TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.showForm11Click(Sender: TObject);
begin
  WindowState := wsNormal;
  Application.BringToFront;
  TrayIcon1.Visible := False;
  Timer1.Enabled := False;
end;

end.
