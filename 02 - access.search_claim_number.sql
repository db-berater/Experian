/*
	Author:		Uwe Ricken
				db Berater GmbH

	Erstellt:	2025-08-04
	Version:	1.00.000
*/
USE [dataEntry3C];
GO

CREATE OR ALTER PROCEDURE [access].search_claim_number
	@search_phrase	VARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE	@return_value INT = 0;

	SELECT	*
	FROM	dbo.vorgaenge
	WHERE	schadennummer LIKE @search_phrase;

	SET		@return_value = @@ROWCOUNT;

	RETURN	@return_value;
END
GO


/* Test */
DECLARE	@return_value INT;
EXEC	@return_value = [access].search_claim_number 'A664773-66';
SELECT	@return_value;
GO

DECLARE	@return_value INT;
EXEC	@return_value = [access].search_claim_number 'A664773%';
SELECT	@return_value;
GO

DECLARE	@return_value INT;
EXEC	@return_value = [access].search_claim_number '%773%';
SELECT	@return_value;
GO
