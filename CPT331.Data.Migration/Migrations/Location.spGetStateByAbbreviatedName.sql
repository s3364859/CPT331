CREATE PROCEDURE [Location].spGetStateByAbbreviatedName

@AbbreviatedName varchar(100)

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
WHERE
	AbbreviatedName = @AbbreviatedName

GO
