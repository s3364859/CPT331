--	NSW Local Government Areas

BEGIN TRAN

DECLARE @@StateID INT = (SELECT ID FROM [Location].State WHERE AbbreviatedName = 'NSW')

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
INSERT INTO [Location].LocalGovernmentArea (StateID, Name) VALUES (@@StateID, 'Young');

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