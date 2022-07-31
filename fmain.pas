unit fMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  uInput,
  uGame;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private
    FGame: TGame;
  public
    procedure DoFrameReady(Sender: TObject);
    procedure DoGameEnded(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := FGame.Terminated;
  if not CanClose then
    FGame.Terminated := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FGame := TGame.Create;
  FGame.OnFrameReady := @DoFrameReady;

  TThread.ExecuteInThread(@FGame.Run, @DoGameEnded);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FGame.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  FGame.Input.DoKeyDown(Key, Shift);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FGame.Input.DoKeyUp(Key, Shift);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  FGame.Painter.Paint(Canvas);
end;

procedure TForm1.DoFrameReady(Sender: TObject);
begin
  Repaint;
end;

procedure TForm1.DoGameEnded(Sender: TObject);
begin
  Close;
end;

end.

