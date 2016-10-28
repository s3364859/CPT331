#region Using References

using System;
using System.Configuration;

#endregion

namespace CPT331.Core
{
	/// <summary>
	/// Represents an ApplicationConfiguration type, used to describe settings required for the application to function.
	/// </summary>
	public sealed class ApplicationConfiguration : ApplicationSettingsBase
	{
		private const string CPT331ConnectionStringKey = "CPT331ConnectionString";
		private const string DefaultMigrationSize = "100000";
		private const string EventFindaPasswordKey = "EventFindaPassword";
		private const string EventFindaUrlKey = "EventFindaUrl";
		private const string EventFindaUsernameKey = "EventFindaUsername";
		private const string MigrationCommitSizeKey = "MigrationCommitSize";
		private const string MigrationDataSourceDirectoryKey = "MigrationDataSourceDirectory";

		private static ApplicationConfiguration _defaultInstance = ((ApplicationConfiguration)(Synchronized(new ApplicationConfiguration())));

		/// <summary>
		/// Returns the Default instance.
		/// </summary>
		public static ApplicationConfiguration Default
		{
			get
			{
				return _defaultInstance;
			}
		}

		/// <summary>
		/// Gets the connection string to the database.
		/// </summary>
		[ApplicationScopedSetting]
		public string CPT331ConnectionString
		{
			get
			{
				return GetConnectionStringValue(CPT331ConnectionStringKey);
			}
		}

		/// <summary>
		/// Gets the password required to connect to the EventFinda web service.
		/// </summary>
		[ApplicationScopedSetting]
		public string EventFindaPassword
		{
			get
			{
				return GetAppSettingsValue(EventFindaPasswordKey);
			}
		}

		/// <summary>
		/// Gets the URL of the EventFinda web service.
		/// </summary>
		[ApplicationScopedSetting]
		public string EventFindaUrl
		{
			get
			{
				return GetAppSettingsValue(EventFindaUrlKey);
			}
		}

		/// <summary>
		/// Gets the username required to connect to the EventFinda web service.
		/// </summary>
		[ApplicationScopedSetting]
		public string EventFindaUsername
		{
			get
			{
				return GetAppSettingsValue(EventFindaUsernameKey);
			}
		}

		private string GetAppSettingsValue(string key)
		{
			return ((this[key] != null) ? ((string)(this[key])) : "");
		}

		private static string GetConnectionStringValue(string key)
		{
			string getConnectionStringValue = "";

			if (ConfigurationManager.ConnectionStrings[key] != null)
			{
				getConnectionStringValue = ConfigurationManager.ConnectionStrings[key].ConnectionString;
			}

			return getConnectionStringValue;
		}

		/// <summary>
		/// Gets the size of the number of statements to include in a transaction.
		/// </summary>
		[ApplicationScopedSetting]
		[DefaultSettingValue(DefaultMigrationSize)]
		public int MigrationCommitSize
		{
			get
			{
				int migrationCommitSize = 0;
				string migrationCommitValue = GetAppSettingsValue(MigrationDataSourceDirectoryKey);

				if (String.IsNullOrEmpty(migrationCommitValue) == false)
				{
					if (Int32.TryParse(migrationCommitValue, out migrationCommitSize) == false)
					{
						migrationCommitSize = Convert.ToInt32(DefaultMigrationSize);
					}
				}

				return migrationCommitSize;
			}
		}

		/// <summary>
		/// Gets the path to the directory containing KML and XML data sources.
		/// </summary>
		[ApplicationScopedSetting]
		[DefaultSettingValue(@"C:\Downloads\Crime Data\")]
		public string MigrationDataSourceDirectory
		{
			get
			{
				return GetAppSettingsValue(MigrationDataSourceDirectoryKey);
			}
		}
	}
}
