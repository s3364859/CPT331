CREATE PROCEDURE [Location].spGetLocalGovernmentAreaByID

@ID int

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
	ID = @ID

GO
