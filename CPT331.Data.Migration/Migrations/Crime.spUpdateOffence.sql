CREATE PROCEDURE Crime.spUpdateOffence

@ID INT,
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

UPDATE
	Crime.Offence
SET
	Name = @Name,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO
