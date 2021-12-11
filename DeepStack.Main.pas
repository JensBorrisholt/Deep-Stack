unit DeepStack.Main;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  DeepStack.ObjectDetectionResult, Vcl.ComCtrls;

type
  TFormMain = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure DrawPredictions(aDetectionResult: TObjectDetectionResult);
    procedure CreateRequest;
  public
    { Public declarations }

  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses Vcl.Clipbrd, System.Threading,
  DeepStack.Request, DeepStack.ClipboardFormatListener;

procedure TFormMain.CreateRequest;
begin
  var
  Bitmap := TBitmap.Create;
  Bitmap.Assign(Clipboard);
  Image1.Picture.Assign(Bitmap);
  StatusBar1.Panels[0].Text := 'Contacting server ...';
  TTask.Run(
    procedure
    var
      Request: TObjectDetectionRequest;
    begin
      Request := TObjectDetectionRequest.Create;
      try
        Request.URL := 'http://localhost:8081/v1/vision/detection';
        Request.Image := Bitmap;
        Request.Post;

        TThread.Synchronize(nil,
          procedure
          begin
            with Request.DetectionResult do
              StatusBar1.Panels[0].Text := 'Request result: ' + Success.ToString(TUseBoolStrs.True) + '. Predictions: ' + (Predictions.Count > 0).ToString(TUseBoolStrs.True);

            DrawPredictions(Request.DetectionResult);
          end);
      finally
        Request.Free;
      end;
    end);
end;

procedure TFormMain.DrawPredictions(aDetectionResult: TObjectDetectionResult);
begin
  if not aDetectionResult.Success then
    exit;

  for var prediction in aDetectionResult.Predictions do
    with Image1.Picture.Bitmap.Canvas do
    begin
      Pen.Width := 3;
      Pen.Color := clYellow;
      Brush.Style := TBrushStyle.bsClear;
      Font.Color := clYellow;
      Font.Size := 12;
      Rectangle(prediction.XMin, prediction.YMin, prediction.YMax, prediction.YMax);

      TextOut(prediction.XMin + 15, prediction.YMin + 15, prediction.&Label + Round(prediction.Confidence * 100).ToString + '%');
    end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  TClipboardFormatListener.Create(Self, [CF_BITMAP]).ClipboardUpdated := procedure(aFormat: Integer)
    begin
      CreateRequest;
    end;
end;

end.
