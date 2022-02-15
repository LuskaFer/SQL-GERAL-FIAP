
--86397 	Artur Fonseca Pinheiro 
--85412 	Sara Kolenyak Freitas da Silva 
--85216 	Lucas Fernandes Godoy 
--83153     Moisés Sodré de Sousa
--80205     Gabriel Rufino
--84621         João vitor
--2_TDSF_2021_SCRIPT_PL_SQL.sql
 
 CREATE TABLE tb_comandos ( 
    cd_comando               NUMBER NOT NULL,     ds_dispositivo_emissor   VARCHAR2(11) NOT NULL,     ds_dispositivo_receptor  VARCHAR2(11) NOT NULL,     ds_conteudo              VARCHAR2(250) NOT NULL,     ds_tipo                  VARCHAR2(10) NOT NULL,     cd_dispositivo           NUMBER(5) NOT NULL 
);  
ALTER TABLE tb_comandos ADD CONSTRAINT tb_comandos_pk 
PRIMARY KEY ( cd_comando, 
                                                          cd_dispositivo ); 
CREATE TABLE tb_dispositivos (     cd_dispositivo  NUMBER(5) NOT NULL,     cd_mac          VARCHAR2(11) NOT NULL,     ds_tipo         VARCHAR2(50) NOT NULL,     ds_sensor1      VARCHAR2(50),     ds_sensor2      VARCHAR2(50),     ds_sensor3      VARCHAR2(50),     ds_atuador1     VARCHAR2(50),     ds_atuador2     VARCHAR2(50),     ds_atuador3     VARCHAR2(50),     cd_usuario      NUMBER(5) NOT NULL 
);  
	ALTER 	TABLE 	tb_dispositivos 	ADD 	CONSTRAINT 
tb_dispositivos_pk PRIMARY KEY ( cd_dispositivo ); 
 
CREATE TABLE tb_usuario ( 
    cd_usuario       NUMBER(5) NOT NULL,     nm_usuario       VARCHAR2(50) NOT NULL,     tp_usuario       VARCHAR2(50) NOT NULL,     dt_ultimo_login  DATE 
); 
 
ALTER TABLE tb_usuario ADD CONSTRAINT tb_usuario_pk 
PRIMARY KEY ( cd_usuario );  
ALTER TABLE tb_comandos 
   

INSERT INTO TB_USUARIO (cd_usuario, nm_usuario, tp_usuario,dt_ultimo_login)
INSERT INTO TB_USUARIO (cd_usuario, nm_usuario, tp_usuario,dt_ultimo_login) VALUES (1, 'Paulo', 'Morador', '30/05/2021'); 
INSERT INTO TB_USUARIO (cd_usuario, nm_usuario, tp_usuario,dt_ultimo_login) VALUES (2, ‘Maria’, ‘Morador’, ‘29/05/2021’); 
INSERT INTO TB_USUARIO (cd_usuario, nm_usuario, tp_usuario,dt_ultimo_login) VALUES (3, ‘João’, ‘Convidado’, ‘30/05/2021’); 
 


 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (1, '1062E', 'Cooktop','1');
 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (2, '2062A', 'Máquina de lavar','2');
 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (3, '3062B', 'aspirador','3');
 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (4, '4062C', 'Máquina de lavar roupas','4');
 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (5, '5062D', 'Cooktop','5');





CREATE OR REPLACE FUNCTION FmDISPOSITIVO(p_id integer)
    RETURN varchar is
    v_dispositivo varchar(20);
BEGIN
    SELECT ds_tipo
    INTO v_dispositivo
    FROM tb_dispositivos  where cd_dispositivo =p_id;
    RETURN v_dispositivo;
     EXCEPTION 
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('CODIGO ERRO:' || SQLCODE); 
    DBMS_OUTPUT.PUT_LINE('DESCRICAO DO ERRO:' || SQLERRM); 
    RETURN 'PARÂMETRO INVÁLIDO';
END;
/
SELECT FmDISPOSITIVO(1) FROM DUAL;

CREATE OR REPLACE PROCEDURE INSERE_dispositivo
(v_cd_dispositivo in int, 
 v_cd_mac in VARCHAR ,
 v_ds_tipo in VARCHAR,
 v_cd_usuario in int)
IS
BEGIN
    insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (v_cd_dispositivo, v_cd_mac, v_ds_tipo,v_cd_usuario);

   COMMIT;
END;
/

EXECUTE INSERE_dispositivo(3,'2132','geladeira',4);

select * from tb_dispositivos;

 insert into tb_dispositivos (cd_dispositivo, cd_mac, ds_tipo,cd_usuario) values (4, '1062E', 'Cooktop','20');
