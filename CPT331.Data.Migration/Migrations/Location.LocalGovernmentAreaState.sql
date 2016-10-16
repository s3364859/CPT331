CREATE VIEW [Location].LocalGovernmentAreaState

AS

SELECT
	[Location].LocalGovernmentArea.ID,
	[Location].LocalGovernmentArea.StateID,
	[Location].[State].AbbreviatedName,
	[Location].[State].Name AS StateName,
	[Location].LocalGovernmentArea.Name,
	[Location].LocalGovernmentArea.Area,
	[Location].LocalGovernmentArea.IsDeleted,
	[Location].LocalGovernmentArea.IsVisible,
	[Location].LocalGovernmentArea.DateCreatedUtc,
	[Location].LocalGovernmentArea.DateUpdatedUtc
FROM
	[Location].LocalGovernmentArea

INNER JOIN [Location].[State] ON
([Location].LocalGovernmentArea.StateID = [Location].[State].ID)