CREATE PROC Registration.spGetUserByID

@ID INT

AS

SELECT
	ID,
	Username,
	Password,
	IsDeleted,
	IsActive,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Registration.[User]
WHERE
	ID = @ID