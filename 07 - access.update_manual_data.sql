USE dataEntry3C;
GO

CREATE OR ALTER PROCEDURE access.update_manual_data
	@processIdOriginal		BIGINT,
	@prueferId				BIGINT,
	@umgesetzteEinsparung	NUMERIC(12, 2),
	@kommentar				VARCHAR(512)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE	@return_value INT = 0;

	IF EXISTS (SELECT * FROM dbo.manuelleEinsparungen WHERE processIdOriginal = @processIdOriginal)
		UPDATE	dbo.manuelleEinsparungen
		SET		prueferId = @prueferId,
				umgesetzteEinsparung = @umgesetzteEinsparung,
				kommentar = @kommentar,
				erfasser = SUSER_SNAME(),
				aktualisierungszeitpunkt = GETDATE()
		WHERE	processIdOriginal = @processIdOriginal;
	ELSE
		INSERT INTO dbo.manuelleEinsparungen
		(processIdOriginal, processIdKorrektur, prueferId, umgesetzteEinsparung, kommentar, erfasser, erfassungszeitpunkt, aktualisierungszeitpunkt)
		SELECT	processIdOriginal,
				processIdKorrektur,
				@prueferId,
				@umgesetzteEinsparung,
				@kommentar,
				SUSER_NAME(),
				GETDATE(),
				NULL
		FROM	dbo.vorgaenge AS v
		WHERE	v.processIdOriginal = @processIdOriginal

	SET		@return_value = @@ROWCOUNT;
	RETURN	@return_value;
END
GO

/* Enter a new record */
DECLARE	@return_value INT;
EXEC @return_value = access.update_manual_data
	@processIdOriginal = 10000,
	@prueferId = 1,
	@umgesetzteEinsparung = 1234,
	@kommentar = 'Das ist nur ein Test';

SELECT	@return_value;
SELECT * FROM dbo.manuelleEinsparungen WHERE processIdOriginal = 10000;
GO

/* Update of existing record */
DECLARE	@return_value INT;
EXEC @return_value = access.update_manual_data
	@processIdOriginal = 10000,
	@prueferId = 1,
	@umgesetzteEinsparung = 1234,
	@kommentar = 'Das ist erneut nur ein Test';

SELECT	@return_value;
SELECT * FROM dbo.manuelleEinsparungen WHERE processIdOriginal = 10000;
GO
