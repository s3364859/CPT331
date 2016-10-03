#region Using References

using System;

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
			//	Obviously this isn't going to work for you if you don't have the file
			VicXmlParser vicXmlParser = new VicXmlParser(@"C:\Users\carl.belle\Downloads\Crime Data\VIC 2014.xml");
			
			vicXmlParser.Parse();
		}
	}
}