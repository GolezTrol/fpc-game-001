unit uPainter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, LCLType;

type

  { TGamePainter }

  TGamePainter = class
    FStep: UInt64;
    FKeys: array[0..255] of Boolean;
    procedure Render(const AFrameReady: TNotifyEvent);
    procedure Paint(const ACanvas: TCanvas);
  end;

implementation

{ TGamePainter }

procedure TGamePainter.Render(const AFrameReady: TNotifyEvent);
begin
  AFrameReady(nil);
end;

procedure TGamePainter.Paint(const ACanvas: TCanvas);
var
  s: String;
  i: Integer;
begin
  s := IntToStr(FStep) + ' ';
  for i := Ord('A') to Ord('Z') do
    if FKeys[i] then
      s := S + Chr(i);
  ACanvas.TextOut(20, 20, s);
end;

end.

