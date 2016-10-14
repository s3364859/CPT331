CREATE PROCEDURE [Location].spUpdateLocalGovernmentArea

@ID INT,
@StateID int,
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

UPDATE
	[Location].LocalGovernmentArea
SET
	StateID = @StateID,
	Name = @Name,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO
