CREATE PROCEDURE Crime.spGetCrime

AS

SELECT
	ID,
	LocalGovernmentAreaID,
	OffenceID,
	[Count],
	[Month],
	[Year]
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.Crime

GO
