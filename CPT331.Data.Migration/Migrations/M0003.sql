DECLARE @@StateID INT = 0

--	NSW Local Government Areas

BEGIN TRAN

SET @@StateID = (SELECT ID FROM [Location].State WHERE AbbreviatedName = 'NSW')

INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Albury')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Armidale Dumaresq')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ashfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Auburn')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ballina')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Balranald')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bankstown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bathurst Regional')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bega Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bellingen')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Berrigan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blacktown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blayney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blue Mountains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bogan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bombala')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Boorowa')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Botany Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bourke')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Brewarrina')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Broken Hill')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Burwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Byron')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cabonne')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Camden')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Campbelltown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Canada Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Canterbury')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Carrathool')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Central Darling')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cessnock')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Clarence Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cobar')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coffs Harbour')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Conargo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coolamon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cooma-Monaro')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coonamble')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cootamundra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Corowa Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cowra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Deniliquin')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dubbo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dungog')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eurobodalla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Fairfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Forbes')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gilgandra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Glen Innes Severn')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gloucester')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gosford')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goulburn Mulwaree')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Great Lakes')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Hume Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Taree')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Griffith')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gundagai')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gunnedah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Guyra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gwydir')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Harden')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hawkesbury')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Holroyd')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hornsby')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hunters Hill')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hurstville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Inverell')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jerilderie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Junee')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kempsey')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kiama')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kogarah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ku-ring-gai')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kyogle')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lachlan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lake Macquarie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lane Cove')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Leeton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Leichhardt')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lismore')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lithgow')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Liverpool')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Liverpool Plains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lockhart')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lord Howe Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maitland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Manly')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Marrickville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mid-Western Regional')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moree Plains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mosman')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Murray')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Murrumbidgee')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Muswellbrook')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nambucca')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Narrabri')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Narrandera')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Narromine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Newcastle')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'North Sydney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Oberon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Orange')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Palerang')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Parkes')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Parramatta')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Penrith')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pittwater')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Port Macquarie-Hastings')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Port Stephens')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Prisons')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Queanbeyan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Randwick')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Richmond Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rockdale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ryde')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Shellharbour')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Shoalhaven')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Singleton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Snowy River')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Strathfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sutherland Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sydney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tamworth Regional')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Temora')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tenterfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'The Hills Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tumbarumba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tumut Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tweed')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Unincorporated Far West')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Upper Hunter Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Upper Lachlan Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Uralla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Urana')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wagga Wagga')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wakool')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Walcha')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Walgett')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Warren')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Warringah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Warrumbungle Shire')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Waverley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Weddin')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wellington')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wentworth')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Willoughby')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wingecarribee')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wollondilly')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wollongong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Woollahra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wyong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yass Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Young')

COMMIT

--	NSW OFFENCES

BEGIN TRAN

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Escape custody' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Breach Apprehended Violence Order' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Breach bail conditions' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Fail to appear' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Resist or hinder officer' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Other offences against justice procedures' FROM Crime.Offence WHERE Name = 'Against justice procedures'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Domestic violence related assault' FROM Crime.Offence WHERE Name = 'Assault'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Non-domestic violence related assault' FROM Crime.Offence WHERE Name = 'Assault'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Assault Police' FROM Crime.Offence WHERE Name = 'Assault'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Trespass' FROM Crime.Offence WHERE Name = 'Disorderly conduct'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Offensive conduct' FROM Crime.Offence WHERE Name = 'Disorderly conduct'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Offensive language' FROM Crime.Offence WHERE Name = 'Disorderly conduct'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Criminal intent' FROM Crime.Offence WHERE Name = 'Disorderly conduct'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of cocaine' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of narcotics' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of cannabis' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of amphetamines' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of ecstasy' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Possession and/or use of other drugs' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in cocaine' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in narcotics' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in cannabis' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in amphetamines' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in ecstasy' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dealing, trafficking in other drugs' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Cultivating cannabis' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Manufacture drug' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Importing drugs' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Other drug offences' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Murder (a)' FROM Crime.Offence WHERE Name = 'Homicide'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Attempted murder' FROM Crime.Offence WHERE Name = 'Homicide'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Murder accessory, conspiracy' FROM Crime.Offence WHERE Name = 'Homicide'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Manslaughter (a)' FROM Crime.Offence WHERE Name = 'Homicide'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Robbery without a weapon' FROM Crime.Offence WHERE Name = 'Robbery'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Robbery with a firearm' FROM Crime.Offence WHERE Name = 'Robbery'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Robbery with a weapon not a firearm' FROM Crime.Offence WHERE Name = 'Robbery'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Sexual assault' FROM Crime.Offence WHERE Name = 'Sexual offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Indecent assault, act of indecency and other sexual offences' FROM Crime.Offence WHERE Name = 'Sexual offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Break and enter dwelling' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Break and enter non-dwelling' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Receiving or handling stolen goods' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Motor vehicle theft' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Steal from motor vehicle' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Steal from retail store' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Steal from dwelling' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Steal from person' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Stock theft' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Fraud' FROM Crime.Offence WHERE Name = 'Theft'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Other theft' FROM Crime.Offence WHERE Name = 'Theft'

COMMIT

--	VIC Local Government Areas

BEGIN TRAN

SET @@StateID = (SELECT ID FROM [Location].State WHERE AbbreviatedName = 'VIC')

INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Alpine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ararat')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ballarat')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Banyule')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bass Coast')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Baw Baw')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bayside')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Benalla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Boroondara')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Brimbank')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Buloke')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Campaspe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cardinia')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Casey')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Central Goldfields')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Colac-Otway')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Corangamite')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Darebin')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'East Gippsland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Frankston')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gannawarra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Glen Eira')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Glenelg')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Golden Plains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Bendigo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Dandenong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Geelong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greater Shepparton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hepburn')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hindmarsh')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hobsons Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Horsham')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hume')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Indigo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kingston')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Knox')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Latrobe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Loddon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Macedon Ranges')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Manningham')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mansfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maribyrnong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maroondah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Melbourne')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Melton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mildura')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mitchell')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moira')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Monash')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moonee Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moorabool')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moreland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mornington Peninsula')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Alexander')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moyne')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Murrindindi')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nillumbik')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Northern Grampians')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Port Phillip')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pyrenees')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Queenscliffe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'South Gippsland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Southern Grampians')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Stonnington')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Strathbogie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Surf Coast')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Swan Hill')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Towong')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wangaratta')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Warrnambool')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wellington')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'West Wimmera')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Whitehorse')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Whittlesea')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wodonga')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wyndham')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yarra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yarra Ranges')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yarriambiack')

COMMIT

--	VIC OFFENCES

BEGIN TRAN

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Homicide and related offences' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Assault and related offences' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Sexual offences' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Abduction and related offences' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Robbery' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Blackmail and extortion' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Stalking, harassment and threatening behaviour' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Dangerous and negligent acts endangering people' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Homicide and related offences' FROM Crime.Offence WHERE Name = 'Crimes against the person'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Arson' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Property damage' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Burglary/Break and enter' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Theft' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Deception' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Bribery' FROM Crime.Offence WHERE Name = 'Property and deception offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Drug dealing and trafficking' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Cultivate or manufacture drugs' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Drug use and possession' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Other drug offences' FROM Crime.Offence WHERE Name = 'Drug offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Weapons and explosives offences' FROM Crime.Offence WHERE Name = 'Public order and security offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Disorderly and offensive conduct' FROM Crime.Offence WHERE Name = 'Public order and security offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Public nuisance offences' FROM Crime.Offence WHERE Name = 'Public order and security offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Public security offences' FROM Crime.Offence WHERE Name = 'Public order and security offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Justice procedures' FROM Crime.Offence WHERE Name = 'Justice procedures offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Breaches of orders' FROM Crime.Offence WHERE Name = 'Justice procedures offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Other government regulatory offences' FROM Crime.Offence WHERE Name = 'Other offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Miscellaneous offences' FROM Crime.Offence WHERE Name = 'Other offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Transport regulation offences' FROM Crime.Offence WHERE Name = 'Other offences'

INSERT INTO Crime.Offence (ParentID, Name)
SELECT ID, 'Regulatory driving offences' FROM Crime.Offence WHERE Name = 'Other offences'

COMMIT

--	QLD Local Government Areas

BEGIN TRAN

SET @@StateID = (SELECT ID FROM [Location].State WHERE AbbreviatedName = 'QLD')

INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Acacia Ridge')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Adavale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Agnes Water')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Albany Creek')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Allora')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Alpha')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Anakie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Annerley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Aramac')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Atherton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Augathella')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Aurukun')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ayr')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Babinda')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Badu Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bamaga')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Baralaba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Barcaldine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bargara')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Beaudesert')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bedourie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Beenleigh')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Beerwah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bell')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Biggenden')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Biloela')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Birdsville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blackall')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blackbutt')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Blackwater')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bollon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Boonah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Boondall')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Booval')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Boulia')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bowen')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bribie Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Brisbane City')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Broadbeach')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Browns Plains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Bundaberg')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Burketown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Burpengary')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Caboolture')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cairns')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Calamvale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Calen')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Calliope')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Caloundra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cambooya')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Camooweal')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Canungra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Capalaba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Capella')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cardwell')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Carina')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Carmila')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Carseldine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cecil Plains')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Charleville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Charters Towers')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cherbourg')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Childers')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Chillagoe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Chinchilla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Clare')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Clermont')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cleveland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Clifton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cloncurry')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coen')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Collinsville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cooktown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coolangatta')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coolum')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coomera')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cooroy')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Coorparoo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cooyar')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Crestmead')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Crows Nest')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Croydon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Cunnamulla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dajarra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dalby')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dayboro')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Deception Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Deeragun')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dimbulah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dirranbandi')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Doomadgee')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Drayton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Duaringa')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dulacca')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dunwich')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dutton Park')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Dysart')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Edmonton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eidsvold')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'El Arish')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Emerald')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Emu Park')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eromanga')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Esk')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eulo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Eumundi')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Farleigh')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ferny Grove')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Finch Hatton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Forsayth')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Fortitude Valley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Fraser Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gatton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gayndah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Georgetown')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gin Gin')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Giru')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gladstone')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Glenden')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goodna')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goombungee')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goomeri')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goondiwindi')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Goovigen')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gordonvale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gracemere')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Greenvale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Gympie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Halifax')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Harrisville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Helidon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hendra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Herberton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hervey Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Holland Park')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Home Hill')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hope Vale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Horn Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Howard')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hughenden')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Hungerford')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ilfracombe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Imbil')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Inala')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Indooroopilly')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ingham')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Inglewood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Injune')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Innisfail')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ipswich')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Isisford')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jandowae')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jericho')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jimboomba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jondaryan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Julia Creek')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Jundah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kalbar')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Karana Downs')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Karumba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kawana Waters')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kenilworth')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kilcoy')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kilkivan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Killarney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kingaroy')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kirwan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kowanyama')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kumbia')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kuranda')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Kynuna')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Laidley')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lakes Creek')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Landsborough')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Laura')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Leyburn')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lockhart River')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Logan Central')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Loganholme')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Longreach')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Lowood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mackay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mackay Northern Beaches')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Macleay Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Magnetic Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Malanda')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maleny')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mango Hill North Lakes')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Many Peaks')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Marburg')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mareeba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Marian')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Marlborough')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Marmor')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maroochydore')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Maryborough')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mckinlay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Meandarra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Middlemount')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Miles')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Millaa Millaa')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Millmerran')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mirani')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Miriam Vale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mission Beach')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mitchell')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Monto')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moore')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moorooka')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moranbah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Morningside')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mornington Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Morven')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mossman')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Garnet')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Isa')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Larcom')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Molloy')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Morgan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Ommaney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Perry')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mount Surprise')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Moura')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mourilyan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mudgeeraba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mundingburra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mundubbera')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mungallala')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Mungindi')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Murgon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Muttaburra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nambour')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nanango')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nebo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Nerang')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Noosa Heads')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Normanton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'North Rockhampton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'North Tamborine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Oakey')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Palm Beach')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Palm Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Palmwoods')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pentland')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Peranga')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Petrie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pittsworth')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pomona')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Pormpuraaw')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Port Douglas')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Prairie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Proserpine')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Proston')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Quilpie')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rathdowney')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ravenshoe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Ravenswood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Redcliffe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Redland Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Richmond')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Robina')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rockhampton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rolleston')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rollingstone')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Roma')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rosedale')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Rosewood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Runaway Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Russell Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Saint George')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Saint Lawrence')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sandgate')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sarina')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sherwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Silkwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Sippy Downs')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Smithfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'South Johnstone')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'South Kolan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Southport')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Springfield')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Springsure')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Springwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Stafford')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Stanthorpe')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Stuart')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Surat')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Surfers Paradise')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Talwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tambo')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tannum Sands')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tara')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Taroom')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Texas')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Thallon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Thargomindah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'The Gap')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Theodore')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Thursday Island')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tiaro')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tieri')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tin Can Bay')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Toogoolawah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Toowoomba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Townsville')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Tully')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Upper Mount Gravatt')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Walkerston')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wallangarra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wallumbilla')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wandoan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Warwick')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Weipa')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'West End')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Westwood')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Whitsunday')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Windorah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Winton')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wondai')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Woodford')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Woorabinda')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wowan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wujal Wujal')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wyandra')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Wynnum')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yamanto')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yangan')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yaraka')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yarrabah')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yarraman')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yelarbon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yeppoon')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yuleba')
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Yungaburra')

COMMIT

