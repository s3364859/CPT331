#region Using References

using System;

using FluentMigrator;

#endregion

namespace CPT331.Data.Migration.Migrations
{
	[Migration(0003)]
	public class M0003 : FluentMigrator.Migration
	{
		public override void Down()
		{
			//	Nothing to see here
		}

		public override void Up()
		{
			Insert.IntoTable("State").InSchema("Location")
				.Row(new { Name = "Australian Capital Territory", AbbreviatedName = "ACT" })
				.Row(new { Name = "New South Wales", AbbreviatedName = "NSW" })
				.Row(new { Name = "Northern Territory", AbbreviatedName = "NT" })
				.Row(new { Name = "Queensland", AbbreviatedName = "QLD" })
				.Row(new { Name = "South Australia", AbbreviatedName = "SA" })
				.Row(new { Name = "Tasmania", AbbreviatedName = "TAS" })
				.Row(new { Name = "Victoria", AbbreviatedName = "VIC" })
				.Row(new { Name = "Western Australia", AbbreviatedName = "WA" });

			//	Offences from NSW
			Insert.IntoTable("Offence").InSchema("Crime")
				.Row(new { Name = "Abduction and Kidnapping" })
				.Row(new { Name = "Against Justice Procedures" })
				.Row(new { Name = "Arson" })
				.Row(new { Name = "Assault" })
				.Row(new { Name = "Betting and gaming offences" })
				.Row(new { Name = "Blackmail and extortion" })
				.Row(new { Name = "Disorderly conduct" })
				.Row(new { Name = "Drug offences" })
				.Row(new { Name = "Harassment, threatening behaviour and private nuisance" })
				.Row(new { Name = "Homicide" })
				.Row(new { Name = "Liquor offences" })
				.Row(new { Name = "Malicious damage to property" })
				.Row(new { Name = "Other offences" })
				.Row(new { Name = "Other offences against the person" })
				.Row(new { Name = "Pornography offences" })
				.Row(new { Name = "Prohibited and regulated weapons offences" })
				.Row(new { Name = "Prostitution offences" })
				.Row(new { Name = "Robbery" })
				.Row(new { Name = "Sexual offences" })
				.Row(new { Name = "Theft" })
				.Row(new { Name = "Transport regulatory offences" });

			//	Offences from VIC
			Insert.IntoTable("Offence").InSchema("Crime")
				.Row(new { Name = "Crimes against the person" })
				.Row(new { Name = "Justice procedures offences" })
				.Row(new { Name = "Property and deception offences" })
				.Row(new { Name = "Public order and security offences" });

			//	Offences from QLD
			Insert.IntoTable("Offence").InSchema("Crime")
				.Row(new { Name = "Advertising Prostitution" })
				.Row(new { Name = "Armed Robbery" })
				.Row(new { Name = "Attempted Murder" })
				.Row(new { Name = "Bomb Possess and/or use of" })
				.Row(new { Name = "Breach Domestic Violence Protection Order" })
				.Row(new { Name = "Common Assault" })
				.Row(new { Name = "Conspiracy to Murder" })
				.Row(new { Name = "Dangerous Operation of a Vehicle" })
				.Row(new { Name = "Disobey Move-on Direction" })
				.Row(new { Name = "Disqualified Driving" })
				.Row(new { Name = "Drink Driving" })
				.Row(new { Name = "Driving Causing Death" })
				.Row(new { Name = "Extortion" })
				.Row(new { Name = "Fare Evasion" })
				.Row(new { Name = "Found in Places Used for Purpose of Prostitution Offences" })
				.Row(new { Name = "Fraud" })
				.Row(new { Name = "Fraud by Cheque" })
				.Row(new { Name = "Fraud by Computer" })
				.Row(new { Name = "Fraud by Credit Card" })
				.Row(new { Name = "Gaming Racing & Betting Offences" })
				.Row(new { Name = "Good Order Offences" })
				.Row(new { Name = "Grievous Assault" })
				.Row(new { Name = "Handling Stolen Goods" })
				.Row(new { Name = "Have Interest in Premises Used for Prostitution Offences" })
				.Row(new { Name = "Homicide (Murder)" })
				.Row(new { Name = "Identity Fraud" })
				.Row(new { Name = "Interfere with Mechanism of Motor Vehicle" })
				.Row(new { Name = "Kidnapping & Abduction etc." })
				.Row(new { Name = "Knowingly Participate in Provision Prostitution Offences" })
				.Row(new { Name = "Life Endangering Acts" })
				.Row(new { Name = "Liquor (excl. Drunkenness)" })
				.Row(new { Name = "Manslaughter (excl. by driving)" })
				.Row(new { Name = "Manslaughter Unlawful Striking Causing Death" })
				.Row(new { Name = "Miscellaneous Offences" })
				.Row(new { Name = "Offences Against Property" })
				.Row(new { Name = "Offences Against the Person" })
				.Row(new { Name = "Other Drug Offences" })
				.Row(new { Name = "Other Fraud" })
				.Row(new { Name = "Other Handling Stolen Goods" })
				.Row(new { Name = "Other Homicide" })
				.Row(new { Name = "Other Offences" })
				.Row(new { Name = "Other Offences Against the Person" })
				.Row(new { Name = "Other Property Damage" })
				.Row(new { Name = "Other Prostitution Offences" })
				.Row(new { Name = "Other Sexual Offences" })
				.Row(new { Name = "Other Stealing" })
				.Row(new { Name = "Other Theft (excl. Unlawful Entry)" })
				.Row(new { Name = "Permit Minor to be at a Place Used for Prostitution Offences" })
				.Row(new { Name = "Possess and/or use other weapons; restricted items" })
				.Row(new { Name = "Possess Drugs" })
				.Row(new { Name = "Possess etc. Tainted Property" })
				.Row(new { Name = "Possess Property Suspected Stolen" })
				.Row(new { Name = "Procuring Prostitution" })
				.Row(new { Name = "Produce Drugs" })
				.Row(new { Name = "Prostitution Offences" })
				.Row(new { Name = "Public Nuisance" })
				.Row(new { Name = "Public Soliciting" })
				.Row(new { Name = "Rape and Attempted Rape" })
				.Row(new { Name = "Receiving Stolen Property" })
				.Row(new { Name = "Resist Incite Hinder Obstruct Police" })
				.Row(new { Name = "Sell Supply Drugs" })
				.Row(new { Name = "Serious Assault" })
				.Row(new { Name = "Serious Assault (Other)" })
				.Row(new { Name = "Sexual Offences" })
				.Row(new { Name = "Shop Stealing" })
				.Row(new { Name = "Stalking" })
				.Row(new { Name = "Stealing from Dwellings" })
				.Row(new { Name = "Stock Related Offences" })
				.Row(new { Name = "Traffic and Related Offences" })
				.Row(new { Name = "Trafficking Drugs" })
				.Row(new { Name = "Trespassing and Vagrancy" })
				.Row(new { Name = "Unarmed Robbery" })
				.Row(new { Name = "Unlawful Entry" })
				.Row(new { Name = "Unlawful Entry With Intent - Dwelling" })
				.Row(new { Name = "Unlawful Entry With Intent - Other" })
				.Row(new { Name = "Unlawful Entry With Intent - Shop" })
				.Row(new { Name = "Unlawful Entry With Violence - Dwelling" })
				.Row(new { Name = "Unlawful Entry Without Violence - Dwelling" })
				.Row(new { Name = "Unlawful Possess Concealable Firearm" })
				.Row(new { Name = "Unlawful Possess Firearm - Other" })
				.Row(new { Name = "Unlawful Use of Motor Vehicle" })
				.Row(new { Name = "Vehicles (steal from/enter with intent)" })
				.Row(new { Name = "Weapons Act Offences" })
				.Row(new { Name = "Weapons Act Offences - Other" });

			Execute.EmbeddedScript("M0003.sql");
		}
	}
}