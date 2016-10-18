CREATE PROCEDURE Crime.spGetOffenceCategory

AS

SELECT
	ID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.OffenceCategory
ORDER BY
	Name

GO
