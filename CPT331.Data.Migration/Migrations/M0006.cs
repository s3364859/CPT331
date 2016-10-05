#region Using References

using System;

using FluentMigrator;

using CPT331.Data.Parsers;

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
			//	Obviously this isn't going to work for you if you don't have the file
			QldXmlParser qldXmlParser = new QldXmlParser(@"C:\Users\carl.belle\Downloads\Crime Data\division_Reported_Offences_Rates.xml");
			
			qldXmlParser.Parse();
		}
	}
}