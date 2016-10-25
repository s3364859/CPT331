CREATE PROCEDURE Crime.spUpdateOffence

@ID INT,
@OffenceCategoryID INT,
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

UPDATE
	Crime.Offence
SET
	Name = @Name,
	OffenceCategoryID = @OffenceCategoryID,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO
