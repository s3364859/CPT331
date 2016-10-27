CREATE PROCEDURE Crime.spGetOffenceByID

@ID int

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
WHERE
	ID = @ID

GO
