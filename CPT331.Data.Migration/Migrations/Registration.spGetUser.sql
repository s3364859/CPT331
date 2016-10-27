CREATE PROC Registration.spGetUser

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
