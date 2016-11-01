#region Using References

using System;
using System.Data.SqlClient;

using CPT331.Core;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents an SqlConnectionFactory type, used to construct SqlConnection objects.
	/// </summary>
	internal static class SqlConnectionFactory
	{
		static SqlConnectionFactory()
		{
			_connectionString = new SqlConnectionStringBuilder(ApplicationConfiguration.Default.CPT331ConnectionString).ConnectionString;
		}

		private static string _connectionString;

		/// <summary>
		/// Constructs and opens a new SqlConnection object.
		/// </summary>
		/// <returns>Returns the newly created and opened SqlConnection object.</returns>
		public static SqlConnection NewSqlConnetion()
		{
			SqlConnection sqlConnection = new SqlConnection(_connectionString);

			sqlConnection.Open();

			return sqlConnection;
		}
	}
}
