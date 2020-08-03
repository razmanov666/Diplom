﻿unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComObj, DB, ADODB, xmldom,
  Provider, Xmlxform, XMLIntf, XMLDoc, Menus,
  ComCtrls, FileCtrl, Unit2, ExtCtrls, StrUtils, DBGrids, msxmldom;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    ADOTable1: TADOTable;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    StatusBar3: TStatusBar;
    StatusBar4: TStatusBar;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    OpenDialog1: TOpenDialog;
    DataSource1: TDataSource;
    XMLDocument1: TXMLDocument;
    ProgressBar1: TProgressBar;
    ADOConnection1: TADOConnection;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);

    procedure readExcel(StringGrid: TStringGrid);
    procedure readDBF(StringGrid: TStringGrid);
    procedure updateStatusBar(str: String);
    procedure readFile(StringGrid: TStringGrid; file_type: String);
    function FindID(fieldName, IDname: string): string;
    function findValue(stringNumber: integer; stringName: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  xlCellTypeLastCell = $0000000B;

var
  Form1: TForm1;
  Form2: TForm2;
  StringGrid1: TStringGrid;
  StringGrid2: TStringGrid;
  tableEmpty, invalidFile, getLayout, xmlCreated: bool;
  FileName, Result: String;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  readFile(StringGrid1, 'input');
  StringGrid1.Visible := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Xml: TXMLDocument;
  value, Dir, id: string;
  y, i, k: integer;
begin
  ProgressBar1.Max := StringGrid1.RowCount - 1;
  if (tableEmpty = false) and (invalidFile = false) and (getLayout = true) then
  begin
    updateStatusBar('wait user');
    Application.MessageBox('Укажите директорию для сохранения', 'Подсказка');
    Dir := '';
    if SelectDirectory(Dir, [sdAllowCreate, sdPrompt], 0) then
    else
    begin
      Application.MessageBox('Директория не была выбрана!', 'Ошибка');
    end;
    StatusBar2.panels[1].Text := Dir;
    StatusBar2.Visible := true;
    for y := 1 to StringGrid1.RowCount - 1 do
    begin
      id := '';
      Xml := TXMLDocument.Create(nil);
      Xml.Active := true;
      Xml.Version := '1.0';
      Xml.Encoding := 'UTF-8';
      with Xml do
      begin
        with AddChild('REPORT_ROOT') do
        begin
          with AddChild('REPORT') do
          begin
            with AddChild('DESCRIPTION') do
            begin
              Attributes['APP_VER'] := '10.3.12.5.ARM';
              Attributes['DB_VER'] := '5';
              Attributes['FT_VER'] := '6';
              Attributes['COMMENT'] := '11';
              Attributes['ID_REF'] := '-1';
              Attributes['ID_FT'] := '17007';
              Attributes['ID_P'] := '12342';
              Attributes['CODE_ESN'] := StringGrid1.Cells[0, y];
              Attributes['NAME_ESN'] := ' ';
              with AddChild('DESCRIPTION') do
              begin
                Attributes['NAME'] := StringGrid1.Cells[1, y];
                Attributes['DEPARTMENT'] := ' ';
                Attributes['PHONE'] := ' ';
                Attributes['EMAIL'] := ' ';
              end;
            end; // close description
            with AddChild('ROW_REPORT') do
            begin
              for i := 2 to StringGrid1.ColCount - 1 do
                with AddChild('row') do
                begin
                  for k := 1 to StringGrid2.ColCount - 1 do
                  begin
                    id := '';
                    id := FindID(StringGrid1.Cells[i, 0],
                      StringGrid2.Cells[k, 0]);
                    Attributes[StringGrid2.Cells[k, 0]] := id;
                  end;
                end;
            end; // row_report
            with AddChild('GRAPH_GCELL') do
            begin
              for i := 2 to StringGrid1.ColCount - 1 do
              begin
                with AddChild('row') do
                begin
                  Attributes['ID_UOM'] := FindID(StringGrid1.Cells[i, 0],
                    'ID_UOM');
                  Attributes['ID_DGP'] := FindID(StringGrid1.Cells[i, 0],
                    'ID_DGP');
                  Attributes['ID_ROWRPT'] := FindID(StringGrid1.Cells[i, 0],
                    'ID_ROWRPT');
                  value := '';
                  value := findValue(y, StringGrid1.Cells[i, 0]);
                  Attributes['VALUE_GCELL'] := value;
                end;
              end; // rows
            end;
          end; // close report
        end; // close report_root
      end;
      if StatusBar1.panels[1].Text <> '' then
      begin
        updateStatusBar('create first');
      end;
      try
        Xml.SaveToFile(Dir + '\' + 'UNP_' + inttostr(y) + '.xml');
        ProgressBar1.Visible := true;
        ProgressBar1.StepIt;
        ProgressBar1.update;
      except
        break;
      end;
    end;
    updateStatusBar('final program');
    Application.MessageBox('Работа программы завершена', 'Уведомление');
    ProgressBar1.Position := 0;
  end
  else
  begin
    if tableEmpty = true then
    begin
      Application.MessageBox('Не выбран файл данных для обработки', 'Ошибка');
    end;
    if getLayout = false then
    begin
      Application.MessageBox('Не выбран макет выгрузки', 'Ошибка');
    end;
    if invalidFile = true then
    begin
      Application.MessageBox('Выбранный файл не может быть обработан',
        'Ошибка');
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  readFile(StringGrid2, 'layout');
  if StringGrid2.Cells[0, 0] <> '' then
    getLayout := true;
end;


procedure TForm1.readFile(StringGrid: TStringGrid; file_type: String);
var
  ExcelApp, ExcelSheet: OLEVariant;
  MyMass: Variant;
  FilePath, FileDbf, MyConnectionString: string;
  x, y, i, j: integer;
begin
  invalidFile := false;
  if OpenDialog1.Execute then
  begin
    ProgressBar1.Visible := false;
    FileName := Form1.OpenDialog1.FileName;
    if file_type = 'input' then
    begin
      StatusBar1.panels[1].Text := FileName;
      StatusBar1.Visible := true;
    end;
    if file_type = 'layout' then
    begin
      StatusBar3.panels[1].Text := FileName;
      StatusBar3.Visible := true;
    end;
  end
  else
  begin
    Application.MessageBox('Файл не был выбран!', 'Ошибка');
    exit;
  end;
  updateStatusBar('open');
  if ExtractFileExt(OpenDialog1.FileName) = '.dbf' then
  begin
    readDBF(stringgrid);
  end
  else
  begin
    readExcel(StringGrid);
  end;
  updateStatusBar('final');
end;

procedure TForm1.readDBF(StringGrid: TStringGrid);
var
FilePath, FileDbf, MyConnectionString: string;
x, y, i, j: integer;
begin
  updateStatusBar('wait user');
    ADOConnection1.close;
    FilePath := ExtractFilePath(OpenDialog1.FileName);
    FileDbf := ExtractFileName(OpenDialog1.FileName);
    try
      MyConnectionString := 'Provider=VFPOLEDB.1;' + 'Data Source=' +
        FilePath + ';' + 'Password="";Collating Sequence=MACHINE';
      ADOConnection1.ConnectionString := MyConnectionString;
      ADOTable1.TableName := FileDbf;
      ADOTable1.Active := true;
    except
      invalidFile := true;
      Application.MessageBox('Выбран не верный формат файла', 'Ошибка');
    end;
    j := 1;
    DBGrid1.DataSource.DataSet.First;
    StringGrid.ColCount := DBGrid1.Columns.Count;
    StringGrid.RowCount := ADOTable1.RecordCount + 1;
    while not DBGrid1.DataSource.DataSet.Eof do
    begin
      for i := 0 to DBGrid1.Columns.Count - 1 do
      begin
        StringGrid.Cells[i, 0] := DBGrid1.Columns[i].fieldName;
        StringGrid.Cells[i, j] := DBGrid1.DataSource.DataSet.Fields[i].AsString;
      end;
      Inc(j);
      DBGrid1.DataSource.DataSet.Next;
    end;
    tableEmpty := false;
end;


procedure TForm1.readExcel(StringGrid: TStringGrid);
var
  ExcelApp, ExcelSheet: OLEVariant;
  MyMass: Variant;
  x, y: integer;
begin
  ExcelApp := CreateOleObject('Excel.Application');
  ExcelApp.Workbooks.Open(FileName);
  ExcelSheet := ExcelApp.Workbooks[1].WorkSheets[1];
  ExcelSheet.Cells.SpecialCells(xlCellTypeLastCell).Activate;
  updateStatusBar('forming');
  x := ExcelApp.ActiveCell.Row;
  y := ExcelApp.ActiveCell.Column;
  MyMass := ExcelApp.Range['A1', ExcelApp.Cells.Item[x, y]].value;
  ExcelApp.Quit;
  ExcelApp := Unassigned;
  ExcelSheet := Unassigned;
  StringGrid.RowCount := x;
  StringGrid.ColCount := y;
  for x := 1 to StringGrid.ColCount do
    for y := 1 to StringGrid.RowCount do
      StringGrid.Cells[x - 1, y - 1] := MyMass[y, x];
  tableEmpty := false;
end;

function TForm1.FindID(fieldName, IDname: string): string;
var
  i, j: integer;
begin
  for i := 1 to StringGrid2.RowCount - 1 do
  begin
    if UpperCase(fieldName) = UpperCase(StringGrid2.Cells[0, i]) then
      for j := 1 to StringGrid2.RowCount - 1 do
      begin
        if UpperCase(IDname) = UpperCase(StringGrid2.Cells[j, 0]) then
        begin
          Result := StringGrid2.Cells[j, i];
        end;
      end;
  end;
end;

function TForm1.findValue(stringNumber: integer; stringName: string): string;
var
  i, j: integer;
begin
  for i := 1 to StringGrid1.ColCount - 1 do
  begin
    if StringGrid1.Cells[i, 0] = stringName then
    begin
      for j := 1 to StringGrid1.RowCount - 1 do
      begin
        if j = stringNumber then
          Result := StringGrid1.Cells[i, j];
      end;
    end;
  end;
end;

procedure TForm1.updateStatusBar(str: String);
begin
  if str = 'wait user' then
  begin
    StatusBar4.panels[1].Text := 'Ожидание ответа пользователя';
  end
  else if str = 'create' then
  begin
    StatusBar4.panels[1].Text := 'Идет процесс создания';
  end
  else if str = 'create first' then
  begin
    StatusBar4.panels[1].Text := 'Идет процесс создания';
    //StatusBar4.panels[2].Text := 'Создано ' + inttostr(countFiles) + ' файлов';
  end
  else if str = 'create other' then
  begin
    StatusBar4.panels[1].Text := 'Идет процесс создания';
    //StatusBar4.panels[2].Text := 'Создано ' + inttostr(countFiles) + ' файлов';
  end
  else if str = 'forming' then
  begin
    StatusBar4.panels[1].Text := 'Формирование таблицы';
  end
  else if str = 'open' then
  begin
    StatusBar4.panels[1].Text := 'Открытие документа';
  end
  else if str = 'final' then
  begin
    StatusBar4.panels[1].Text := 'Чтение документа завершено';
  end
  else if str = 'final program' then
  begin
    StatusBar4.panels[1].Text := 'Создание завершено';
    StatusBar4.panels[2].Text := 'Создано ' + inttostr(StringGrid1.RowCount-1) + ' файлов '+ ' sss';
  end
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Application.MessageBox
    ('   Программное обеспечение служит для загрузки данных'
      +
      ' нецентрализованных статистических обследований в Единую информационную'
      + 'систему государственной статистики.', 'О программе');
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Unit2.Form2.showmodal;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Application.MessageBox('Студент МГЭИ им.А.Д.Сахарова БГУ,'#13#10'' +
      'Разманов Алексей Сергеевич, '#13#10'группа 61025.' +
      ''#13#10''#13#10'Контактный адрес : razmanov666@gmail.com',
    'О разработчике');
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  tableEmpty := true;
  getLayout := false;
end;
end.
