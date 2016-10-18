CREATE PROCEDURE Crime.spGetCrimesByCoordinate

@Latitude DECIMAL(12, 8),
@Longitude DECIMAL(12, 8)

AS

DECLARE @@Location GEOGRAPHY = (geography::Point(@Latitude, @Longitude, 4326))

SELECT
	Crime.Crime.OffenceID,
	LGA.Name,
	Crime.Offence.Name AS Offence,
	SUM(Crime.[Count]) AS OffenceCount,
	MIN(Crime.Crime.Year) AS BeginYear,
	MAX(Crime.Crime.Year) AS EndYear
FROM
	Crime.Crime

INNER JOIN Crime.Offence ON
(Crime.Offence.ID = Crime.Crime.OffenceID)

INNER JOIN [Location].LocalGovernmentArea AS LGA ON
(LGA.ID = Crime.Crime.LocalGovernmentAreaID)

WHERE
	LGA.Area.STIntersects(@@Location) = 1 

GROUP BY
	Crime.Crime.OffenceID,
	Crime.Offence.Name,
	LGA.Name

ORDER BY
	Crime.Offence.Name

GO
