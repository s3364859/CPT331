CREATE PROCEDURE Crime.spGetCrimesByCoordinate

@Latitude DECIMAL(12, 8),
@Longitude DECIMAL(12, 8)

AS

DECLARE @@KilometresPerDegree DECIMAL(12, 8) = CONVERT(DECIMAL(12, 8), 111.325)

SELECT
	Crime.Crime.OffenceID,
	[Location].LocalGovernmentArea.Name,
	Crime.Offence.Name AS Offence,
	SUM(Crime.[Count]) AS OffenceCount,
	MIN(Crime.Crime.Year) AS BeginYear,
	MAX(Crime.Crime.Year) AS EndYear
FROM
	Crime.Crime

INNER JOIN Crime.Offence ON
(Crime.Offence.ID = Crime.Crime.OffenceID)

INNER JOIN [Location].LocalGovernmentArea ON
([Location].LocalGovernmentArea.ID = Crime.Crime.LocalGovernmentAreaID)

WHERE
	Crime.Crime.LocalGovernmentAreaID IN 
	(
		SELECT Distances.LocalGovernmentAreaID FROM
		(
			SELECT TOP 1
				LocalGovernmentAreaID,
			--	Latitude,
			--	Longitude,
				(SQRT(POWER((Latitude - @Latitude), 2) + POWER((Longitude - @Longitude), 2)) * @@KilometresPerDegree) AS Distance
			FROM
				Location.LocalGovernmentAreaBoundary
			ORDER BY
				Distance
		)
		AS Distances
	)

GROUP BY
	Crime.Crime.OffenceID,
	Crime.Offence.Name,
	[Location].LocalGovernmentArea.Name

ORDER BY
	Crime.Offence.Name

GO
