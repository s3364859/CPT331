CREATE PROCEDURE Crime.spGetCrime

@Skip INT = 0,
@Take INT = 100

AS

SELECT
	ID,
	LocalGovernmentAreaID,
	OffenceID,
	[Count],
	[Month],
	[Year],
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.Crime

ORDER BY
	ID

OFFSET @Skip ROWS

FETCH NEXT @Take ROWS ONLY

GO
