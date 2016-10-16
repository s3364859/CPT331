CREATE PROCEDURE Crime.spAddOffenceCategory

@Name varchar(100),
@IsDeleted bit,
@IsVisible bit

AS

INSERT INTO Crime.OffenceCategory (Name, IsDeleted, IsVisible) VALUES (@Name, @IsDeleted, @IsVisible)

SELECT SCOPE_IDENTITY() AS NewID

GO
