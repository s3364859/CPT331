CREATE PROCEDURE [Location].spAddLocalGovernmentArea

@StateID int,
@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

INSERT INTO [Location].LocalGovernmentArea (StateID, Name, IsDeleted, IsVisible) VALUES (@StateID, @Name, @IsDeleted, @IsVisible)

SELECT SCOPE_IDENTITY() AS NewID

GO
