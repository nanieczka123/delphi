{function Sprawdzanie (var tab: array of string);
var p: integer;
begin
p:= ListBox1.Items.Count;
i:=1;
while i<=p do


end;}
  unit kolejka;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
TForm1 = class(TForm)
ListBox1: TListBox;
Button1: TButton;
Button2: TButton;
Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;

procedure Edit1Click(Sender: TObject);
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1Enter(Sender: TObject);
end;
type
wskaznik_kolejki = ^skladnik_kolejki;

skladnik_kolejki = record
wartosc: string;
wskaznik: wskaznik_kolejki
end;

complex = record
  re, im : Extended
  end;
var
plik3 : TextFile;
Form1: TForm1;
wartosc: string;
dane: string;
x: wskaznik_kolejki;
y: string;
s, i, j: integer;
nazwa: string;
a: boolean;

implementation

{$R *.dfm}

procedure DoKolejki (var element: string; var koniec_kolejki: wskaznik_kolejki);
var punkt: wskaznik_kolejki;
begin
a:=false;
punkt:=koniec_kolejki;
New(koniec_kolejki);
with koniec_kolejki^ do
begin
dane:= element;
wskaznik:=nil
end;
if punkt<>nil then
punkt^.wskaznik:=koniec_kolejki
end;

procedure ZKolejki (var poczatek_kolejki: wskaznik_kolejki);
var punkt: wskaznik_kolejki;
begin
a:=false;
if poczatek_kolejki<>nil then
begin
with poczatek_kolejki^ do
begin
punkt:=wskaznik
end;
Dispose (poczatek_kolejki);
poczatek_kolejki:=punkt
end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
y:=edit1.Text;
if Length(y)<>0 then
begin
DoKolejki(y,x);
ListBox1.Items.Add(y);
end;
end;
procedure TForm1.Edit1Enter(Sender: TObject);
begin
y:=edit1.Text;
if Length(y)<>0 then
begin
DoKolejki(y,x);
ListBox1.Items.Add(y);
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ZKolejki(x);
ListBox1.Items.Delete(ListBox1.Items.Count-1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
nazwa:= '';
if PromptForFileName(nazwa,'Pliki tekstowe (*.txt)|*.TXT','','Kolejka','',False)
then
begin
if ListBox1.Items.Count > 0 then
begin
s:=MessageDlg('Czy chcesz nadpisa� kolejk�?',mtInformation,mbYesNo,0);
case s of
mrYes:
begin
 i:=0;
 j:=ListBox1.Items.Count;
while i<j do
begin
   ZKolejki(x);
   ListBox1.Items.Delete(ListBox1.Items.Count-1);
   i:=i+1;
end;
end;
end;
AssignFile (plik3, nazwa);
Reset (plik3);
while not Eof(plik3) do
  begin
    Readln(plik3, y);
    if Length(y)<>0 then
      begin
       DoKolejki(y,x);
       ListBox1.Items.Add(y);
      end;
  end;
CloseFile(plik3);
end;
end;
end;


procedure TForm1.Button5Click(Sender: TObject);
begin
nazwa:= '';
if PromptForFileName(nazwa,'','Pliki tekstowe (*.txt)|*.TXT','Kolejka','',True)
then
begin
AssignFile (plik3, nazwa);
Rewrite (plik3);
i:=0;
while i <> ListBox1.Items.Count do
begin
  WriteLn(plik3,ListBox1.Items[i]);
  a:=true;
  i:=i+1;
end;
CloseFile(plik3);
end;
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
edit1.Clear
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var  msg: String;
begin
if a=false then
begin
if ListBox1.Items.Count<>0 then
begin
msg:='Nie zapisano, czy na pewno chcesz wyj��?';
if MessageDlg(msg, mtWarning, [mbOk, mbCancel], 0) = mrCancel then
    CanClose := false;
end;
end;
end;



end.


