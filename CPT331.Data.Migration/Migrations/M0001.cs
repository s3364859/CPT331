#region Using References

using System;

using FluentMigrator;

#endregion

namespace CPT331.Data.Migration.Migrations
{
	[Migration(0001)]
	public class M0001 : FluentMigrator.Migration
	{
		public override void Down()
		{
			//	Nothing to see here
		}

		public override void Up()
		{
			//	Example of test bits and pieces

			//	Whip up a new table
			Create.Table("Test")
				.WithColumn("ID")
					.AsInt32()
					.NotNullable()
					.Identity()
					.PrimaryKey()
				.WithColumn("Value0")
					.AsString()
					.NotNullable()
				.WithColumn("Value1")
					.AsString()
					.NotNullable();

			//	Whack some data into it
			Insert.IntoTable("Test")
				.Row(new { Value0 = "Row0Value0", Value1 = "Row0Value1" })
				.Row(new { Value0 = "Row1Value0", Value1 = "Row1Value1" })
				.Row(new { Value0 = "Row2Value0", Value1 = "Row2Value1" });

			//	Not designed with sprocs in mind, typical - we can take care of this by ourselves
			Execute.EmbeddedScript("M0001.sql");
		}
	}
}
