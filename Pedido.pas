unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.SQLiteVDataSet, Vcl.ExtCtrls;

type
  TFrmPedido = class(TForm)
    Label1: TLabel;
    EdtCodCliente: TEdit;
    Label2: TLabel;
    LblNomeCliente: TLabel;
    Label4: TLabel;
    LblCidadeCliente: TLabel;
    LblUFCliente: TLabel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    FDConnection1: TFDConnection;
    FDQCliente: TFDQuery;
    FDQProduto: TFDQuery;
    DSProduto: TDataSource;
    FDTransaction1: TFDTransaction;
    FDQPedido: TFDQuery;
    FDQItemPedido: TFDQuery;
    DSItemPedido: TDataSource;
    BtnNovoPedido: TButton;
    DSPedido: TDataSource;
    FDLocalSQL1: TFDLocalSQL;
    Label9: TLabel;
    LblTotalPedido: TLabel;
    BtnCarregarPedido: TButton;
    BtnApagarPedido: TButton;
    PnlItens: TPanel;
    EdtCodProduto: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEValor_Unitario: TDBEdit;
    Label3: TLabel;
    EdtQuantidade: TEdit;
    BtnInserirItem: TButton;
    BtnSalvarPedido: TButton;
    LblDescProduto: TLabel;
    BtnCancelarPedido: TButton;
    procedure EdtCodClienteExit(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnNovoPedidoClick(Sender: TObject);
    procedure BtnInserirItemClick(Sender: TObject);
    procedure BtnSalvarPedidoClick(Sender: TObject);
    procedure FDQPedidoAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarPedidoClick(Sender: TObject);
    procedure BtnCarregarPedidoClick(Sender: TObject);
    procedure BtnApagarPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;

implementation

{$R *.dfm}

procedure TFrmPedido.BtnApagarPedidoClick(Sender: TObject);
var
  InputString: String;
begin

  try

    InputString:= InputBox('Informe o número do pedido', 'Número:', '');

    if (InputString <> '')
        and (MessageDlg('Confirma exclusão do pedido no. ' + InputString +'?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes) then
    begin
      FDTransaction1.StartTransaction;

      FDQItemPedido.Close;
      FDQPedido.Close;

      FDQPedido.ParamByName('ID').AsLargeInt := StrToInt(InputString);
      FDQPedido.Open;
      FDQItemPedido.Open;
      FDQPedido.Delete;
      FDQPedido.ApplyUpdates();

      FDTransaction1.Commit;

      FDQItemPedido.Close;
      FDQPedido.Close;
    end;

  except
    FDTransaction1.Rollback;
  end;

end;

procedure TFrmPedido.BtnCancelarPedidoClick(Sender: TObject);
begin
  if FDQPedido.State in [dsInsert, dsEdit] then
    FDQPedido.CancelUpdates;

  if FDQItemPedido.State in [dsInsert, dsEdit] then
    FDQItemPedido.CancelUpdates;

  if FDTransaction1.Active then
    FDTransaction1.Rollback;

  FDQItemPedido.Close;
  FDQPedido.Close;
  PnlItens.Visible := False;
end;

procedure TFrmPedido.BtnInserirItemClick(Sender: TObject);
var
  total: Currency;
begin
  if FDQPedido.State in [dsInsert, dsEdit] then
  begin
    if not (FDQItemPedido.State in [dsInsert, dsEdit]) then
      FDQItemPedido.Open;
    FDQItemPedido.Append;
    FDQItemPedido.FieldByName('ID_Pedido').AsLargeInt :=
        FDQPedido.FieldByName('ID').AsLargeInt;
    FDQItemPedido.FieldByName('Cod_Produto').AsString :=
        FDQProduto.FieldByName('Codigo').AsString;
    FDQItemPedido.FieldByName('Quantidade').AsInteger := StrToInt(EdtQuantidade.Text);
    FDQItemPedido.FieldByName('Valor_Unitario').AsCurrency :=
        StrToCurr(DBEValor_Unitario.Text);
    FDQItemPedido.FieldByName('Valor_Total').AsCurrency :=
        StrToInt(EdtQuantidade.Text) * StrToCurr(DBEValor_Unitario.Text);

    FDQItemPedido.DisableControls;
    FDQItemPedido.First;
    total := 0;
    while not(FDQItemPedido.EOF) do
    begin
      Total := total + FDQItemPedido.FieldByName('Valor_Total').AsCurrency;
      FDQItemPedido.Next;
    end;

    FDQItemPedido.EnableControls;

    FDQPedido.Edit;
    FDQPedido.FieldByName('Valor_Total').AsCurrency := total;
    LblTotalPedido.Caption := CurrToStr(total);

    EdtCodProduto.SetFocus;
  end;
end;

procedure TFrmPedido.BtnNovoPedidoClick(Sender: TObject);
begin
  FDTransaction1.StartTransaction;
  FDQItemPedido.Close;
  FDQPedido.Close;
  FDQPedido.Open;
  FDQPedido.Append;
  FDQPedido.FieldByName('Cod_Cliente').AsString :=
      FDQCliente.FieldByName('Codigo').AsString;

  PnlItens.Visible := True;
  EdtCodProduto.SetFocus;
end;

procedure TFrmPedido.BtnSalvarPedidoClick(Sender: TObject);
var
  resultado: Integer;
begin

  try

    try

      if (FDQPedido.State in [dsInsert, dsEdit]) then
        FDQPedido.Post;

      resultado := FDQPedido.ApplyUpdates();

      if resultado = 0 then
      begin
        if (FDQItemPedido.State in [dsInsert, dsEdit]) then
          FDQItemPedido.Post;

        resultado := FDQItemPedido.ApplyUpdates();

        if resultado = 0 then
        begin
          FDTransaction1.Commit;
          ShowMessage('Pedido no. ' + FDQPedido.FieldByName('ID').AsString + ' salvo.');
        end
        else
        begin
          FDTransaction1.Rollback;
          ShowMessage('Pedido não salvo.');
        end;

      end;

    except
        FDTransaction1.Rollback;
    end;

  finally
    FDQItemPedido.Close;
    FDQPedido.Close;
    PnlItens.Visible := False;

  end;

end;

procedure TFrmPedido.BtnCarregarPedidoClick(Sender: TObject);
var InputString: String;
begin
  try

    InputString:= InputBox('Informe o número do pedido', 'Número:', '');

    if InputString <> '' then
    begin
      FDQPedido.Close;
      FDQItemPedido.Close;

      FDQPedido.ParamByName('ID').AsLargeInt := StrToInt(InputString);
      FDQPedido.Open;

      FDQItemPedido.ParamByName('ID_Pedido').AsLargeInt := StrToInt(InputString);
      FDQItemPedido.Open;

      EdtCodCliente.Text := FDQPedido.FieldByName('Cod_Cliente').AsString;
      self.EdtCodClienteExit(EdtCodCliente);
    end;

  finally


  end;
end;

procedure TFrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    FDQItemPedido.Delete
  else if Char(Key) = #13 then
  begin
    EdtCodProduto.Text := FDQItemPedido.FieldByName('Cod_Produto').AsString;
    EdtQuantidade.Text := FDQItemPedido.FieldByName('Quantidade').AsString;

    Self.EdtCodProdutoExit(EdtCodProduto);

    DBEValor_Unitario.Text :=
        CurrToStr(FDQItemPedido.FieldByName('Valor_Unitario').AsCurrency);

    FDQItemPedido.Delete
  end;


end;

procedure TFrmPedido.EdtCodClienteExit(Sender: TObject);
begin
  FDQCliente.Close;
  FDQCliente.ParamByName('Codigo').AsString :=
      (String(EdtCodCliente.Text)).PadLeft(4, '0');
  FDQCliente.Open;

  if not FDQCliente.Eof then
  begin
    EdtCodCliente.Text := FDQCliente.FieldByName('Codigo').AsString;
    LblNomeCliente.Caption := FDQCliente.FieldByName('Nome').AsString;
    LblCidadeCliente.Caption := FDQCliente.FieldByName('Cidade').AsString;
    LblUFCliente.Caption := FDQCliente.FieldByName('UF').AsString;
  end
  else
  begin
    ShowMessage('Cliente não encontrado.');
    EdtCodCliente.Text := '';
    LblNomeCliente.Caption := '';
    LblCidadeCliente.Caption := '';
    LblUFCliente.Caption := '';
    FDQCliente.Close;
  end;

end;

procedure TFrmPedido.EdtCodProdutoExit(Sender: TObject);
begin
  FDQProduto.Close;
  FDQProduto.ParamByName('Codigo').AsString :=
      (String(EdtCodProduto.Text)).PadLeft(4, '0');
  FDQProduto.Open;

  if not FDQCliente.Eof then
  begin
    EdtCodProduto.Text := FDQProduto.FieldByName('Codigo').AsString;
    LblDescProduto.Caption := FDQProduto.FieldByName('Descricao').AsString;
  end
  else
  begin
    ShowMessage('Produto não encontrado.');
    EdtCodProduto.Text := '';
    LblDescProduto.Caption := '';
    FDQProduto.Close;
  end;
end;

procedure TFrmPedido.FDQPedidoAfterApplyUpdates(DataSet: TFDDataSet;
  AErrors: Integer);
begin
  FDQItemPedido.DisableControls;
  FDQItemPedido.First;
  while not(FDQItemPedido.EOF) do
  begin
    FDQItemPedido.Edit;
    FDQItemPedido.FieldByName('ID_Pedido').AsLargeInt :=
        FDQPedido.FieldByName('ID').AsLargeInt;
    FDQItemPedido.Next;
  end;

  FDQItemPedido.EnableControls;
end;

end.
