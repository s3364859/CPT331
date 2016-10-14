CREATE PROCEDURE [Location].spAddState

@Name varchar(100),
@AbbreviatedName varchar(3),
@IsDeleted bit,
@IsVisible bit

AS

INSERT INTO [Location].[State] (Name, AbbreviatedName, IsDeleted, IsVisible) VALUES (@Name, @AbbreviatedName, @IsDeleted, @IsVisible)

SELECT SCOPE_IDENTITY() AS NewID

GO