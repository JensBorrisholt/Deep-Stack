unit DeepStack.Request;

interface

uses System.Net.HttpClient, System.Net.HttpClientComponent, System.Net.Mime, System.Classes,

  Vcl.Graphics,

  DeepStack.ObjectDetectionResult, DeepStack.Objectcontainter;
{$M+}

type
  TObjectDetectionRequest = class
  strict private
  private
    FNetHTTPClient: TNetHTTPClient;
    FUrl: string;
    FImage: TBitmap;
    FPostStream: TMemoryStream;
    FObjectcontainter: TObjectcontainter;
    FDetectionResult: TObjectDetectionResult;
    FPostBody: TMultipartFormData;
    procedure SetImage(const Value: TBitmap);
  published
    property URL: string read FUrl write FUrl;
    property Image: TBitmap read FImage write SetImage;
    property DetectionResult: TObjectDetectionResult read FDetectionResult;
  public
    constructor Create;
    destructor Destroy; override;
    function Post(aOwnsObject: Boolean = True): TObjectDetectionResult;
  end;

implementation

uses System.SysUtils;

{ TObjectDetection }

constructor TObjectDetectionRequest.Create;
begin
  inherited;
  FObjectcontainter := TObjectcontainter.Create;
  FNetHTTPClient := FObjectcontainter.Add(TNetHTTPClient.Create(nil));
  FPostStream := FObjectcontainter.Add<TMemoryStream>;
  FPostBody := FObjectcontainter.Add(TMultipartFormData.Create);
end;

destructor TObjectDetectionRequest.Destroy;
begin
  FreeAndNil(FObjectcontainter);
  inherited;
end;

function TObjectDetectionRequest.Post(aOwnsObject: Boolean = True): TObjectDetectionResult;
begin
  FPostStream.Position := 0;
  FPostBody.AddStream('image', FPostStream, 'image.bmp');

  Result := TObjectDetectionResult.Create;
  Result.AsJson := FNetHTTPClient.Post(URL, FPostBody).ContentAsString;
  FDetectionResult := Result;
  if aOwnsObject then
    FObjectcontainter.Add(Result);
end;

procedure TObjectDetectionRequest.SetImage(const Value: TBitmap);
begin
  FImage := FObjectcontainter.Add(Value);
  FPostStream.Clear;
  Value.SaveToStream(FPostStream);
end;

end.
