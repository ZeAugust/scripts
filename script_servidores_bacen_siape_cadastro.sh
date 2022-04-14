#!/bin/bash

##########################################################################
# SCRIPT PARA BAIXAR OS ARQUIVOS REFERENTES AOS SERVIDORES NO P.T.
##########################################################################

inst=(BACEN SIAPE)

for i in "${inst[@]}"
do
	for j in {01..11}
	do
		wget --read-timeout=5 -P /home/jose/Desktop/scripts/files_servidores/servidores_"${i}" "https://www.portaltransparencia.gov.br/download-de-dados/servidores/2021${j}_Servidores_"${i}""		
		unzip "/home/jose/Desktop/scripts/files_servidores/servidores_"${i}"/2021${j}_Servidores_"${i}"" -d /home/jose/Desktop/scripts/files_servidores/servidores_"${i}"
		rm /home/jose/Desktop/scripts/files_servidores/servidores_"${i}"/2021${j}_Servidores_"${i}"

		
			PGPASSWORD="'' " psql -U aml -c "drop table if exists tmp_servidores;"
			PGPASSWORD="'' " psql -U aml -c "CREATE TABLE public.""tmp_servidores"" (
	ID_SERVIDOR_PORTAL varchar(1024) ,
	NOME varchar(1024) ,
	CPF varchar(1024) ,
	MATRICULA varchar(1024) ,
	DESCRICAO_CARGO    varchar(1024) ,
	CLASSE_CARGO varchar(1024) ,
	REFERENCIA_CARGO varchar(1024) ,
	PADRAO_CARGO varchar(1024) ,
	NIVEL_CARGO    varchar(1024) ,
	SIGLA_FUNCAO varchar(1024) ,
	NIVEL_FUNCAO varchar(1024) ,
	FUNCAO    varchar(1024) ,
	CODIGO_ATIVIDADE varchar(1024) ,
	ATIVIDADE varchar(1024) ,
	OPCAO_PARCIAL varchar(1024) ,
	COD_UORG_LOTACAO varchar(1024) ,
	UORG_LOTACAO varchar(1024) ,
	COD_ORG_LOTACAO varchar(1024) ,
	ORG_LOTACAO    varchar(1024) ,
	COD_ORGSUP_LOTACAO varchar(1024) ,
	ORGSUP_LOTACAO varchar(1024) ,
	COD_UORG_EXERCICIO varchar(1024) ,
	UORG_EXERCICIO varchar(1024) ,
	COD_ORG_EXERCICIO varchar(1024) ,
	ORG_EXERCICIO varchar(1024) ,
	COD_ORGSUP_EXERCICIO varchar(1024) ,
	ORGSUP_EXERCICIO varchar(1024) ,
	COD_TIPO_VINCULO varchar(1024) ,
	TIPO_VINCULO varchar(1024) ,
	SITUACAO_VINCULO varchar(1024) ,
	DATA_INICIO_AFASTAMENTO varchar(1024) ,
	DATA_TERMINO_AFASTAMENTO varchar(1024) ,
	REGIME_JURIDICO    varchar(1024) ,
	JORNADA_DE_TRABALHO varchar(1024) ,
	DATA_INGRESSO_CARGOFUNCAO varchar(1024) ,
	DATA_NOMEACAO_CARGOFUNCAO varchar(1024) ,
	DATA_INGRESSO_ORGAO    varchar(1024) ,
	DOCUMENTO_INGRESSO_SERVICOPUBLICO varchar(1024) ,
	DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO varchar(1024) ,
	DIPLOMA_INGRESSO_CARGOFUNCAO varchar(1024) ,
	DIPLOMA_INGRESSO_ORGAO varchar(1024) ,
	DIPLOMA_INGRESSO_SERVICOPUBLICO    varchar(1024),
	UF_EXERCICIO varchar(1024) 
);"
			PGPASSWORD="'' " psql -U aml -c "\copy tmp_servidores
from '/home/jose/Desktop/scripts/files_servidores/servidores_"${i}"/2021${j}_Cadastro.csv'
with 
	delimiter ';'
	csv
	header
	encoding 'latin1';"

			PGPASSWORD="'' " psql -U aml -c "CREATE TABLE public.""final_servidores"" (
	ID_SERVIDOR_PORTAL varchar(32) ,
	NOME varchar(128) ,
	CPF varchar(64) ,
	MATRICULA varchar(24) ,
	DESCRICAO_CARGO    varchar(128) ,
	CLASSE_CARGO varchar(1) ,
	REFERENCIA_CARGO varchar(1024) ,
	PADRAO_CARGO varchar(4) ,
	NIVEL_CARGO    varchar(4) ,
	SIGLA_FUNCAO varchar(4) ,
	NIVEL_FUNCAO varchar(5),
	FUNCAO    varchar(128) ,
	CODIGO_ATIVIDADE varchar(5) ,
	ATIVIDADE varchar(64) ,
	OPCAO_PARCIAL varchar(32) ,
	COD_UORG_LOTACAO varchar(64) ,
	UORG_LOTACAO varchar(128) ,
	COD_ORG_LOTACAO varchar(6) ,
	ORG_LOTACAO    varchar(64) ,
	COD_ORGSUP_LOTACAO varchar(6) ,
	ORGSUP_LOTACAO varchar(64) ,
	COD_UORG_EXERCICIO varchar(32) ,
	UORG_EXERCICIO varchar(64) ,
	COD_ORG_EXERCICIO varchar(6) ,
	ORG_EXERCICIO varchar(64) ,
	COD_ORGSUP_EXERCICIO varchar(6) ,
	ORGSUP_EXERCICIO varchar(64) ,
	COD_TIPO_VINCULO varchar(2) ,
	TIPO_VINCULO varchar(32) ,
	SITUACAO_VINCULO varchar(64) ,
	DATA_INICIO_AFASTAMENTO date ,
	DATA_TERMINO_AFASTAMENTO date ,
	REGIME_JURIDICO    varchar(64) ,
	JORNADA_DE_TRABALHO varchar(32) ,
	DATA_INGRESSO_CARGOFUNCAO date ,
	DATA_NOMEACAO_CARGOFUNCAO date ,
	DATA_INGRESSO_ORGAO    date ,
	DOCUMENTO_INGRESSO_SERVICOPUBLICO varchar(64) ,
	DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO date ,
	DIPLOMA_INGRESSO_CARGOFUNCAO varchar(64) ,
	DIPLOMA_INGRESSO_ORGAO varchar(64) ,
	DIPLOMA_INGRESSO_SERVICOPUBLICO    varchar(32),
	UF_EXERCICIO varchar(2) 
);

	"
	
	PGPASSWORD="'' " psql -U aml -c "INSERT INTO public.""final_servidores"" 
SELECT 
	ID_SERVIDOR_PORTAL ,
	NOME ,
	CPF ,
	MATRICULA ,
	DESCRICAO_CARGO    ,
	CLASSE_CARGO ,
	REFERENCIA_CARGO ,
	PADRAO_CARGO ,
	NIVEL_CARGO    ,
	SIGLA_FUNCAO ,
	NIVEL_FUNCAO ,
	FUNCAO    ,
	CODIGO_ATIVIDADE ,
	ATIVIDADE  ,
	OPCAO_PARCIAL ,
	COD_UORG_LOTACAO ,
	UORG_LOTACAO ,
	COD_ORG_LOTACAO ,
	ORG_LOTACAO    ,
	COD_ORGSUP_LOTACAO ,
	ORGSUP_LOTACAO ,
	COD_UORG_EXERCICIO ,
	UORG_EXERCICIO ,
	COD_ORG_EXERCICIO ,
	ORG_EXERCICIO ,
	COD_ORGSUP_EXERCICIO ,
	ORGSUP_EXERCICIO ,
	COD_TIPO_VINCULO ,
	TIPO_VINCULO ,
	SITUACAO_VINCULO , 
	TO_DATE(DATA_INICIO_AFASTAMENTO, 'DD/MM/YYYY') AS ""DATA_INICIO_AFASTAMENTO""  ,
	TO_DATE(DATA_TERMINO_AFASTAMENTO, 'DD/MM/YYYY') AS ""DATA_TERMINO_AFASTAMENTO"" ,
	REGIME_JURIDICO    ,
	JORNADA_DE_TRABALHO ,
	TO_DATE(DATA_INGRESSO_CARGOFUNCAO, 'DD/MM/YYYY') AS ""DATA_INGRESSO_CARGOFUNCAO""  ,
	TO_DATE(DATA_NOMEACAO_CARGOFUNCAO, 'DD/MM/YYYY') AS ""DATA_NOMEACAO_CARGOFUNCAO""  ,
	TO_DATE(DATA_INGRESSO_ORGAO, 'DD/MM/YYYY') AS ""DATA_INGRESSO_ORGAO""  ,
	DOCUMENTO_INGRESSO_SERVICOPUBLICO  ,
	TO_DATE(DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO, 'DD/MM/YYYY') AS ""DATA_DIPLOMA_INGRESSO_SERVICOPUBLICO"" ,
	DIPLOMA_INGRESSO_CARGOFUNCAO  ,
	DIPLOMA_INGRESSO_ORGAO  ,
	DIPLOMA_INGRESSO_SERVICOPUBLICO    ,
	UF_EXERCICIO 
FROM public.""tmp_servidores""";

	done
done




