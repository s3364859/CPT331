#region Using References

using System;
using System.Data;
using System.Data.SqlClient;

using Dapper;

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
				using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
				{
					SqlMapper.Execute(sqlConnection, sql, commandType: CommandType.Text, commandTimeout: commandTimeout);
				}
			}

			return executeScript;
		}
	}
}
