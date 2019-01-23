program Project10;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Unit7 in 'Unit7.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
