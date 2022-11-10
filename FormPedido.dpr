program FormPedido;

uses
  Vcl.Forms,
  Pedido in 'Pedido.pas' {FrmPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.Run;
end.
