CREATE PROCEDURE Crime.spAddOffence

@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

INSERT INTO Crime.Offence (Name, IsDeleted, IsVisible) VALUES (@Name, @IsDeleted, @IsVisible)

SELECT SCOPE_IDENTITY() AS NewID

GO
