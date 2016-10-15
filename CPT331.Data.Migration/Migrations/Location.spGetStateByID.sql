CREATE PROCEDURE [Location].spGetStateByID

@ID int

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
	ID = @ID

GO
