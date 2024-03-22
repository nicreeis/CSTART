-- SCRIPT DDL PARA CRIACAO DA ESTRUTURA DO BD - CSTART


-- ELIMINAR AS TABELAS DA ESTRUTURA

/*
DROP TABLE T_CSTART_USUARIO           CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_EMPRESA           CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_EVENTO            CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_TRIBUTACAO        CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_VAGA              CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_PROFISSAO         CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_COMPETENCIA       CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_AREA              CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_COMPET_PROFIS     CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_PROFIS_SETOR      CASCADE CONSTRAINTS;
DROP TABLE T_CSTART_USER_COMPET       CASCADE CONSTRAINTS;
*/

-- CRIACAO DE TABELAS

-- Tabela de Usuario
CREATE TABLE T_CSTART_USUARIO 
(
    id_usuario                  NUMERIC(5)      NOT NULL,
    nm_usuario                  VARCHAR(100)    NOT NULL,
    ds_email                    VARCHAR(100)    NOT NULL,
    ds_localizacao              VARCHAR(100)    NOT NULL,
    nr_telefone                 NUMERIC(9)      NULL,
    nr_ddd                      NUMERIC(2)      NULL,
    dt_nascimento               DATE            NOT NULL,
    ds_genero                   CHAR(2)         NOT NULL
  );
  
    ALTER TABLE T_CSTART_USUARIO  
        ADD CONSTRAINT PK_CSTART_ID_USUARIO 
        PRIMARY KEY(id_usuario); 


-- Tabela de Empresas
CREATE TABLE T_CSTART_EMPRESA
(
    id_empresa                  NUMERIC(5)      NOT NULL,
    nm_empresa                  VARCHAR(100)    NOT NULL,
    id_setor                    NUMERIC(5)      NULL,
    ds_localizacao              VARCHAR(100)    NOT NULL,
    dt_fundacao                 DATE            NULL,
    ds_url_site                 VARCHAR(100)    NULL,
    qt_funcionarios             NUMERIC(10)     NULL    
);

    ALTER TABLE T_CSTART_EMPRESA  
        ADD CONSTRAINT PK_CSTART_ID_EMPRESA 
        PRIMARY KEY(id_empresa);

-- Tabela de Eventos
CREATE TABLE T_CSTART_EVENTO 
(
    id_evento                   NUMERIC(5)      NOT NULL,
    nome_evento                 VARCHAR(100)    NOT NULL,
    dt_evento                   DATE            NOT NULL,
    ds_localizacao              VARCHAR(100)    NOT NULL,
    tp_evento                   VARCHAR(50)     NOT NULL,
    nm_organizad_evento         VARCHAR(100)    NOT NULL
);

    ALTER TABLE T_CSTART_EVENTO  
        ADD CONSTRAINT PK_CSTART_ID_EVENTO 
        PRIMARY KEY (id_evento)

-- Tabela de Tributacao
CREATE TABLE T_CSTART_TRIBUTACAO 
(
    id_tributacao               NUMERIC(5)     NOT NULL,
    nm_imposto                  VARCHAR(100)   NOT NULL,
    vl_percent_tributacao       NUMERIC(5,2)   NOT NULL,
    ds_legislacao_imposto       TEXT           NOT NULL,
    dt_vigencia_inicio          DATE           NOT NULL,
    dt_vigencia_fim             DATE           NULL
);

    ALTER TABLE T_CSTART_TRIBUTACAO  
        ADD CONSTRAINT PK_CSTART_ID_TRIBUTACAO 
        PRIMARY KEY (id_tributacao)

-- Tabela de Vagas
CREATE TABLE T_CSTART_VAGA 
(
    id_vaga                     NUMERIC(5)      NOT NULL,
    id_empresa                  NUMERIC(5)      NOT NULL,
    nm_profissao                VARCHAR(100)    NOT NULL,
    nm_vaga                     VARCHAR(100)    NOT NULL,
    cd_cidade                   VARCHAR(20)     NULL,
    cd_pais                     NUMERIC(10)     NULL,
    tp_contratacao              VARCHAR(10)     NOT NULL,
    qt_tempo_qualificacao       NUMERIC(5)      NOT NULL,
    vl_salario                  NUMERIC(10,2)   NULL,
    ds_requisitos_minimos       TEXT            NULL,
    ds_beneficios               TEXT            NULL,
    dt_publicacao               DATE            NOT NULL,
    dt_encerramento             DATE            NULL
);

    ALTER TABLE T_CSTART_VAGA  
        ADD CONSTRAINT PK_CSTART_ID_VAGA 
        PRIMARY KEY (id_vaga)

-- Tabela de Profissao
CREATE TABLE T_CSTART_PROFISSAO 
(
    id_profissao               NUMERIC(5)    NOT NULL,
    nm_profissao               VARCHAR(100)  NOT NULL,
    id_competencia             NUMERIC(5)    NOT NULL,
    ds_profissao               TEXT          NOT NULL
);

    ALTER TABLE T_CSTART_PROFISSAO  
        ADD CONSTRAINT PK_CSTART_ID_PROFISSAO 
        PRIMARY KEY (id_profissao)

-- Tabela de Competencia
CREATE TABLE T_CSTART_COMPETENCIA 
(
    id_competencia            NUMERIC(5)       NOT NULL,
    nm_competencia            VARCHAR(100)     NOT NULL,
    ds_competencia            TEXT             NOT NULL
);

    ALTER TABLE T_CSTART_COMPETENCIA  
        ADD CONSTRAINT PK_CSTART_ID_COMPETENCIA 
        PRIMARY KEY (id_competencia)

-- Tabela do Setor
CREATE TABLE T_CSTART_SETOR 
(
    id_setor                NUMERIC(5)    NOT NULL,
    nm_setor                VARCHAR(100)  NOT NULL,
    ds_setor                TEXT          NULL
);

    ALTER TABLE T_CSTART_SETOR  
        ADD CONSTRAINT PK_CSTART_ID_SETOR 
        PRIMARY KEY (id_setor)
        
-------------------------------------------------------------------------------

-- TABELAS ASSOCIATIVAS

-- Tabela Associativa de Competencia por Profissao      
CREATE TABLE T_CSTART_COMPET_PROFIS 
(
    id_competencia                NUMERIC(5)        NOT NULL,
    id_profissao                  NUMERIC(5)        NOT NULL
);

-- Tabela Associativa de Profissao por Setor      
CREATE TABLE T_CSTART_PROFIS_SETOR 
(
    id_setor                      NUMERIC(5)        NOT NULL,
    id_profissao                  NUMERIC(5)        NOT NULL
); 

-- Tabela Associativa de Usuário por Competencia
CREATE TABLE T_CSTART_USER_COMPET
(
    id_usuario                    NUMERIC(5)        NOT NULL, 
    id_competencia                NUMERIC(5)        NOT NULL
);

-------------------------------------------------------------------------------

-- CHAVES ESTRANGEIRAS

-- Chave estrangeira Empresa <> Setor (ID_SETOR)
ALTER TABLE T_CSTART_EMPRESA
ADD CONSTRAINT FK_T_CSTART_EMPRESA_SETOR 
    FOREIGN KEY (ID_SETOR) 
    REFERENCES T_CSTART_SETOR (ID_SETOR); 

-- Chave estrangeira Vaga <> Empresa (ID_EMPRESA)
ALTER TABLE T_CSTART_VAGA
ADD CONSTRAINT FK_T_CSTART_VAGA_EMPRESA
    FOREIGN KEY (ID_EMPRESA) 
    REFERENCES T_CSTART_EMPRESA (ID_EMPRESA); 
    
-- Chave estrangeira Profissao <> Setor (ID_SETOR / ID_PROFISSAO)
ALTER TABLE T_CSTART_PROFIS_SETOR
ADD CONSTRAINT FK_T_CSTART_PROFIS_SETOR_SETOR
    FOREIGN KEY (ID_SETOR) 
    REFERENCES T_CSTART_SETOR (ID_SETOR); 
    
ALTER TABLE T_CSTART_PROFIS_SETOR
ADD CONSTRAINT FK_T_CSTART_SETOR_PROFIS_PROFIS
    FOREIGN KEY (ID_PROFISSAO) 
    REFERENCES T_CSTART_PROFISSAO (ID_PROFISSAO); 
    
-- Chave estrangeira Profissao <> Competencia (ID_COMPETENCIA / ID_PROFISSAO)
ALTER TABLE T_CSTART_COMPET_PROFIS
ADD CONSTRAINT FK_T_CSTART_COMPET_PROFIS_PROFIS
    FOREIGN KEY (ID_COMPETENCIA) 
    REFERENCES T_CSTART_COMPETENCIA (ID_COMPETENCIA); 
    
ALTER TABLE T_CSTART_COMPET_PROFIS
ADD CONSTRAINT FK_T_CSTART_PROFIS_COMPET
    FOREIGN KEY (ID_PROFISSAO) 
    REFERENCES T_CSTART_PROFISSAO (ID_PROFISSAO); 
    
-- Chave estrangeira Usuario <> Competencia (ID_COMPETENCIA / ID_USUARIO)
ALTER TABLE T_CSTART_USER_COMPET
ADD CONSTRAINT FK_T_CSTART_COMPET_USER_COMPET
    FOREIGN KEY (ID_COMPETENCIA) 
    REFERENCES T_CSTART_COMPETENCIA (ID_COMPETENCIA); 
    
ALTER TABLE T_CSTART_USER_COMPET
ADD CONSTRAINT FK_T_CSTART_USER_COMPET_USER 
    FOREIGN KEY (ID_USUARIO) 
    REFERENCES T_CSTART_USUARIO (ID_USUARIO); 

-- Chave estrangeira Vaga <> Profissao (NM_PROFISSAO)
ALTER TABLE T_CSTART_VAGA
ADD CONSTRAINT FK_T_CSTART_VAGA_PROFISSAO
    FOREIGN KEY (NM_PROFISSAO) 
    REFERENCES T_CSTART_PROFISSAO (NM_PROFISSAO); 
