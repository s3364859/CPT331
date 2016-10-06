#region Using References

using System;

using FluentMigrator;

using CPT331.Data.Parsers;
using System.IO;

#endregion

namespace CPT331.Data.Migration.Migrations
{
	[Migration(0006)]
	public class M0006 : FluentMigrator.Migration
	{
		public override void Down()
		{
			//	Nothing to see here
		}

		public override void Up()
		{
			//	Eventually these should be pulled out of here
			QldXmlParser qldXmlParser = new QldXmlParser(Path.Combine(ApplicationConfig.Default.CrimeDataFolder, "QLD.xml"));

			qldXmlParser.Parse();
		}
	}
}