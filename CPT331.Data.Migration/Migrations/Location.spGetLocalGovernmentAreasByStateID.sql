CREATE PROCEDURE [Location].spGetLocalGovernmentAreasByStateID

@StateID int

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
WHERE
	StateID = @StateID
ORDER BY
	Name

GO
