USE dataEntry3C;
GO

/* Schema für Speicherung von Prozeduren */
IF SCHEMA_ID(N'access') IS NULL
BEGIN
	RAISERROR ('Erstellung von Schema [access]...', 0, 1) WITH NOWAIT;
	EXEC sp_executesql N'CREATE SCHEMA [access] AUTHORIZATION dbo;';
END
GO

/* Benutzerrolle für Zugriff auf Prozeduren */
IF NOT EXISTS
(
	SELECT	*
	FROM	sys.database_principals
	WHERE	type = N'R'
			AND name = N'access' 
)
BEGIN
	RAISERROR ('Erstellung von Benutzerrolle [access]...', 0, 1) WITH NOWAIT;
	EXEC sp_executesql N'CREATE ROLE [access];';
END
GO

/* Erteilung von Berechigungen für Benutzergruppe auf Schema */
GRANT EXECUTE ON SCHEMA::[access] TO [access];
GO

PRINT '
Die Securityelemente wurden eingerichtet.
Damit Benutzer die Applikation "Data Input" verwenden können,
müssen die Datenbankbenutzer der Datenbankrolle [access] hinzu
gefügt werden!'
GO