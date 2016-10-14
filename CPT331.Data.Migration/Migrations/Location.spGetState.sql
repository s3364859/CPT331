CREATE PROCEDURE [Location].spGetState

AS

SELECT
	ID,
	Name,
	AbbreviatedName,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].[State]
ORDER BY
	Name

GO
