CREATE PROCEDURE Crime.spGetCrimeByID

@ID int

AS

SELECT
	[Count],
	DateCreatedUtc,
	DateUpdatedUtc,
	ID,
	IsDeleted,
	IsVisible,
	LocalGovernmentAreaID,
	[Month],
	OffenceID,
	[Year]
FROM
	Crime.Crime
WHERE
	ID = @ID

GO
