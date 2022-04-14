#!/bin/bash

##########################################################################
# SCRIPT PARA BAIXAR OS ARQUIVOS REFERENTES AOS SERVIDORES NO P.T.
##########################################################################

inst=(SIAPE)

PGPASSWORD="'' " psql -U aml -c "drop table if exists final_servidores_siape_remuneracao;"

for i in "S{inst[@]}"
do
	for j in {01..11}
	do
		#wget --read-timeout=5 -P /home/jose/Desktop/scripts/files_servidores/servidores_"${i}" "https://www.portaltransparencia.gov.br/download-de-dados/servidores/2021${j}_Servidores_"${i}""		
		#unzip "/home/jose/Desktop/scripts/files_servidores/servidores_"${i}"/2021${j}_Servidores_"${i}"" -d /home/jose/Desktop/scripts/files_servidores/servidores_"${i}"
		#rm /home/jose/Desktop/scripts/files_servidores/servidores_"${i}"/2021S{j}_Servidores_"${i}"

		
			PGPASSWORD="'' " psql -U aml -c "drop table if exists tmp_servidores_siape_remuneracao;"
			PGPASSWORD="'' " psql -U aml -c "create table public.tmp_servidores_siape_remuneracao(
	""ANO"" varchar(1024) null,
	""MES"" varchar(1024) null,
	""ID_SERVIDOR_PORTAL"" varchar(1024) null,
	""CPF"" varchar(1024) null,
	""NOME"" varchar(1024) null,
	""REMUNERACAO_BASICA_BRUTA_RS"" varchar(1024) null,
	""REMUNERACAO_BASICA_BRUTA_US"" varchar(1024) null,
	""ABATE_TETO_RS"" varchar(1024) null,
	""ABATE_TETO_US"" varchar(1024) null,
	""GRATIFICACAO_NATALINA_RS"" varchar(1024) null,
	""GRATIFICACAO_NATALINA_US"" varchar(1024) null,
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_RS"" varchar(1024) null,
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_US"" varchar(1024) null,
	""FERIAS_RS"" varchar(1024) null,
	""FERIAS_US"" varchar(1024) null,
	""OUTRAS_REMUNERACOES_EVENTUAIS_RS"" varchar(1024) null,
	""OUTRAS_REMUNERACOES_EVENTUAIS_US"" varchar(1024) null,
	""IRRF_RS"" varchar(1024) null,
	""IRRF_US"" varchar(1024) null,
	""PSS_RPGS_RS"" varchar(1024) null,
	""PSS_RPGS_US"" varchar(1024) null,
	""DEMAIS_DEDUCOES_RS"" varchar(1024) null,
	""DEMAIS_DEDUCOES_US"" varchar(1024) null,
	""PENSAO_MILITAR_RS"" varchar(1024) null,
	""PENSAO_MILITAR_US"" varchar(1024) null,
	""FUNDO_DE_SAUDE_RS"" varchar(1024) null,
	""FUNDO_DE_SAUDE_US"" varchar(1024) null,
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_RS"" varchar(1024) null,
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_US"" varchar(1024) null,
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_RS"" varchar(1024) null,
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_US"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_RS"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_US"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_RS"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_US"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_RS"" varchar(1024) null,
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_US"" varchar(1024) null,
	""TOTAL_DE_VERBAS_INDENIZATORIAS_RS"" varchar(1024) null,
	""TOTAL_DE_VERBAS_INDENIZATORIAS_US"" varchar(1024) null
);"
			PGPASSWORD="'' " psql -U aml -c "\copy public.tmp_servidores_siape_remuneracao
from '/home/jose/Desktop/scripts/files_servidores/servidores_SIAPE/2021${j}_Remuneracao.csv'
with 
	delimiter ';'
	csv
	header
	encoding 'latin1';"

			PGPASSWORD="'' " psql -U aml -c "delete from tmp_servidores_siape_remuneracao
			where ""ANO"" like '%(*)%';"

			PGPASSWORD="'' " psql -U aml -c "create table public.final_servidores_siape_remuneracao(
	""ANO"" integer null,
	""MES"" integer null,
	""ID_SERVIDOR_PORTAL"" varchar(1024) null,
	""CPF"" varchar(1024) null,
	""NOME"" varchar(1024) null,
	""REMUNERACAO_BASICA_BRUTA_RS"" numeric(20,2) null,
	""REMUNERACAO_BASICA_BRUTA_US"" numeric(20,2) null,
	""ABATE_TETO_RS"" numeric(20,2) null,
	""ABATE_TETO_US"" numeric(20,2) null,
	""GRATIFICACAO_NATALINA_RS"" numeric(20,2) null,
	""GRATIFICACAO_NATALINA_US"" numeric(20,2) null,
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_RS"" numeric(20,2) null,
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_US"" numeric(20,2) null,
	""FERIAS_RS"" numeric(20,2) null,
	""FERIAS_US"" numeric(20,2) null,
	""OUTRAS_REMUNERACOES_EVENTUAIS_RS"" numeric(20,2) null,
	""OUTRAS_REMUNERACOES_EVENTUAIS_US"" numeric(20,2) null,
	""IRRF_RS"" numeric(20,2) null,
	""IRRF_US"" numeric(20,2) null,
	""PSS_RPGS_RS"" numeric(20,2) null,
	""PSS_RPGS_US"" numeric(20,2) null,
	""DEMAIS_DEDUCOES_RS"" numeric(20,2) null,
	""DEMAIS_DEDUCOES_US"" numeric(20,2) null,
	""PENSAO_MILITAR_RS"" numeric(20,2) null,
	""PENSAO_MILITAR_US"" numeric(20,2) null,
	""FUNDO_DE_SAUDE_RS"" numeric(20,2) null,
	""FUNDO_DE_SAUDE_US"" numeric(20,2) null,
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_RS"" numeric(20,2) null,
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_US"" numeric(20,2) null,
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_RS"" numeric(20,2) null,
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_US"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_RS"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_US"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_RS"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_US"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_RS"" numeric(20,2) null,
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_US"" numeric(20,2) null,
	""TOTAL_DE_VERBAS_INDENIZATORIAS_RS"" numeric(20,2) null,
	""TOTAL_DE_VERBAS_INDENIZATORIAS_US"" numeric(20,2) null
);"
	
	PGPASSWORD="'' " psql -U aml -c "insert into public.final_servidores_siape_remuneracao(
	""ANO"",
	""MES"",
	""ID_SERVIDOR_PORTAL"",
	""CPF"",
	""NOME"",
	""REMUNERACAO_BASICA_BRUTA_RS"",
	""REMUNERACAO_BASICA_BRUTA_US"",
	""ABATE_TETO_RS"",
	""ABATE_TETO_US"",
	""GRATIFICACAO_NATALINA_RS"",
	""GRATIFICACAO_NATALINA_US"",
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_RS"",
	""ABATE_TETO_DA_GRATIFICACAO_NATALINA_US"",
	""FERIAS_RS"",
	""FERIAS_US"",
	""OUTRAS_REMUNERACOES_EVENTUAIS_RS"",
	""OUTRAS_REMUNERACOES_EVENTUAIS_US"",
	""IRRF_RS"",
	""IRRF_US"",
	""PSS_RPGS_RS"",
	""PSS_RPGS_US"",
	""DEMAIS_DEDUCOES_RS"",
	""DEMAIS_DEDUCOES_US"",
	""PENSAO_MILITAR_RS"",
	""PENSAO_MILITAR_US"",
	""FUNDO_DE_SAUDE_RS"",
	""FUNDO_DE_SAUDE_US"",
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_RS"",
	""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_US"",
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_RS"",
	""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_US"",
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_RS"",
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_US"",
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_RS"",
	""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_US"",
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_RS"",
	""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_US"",
	""TOTAL_DE_VERBAS_INDENIZATORIAS_RS"",
	""TOTAL_DE_VERBAS_INDENIZATORIAS_US""
)
select
	cast(""ANO"" as integer),
	cast(""MES"" as integer),
	""ID_SERVIDOR_PORTAL"",
	""CPF"",
	""NOME"",
	cast(replace(""REMUNERACAO_BASICA_BRUTA_RS"", ',', '.') as numeric),
	cast(replace(""REMUNERACAO_BASICA_BRUTA_US"", ',', '.') as numeric),
	cast(replace(""ABATE_TETO_RS"", ',', '.') as numeric),
	cast(replace(""ABATE_TETO_US"", ',', '.') as numeric),
	cast(replace(""GRATIFICACAO_NATALINA_RS"", ',', '.') as numeric),
	cast(replace(""GRATIFICACAO_NATALINA_US"", ',', '.') as numeric),
	cast(replace(""ABATE_TETO_DA_GRATIFICACAO_NATALINA_RS"", ',', '.') as numeric),
	cast(replace(""ABATE_TETO_DA_GRATIFICACAO_NATALINA_US"", ',', '.') as numeric),
	cast(replace(""FERIAS_RS"", ',', '.') as numeric),
	cast(replace(""FERIAS_US"", ',', '.') as numeric),
	cast(replace(""OUTRAS_REMUNERACOES_EVENTUAIS_RS"", ',', '.') as numeric),
	cast(replace(""OUTRAS_REMUNERACOES_EVENTUAIS_US"", ',', '.') as numeric),
	cast(replace(""IRRF_RS"", ',', '.') as numeric),
	cast(replace(""IRRF_US"", ',', '.') as numeric),
	cast(replace(""PSS_RPGS_RS"", ',', '.') as numeric),
	cast(replace(""PSS_RPGS_US"", ',', '.') as numeric),
	cast(replace(""DEMAIS_DEDUCOES_RS"", ',', '.') as numeric),
	cast(replace(""DEMAIS_DEDUCOES_US"", ',', '.') as numeric),
	cast(replace(""PENSAO_MILITAR_RS"", ',', '.') as numeric),
	cast(replace(""PENSAO_MILITAR_US"", ',', '.') as numeric),
	cast(replace(""FUNDO_DE_SAUDE_RS"", ',', '.') as numeric),
	cast(replace(""FUNDO_DE_SAUDE_US"", ',', '.') as numeric),
	cast(replace(""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_RS"", ',', '.') as numeric),
	cast(replace(""TAXA_DE_OCUPACAO_IMOVEL_FUNCIONAL_US"", ',', '.') as numeric),
	cast(replace(""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_RS"", ',', '.') as numeric),
	cast(replace(""REMUNERACAO_APOS_DEDUCOES_OBRIGATORIAS_US"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_RS"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_CIVIL_US"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_RS"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_REGISTRADAS_EM_S_DE_PESSOAS_MILITAR_US"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_RS"", ',', '.') as numeric),
	cast(replace(""VERBAS_INDENIZATORIAS_P_DESLIGAMENTO_VOLUNTARIO_MP_792_2017_US"", ',', '.') as numeric),
	cast(replace(""TOTAL_DE_VERBAS_INDENIZATORIAS_RS"", ',', '.') as numeric),
	cast(replace(""TOTAL_DE_VERBAS_INDENIZATORIAS_US"", ',', '.') as numeric)
from public.tmp_servidores_siape_remuneracao;"

	done
done




