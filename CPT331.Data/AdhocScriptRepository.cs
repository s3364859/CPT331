#region Using References

using System;
using System.Data;
using System.Data.SqlClient;

using Dapper;

using CPT331.Core.Logging;

#endregion

namespace CPT331.Data
{
	public static class AdhocScriptRepository
	{
		private const int DefaultCommandTimeout = 300;

		public static int ExecuteScript(string sql)
		{
			return ExecuteScript(sql, DefaultCommandTimeout);
		}

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
