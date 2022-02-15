/*COMPONENTE              RM
ARTAXERXES ANTONIO      86180
CARLA HILST             84998 
FERNANDA RIBEIRO        85800
LEANDRO GUIDON          85756
LUCAS GODOY             85216
*/

/*
DROP TABLE t_dvf_cronologia CASCADE CONSTRAINTS;
DROP TABLE t_dvf_personagem CASCADE CONSTRAINTS;
*/


CREATE TABLE t_dvf_cronologia (
    nr_ano    NUMBER(4) NOT NULL,
    nm_tempo  VARCHAR2(10)
);

COMMENT ON COLUMN t_dvf_cronologia.nm_tempo IS
    'RN01 - O nome tempo fica restrito as opções "passado", "presente" e "futuro".';

ALTER TABLE t_dvf_cronologia ADD CONSTRAINT pk_dvf_cronologia PRIMARY KEY ( nr_ano );

CREATE TABLE t_dvf_personagem (
    id_personagem  NUMBER(2)NOT NULL,
    nr_ano         NUMBER(4) NOT NULL,
    ds_tipo        VARCHAR2(10) NOT NULL,
    nm_personagem  VARCHAR2(30) NOT NULL,
    ds_missao      VARCHAR2(500) NOT NULL,
    ds_imagem      VARCHAR2(150) NOT NULL
);

COMMENT ON COLUMN t_dvf_personagem.ds_tipo IS
    'RN02 - O código do tipo de personagem fica restrito a (1) para tipo de personagem principal e (2) para tipo de pesonagem secundário.';

ALTER TABLE t_dvf_personagem ADD CONSTRAINT pk_dvf_personagem PRIMARY KEY ( id_personagem,
                                                                            nm_personagem );

ALTER TABLE t_dvf_personagem
    ADD CONSTRAINT fk_dvf_person_cronol FOREIGN KEY ( nr_ano )
        REFERENCES t_dvf_cronologia ( nr_ano );



