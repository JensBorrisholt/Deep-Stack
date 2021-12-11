unit DeepStack.ObjectDetectionResult;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TPredictions = class
  private
    FConfidence: Double;
    FLabel: string;
    [JSONName('x_max')]
    FXMax: Integer;
    [JSONName('x_min')]
    FXMin: Integer;
    [JSONName('y_max')]
    FYMax: Integer;
    [JSONName('y_min')]
    FYMin: Integer;
  published
    property Confidence: Double read FConfidence write FConfidence;
    property &Label: string read FLabel write FLabel;
    property XMax: Integer read FXMax write FXMax;
    property XMin: Integer read FXMin write FXMin;
    property YMax: Integer read FYMax write FYMax;
    property YMin: Integer read FYMin write FYMin;
  end;

  TObjectDetectionResult = class(TJsonDTO)
  private
    FDuration: Integer;
    [JSONName('predictions'), JSONMarshalled(False)]
    FPredictionsArray: TArray<TPredictions>;
    [GenericListReflect]
    FPredictions: TObjectList<TPredictions>;
    FSuccess: Boolean;
    function GetPredictions: TObjectList<TPredictions>;
  protected
    function GetAsJson: string; override;
  published
    property Duration: Integer read FDuration write FDuration;
    property Predictions: TObjectList<TPredictions> read GetPredictions;
    property Success: Boolean read FSuccess write FSuccess;
  public
    destructor Destroy; override;
  end;

implementation

{ TObjectDetectionResult }

destructor TObjectDetectionResult.Destroy;
begin
  GetPredictions.Free;
  inherited;
end;

function TObjectDetectionResult.GetPredictions: TObjectList<TPredictions>;
begin
  Result := ObjectList<TPredictions>(FPredictions, FPredictionsArray);
end;

function TObjectDetectionResult.GetAsJson: string;
begin
  RefreshArray<TPredictions>(FPredictions, FPredictionsArray);
  Result := inherited;
end;

end.
