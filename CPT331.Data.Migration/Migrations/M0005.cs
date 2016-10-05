#region Using References

using System;
using System.IO;

using FluentMigrator;

using CPT331.Data.Parsers;

#endregion

namespace CPT331.Data.Migration.Migrations
{
	[Migration(0005)]
	public class M0005 : FluentMigrator.Migration
	{
		public override void Down()
		{
			//	Nothing to see here
		}

		public override void Up()
		{
			//	Eventually these should be pulled out of here
			VicXmlParser vicXmlParser = new VicXmlParser(Path.Combine(ApplicationConfig.Default.CrimeDataFolder, "VIC.xml"));
			
			vicXmlParser.Parse();
		}
	}
}