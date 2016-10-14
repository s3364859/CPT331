CREATE PROCEDURE [Location].spUpdateState

@ID INT,
@AbbreviatedName varchar(100),
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

UPDATE
	[Location].[State]
SET
	AbbreviatedName = @AbbreviatedName,
	Name = @Name,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO