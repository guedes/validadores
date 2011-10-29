/*
 * Author: Dickson S. Guedes <guedes@guedesoft.net>
 * Created at: 2011-10-28 14:41:30 -0200
 *
 */

--
-- This is a example code genereted automaticaly
-- by pgxn-utils.

SET client_min_messages = warning;

CREATE OR REPLACE FUNCTION cpf_valido(numeric)
RETURNS BOOLEAN 
LANGUAGE SQL 
COST 10
IMMUTABLE STRICT
AS 
$_$
	with
	cpf as (
	   select $1 as numero
	),
	cpf_formatado as (
	   select lpad(cpf.numero::text,11,'0') as numero from cpf
	),
	matriz as (
	   select unnest( string_to_array( cpf_formatado.numero, null ) ) as valor from cpf_formatado
	),
	digitos_por_posicao_1 as (
	   select row_number() over () as posicao, valor::int from matriz
	),
	digitos_por_posicao_2 as (
	   select posicao - 1 as posicao, valor from digitos_por_posicao_1
	),
	digito_1 as (
	   select sum(posicao*valor) as soma, sum(posicao*valor) % 11 as resto from digitos_por_posicao_1 where posicao<=9
	),
	digito_2 as (
	   select sum(posicao*valor) as soma, sum(posicao*valor) % 11 as resto from digitos_por_posicao_2 where posicao<=9
	),
	cpf_esperado as (
	select array_to_string(array_agg(valor),'')::numeric as numero 
	from
	  (
	   select valor from digitos_por_posicao_1 where posicao <=9
	   union all
	   select resto from digito_1
	   union all
	   select resto from digito_2
	  ) as foo
	)
	select distinct cpf.numero = cpf_esperado.numero from cpf, cpf_esperado;
$_$;

CREATE OPERATOR #? (
	LEFTARG   = numeric,
	PROCEDURE = cpf_valido
);

CREATE DOMAIN cpf AS numeric CHECK ( cpf_valido(VALUE) );
