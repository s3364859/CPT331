#region Using References

using System;
using System.Data.SqlClient;

using CPT331.Core;

#endregion

namespace CPT331.Data
{
	public static class SqlConnectionFactory
	{
		static SqlConnectionFactory()
		{
			_connectionString = new SqlConnectionStringBuilder(ApplicationConfiguration.CPT331ConnectionString).ConnectionString;
		}

		private static string _connectionString;

		internal static SqlConnection NewSqlConnetion()
		{
			SqlConnection sqlConnection = new SqlConnection(_connectionString);

			sqlConnection.Open();

			return sqlConnection;
		}
	}
}
