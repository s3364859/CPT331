#region Using References

using System;

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
			//	Obviously this isn't going to work for you if you don't have the file (which is ~50 MB atm)
			NswXmlParser nswXmlParser = new NswXmlParser(@"D:\Downloads\Crime Data\NSW\Book1.xml");
			
			nswXmlParser.Parse();
		}
	}
}