CREATE VIEW Crime.CrimeOffenceLocalGovernmentAreaState

AS

SELECT
	Crime.Crime.ID,
	[Location].[State].ID AS StateID,
	[Location].[State].Name AS StateName,
	Crime.Crime.LocalGovernmentAreaID,
	[Location].LocalGovernmentArea.Name AS LocalGovernmentAreaName,
	Crime.Crime.OffenceID,
	Crime.Offence.Name AS OffenceName,
	Crime.Crime.[Count],
	Crime.Crime.[Month],
	Crime.Crime.[Year],
	Crime.Crime.IsDeleted,
	Crime.Crime.IsVisible,
	Crime.Crime.DateCreatedUtc,
	Crime.Crime.DateUpdatedUtc
FROM
	Crime.Crime

INNER JOIN Crime.Offence ON
(Crime.Crime.OffenceID = Crime.Offence.ID)

INNER JOIN [Location].LocalGovernmentArea ON
(Crime.Crime.LocalGovernmentAreaID = [Location].LocalGovernmentArea.ID)

INNER JOIN [Location].[State] ON
([Location].LocalGovernmentArea.StateID = [Location].[State].ID)