CREATE SCHEMA IF NOT EXISTS `delivery` DEFAULT CHARACTER SET utf8;
USE `delivery`;

CREATE TABLE `delivery`.`tbl_usuarios` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `sobrenome` varchar(60) NOT NULL,
  `data_nascimento` datetime NOT NULL,
  `documento` varchar(14) UNIQUE NOT NULL,
  `email` varchar(140) UNIQUE NOT NULL,
  `senha` varchar(255) NOT NULL,
  `token_dispositivo` varchar(255),
  `cidade` varchar(45) NOT NULL,
  `status` varchar(1) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT now(),
  `data_atualizacao` datetime
);

CREATE TABLE `delivery`.`tbl_permissoes` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(40) UNIQUE NOT NULL,
  `status` varchar(1) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT now()
);

CREATE TABLE `delivery`.`tbl_usuario_permissao` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_usuario` int UNIQUE NOT NULL,
  `id_permissao` int UNIQUE NOT NULL
);

CREATE TABLE `delivery`.`tbl_estabelecimentos` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_usuario` int UNIQUE NOT NULL,
  `cnpj` varchar(14) UNIQUE NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(11),
  `descricao` varchar(150),
  `url_imagem` varchar(255),
  `latitude` varchar(15) NOT NULL,
  `longitude` varchar(15) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `numero_endereco` varchar(6) NOT NULL,
  `complemento` varchar(15),
  `status` varchar(1) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT now(),
  `data_atualizacao` datetime
);

CREATE TABLE `delivery`.`tbl_categorias` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) UNIQUE NOT NULL,
  `descricao` varchar(110),
  `data_criacao` datetime NOT NULL DEFAULT now(),
  `data_atualizacao` datetime
);

CREATE TABLE `delivery`.`tbl_produtos` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `valor` double NOT NULL,
  `status` varchar(1) NOT NULL,
  `id_categoria` int NOT NULL,
  `id_estabelecimento` int NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT now(),
  `data_atualizacao` datetime
);

CREATE TABLE `delivery`.`tbl_vendas` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_produto` int NOT NULL,
  `status` varchar(1) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT now(),
  `data_atualizacao` datetime
);

CREATE TABLE `delivery`.`tbl_pushs` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `titulo` varchar(125) NOT NULL,
  `id_usuario` int NOT NULL,
  `descricao` varchar(255),
  `data_criacao` datetime NOT NULL DEFAULT now()
);

ALTER TABLE `delivery`.`tbl_usuario_permissao` ADD FOREIGN KEY (`id_usuario`) REFERENCES `delivery`.`tbl_usuarios` (`id`);

ALTER TABLE `delivery`.`tbl_usuario_permissao` ADD FOREIGN KEY (`id_permissao`) REFERENCES `delivery`.`tbl_permissoes` (`id`);

ALTER TABLE `delivery`.`tbl_estabelecimentos` ADD FOREIGN KEY (`id_usuario`) REFERENCES `delivery`.`tbl_usuarios` (`id`);

ALTER TABLE `delivery`.`tbl_produtos` ADD FOREIGN KEY (`id_categoria`) REFERENCES `delivery`.`tbl_categorias` (`id`);

ALTER TABLE `delivery`.`tbl_produtos` ADD FOREIGN KEY (`id_estabelecimento`) REFERENCES `delivery`.`tbl_estabelecimentos` (`id`);

ALTER TABLE `delivery`.`tbl_vendas` ADD FOREIGN KEY (`id_usuario`) REFERENCES `delivery`.`tbl_usuarios` (`id`);

ALTER TABLE `delivery`.`tbl_vendas` ADD FOREIGN KEY (`id_produto`) REFERENCES `delivery`.`tbl_produtos` (`id`);

ALTER TABLE `delivery`.`tbl_pushs` ADD FOREIGN KEY (`id_usuario`) REFERENCES `delivery`.`tbl_usuarios` (`id`);
