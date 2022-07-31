unit uGame;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Crt,
  LCLType,
  uInput, uPainter;

type
  { TGame }

  TGame = class
  private
    FGameInput: TGameInput;
    FGamePainter: TGamePainter;
    FOnFrameReady: TNotifyEvent;
    FTerminated: Boolean;
    FStep: UInt64;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure Finalize;
    procedure Step;
    procedure Act;
    procedure Move;
    procedure Draw;
    procedure Run;
    property Terminated: Boolean read FTerminated write FTerminated;
    property Input: TGameInput read FGameInput;
    property Painter: TGamePainter read FGamePainter;
    property OnFrameReady: TNotifyEvent read FOnFrameReady write FOnFrameReady;
  end;

implementation

{ TGame }

constructor TGame.Create;
begin
  fGameInput := TGameInput.Create;
  FGamePainter := TGamePainter.Create;
end;

destructor TGame.Destroy;
begin
  FGamePainter.Free;
  FGameInput.Free;
  inherited Destroy;
end;

procedure TGame.Initialize;
begin
  FStep := 0;
  FTerminated := False;
end;

procedure TGame.Finalize;
begin

end;

procedure TGame.Step;
begin
  Inc(FStep);
  Act;
  Move;
  Draw;
end;

procedure TGame.Act;
begin
  if Input.KeyboardState[VK_ESCAPE] then
    Terminated := True;
end;

procedure TGame.Move;
begin

end;

procedure TGame.Draw;
begin
  FGamePainter.FStep := FStep;
  FGamePainter.FKeys := FGameInput.KeyboardState;
  FGamePainter.Render(FOnFrameReady);
end;

procedure TGame.Run;
begin
  Initialize;
  while not Terminated do
  begin
    Step;
  end;
  Finalize;
end;

end.

