CREATE PROCEDURE Crime.spGetCrimeOffenceLocalGovernmentAreaState

@Skip INT = 0,
@Take INT = 100,
@OrderBy VARCHAR(10) = 'ID',
@SortDirection VARCHAR(4) = 'ASC'

AS

IF (@OrderBy IS NULL) OR (@OrderBy = '')
BEGIN
	SET @OrderBy = 'ID'
END

IF (@SortDirection IS NULL) OR (@SortDirection = '')
BEGIN
	SET @SortDirection = 'ASC'
END

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

ORDER BY
	ID
	/*
	CASE WHEN @OrderBy = 'Count' AND @SortDirection = 'ASC' THEN [Count] END ASC,
	CASE WHEN @OrderBy = 'Count' AND @SortDirection = 'DESC' THEN [Count] END DESC,
	CASE WHEN @OrderBy = 'DateUpdatedUtc' AND @SortDirection = 'ASC' THEN DateUpdatedUtc END ASC,
	CASE WHEN @OrderBy = 'DateUpdatedUtc' AND @SortDirection = 'DESC' THEN DateUpdatedUtc END DESC,
	CASE WHEN @OrderBy = 'ID' AND @SortDirection = 'ASC' THEN ID END ASC,
	CASE WHEN @OrderBy = 'ID' AND @SortDirection = 'DESC' THEN ID END DESC--,
	CASE WHEN @OrderBy = 'Month' AND @SortDirection = 'ASC' THEN [Month] END ASC,
	CASE WHEN @OrderBy = 'Month' AND @SortDirection = 'DESC' THEN [Month] END DESC,
	CASE WHEN @OrderBy = 'OffenceName' AND @SortDirection = 'ASC' THEN OffenceName END ASC,
	CASE WHEN @OrderBy = 'OffenceName' AND @SortDirection = 'DESC' THEN OffenceName END DESC,
	CASE WHEN @OrderBy = 'StateName' AND @SortDirection = 'ASC' THEN StateName END ASC,
	CASE WHEN @OrderBy = 'StateName' AND @SortDirection = 'DESC' THEN StateName END DESC,
	CASE WHEN @OrderBy = 'Year' AND @SortDirection = 'ASC' THEN [Year] END ASC,
	CASE WHEN @OrderBy = 'Year' AND @SortDirection = 'DESC' THEN [Year] END DESC
	*/

OFFSET @Skip ROWS

FETCH NEXT @Take ROWS ONLY

GO
