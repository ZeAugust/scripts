#!/bin/bash

##########################################
#    SCRIPT PARA BAIXAR ARQUIVOS DO P.T.
##########################################

	if  [ ! -d "/home/jose/Desktop/scripts/files_cpgf" ]
		then
			mkdir -p /home/jose/Desktop/scripts/files_cpgf
	fi

	for i in {2017..2021};
	do
		for j in {01..12};
		do
				wget --read-timeout=5 -P /home/jose/Desktop/scripts/files_cpgf "https://www.portaltransparencia.gov.br/download-de-dados/cpgf/${i}${j}"
				unzip "/home/jose/Desktop/scripts/files_cpgf/${i}${j}" -d /home/jose/Desktop/scripts/files_cpgf
		done
	done
	
		PGPASSWORD="'' " psql -U aml -c "drop table if exists public.final_cpgf;"

	for i in /home/jose/Desktop/scripts/files_cpgf/*.csv;
	do
		PGPASSWORD="'' " psql -U aml -c "drop table if exists public.tmp_cpgf;"
		PGPASSWORD="'' " psql -U aml -c "create table public.tmp_cpgf(	
		codigo_orgao_superior integer NULL,
		nome_orgao_superior varchar(1024) NULL,
		codigo_orgao integer NULL,
		nome_orgao varchar(1024) NULL,
		codigo_unidade_gestora integer NULL,
		nome_unidade_gestora varchar(1024) NULL,
		ano integer NULL,
		mes integer NULL,
		cpf_portador varchar(1024) NULL,
		nome_portador varchar(1024) NULL,
		documento_favorecido varchar(1024) NULL,
		nome_favorecido varchar(1024) NULL,
		transacao varchar(1024) NULL,
		""data"" varchar(1024) NULL,
		valor varchar(1024) NULL
		);"	
	
		PGPASSWORD="'' " psql -U aml -c "\COPY tmp_cpgf FROM '${i}' CSV DELIMITER ';' HEADER ENCODING 'latin1';"	

		PGPASSWORD="'' " psql -U aml -c "create table public.final_cpgf(	
		codigo_orgao_superior integer NULL,
		nome_orgao_superior varchar(1024) NULL,
		codigo_orgao integer NULL,
		nome_orgao varchar(1024) NULL,
		codigo_unidade_gestora integer NULL,
		nome_unidade_gestora varchar(1024) NULL,
		ano integer NULL,
		mes integer NULL,
		cpf_portador varchar(1024) NULL,
		nome_portador varchar(1024) NULL,
		documento_favorecido varchar(1024) NULL,
		nome_favorecido varchar(1024) NULL,
		transacao varchar(1024) NULL,
		""data"" date NULL,
		valor decimal(20,2) NULL
		);"
		
		PGPASSWORD=" " psql -U aml -c "insert into final_cpgf(
	codigo_orgao_superior,
	nome_orgao_superior,
	codigo_orgao,
	nome_orgao,
	codigo_unidade_gestora,
	nome_unidade_gestora,
	ano,
	mes,
	cpf_portador,
	nome_portador,
	documento_favorecido,
	nome_favorecido,
	transacao,
	""data"",
	valor)
select
	codigo_orgao_superior,
	nome_orgao_superior,
	codigo_orgao,
	nome_orgao,
	codigo_unidade_gestora,
	nome_unidade_gestora,
	ano,
	mes,
	cpf_portador,
	nome_portador,
	documento_favorecido,
	nome_favorecido,
	transacao,
	to_date(""data"", 'DD/MM/YYYY') as ""data"",
	cast(replace(valor, ',', '.') as decimal(20,2))
	from tmp_cpgf;"


		
	done	
