program DeepStackDemo;

uses
  Vcl.Forms,
  DeepStack.Main in 'DeepStack.Main.pas' {FormMain},
  DeepStack.ObjectDetectionResult in 'DTO\DeepStack.ObjectDetectionResult.pas',
  Pkg.Json.DTO in 'DTO\Pkg.Json.DTO.pas',
  DeepStack.Request in 'DeepStack.Request.pas',
  DeepStack.Objectcontainter in 'DeepStack.Objectcontainter.pas',
  DeepStack.ClipboardFormatListener in 'DeepStack.ClipboardFormatListener.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
