-- COMPONENTE               RM
-- ARTAXERXES ANTONIO      86180
-- CARLA HILST             84998 
-- FERNANDA RIBEIRO        85800
-- LEANDRO GUIDON          85756
-- LUCAS GODOY             85216


/*
DROP TABLE t_sgc_cargo CASCADE CONSTRAINTS;
DROP TABLE t_sgc_departamento CASCADE CONSTRAINTS;
DROP TABLE t_sgc_funcionario CASCADE CONSTRAINTS;
DROP TABLE t_sgc_gestor CASCADE CONSTRAINTS;
DROP TABLE t_sgc_missao CASCADE CONSTRAINTS;
*/


CREATE TABLE t_sgc_cargo (
    cd_cargo  NUMBER(5) NOT NULL,
    nm_cargo  VARCHAR2(30) NOT NULL,
    cd_depto  NUMBER(3) NOT NULL,
    nm_depto  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_sgc_cargo.cd_cargo IS
    'RN02 - Um cargo � identificado por um c�digo num�rico de cinco d�gitos, iniciando pelo c�digo do departamento.';

ALTER TABLE t_sgc_cargo
    ADD CONSTRAINT pk_sgc_cargo PRIMARY KEY ( cd_cargo,
                                              cd_depto,
                                              nm_cargo,
                                              nm_depto );

CREATE TABLE t_sgc_departamento (
    cd_depto  NUMBER(3) NOT NULL,
    nm_depto  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_sgc_departamento.cd_depto IS
    'RN01 - Um departamento � identificado por um c�digo num�rico de tr�s d�gitos.';

ALTER TABLE t_sgc_departamento ADD CONSTRAINT pk_sgc_departamento PRIMARY KEY ( cd_depto,
                                                                                nm_depto );

CREATE TABLE t_sgc_funcionario (
    nr_mtrfunc    NUMBER(3) NOT NULL,
    nm_func       VARCHAR2(50) NOT NULL,
    cd_depto      NUMBER(3) NOT NULL,
    nm_depto      VARCHAR2(30) NOT NULL,
    cd_cargo      NUMBER(5) NOT NULL,
    nm_cargo      VARCHAR2(30) NOT NULL,
    nr_mtrgestor  NUMBER(3) NOT NULL,
    ds_genero     VARCHAR2(10),
    nr_telefone   NUMBER(11),
    ds_email      VARCHAR2(80) NOT NULL,
    dt_admissao   DATE NOT NULL,
    qt_pontuacao  NUMBER(3) NOT NULL
);

COMMENT ON COLUMN t_sgc_funcionario.nr_telefone IS
    'RN05 � O n�mero de telefone � do tipo num�rico composto por onze d�gitos e dever� ser informado no formato **XXXX-XXXX.';

ALTER TABLE t_sgc_funcionario ADD CONSTRAINT pk_sgc_funcionario PRIMARY KEY ( nr_mtrfunc,
                                                                              nr_mtrgestor );

CREATE TABLE t_sgc_gestor (
    nr_mtrgestor  NUMBER(3) NOT NULL,
    nm_gestor     VARCHAR2(50) NOT NULL,
    cd_depto      NUMBER(3) NOT NULL,
    nm_depto      VARCHAR2(30) NOT NULL,
    cd_cargo      NUMBER(5) NOT NULL,
    nm_cargo      VARCHAR2(30) NOT NULL,
    ds_genero     VARCHAR2(10),
    nr_telefone   NUMBER(11),
    ds_email      VARCHAR2(80) NOT NULL,
    dt_admissao   DATE NOT NULL
);

COMMENT ON COLUMN t_sgc_gestor.nr_telefone IS
    'RN05 � O n�mero de telefone � do tipo num�rico composto por onze d�gitos e dever� ser informado no formato **XXXX-XXXX.';

ALTER TABLE t_sgc_gestor
    ADD CONSTRAINT pk_sgc_gestor PRIMARY KEY ( nr_mtrgestor,
                                               cd_depto,
                                               nm_depto );

CREATE TABLE t_sgc_missao (
    cd_missao     NUMBER(5) NOT NULL,
    ds_missao     VARCHAR2(500) NOT NULL,
    dt_cadastro   DATE NOT NULL,
    cd_depto      NUMBER(3) NOT NULL,
    nm_depto      VARCHAR2(30) NOT NULL,
    nr_mtrgestor  NUMBER(3) NOT NULL,
    nr_mtrfunc    NUMBER(3) NOT NULL,
    cd_cargo      NUMBER(5) NOT NULL,
    nm_cargo      VARCHAR2(30) NOT NULL,
    ds_status     VARCHAR2(10) NOT NULL,
    qt_valor      NUMBER(3) NOT NULL,
    dt_termino    DATE NOT NULL
);

COMMENT ON COLUMN t_sgc_missao.cd_missao IS
    'RN04 � Uma miss�o � identificada por um c�digo num�rico �nico de cinco d�gitos.';

COMMENT ON COLUMN t_sgc_missao.ds_status IS
    'RN21 � O status da miss�o dever� ser definido como: �ABERTO�, �EM ANDAMENTO� ou �CONCLU�DO�.';

COMMENT ON COLUMN t_sgc_missao.qt_valor IS
    'RN15 � A miss�o poder� ser atribu�do valor de at� 100 pontos.';

COMMENT ON COLUMN t_sgc_missao.dt_termino IS
    'RN18 � A data final de uma miss�o n�o pode ser anterior a data de cadastro.';

ALTER TABLE t_sgc_missao ADD CONSTRAINT t_sgc_missao_pk PRIMARY KEY ( cd_missao );

ALTER TABLE t_sgc_cargo
    ADD CONSTRAINT fk_sgc_cargo_depto FOREIGN KEY ( cd_depto,
                                                    nm_depto )
        REFERENCES t_sgc_departamento ( cd_depto,
                                        nm_depto );

ALTER TABLE t_sgc_funcionario
    ADD CONSTRAINT fk_sgc_func_gestor FOREIGN KEY ( nr_mtrgestor,
                                                    cd_depto,
                                                    nm_depto )
        REFERENCES t_sgc_gestor ( nr_mtrgestor,
                                  cd_depto,
                                  nm_depto );

ALTER TABLE t_sgc_gestor
    ADD CONSTRAINT fk_sgc_gestor_cargo FOREIGN KEY ( cd_cargo,
                                                     cd_depto,
                                                     nm_cargo,
                                                     nm_depto )
        REFERENCES t_sgc_cargo ( cd_cargo,
                                 cd_depto,
                                 nm_cargo,
                                 nm_depto );

ALTER TABLE t_sgc_missao
    ADD CONSTRAINT fk_sgc_missao_func FOREIGN KEY ( nr_mtrfunc,
                                                    nr_mtrgestor )
        REFERENCES t_sgc_funcionario ( nr_mtrfunc,
                                       nr_mtrgestor );


