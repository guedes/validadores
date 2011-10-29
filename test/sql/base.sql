\set ECHO 0
BEGIN;
\i sql/validadores.sql
\set ECHO all

SELECT cpf_valido(59328253241);

SELECT 59328253241 #? AS cpf_valido;
SELECT 37821042773 #? AS cpf_valido;
SELECT 91416742433 #? AS cpf_valido;
SELECT 91416000433 #? AS cpf_valido;
SELECT 37821042003 #? AS cpf_valido;
SELECT NOT 37821042003 #? AS cpf_valido;
SELECT NOT 91416000433 #? AS cpf_valido;

CREATE TABLE pessoa (
    nro_cpf cpf
);

INSERT INTO pessoa VALUES(88229346798);
INSERT INTO pessoa VALUES(45476684425);

SAVEPOINT cpf_invalido;
INSERT INTO pessoa VALUES(45076684425);
ROLLBACK TO cpf_invalido;

SAVEPOINT cpf_invalido;
INSERT INTO pessoa VALUES(81249396798);
ROLLBACK TO cpf_invalido;

ROLLBACK;
