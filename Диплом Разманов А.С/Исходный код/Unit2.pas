unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, pngimage;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Image2: TImage;
    Label11: TLabel;
    Image6: TImage;
    Label8: TLabel;
    Image5: TImage;
    Label12: TLabel;
    Label13: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    Image7: TImage;
    Label15: TLabel;
    Label16: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
form2.Close;
end;

end.
