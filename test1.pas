{$mode delphi}{$H+}
{$L fpcinit.obj}
{$L Strings.obj}
//program test2;

unit test1;

interface

procedure ExitProcess(AValue: Integer); external 'kernel32.dll';
procedure EntryPoint;

implementation

procedure EntryPoint;
begin
  ExitProcess(42);
end;

begin
  ExitProcess(21);
end.
