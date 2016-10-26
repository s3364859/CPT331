CREATE PROCEDURE Crime.spAddOffence

@Name varchar(100),
@OffenceCategoryID int,
@IsDeleted bit,
@IsVisible bit

AS

INSERT INTO Crime.Offence (Name, OffenceCategoryID, IsDeleted, IsVisible) VALUES (@Name, @OffenceCategoryID, @IsDeleted, @IsVisible)

SELECT SCOPE_IDENTITY() AS NewID

GO
