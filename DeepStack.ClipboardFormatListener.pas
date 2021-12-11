unit DeepStack.ClipboardFormatListener;

interface

uses Winapi.Windows, Winapi.Messages, System.Classes, VCl.Controls;
{$M+}

type
  TClipboardFormatListener = class;

  TClipboardUpdated = reference to procedure(aFormat: Integer);

  TClipboardFormatListener = class(TWincontrol)
  private
    FFormats: TArray<Integer>;
    FClipboardUpdated: TClipboardUpdated;
    procedure WMClipboardUpdate(var Msg: TMessage); message WM_CLIPBOARDUPDATE;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  published
    property ClipboardUpdated: TClipboardUpdated read FClipboardUpdated write FClipboardUpdated;
  public
    constructor Create(aOwner : TWinControl; const aFormats: TArray<Integer>); reintroduce;
  end;

implementation

{ TClipboardFormatListener }

constructor TClipboardFormatListener.Create(aOwner: TWinControl; const aFormats: TArray<Integer>);
begin
  inherited Create(aOwner);
  ParentWindow := aOwner.Handle;
  FFormats := aFormats;
end;

procedure TClipboardFormatListener.CreateWnd;
begin
  inherited;
  AddClipboardFormatListener(Handle);
end;

procedure TClipboardFormatListener.DestroyWnd;
begin
  RemoveClipboardFormatListener(Handle);
  inherited;
end;

procedure TClipboardFormatListener.WMClipboardUpdate(var Msg: TMessage);
begin
  if not Assigned(FClipboardUpdated) then
    exit;

  for var format in FFormats do
    if IsClipboardFormatAvailable(format) then
      FClipboardUpdated(format);
end;

end.
