USE dataEntry3C;
GO

CREATE OR ALTER PROCEDURE access.delete_manual_data
	@processIdOriginal BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE	@return_value INT = 0;

	DELETE	dbo.manuelleEinsparungen
	WHERE	processIdOriginal = @processIdOriginal;

	SET		@return_value = @@ROWCOUNT;
	RETURN	@return_value;
END
GO