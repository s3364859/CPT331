CREATE PROCEDURE Crime.spGetOffence

AS

SELECT
	ID,
	OffenceCategoryID,
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
