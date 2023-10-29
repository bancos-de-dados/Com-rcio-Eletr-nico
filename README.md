   ![comercio](https://github.com/AndreFelipefer/COMERCIO_ELETRONICO/assets/129207232/3b9c9345-c416-4f29-a46c-cc91ab04e8a1) 
### O sistema envolve várias tabelas, incluindo "Produtos" para armazenar informações sobre produtos, "Pedidos" para registrar detalhes de pedidos, "Clientes" para manter informações de clientes e "Itens de Pedido" para registrar produtos em cada pedido. Além disso, foram estabelecidos relacionamentos essenciais entre "Pedidos" e "Clientes" para rastrear os pedidos de cada cliente, e entre "Itens de Pedido" e "Produtos" para associar produtos aos pedidos. Este sistema é projetado para facilitar a gestão e o rastreamento de pedidos em um ambiente de comércio eletrônico.

# Criação da tabela Comercio Eletronico 
```SQL
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ComercioEletronico
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ComercioEletronico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ComercioEletronico` DEFAULT CHARACTER SET utf8 ;
USE `ComercioEletronico` ;

-- -----------------------------------------------------
-- Table `ComercioEletronico`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`Produtos` (
  `idProdutos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `descricao` VARCHAR(100) NULL,
  `preco` DECIMAL(10,2) NULL,
  `quantidadeEstoque` INT NULL,
  PRIMARY KEY (`idProdutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComercioEletronico`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(100) NULL,
  `endereco` VARCHAR(100) NULL,
  `telefone` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComercioEletronico`.`Itens_de_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`Itens_de_Pedido` (
  `idItens_de_Pedido` INT NOT NULL AUTO_INCREMENT,
  `pedido` VARCHAR(100) NULL,
  `quantidadePedido` INT NULL,
  PRIMARY KEY (`idItens_de_Pedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComercioEletronico`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`Pedidos` (
  `idPedidos` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `clientePedido` VARCHAR(100) NULL,
  `status` VARCHAR(100) NULL,
  `Clientes_idClientes` INT NOT NULL,
  `Itens_de_Pedido_idItens_de_Pedido` INT NOT NULL,
  PRIMARY KEY (`idPedidos`, `Clientes_idClientes`, `Itens_de_Pedido_idItens_de_Pedido`),
  INDEX `fk_Pedidos_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Pedidos_Itens_de_Pedido1_idx` (`Itens_de_Pedido_idItens_de_Pedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `ComercioEletronico`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Itens_de_Pedido1`
    FOREIGN KEY (`Itens_de_Pedido_idItens_de_Pedido`)
    REFERENCES `ComercioEletronico`.`Itens_de_Pedido` (`idItens_de_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComercioEletronico`.``
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`` (
  `Produtos_idProdutos` INT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`Produtos_idProdutos`, `Pedidos_idPedidos`),
  INDEX `fk_Produtos_has_Pedidos_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Pedidos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Pedidos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `ComercioEletronico`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Pedidos_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `ComercioEletronico`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ComercioEletronico`.`Itens_de_Pedido_has_Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ComercioEletronico`.`Itens_de_Pedido_has_Produtos` (
  `Itens_de_Pedido_idItens_de_Pedido` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  PRIMARY KEY (`Itens_de_Pedido_idItens_de_Pedido`, `Produtos_idProdutos`),
  INDEX `fk_Itens_de_Pedido_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Itens_de_Pedido_has_Produtos_Itens_de_Pedido1_idx` (`Itens_de_Pedido_idItens_de_Pedido` ASC) VISIBLE,
  CONSTRAINT `fk_Itens_de_Pedido_has_Produtos_Itens_de_Pedido1`
    FOREIGN KEY (`Itens_de_Pedido_idItens_de_Pedido`)
    REFERENCES `ComercioEletronico`.`Itens_de_Pedido` (`idItens_de_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Itens_de_Pedido_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `ComercioEletronico`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

```

Tabelas:

### Produtos: Armazene informações sobre produtos, como nome, descrição, preço e quantidade em estoque.
![image](https://github.com/AndreFelipefer/ComercioEletronico/assets/129207232/8b00bde9-5722-4c6c-841d-832107a058ac)


### Pedidos: Registre detalhes de pedidos, incluindo data, cliente e status.
```SQL

```

### Clientes: Mantenha informações dos clientes, como nome, endereço de entrega e informações de contato.
![image](https://github.com/AndreFelipefer/ComercioEletronico/assets/129207232/50ccab56-2c01-4c55-80ae-71f4a0c0e69f)


### Itens de Pedido: Registre os produtos incluídos em cada pedido, junto com a quantidade.
![image](https://github.com/AndreFelipefer/ComercioEletronico/assets/129207232/f65d61a0-5776-4170-a79b-2ad6d703d7f4)


Relacionamentos:

### Crie um relacionamento entre "Pedidos" e "Clientes" para rastrear os pedidos de cada cliente.
```SQL

```

### Estabeleça um relacionamento entre "Itens de Pedido" e "Produtos" para associar produtos a pedidos.
```SQL

```

### Stored Procedures:
```SQL

```

### Implemente uma stored procedure para permitir que os clientes adicionem produtos ao carrinho de compras.
```SQL

```

### Crie uma stored procedure para processar pedidos, atualizando o estoque de produtos e registrando os detalhes do pedido.
```SQL

```

### Desenvolva uma stored procedure para calcular o total de um pedido com base nos produtos incluídos.
```SQL

```

Views:

### Crie uma view que mostre o histórico de pedidos de um cliente específico, incluindo os produtos incluídos em cada pedido.
```SQL

```

### Implemente uma view que forneça uma lista de todos os produtos disponíveis, excluindo aqueles que estão esgotados.
```SQL

```
