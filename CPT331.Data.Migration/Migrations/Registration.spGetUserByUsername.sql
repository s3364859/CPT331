CREATE PROC Registration.spGetUserByUsername

@Username VARCHAR(150)

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
	Username = @Username
