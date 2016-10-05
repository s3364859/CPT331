#region Using References

using System;
using System.IO;

using FluentMigrator;

using CPT331.Data.Parsers;

#endregion

namespace CPT331.Data.Migration.Migrations
{
	[Migration(0004)]
	public class M0004 : FluentMigrator.Migration
	{
		public override void Down()
		{
			//	Nothing to see here
		}

		public override void Up()
		{
			//	Eventually these should be pulled out of here
			NswXmlParser nswXmlParser = new NswXmlParser(Path.Combine(ApplicationConfig.Default.CrimeDataFolder, "NSW.xml"));
			
			nswXmlParser.Parse();
		}
	}
}