CREATE PROCEDURE [Location].spGetLocalGovernmentAreaState

AS

SELECT
	ID,
	StateID,
	StateName,
	AbbreviatedName,
	Name,
	Area,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].LocalGovernmentAreaState
ORDER BY
	StateName,
	Name

GO