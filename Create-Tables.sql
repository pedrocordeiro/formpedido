CREATE TABLE `Cliente` (
  `Codigo` varchar(4) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Cidade` varchar(100) NOT NULL,
  `UF` varchar(2) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ItemPedido` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ID_Pedido` bigint(20) NOT NULL,
  `Cod_Produto` varchar(4) NOT NULL,
  `Quantidade` int(11) NOT NULL,
  `Valor_Unitario` decimal(18,2) NOT NULL,
  `Valor_Total` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ItemPedido_Produto_FK_` (`Cod_Produto`),
  KEY `ID_Pedido` (`ID_Pedido`),
  CONSTRAINT `ItemPedido_ibfk_3` FOREIGN KEY (`ID_Pedido`) REFERENCES `Pedido` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `ItemPedido_ibfk_2` FOREIGN KEY (`Cod_Produto`) REFERENCES `Produto` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

CREATE TABLE `Pedido` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Cod_Cliente` varchar(4) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valor_Total` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Pedido_Cliente_FK_` (`Cod_Cliente`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`Cod_Cliente`) REFERENCES `Cliente` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

CREATE TABLE `Produto` (
  `Codigo` varchar(4) NOT NULL,
  `Descricao` varchar(100) NOT NULL,
  `Valor` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


