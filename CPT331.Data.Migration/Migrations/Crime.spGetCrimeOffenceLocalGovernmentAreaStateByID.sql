CREATE PROCEDURE Crime.spGetCrimeOffenceLocalGovernmentAreaStateByID

@ID int

AS

SELECT
	ID,
	StateID,
	StateName,
	LocalGovernmentAreaID,
	LocalGovernmentAreaName,
	OffenceID,
	OffenceName,
	[Count],
	[Month],
	[Year],
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.CrimeOffenceLocalGovernmentAreaState

WHERE
	ID = @ID

GO
