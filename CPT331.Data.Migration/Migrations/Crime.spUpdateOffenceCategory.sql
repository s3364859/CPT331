CREATE PROCEDURE Crime.spUpdateOffenceCategory

@ID INT,
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

UPDATE
	Crime.OffenceCategory
SET
	Name = @Name,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO
