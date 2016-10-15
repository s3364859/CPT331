CREATE PROCEDURE [Location].spGetLocalGovernmentArea

AS

SELECT
	ID,
	StateID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].LocalGovernmentArea
ORDER BY
	Name

GO