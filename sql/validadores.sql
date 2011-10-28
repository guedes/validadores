/*
 * Author: Dickson S. Guedes <guedes@guedesoft.net>
 * Created at: 2011-10-28 14:41:30 -0200
 *
 */

--
-- This is a example code genereted automaticaly
-- by pgxn-utils.

SET client_min_messages = warning;

-- If your extension will create a type you can
-- do somenthing like this
CREATE TYPE validadores AS ( a text, b text );

-- Maybe you want to create some function, so you can use
-- this as an example
CREATE OR REPLACE FUNCTION validadores (text, text)
RETURNS validadores LANGUAGE SQL AS 'SELECT ROW($1, $2)::validadores';

-- Sometimes it is common to use special operators to
-- work with your new created type, you can create
-- one like the command bellow if it is applicable
-- to your case

CREATE OPERATOR #? (
	LEFTARG   = text,
	RIGHTARG  = text,
	PROCEDURE = validadores
);
