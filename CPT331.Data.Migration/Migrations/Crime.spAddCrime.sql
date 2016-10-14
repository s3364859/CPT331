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
