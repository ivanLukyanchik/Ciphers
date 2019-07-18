  unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls;

type
  TForm1 = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    Label1: TLabel;
    edt3: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    bt1: TButton;
    bt2: TButton;
    lbl8: TLabel;
    grp2: TGroupBox;
    lbl9: TLabel;
    lbl10: TLabel;
    mmo1: TMemo;
    mmo2: TMemo;
    grp3: TGroupBox;
    bt3: TButton;
    bt4: TButton;
    mmo3: TMemo;
    mmo4: TMemo;
    bt5: TButton;
    bt6: TButton;
    lbl11: TLabel;
    lbl12: TLabel;
    dlgOpen1: TOpenDialog;
    strngrd1: TStringGrid;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl14: TLabel;
    strngrd2: TStringGrid;
    lbl17: TLabel;
    ProgressBar1: TProgressBar;
    procedure bt2Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure bt1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt3Click(Sender: TObject);
    procedure Save(const name: string);
    procedure Save1(const name: string);
    procedure bt5Click(Sender: TObject);
    procedure bt4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  P, Q, N, e, d, Fi, m, c : Cardinal;
  ext:string[5];

implementation

{$R *.dfm}

procedure TForm1.bt2Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.edt1KeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
  Key:=#0;
end;

function modinv (a,m:Cardinal):Cardinal;
var
i,b:integer;         //��� ����� ������������ ��� ����������
x,j,y,c:integer;     //"����������� �������� �������".
begin                //���������� ����� D, ��� (E*D) mod N =1.
 b := m;
 c := a;
 i := 0;
 j := 1;
 while (c <> 0) do
  begin
   x := b div c;
   y := b mod c;
   b := c;
   c := y;
   y := j;
   j := i - j * x;
   i := y
  end;
 if (i < 0) then i := i+m;
 modinv:=i;
end;

function nod(var a, b:Cardinal):Cardinal; //������� ��� ����������
var j,i:integer;                          //����������� ������ ��������.
begin                                     //����������� ��� ���������� ����� �
  if a>b then
    i:=b
  else
    i:=a;

  for j:=i downto 1 do
    if (a mod j = 0) and (b mod j=0) then
     begin
       nod:=j;
       exit;
     end;
end;

function prostoe(a:Cardinal):Boolean;
var
  j : Cardinal;
begin
  Result:=True;
  for j:=a-1 downto 2 do
    if (a mod j = 0) then
    begin
      Result:=False;
      ShowMessage(IntToStr(j));
      exit;
    end;
end;

procedure TForm1.bt1Click(Sender: TObject);
begin
  bt3.Enabled:=True;
  bt5.Enabled:=True;
  if edt1.Text='' then
  begin
    messagebox(Form1.Handle, pchar('������� ����� P!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;
  if edt2.Text='' then
  begin
    messagebox(Form1.Handle, pchar('������� ����� Q!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;
  if edt3.Text='' then
  begin
    messagebox(Form1.Handle, pchar('������� ����� d!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;
  if Length(edt1.Text)<>Length(edt2.Text) then
  begin
    messagebox(Form1.Handle, pchar('����� P � Q ������ ���� ������ ������� (��������� ���������� ���-�� ����)!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;

  p:=StrToInt(edt1.Text);
  if not(prostoe(p)) then
  begin
    messagebox(Form1.Handle, pchar('����� p ������ ���� �������! ��������� ���� ����� p!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;

  q:=StrToInt(edt2.Text);
  if not(prostoe(q)) then
  begin
    messagebox(Form1.Handle, pchar('����� q ������ ���� �������! ��������� ���� ����� q!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;

  Fi:=(p-1)*(q-1);
  lbl7.Caption:=InttoStr(Fi);

  d:=StrToInt(edt3.Text);
  if d<=1 then
  begin
    messagebox(Form1.Handle, pchar('����� d ������ ���� ������ 1! ��������� ���� ����� d!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;
  if nod(d,Fi)<>1 then
  begin
    messagebox(Form1.Handle, pchar('����� d ������ ���� ������� ������� � Fi! ��������� ���� ����� d!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;
  {if not(prostoe(d)) then
  begin
    messagebox(Form1.Handle, pchar('����� d ������ ���� �������! ��������� ���� ����� d!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;   }
  if d>=Fi then
  begin
    messagebox(Form1.Handle, pchar('����� d ������ ���� ������ ������ Fi! ��������� ���� ����� d!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;

  N:=p*q;
  lbl6.Caption:=IntToStr(n);

  e:=modinv(d,Fi);
  lbl8.Caption:=IntToStr(e);

  mmo1.Text:=IntToStr(e)+'-'+IntToStr(N);
  mmo2.Text:=IntToStr(d)+'-'+IntToStr(N);


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edt1.Text:='3557';
  edt2.Text:='2579';
  edt3.Text:='6111579';
  lbl15.Visible:=False;
  lbl12.Visible:=False;
  lbl16.Visible:=True;
  bt3.Enabled:=False;
  bt5.Enabled:=False;
end;

function fast_exp(a,z,n : Cardinal): Cardinal;
var
  a1, z1, x : Cardinal;
begin
  a1:=a;
  z1:=z;
  x:=1;
  while z1<>0 do
  begin
    while (z1 mod 2)=0 do //�������� � ������ a1, ���� z �����
    begin
      z1:=z1 div 2;
      a1:=(a1*a1) mod n;
    end;
    z1:=z1-1;
    x:=(x*a1) mod n;      //���������
  end;
  fast_exp:=x;
end;

procedure TForm1.Save(const name: string);
var
  F: File of Byte;
  by : Byte;
  i: Integer;
begin
  AssignFile(F, name);
  Rewrite(F);
  for i:=0 to (strngrd1.ColCount-1) do
  begin
    by:=StrToInt(strngrd1.Cells[i,1]);
    Write(F,by);
  end;
  CloseFile(F);
end;

procedure TForm1.Save1(const name: string);
var
  F: TextFile;
  by : Integer;
  i: Integer;
begin
  AssignFile(F, name);
  Rewrite(F);
  for i:=0 to (strngrd1.ColCount-1) do
  begin
    by:=StrToInt(strngrd1.Cells[i,1]);
    Write(F,by);
  end;
  CloseFile(F);
end;

procedure Initialize(edt1,edt2,edt3:TEdit);
begin
  p:=StrToInt(edt1.Text);
  q:=StrToInt(edt2.Text);
  Fi:=(p-1)*(q-1);
  d:=StrToInt(edt3.Text);
  N:=p*q;
  e:=modinv(d,Fi);
end;

procedure TForm1.bt3Click(Sender: TObject);
var
  F : File of Byte;
  by : Byte;
  i: Cardinal;
begin

  Initialize(edt1,edt2,edt3);

  lbl15.Visible:=False;
  lbl16.Visible:=False;
  lbl12.Visible:=true;

  dlgOpen1.InitialDir:='C:\Users\����\Desktop\������\';

  if dlgOpen1.Execute then
  begin
    AssignFile(F, dlgOpen1.FileName);
    ext:=Copy(dlgOpen1.FileName,Pos('.',dlgOpen1.FileName),Length(dlgOpen1.FileName)-Pos('.',dlgOpen1.FileName)+1);
    Reset(F);
    strngrd1.ColCount:=1;
    strngrd2.ColCount:=1;
    mmo3.Text:='';
    mmo4.Text:='';
    strngrd1.Cells[0,0]:='';
    strngrd1.Cells[0,1]:='';
    strngrd2.Cells[0,0]:='';

    i:=0;
    If FileSize(F)<>0 then
    begin
      ProgressBar1.Min:=1;
      ProgressBar1.Max:=FileSize(F);
      progressbar1.Step:=1;
      progressbar1.Position:=1;
      repeat
        read(F,By);
        if (by>n-1) then
        begin
          messagebox(Form1.Handle, pchar('����� ��������� ��������� ������ ���� m<=(n-1)'), pchar('������'), mb_ok+mb_iconerror);
          Exit;
        end;
        progressbar1.position:=progressbar1.position+1;
        strngrd1.cells[i,0]:=inttostr(by);
        strngrd1.cells[i,1]:=inttostr(fast_exp(by,e,n));
        strngrd2.cells[i,0]:=strngrd1.cells[i,1];
        if i<=64 then
        begin
          mmo4.Text:=mmo4.Text+strngrd1.cells[i,0]+' ';
          mmo3.Text:=mmo3.Text+strngrd1.cells[i,1]+' ';
        end;
        strngrd1.ColCount:=strngrd1.ColCount+1;
        strngrd2.ColCount:=strngrd2.ColCount+1;
        Inc(i);
      until (EOF(F));
    end
    else
    begin
      messagebox(Form1.Handle, pchar('��������� ���� �� ������ ���� ������! �������� ������ ����.'), pchar('������'), mb_ok+mb_iconerror);
      exit;
    end;

    strngrd1.ColCount:=strngrd1.ColCount-1;
    strngrd2.ColCount:=strngrd2.ColCount-1;

    Save('C:\Users\����\Desktop\������\cyphered');
    MessageBeep(MB_OK);
  end;
end;

procedure TForm1.bt5Click(Sender: TObject);
var
  F : File of Byte;
  byt:Byte;
  by:Cardinal;
  i : Cardinal;

begin
  Initialize(edt1,edt2,edt3);

  lbl15.Visible:=True;
  lbl12.Visible:=False;
  lbl16.Visible:=False;

  AssignFile(F, 'C:\Users\����\Desktop\������\cyphered');
  Reset(F);

  strngrd1.ColCount:=1;
  mmo3.Text:='';
  mmo4.Text:='';
  strngrd1.Cells[0,0]:='';
  strngrd1.Cells[0,1]:='';

  if (strngrd2.ColCount<>1) and (strngrd2.Cells[0,0]<>'') then
  begin
    ProgressBar1.Min:=1;
    ProgressBar1.Max:=FileSize(F);
    progressbar1.Step:=1;
    progressbar1.Position:=1;

    i:=0;
    repeat
      read(f,byt);
      by:=StrToInt(strngrd2.Cells[i,0]);
      strngrd1.cells[i,0]:=strngrd2.cells[i,0];
      strngrd1.cells[i,1]:=IntToStr(fast_exp(by,d,n));
      progressbar1.position:=progressbar1.position+1;
      if i<=64 then
      begin
        mmo4.Text:=mmo4.Text+strngrd1.cells[i,0]+' ';
        mmo3.Text:=mmo3.Text+strngrd1.cells[i,1]+' ';
      end;
      strngrd1.ColCount:=strngrd1.ColCount+1;
      Inc(i);
    until (i=strngrd2.ColCount);
  end
  else
  begin
    messagebox(Form1.Handle, pchar('����������� ���� �� ������ ���� ������!'), pchar('������'), mb_ok+mb_iconerror);
    Exit;
  end;

  strngrd1.ColCount:=strngrd1.ColCount-1;

  Save('C:\Users\����\Desktop\������\decyphered'+ext);
  MessageBeep(MB_OK);
end;

procedure TForm1.bt4Click(Sender: TObject);
var
  F : File of Byte;
begin
  AssignFile(F, 'decyphered');
  Rewrite(F);
  CloseFile(F);
  strngrd2.ColCount:=1;
  strngrd2.Cells[0,0]:='';
end;

end.
