unit uInput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType;

type

  { TGameInput }

  TKeyBufferItem = record
    Key: Word;
    Shift: TShiftState;
    Up: Boolean;
  end;

  TGameInput = class
    KeyboardState: array[0..255] of Boolean;
    Buffer: TKeyBufferItem;
    procedure DoKeyDown(var Key: Word; Shift: TShiftState);
    procedure DoKeyUp(var Key: Word; Shift: TShiftState);
  end;

implementation

{ TGameInput }

procedure TGameInput.DoKeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key < 256 then
    KeyboardState[Key] := True;
end;

procedure TGameInput.DoKeyUp(var Key: Word; Shift: TShiftState);
begin
  if Key < 256 then
    KeyboardState[Key] := False;
end;

end.

