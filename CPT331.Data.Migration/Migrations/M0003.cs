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
				.Row(new { Name = "Abduction and kidnapping" })
				.Row(new { Name = "Against justice procedures" })
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

			Execute.EmbeddedScript("M0003.sql");
		}
	}
}