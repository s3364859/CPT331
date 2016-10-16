CREATE PROCEDURE Crime.spGetOffenceCategoryByID

@ID int

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
WHERE
	ID = @ID

GO
