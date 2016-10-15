CREATE PROCEDURE Crime.spUpdateCrime

@ID INT,
@LocalGovernmentAreaID INT,
@OffenceID INT,
@Count INT,
@Month INT,
@Year INT,
@IsDeleted BIT,
@IsVisible BIT

AS

UPDATE
	Crime.Crime
SET
	LocalGovernmentAreaID = @LocalGovernmentAreaID,
	OffenceID = @OffenceID,
	[Count] = @Count,
	[Month] = @Month,
	[Year] = @Year,
	IsDeleted = @IsDeleted,
	IsVisible = @IsVisible,
	DateUpdatedUtc = GETUTCDATE()
WHERE
	ID = @ID

GO
