-- Gerado por Oracle SQL Developer Data Modeler 4.1.5.907
--   em:        2020-10-01 14:49:07 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g


/*
DROP TABLE T_SPV_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_SPV_UNID_COMERCIAL CASCADE CONSTRAINTS;
DROP TABLE T_SPV_CLASSIF_FISCAL CASCADE CONSTRAINTS;
DROP TABLE T_SPV_CLIENTE CASCADE CONSTRAINTS;
DROP TABLE T_SPV_NOTA_FISCAL CASCADE CONSTRAINTS;
DROP TABLE T_SPV_ITEM_NF CASCADE CONSTRAINTS;
*/


/*

DELETE FROM T_SPV_PRODUTO;
DELETE FROM T_SPV_UNID_COMERCIAL;
DELETE FROM T_SPV_CLASSIF_FISCAL;
DELETE FROM T_SPV_CLIENTE;
DELETE FROM T_SPV_NOTA_FISCAL;
DELETE FROM T_SPV_ITEM_NF;

-- CASCADE CONSTRAINT INSERIDO AO FINAL DAS FOREIGN KEYS.

*/


CREATE TABLE T_SPV_CLASSIF_FISCAL
  (
    nr_cfop             NUMBER(4)      NOT NULL ,
    ds_tipo_operacao    NUMBER(1)      NOT NULL ,
    nm_nat_operacao     VARCHAR2(50)   NOT NULL ,
    ds_nat_operacao     VARCHAR2(600)  NOT NULL
  );
  
ALTER TABLE T_SPV_CLASSIF_FISCAL 
    ADD CONSTRAINT T_SPV_CLASSIF_FISCAL_OP 
    CHECK (DS_TIPO_OPERACAO IN (1,2));

ALTER TABLE T_SPV_CLASSIF_FISCAL
    ADD CONSTRAINT PK_CLASSIF_FISCAL 
    PRIMARY KEY (nr_cfop);
    
ALTER TABLE T_SPV_CLASSIF_FISCAL 
    ADD CONSTRAINT UN_SPV_CLASSIF_FISCAL_NATOP 
    UNIQUE (nm_nat_operacao);


CREATE TABLE T_SPV_CLIENTE
  (
    cd_cliente      NUMBER(5)       NOT NULL,
    nm_cliente      VARCHAR2(50)    NOT NULL,
    dt_nascimento   DATE            NULL,
    ds_genero       CHAR(2)         NOT NULL,
    ds_endereco     VARCHAR2(100)   NOT NULL,
    nr_ddd_fone     NUMBER(3)       NULL,
    nr_telefone     NUMBER(9)       NULL,
    ds_email        VARCHAR2(40)    NULL,
    nr_cpf          NUMBER(9)       NOT NULL,
    nr_cpf_dig      NUMBER(2)       NOT NULL,
    nr_rg           NUMBER(8)       NOT NULL,
    nr_rg_dig       CHAR(1)         NOT NULL
  );
  
ALTER TABLE T_SPV_CLIENTE 
    ADD CONSTRAINT CK_SPV_CLIENTE_GENERO 
    CHECK (UPPER(DS_GENERO) = 'H' OR UPPER(DS_GENERO) = 'M' OR UPPER(DS_GENERO) = 'NB');
    
ALTER TABLE T_SPV_CLIENTE 
    ADD CONSTRAINT PK_SPV_CLIENTE 
    PRIMARY KEY (cd_cliente);


CREATE TABLE T_SPV_ITEM_NF
  (
    nr_nota_fiscal      NUMBER(5)       NOT NULL ,
    cd_produto          NUMBER(5)       NOT NULL ,
    qt_vendida          NUMBER(4)       NOT NULL ,
    vl_preco_unit_venda NUMBER(6,2)     NOT NULL ,
    vl_preco_total_item NUMBER(8,2)     NOT NULL
  ) ;
  
ALTER TABLE T_SPV_ITEM_NF 
    ADD CONSTRAINT CK_SPV_ITEM_NF_QT_VENDIDA 
    CHECK (qt_vendida > 0);
    
ALTER TABLE T_SPV_ITEM_NF 
    ADD CONSTRAINT CK_SPV_ITEM_NF_PRECO_UNIT 
    CHECK (vl_preco_unit_venda > 0.00);
    
ALTER TABLE T_SPV_ITEM_NF 
    ADD CONSTRAINT PK_SPV_ITEM_NF 
    PRIMARY KEY (nr_nota_fiscal, cd_produto);


CREATE TABLE T_SPV_NOTA_FISCAL
  (
    nr_nota_fiscal NUMBER(5)       NOT NULL,
    cd_cliente     NUMBER(5)       NOT NULL,
    nr_cfop        NUMBER(4)       NOT NULL,
    dt_emissao     DATE            NOT NULL,
    dt_saida       DATE            NOT NULL,
    vl_total_nf    NUMBER(9,2)     NOT NULL,
    vl_desconto    NUMBER(3,1)     NOT NULL
  );
  
ALTER TABLE T_SPV_NOTA_FISCAL 
    ADD CONSTRAINT CK_SPV_NOTA_FISCAL_DT 
    CHECK (dt_saida >= dt_emissao);
    
ALTER TABLE T_SPV_NOTA_FISCAL 
    ADD CONSTRAINT CK_SPV_NOTA_FISCAL_DESCONTO 
    CHECK (VL_DESCONTO >= 0 AND VL_DESCONTO <= 25);
    
ALTER TABLE T_SPV_NOTA_FISCAL 
    ADD CONSTRAINT PK_SPV_NOTA_FISCAL 
    PRIMARY KEY (nr_nota_fiscal);


CREATE TABLE T_SPV_PRODUTO
  (
    cd_produto          NUMBER(5)      NOT NULL,
    cd_unid_comercial   NUMBER(3)      NOT NULL,
    ds_produto          VARCHAR2(30)   NOT NULL,
    ds_produto_completa VARCHAR2(80)   NOT NULL,
    qt_estoque          NUMBER(4)      NOT NULL,
    vl_preco_unitario   NUMBER(6,2)    NOT NULL
  ) ;
  
ALTER TABLE T_SPV_PRODUTO 
    ADD CONSTRAINT CK_SPV_PRODUTO_PREUNI 
    CHECK (VL_PRECO_UNITARIO > 0);
    
ALTER TABLE T_SPV_PRODUTO 
    ADD CONSTRAINT PK_SPV_PRODUTO 
    PRIMARY KEY ( cd_produto );
    
ALTER TABLE T_SPV_PRODUTO 
    ADD CONSTRAINT UN_SPV_PRODUTO_DESC 
    UNIQUE ( ds_produto );


CREATE TABLE T_SPV_UNID_COMERCIAL
  (
    cd_unid_comercial       NUMBER(3)         NOT NULL,
    sg_unid_comercial       VARCHAR2(10)      NOT NULL,
    ds_unid_comercial       VARCHAR2(30)      NOT NULL
  );
  
ALTER TABLE T_SPV_UNID_COMERCIAL 
    ADD CONSTRAINT PK_SPV_UNID_COMERCIAL 
    PRIMARY KEY (cd_unid_comercial);
    
ALTER TABLE T_SPV_UNID_COMERCIAL 
    ADD CONSTRAINT UN_SPV_UNID_COMERCIAL_DESC 
    UNIQUE (ds_unid_comercial);


ALTER TABLE T_SPV_ITEM_NF 
    ADD CONSTRAINT FK_SPV_ITEM_NF_NOTA_FISCAL 
    FOREIGN KEY (nr_nota_fiscal) 
    REFERENCES T_SPV_NOTA_FISCAL (nr_nota_fiscal)
    ON DELETE CASCADE;

ALTER TABLE T_SPV_ITEM_NF 
    ADD CONSTRAINT FK_SPV_ITEM_NF_PRODUTO 
    FOREIGN KEY (cd_produto) 
    REFERENCES T_SPV_PRODUTO (cd_produto)
    ON DELETE CASCADE;

ALTER TABLE T_SPV_NOTA_FISCAL 
    ADD CONSTRAINT FK_SPV_NF_CLASSIF_FISCAL 
    FOREIGN KEY (nr_cfop) 
    REFERENCES T_SPV_CLASSIF_FISCAL (nr_cfop)
    ON DELETE CASCADE;

ALTER TABLE T_SPV_NOTA_FISCAL 
    ADD CONSTRAINT FK_SPV_NF_CLIENTE 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_SPV_CLIENTE (cd_cliente)
    ON DELETE CASCADE;

ALTER TABLE T_SPV_PRODUTO 
    ADD CONSTRAINT FK_SPV_UNID_COMERCIAL 
    FOREIGN KEY (cd_unid_comercial) 
    REFERENCES T_SPV_UNID_COMERCIAL (cd_unid_comercial) 
    ON DELETE CASCADE;


INSERT INTO T_SPV_UNID_COMERCIAL (CD_UNID_COMERCIAL, SG_UNID_COMERCIAL, DS_UNID_COMERCIAL)   -- COMANDO PARA INSERÇÃO, COM NOME DA TABELA E DAS COLUNAS
    VALUES (1, 'CX', 'CAIXA');
    
INSERT INTO T_SPV_UNID_COMERCIAL
    VALUES (2, 'PACOTE', 'PACOTE');

INSERT INTO T_SPV_UNID_COMERCIAL
    VALUES (3, 'PC', 'PEÇA');
    
INSERT INTO T_SPV_UNID_COMERCIAL
    VALUES (4, 'M', 'METRO');
    
INSERT INTO T_SPV_UNID_COMERCIAL
    VALUES (5, 'KG', 'QUILOGRAMA');
    
    
INSERT INTO T_SPV_CLASSIF_FISCAL (NR_CFOP, DS_TIPO_OPERACAO, NM_NAT_OPERACAO, DS_NAT_OPERACAO)
    VALUES (1101, 1, 'COMPRA INDUSTRIALIZAÇÃO', 'COMPRA DE MERCADORIAS PARA PROCESSOS DE INDUSTRIALIZAÇÃO');
    
INSERT INTO T_SPV_CLASSIF_FISCAL
    VALUES (1102, 1, 'COMPRA COMERCIALIZAÇÃO', 'COMPRA DE MERCADORIAS PARA SEREM COMERCIALIZADAS');

INSERT INTO T_SPV_CLASSIF_FISCAL
    VALUES (5101, 2, 'VENDA', 'VENDA DE MERCADORIAS COMERCIALIZADAS');

INSERT INTO T_SPV_CLASSIF_FISCAL
    VALUES (5102, 2, 'BRINDE', 'MERCADORIAS OFERECIDAS NAS COMERCIALIZAÇÕES SEM CUSTO');
    
    
INSERT INTO T_SPV_CLIENTE (CD_CLIENTE, NM_CLIENTE, DT_NASCIMENTO, DS_GENERO, DS_ENDERECO, NR_DDD_FONE, NR_TELEFONE, DS_EMAIL, NR_CPF, NR_CPF_DIG, NR_RG, NR_RG_DIG)
    VALUES (1, 
        'MARIA DAS DORES', 
        TO_DATE('21/04/1987', 'DD/MM/YYYY'),
        'M', 
        'RUA AGUAPEI, 25', 
        11, 
        945451212,
        'MARIAJOSE@MARIAJOSE.COM.BR',
        12345678, 
        9,
        1234567, 
        8);
        
INSERT INTO T_SPV_CLIENTE
    VALUES (2,
            'ANA MARIA',
            TO_DATE('10/02/1986', 'DD/MM/YYYY'),
            'M',
            'RUA BELA VISTA, 30',
            11,
            94541213,
            'ANAMARIA@ANAMARIA.COM.BR',
            23456789,
            0,
            2345678,
            9);
        
INSERT INTO T_SPV_CLIENTE
    VALUES (3,
            'JOÃO DA SILVA',
            TO_DATE('08/09/1991', 'DD/MM/YYYY'),
            'H',
            'AVENIDA PAULISTA, 1009',
            11,
            945412141,
            'JOAOSILVA@JOAOSILVA.COM.BR',
            34567890,
            1,
            3456789,
            0);
            
INSERT INTO T_SPV_CLIENTE
    VALUES (4,
            'JOAQUIM XAVIER',
            TO_DATE('21/04/1988', 'DD/MM/YYYY'),
            'H',
            'AVENIDA SÃO JOÃO, 34',
            11,
            945412151,
            'JOAQUIMXAVIER@JOAQUIMXAVIER.COM.BR',
            45678901,
            2,
            4567890,
            1);


UPDATE T_SPV_CLIENTE
    SET NR_TELEFONE = 945451213
    WHERE CD_CLIENTE = 2;   


INSERT INTO T_SPV_PRODUTO (CD_PRODUTO, CD_UNID_COMERCIAL, DS_PRODUTO, DS_PRODUTO_COMPLETA, QT_ESTOQUE, VL_PRECO_UNITARIO)
    VALUES (1, 1, 'NOTEBOOK SENSACIONAL', 'NOTEBOOK XPTO SUPER ESPECIAL', 3, 1980.56);
    
INSERT INTO T_SPV_PRODUTO 
    VALUES (2, 1, 'IMPRESSORA X3', 'IMPRESSORA MULTIFUNCIONAL HP', 5, 432.89);
    
INSERT INTO T_SPV_PRODUTO 
    VALUES (3, 1, 'PEN DRIVE - 16GB', 'PEN DRIVE 16GB KINGSTON', 10, 60);
    
INSERT INTO T_SPV_PRODUTO 
    VALUES (4, 1, 'PEN DRIVE - 32 GB', 'PEN DRIVE 32GB KINGSTON', 10, 108);
    
INSERT INTO T_SPV_PRODUTO 
    VALUES (5, 1, 'HD EXTERNO - 500GB', 'HD EXTERNO SAMSUMG - 500GB', 10, 305);
    
INSERT INTO T_SPV_PRODUTO 
    VALUES (6, 1, 'HD EXTERNO - 1TB', 'HD EXTERNO SAMSUNG - 1TB', 10, 870);


INSERT INTO T_SPV_NOTA_FISCAL (NR_NOTA_FISCAL, CD_CLIENTE, NR_CFOP, DT_EMISSAO, DT_SAIDA, VL_TOTAL_NF, VL_DESCONTO)
    VALUES (1234, 1, 1102, TO_DATE('09/08/2019', 'DD/MM/YYYY'), TO_DATE('09/08/2019', 'DD/MM/YYYY'), 870, 2.5);
    
INSERT INTO T_SPV_NOTA_FISCAL
    VALUES (1235, 1, 1102, TO_DATE('10/08/2019', 'DD/MM/YYYY'), TO_DATE('11/08/2019', 'DD/MM/YYYY'), 2168.67, 2);

INSERT INTO T_SPV_NOTA_FISCAL
    VALUES (1236, 2, 5101, TO_DATE('15/08/2019', 'DD/MM/YYYY'), TO_DATE('15/08/2019', 'DD/MM/YYYY'), 60, 0);


INSERT INTO T_SPV_ITEM_NF (NR_NOTA_FISCAL, CD_PRODUTO, QT_VENDIDA, VL_PRECO_UNIT_VENDA, VL_PRECO_TOTAL_ITEM)
    VALUES (1234, 6, 1, 870, 870);
    
INSERT INTO T_SPV_ITEM_NF 
    VALUES (1235, 6, 1, 870, 870);
    
INSERT INTO T_SPV_ITEM_NF 
    VALUES (1235, 2, 3, 432.89, 1298.67);
    
INSERT INTO T_SPV_ITEM_NF
    VALUES (1236, 3, 1, 60, 60);
 

/*
SELECT * FROM T_SPV_UNID_COMERCIAL;
SELECT * FROM T_SPV_CLASSIF_FISCAL;
SELECT * FROM T_SPV_CLIENTE;
SELECT * FROM T_SPV_PRODUTO;
SELECT * FROM T_SPV_NOTA_FISCAL;
SELECT * FROM T_SPV_ITEM_NF;
*/

COMMIT;

-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             21
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
