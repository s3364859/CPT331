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
			// Database Schemas
			Create.Schema("Crime");
			Create.Schema("Location");
			Create.Schema("Registration");

			//	Tables
			Create.Table("State")
				.InSchema("Location")
					.WithColumn("ID")
						.AsInt32()
						.NotNullable()
						.Identity()
						.PrimaryKey()
					.WithColumn("Name")
						.AsAnsiString(100)
						.NotNullable()
					.WithColumn("AbbreviatedName")
						.AsAnsiString(3)
						.NotNullable()
					.WithColumn("IsDeleted")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(false)
					.WithColumn("IsVisible")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(true)
					.WithColumn("DateCreatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime)
					.WithColumn("DateUpdatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime);

			Execute.EmbeddedScript("Location.LocalGovernmentArea.sql");

			Create.Table("OffenceCategory")
				.InSchema("Crime")
					.WithColumn("ID")
						.AsInt32()
						.NotNullable()
						.Identity()
						.PrimaryKey()
					.WithColumn("Name")
						.AsAnsiString(100)
						.NotNullable()
					.WithColumn("IsDeleted")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(false)
					.WithColumn("IsVisible")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(true)
					.WithColumn("DateCreatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime)
					.WithColumn("DateUpdatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime);

			Create.Table("Offence")
				.InSchema("Crime")
					.WithColumn("ID")
						.AsInt32()
						.NotNullable()
						.Identity()
						.PrimaryKey()
					.WithColumn("OffenceCategoryID")
						.AsInt32()
						.Nullable()
						.ForeignKey("FK_Offence_OffenceCategory", "Crime", "OffenceCategory", "ID")
					.WithColumn("Name")
						.AsAnsiString(100)
						.NotNullable()
					.WithColumn("IsDeleted")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(false)
					.WithColumn("IsVisible")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(true)
					.WithColumn("DateCreatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime)
					.WithColumn("DateUpdatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime);

			Create.Table("Crime")
				.InSchema("Crime")
					.WithColumn("ID")
						.AsInt32()
						.NotNullable()
						.Identity()
						.PrimaryKey()
					.WithColumn("LocalGovernmentAreaID")
						.AsInt32()
						.NotNullable()
						.ForeignKey("FK_Crime_LocalGovernmentArea", "Location", "LocalGovernmentArea", "ID")
					.WithColumn("OffenceID")
						.AsInt32()
						.NotNullable()
						.ForeignKey("FK_Crime_Offence", "Crime", "Offence", "ID")
					.WithColumn("Count")
						.AsInt32()
						.NotNullable()
					.WithColumn("Month")
						.AsInt32()
						.NotNullable()
					.WithColumn("Year")
						.AsInt32()
						.NotNullable()
					.WithColumn("IsDeleted")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(false)
					.WithColumn("IsVisible")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(true)
					.WithColumn("DateCreatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime)
					.WithColumn("DateUpdatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime);

		Create.Table("User")
				.InSchema("Registration")
					.WithColumn("ID")
						.AsInt32()
						.NotNullable()
						.Identity()
						.PrimaryKey()
					.WithColumn("Username")
						.AsAnsiString(150)
						.NotNullable()
					.WithColumn("Password")
						.AsAnsiString(50)
						.NotNullable()
					.WithColumn("IsDeleted")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(false)
					.WithColumn("IsActive")
						.AsBoolean()
						.NotNullable()
						.WithDefaultValue(true)
					.WithColumn("DateCreatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime)
					.WithColumn("DateUpdatedUtc")
						.AsDateTime()
						.NotNullable()
						.WithDefault(SystemMethods.CurrentUTCDateTime);

			//	Views
			Execute.EmbeddedScript("Crime.CrimeOffenceLocalGovernmentAreaState.sql");
			Execute.EmbeddedScript("Location.LocalGovernmentAreaState.sql");

			//	Indicies
			Execute.EmbeddedScript("Crime.Crime.Indicies.sql");

			//	Stored Procedures
			Execute.EmbeddedScript("Crime.spAddCrime.sql");
			Execute.EmbeddedScript("Crime.spAddOffence.sql");
			Execute.EmbeddedScript("Crime.spAddOffenceCategory.sql");
			Execute.EmbeddedScript("Crime.spGetCrime.sql");
			Execute.EmbeddedScript("Crime.spGetCrimeByID.sql");
			Execute.EmbeddedScript("Crime.spGetCrimeOffenceLocalGovernmentAreaState.sql");
			Execute.EmbeddedScript("Crime.spGetCrimeOffenceLocalGovernmentAreaStateByID.sql");
			Execute.EmbeddedScript("Crime.spGetCrimesByCoordinate.sql");
			Execute.EmbeddedScript("Crime.spGetOffence.sql");
			Execute.EmbeddedScript("Crime.spGetOffenceByID.sql");
			Execute.EmbeddedScript("Crime.spGetOffenceCategory.sql");
			Execute.EmbeddedScript("Crime.spGetOffenceCategoryByID.sql");
			Execute.EmbeddedScript("Crime.spUpdateCrime.sql");
			Execute.EmbeddedScript("Crime.spUpdateOffence.sql");
			Execute.EmbeddedScript("Crime.spUpdateOffenceCategory.sql");
			Execute.EmbeddedScript("Location.spAddLocalGovernmentArea.sql");
			Execute.EmbeddedScript("Location.spAddState.sql");
			Execute.EmbeddedScript("Location.spGetLocalGovernmentArea.sql");
			Execute.EmbeddedScript("Location.spGetLocalGovernmentAreaState.sql");
			Execute.EmbeddedScript("Location.spGetLocalGovernmentAreaByID.sql");
			Execute.EmbeddedScript("Location.spGetLocalGovernmentAreasByStateID.sql");
			Execute.EmbeddedScript("Location.spGetState.sql");
			Execute.EmbeddedScript("Location.spGetStateByAbbreviatedName.sql");
			Execute.EmbeddedScript("Location.spGetStateByID.sql");
			Execute.EmbeddedScript("Location.spUpdateLocalGovernmentArea.sql");
			Execute.EmbeddedScript("Location.spUpdateState.sql");
			Execute.EmbeddedScript("Registration.spGetUser.sql");
			Execute.EmbeddedScript("Registration.spGetUserByID.sql");
			Execute.EmbeddedScript("Registration.spGetUserByUsername.sql");
		}
	}
}