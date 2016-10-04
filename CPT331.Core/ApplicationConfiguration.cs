#region Using References

using System;
using System.Configuration;

#endregion

namespace CPT331.Core
{
	public static class ApplicationConfiguration
	{
		private const string CPT331ConnectionStringKey = "CPT331ConnectionString";
		private const string EventFindaPasswordKey = "EventFinda.Password";
		private const string EventFindaUrlKey = "EventFinda.Url";
		private const string EventFindaUsernameKey = "EventFinda.Username";

		public static string CPT331ConnectionString
		{
			get
			{
				return GetConnectionStringValue(CPT331ConnectionStringKey);
			}
		}

		public static string EventFindaPassword
		{
			get
			{
				return GetAppSettingsValue(EventFindaPasswordKey);
			}
		}

		public static string EventFindaUrl
		{
			get
			{
				return GetAppSettingsValue(EventFindaUrlKey);
			}
		}

		public static string EventFindaUsername
		{
			get
			{
				return GetAppSettingsValue(EventFindaUsernameKey);
			}
		}

		private static string GetAppSettingsValue(string key)
		{
			string getAppSettingsValue = "";

			if (ConfigurationManager.AppSettings[key] != null)
			{
				getAppSettingsValue = ConfigurationManager.AppSettings[key];
			}

			return getAppSettingsValue;
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
	}
}
