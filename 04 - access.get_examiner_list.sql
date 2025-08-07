/*
	Author:		Uwe Ricken
				db Berater GmbH

	Erstellt:	2025-08-04
	Version:	1.00.000
*/
USE dataEntry3C;
GO

CREATE OR ALTER PROCEDURE access.get_examiner_list
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT	id,
			name
	FROM	dbo.pruefer
	ORDER BY
			sortierung ASC;
END
GO

EXEC access.get_examiner_list;