unit DeepStack.Objectcontainter;

interface

uses System.Classes, System.Contnrs;

type
  TObjectcontainter = class
  strict private
    FContainer: TObjectList;
  public
    constructor Create;
    Destructor Destroy; override;
    function Add<T: class, constructor>: T; overload;
    function Add<T: class>(aObject: T): T; overload;
    procedure Clear;
  end;

implementation

{ TObjectcontainter }

function TObjectcontainter.Add<T>: T;
begin
  Result := Add(T.Create);
end;

function TObjectcontainter.Add<T>(aObject: T): T;
begin
  FContainer.Add(aObject);
  Result := aObject;
end;

procedure TObjectcontainter.Clear;
begin
  FContainer.Clear;
end;

constructor TObjectcontainter.Create;
begin
  inherited;
  FContainer := TObjectList.Create;
end;

destructor TObjectcontainter.Destroy;
begin
  FContainer.Free;
  inherited;
end;

end.
