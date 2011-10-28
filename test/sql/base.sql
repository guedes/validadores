\set ECHO 0
BEGIN;
\i sql/validadores.sql
\set ECHO all

-- You should write your tests

SELECT validadores('foo', 'bar');

SELECT 'foo' #? 'bar' AS arrowop;

CREATE TABLE ab (
    a_field validadores
);

INSERT INTO ab VALUES('foo' #? 'bar');
SELECT (a_field).a, (a_field).b FROM ab;

SELECT (validadores('foo', 'bar')).a;
SELECT (validadores('foo', 'bar')).b;

SELECT ('foo' #? 'bar').a;
SELECT ('foo' #? 'bar').b;

ROLLBACK;
