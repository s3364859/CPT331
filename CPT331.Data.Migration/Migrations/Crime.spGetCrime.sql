CREATE PROCEDURE Crime.spGetCrime

AS

SELECT
	ID,
	LocalGovernment
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.Offence
ORDER BY
	Name

GO
