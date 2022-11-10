object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido de Vendas'
  ClientHeight = 613
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 63
    Height = 13
    Caption = 'Cod. Cliente:'
  end
  object Label2: TLabel
    Left = 56
    Top = 56
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object LblNomeCliente: TLabel
    Left = 112
    Top = 56
    Width = 349
    Height = 13
  end
  object Label4: TLabel
    Left = 50
    Top = 88
    Width = 37
    Height = 13
    Caption = 'Cidade:'
  end
  object LblCidadeCliente: TLabel
    Left = 112
    Top = 88
    Width = 349
    Height = 13
  end
  object LblUFCliente: TLabel
    Left = 112
    Top = 120
    Width = 37
    Height = 13
  end
  object Label5: TLabel
    Left = 70
    Top = 120
    Width = 17
    Height = 13
    Caption = 'UF:'
  end
  object Label9: TLabel
    Left = 8
    Top = 568
    Width = 78
    Height = 13
    Caption = 'Total do Pedido:'
  end
  object LblTotalPedido: TLabel
    Left = 104
    Top = 568
    Width = 65
    Height = 13
  end
  object EdtCodCliente: TEdit
    Left = 112
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 1
    OnExit = EdtCodClienteExit
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 272
    Width = 792
    Height = 265
    DataSource = DSItemPedido
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'Cod_Produto'
        Title.Caption = 'Cod. Produto'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantidade'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Unitario'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 121
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Total'
        Title.Caption = 'Valor Total'
        Width = 139
        Visible = True
      end>
  end
  object BtnNovoPedido: TButton
    Left = 8
    Top = 137
    Width = 75
    Height = 25
    Caption = '&Novo Pedido'
    TabOrder = 0
    OnClick = BtnNovoPedidoClick
  end
  object BtnCarregarPedido: TButton
    Left = 269
    Top = 25
    Width = 100
    Height = 25
    Caption = 'Carregar Pedido'
    TabOrder = 3
    OnClick = BtnCarregarPedidoClick
  end
  object BtnApagarPedido: TButton
    Left = 375
    Top = 25
    Width = 95
    Height = 25
    Caption = 'Apagar Pedido'
    TabOrder = 4
    OnClick = BtnApagarPedidoClick
  end
  object PnlItens: TPanel
    Left = 8
    Top = 168
    Width = 774
    Height = 98
    TabOrder = 5
    Visible = False
    object Label6: TLabel
      Left = 11
      Top = 13
      Width = 68
      Height = 13
      Caption = 'Cod. Produto:'
    end
    object Label7: TLabel
      Left = 37
      Top = 40
      Width = 42
      Height = 13
      Caption = 'Produto:'
    end
    object Label8: TLabel
      Left = 48
      Top = 69
      Width = 28
      Height = 13
      Caption = 'Valor:'
    end
    object Label3: TLabel
      Left = 261
      Top = 69
      Width = 60
      Height = 13
      Caption = 'Quantidade:'
    end
    object LblDescProduto: TLabel
      Left = 104
      Top = 40
      Width = 324
      Height = 13
    end
    object EdtCodProduto: TEdit
      Left = 104
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = EdtCodProdutoExit
    end
    object DBEValor_Unitario: TDBEdit
      Left = 104
      Top = 69
      Width = 121
      Height = 21
      DataField = 'Valor'
      DataSource = DSProduto
      TabOrder = 1
    end
    object EdtQuantidade: TEdit
      Left = 335
      Top = 69
      Width = 93
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object BtnInserirItem: TButton
      Left = 456
      Top = 65
      Width = 75
      Height = 25
      Caption = 'Inserir Item'
      TabOrder = 3
      OnClick = BtnInserirItemClick
    end
    object BtnSalvarPedido: TButton
      Left = 537
      Top = 65
      Width = 75
      Height = 25
      Caption = 'Salvar Pedido'
      TabOrder = 4
      OnClick = BtnSalvarPedidoClick
    end
    object BtnCancelarPedido: TButton
      Left = 618
      Top = 64
      Width = 89
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 5
      OnClick = BtnCancelarPedidoClick
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=sql10.freemysqlhosting.net'
      'Password=MB9gtixXzE'
      'Database=sql10556303'
      'User_Name=sql10556303'
      'DriverID=MySQL')
    Connected = True
    Left = 528
    Top = 24
  end
  object FDQCliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * '
      'from Cliente'
      'where Codigo = :Codigo')
    Left = 616
    Top = 24
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
        Value = Null
      end>
  end
  object FDQProduto: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * '
      'from Produto'
      'where Codigo = :Codigo')
    Left = 688
    Top = 24
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
        Value = Null
      end>
  end
  object DSProduto: TDataSource
    DataSet = FDQProduto
    Left = 752
    Top = 24
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 528
    Top = 88
  end
  object FDQPedido: TFDQuery
    CachedUpdates = True
    AfterApplyUpdates = FDQPedidoAfterApplyUpdates
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * '
      'from Pedido'
      'where ID = :ID')
    Left = 608
    Top = 88
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQItemPedido: TFDQuery
    CachedUpdates = True
    MasterSource = DSPedido
    MasterFields = 'ID'
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * '
      'from ItemPedido'
      'where ID_Pedido = :ID_Pedido')
    Left = 680
    Top = 88
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSItemPedido: TDataSource
    DataSet = FDQItemPedido
    Left = 680
    Top = 160
  end
  object DSPedido: TDataSource
    DataSet = FDQPedido
    Left = 608
    Top = 160
  end
  object FDLocalSQL1: TFDLocalSQL
    Connection = FDConnection1
    DataSets = <
      item
      end>
    Left = 528
    Top = 160
  end
end
