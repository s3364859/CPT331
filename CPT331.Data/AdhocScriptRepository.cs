#region Using References

using System;
using System.Data;
using System.Data.SqlClient;

using Dapper;

using CPT331.Core.Logging;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents an AdhocScriptRepository type, used to execute SQL against a data source.
	/// </summary>
	public static class AdhocScriptRepository
	{
		private const int DefaultCommandTimeout = 300;

		/// <summary>
		/// Executes SQL against the underlying data source.
		/// </summary>
		/// <param name="sql">The SQL to execute.</param>
		/// <returns>Returns the number of rows affected</returns>
		public static int ExecuteScript(string sql)
		{
			return ExecuteScript(sql, DefaultCommandTimeout);
		}

		/// <summary>
		/// Executes SQL against the underlying data source.
		/// </summary>
		/// <param name="sql">The SQL to execute.</param>
		/// <param name="commandTimeout">Specifies the amount of time in seconds the command is permitted to wait before throwing an exception.</param>
		/// <returns>Returns the number of rows affected</returns>
		public static int ExecuteScript(string sql, int commandTimeout)
		{
			int executeScript = 0;

			if (String.IsNullOrEmpty(sql) == false)
			{
				try
				{
					using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
					{
						SqlMapper.Execute(sqlConnection, sql, commandType: CommandType.Text, commandTimeout: commandTimeout);
					}
				}
				catch (Exception exception)
				{
					OutputStreams.WriteLine();
					OutputStreams.WriteLine(exception.Message);
					OutputStreams.WriteLine();
					OutputStreams.WriteLine(sql);
					OutputStreams.WriteLine();
				}
			}

			return executeScript;
		}
	}
}
