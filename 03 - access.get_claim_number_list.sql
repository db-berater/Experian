/*
	Author:		Uwe Ricken
				db Berater GmbH

	Erstellt:	2025-08-04
	Version:	1.00.000
*/
USE dataEntry3C;
GO

CREATE OR ALTER PROCEDURE access.get_claim_number_list
	@search_phrase VARCHAR(64)
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	SELECT	v.processIdOriginal,
			v.versicherung						AS	Versicherung,
			v.prozess								AS	Prozess,
			v.schadennummer						AS	Schadennummer,
			v.kennzeichen							AS	Kennzeichen,
			FORMAT
			(
				v.eingangszeitpunktKorrektur,
				N'dd.MM.yyyy',
				N'de-de'
			)									AS	[Eingang],
			FORMAT
			(
				v.abschlusszeitpunktKorrektur,
				N'dd.MM.yyyy',
				N'de-de'
			)									AS	[Abschluﬂ],
			FORMAT
			(
				v.reparaturkostenNettoOriginal,
				N'#,##0.00 Ä',
				N'de-de'
			)									AS	[Kosten],
			CASE WHEN me.processIdOriginal IS NOT NULL
					THEN 'X'
					ELSE '-'
			END									AS	[_]
	FROM	dbo.vorgaenge AS v
			LEFT JOIN dbo.manuelleEinsparungen AS me
			ON
			(
				v.processIdOriginal = me.processIdOriginal
				AND v.processIdKorrektur = me.processIdKorrektur
			)
	WHERE	v.schadennummer LIKE @search_phrase
	ORDER BY
			v.schadennummer,
			v.eingangszeitpunktKorrektur DESC;
END
GO

EXEC access.get_claim_number_list '%773%'