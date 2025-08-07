USE dataEntry3C;
GO

CREATE OR ALTER PROCEDURE access.get_manual_data
	@processIdOriginal BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT	processIdOriginal,
			prueferId				AS	cbo_examiner,
			umgesetzteEinsparung	AS	txt_saving,
			kommentar				AS	txt_comment
	FROM	dbo.manuelleEinsparungen
	WHERE	processIdOriginal = @processIdOriginal;
END
GO

EXEC access.get_manual_data @processIdOriginal = 10100;

SELECT * FROM dbo.vorgaenge WHERE processIdOriginal = 10100