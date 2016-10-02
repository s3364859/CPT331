CREATE PROCEDURE Crime.spAddCrime

@LocalGovernmentAreaID int,
@OffenceID int,
@Count int,
@Month int,
@Year int

AS

INSERT INTO Crime.Crime (LocalGovernmentAreaID, OffenceID, [Count], [Month], [Year]) VALUES (@LocalGovernmentAreaID, @OffenceID, @Count, @Month, @Year)

SELECT SCOPE_IDENTITY() AS NewID

GO

CREATE PROCEDURE [Location].spGetLocalGovernmentArea

AS

SELECT
	ID,
	StateID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].LocalGovernmentArea
ORDER BY
	Name

GO

CREATE PROCEDURE [Location].spGetLocalGovernmentAreaByID

@ID int

AS

SELECT
	ID,
	StateID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].LocalGovernmentArea
WHERE
	ID = @ID

GO

CREATE PROCEDURE [Location].spGetLocalGovernmentAreasByStateID

@StateID int

AS

SELECT
	ID,
	StateID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].LocalGovernmentArea
WHERE
	StateID = @StateID
ORDER BY
	Name

GO

CREATE PROCEDURE Crime.spGetOffence

AS

SELECT
	ID,
	ParentID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.Offence
ORDER BY
	Name

GO

CREATE PROCEDURE Crime.spGetOffenceByID

@ID int

AS

SELECT
	ID,
	ParentID,
	Name,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	Crime.Offence
WHERE
	ID = @ID

GO

CREATE PROCEDURE [Location].spGetState

AS

SELECT
	ID,
	Name,
	AbbreviatedName,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].[State]
ORDER BY
	Name

GO

CREATE PROCEDURE [Location].spGetStateByID

@ID int

AS

SELECT
	ID,
	Name,
	AbbreviatedName,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].[State]
WHERE
	ID = @ID

GO

CREATE PROCEDURE [Location].spGetStateByAbbreviatedName

@AbbreviatedName varchar(100)

AS

SELECT
	ID,
	Name,
	AbbreviatedName,
	IsDeleted,
	IsVisible,
	DateCreatedUtc,
	DateUpdatedUtc
FROM
	[Location].[State]
WHERE
	AbbreviatedName = @AbbreviatedName

GO