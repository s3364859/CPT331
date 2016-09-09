#region Using References

using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

using CommandLine;

using FluentMigrator.Runner.Announcers;
using FluentMigrator.Runner.Initialization;

using CPT331.Core;
using CPT331.Core.Logging;

#endregion

namespace CPT331.Data.Migration
{
	public class Program
	{
		static Program()
		{
			_options = new Options();
		}

		private const int ErrorSuccess = 0;
		private const int ErrorInvalidFunction = 1;
		private const string MigrationNamespace = "CPT331.Data.Migration";

		private static readonly Options _options;

		private static void CreateDatabase(SqlConnection sqlConnection, string databaseName)
		{
			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.AppendLine($"IF NOT EXISTS(SELECT database_id FROM sys.databases WHERE name = '{databaseName}')");
			stringBuilder.AppendLine("BEGIN");
			stringBuilder.AppendLine($"\tCREATE DATABASE [{databaseName}]");
			stringBuilder.AppendLine("END");

			ExecuteNonQuery(sqlConnection, stringBuilder.ToString());
		}

		private static void DropDatabase(SqlConnection sqlConnection, string databaseName)
		{
			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.AppendLine($"IF EXISTS(SELECT database_id FROM sys.databases WHERE name = '{databaseName}')");
			stringBuilder.AppendLine("BEGIN");
			stringBuilder.AppendLine($"\tDROP DATABASE [{databaseName}]");
			stringBuilder.AppendLine("END");

			ExecuteNonQuery(sqlConnection, stringBuilder.ToString());
		}

		private static void ExecuteNonQuery(SqlConnection sqlConnection, string sql)
		{
			using (SqlCommand sqlCommand = sqlConnection.CreateCommand())
			{
				sqlCommand.CommandType = CommandType.Text;
				sqlCommand.CommandText = sql;

				sqlCommand.ExecuteNonQuery();
			}
		}

		public static void Main(string[] arguments)
		{
			OutputStreams.WriteLine();
			OutputStreams.WriteLine("CPT331 Database Migrator");
			OutputStreams.WriteLine();

			try
			{
				if (Parser.Default.ParseArguments(arguments, _options) == true)
				{
					SqlConnectionStringBuilder sqlConnectionStringBuilder = new SqlConnectionStringBuilder(ApplicationConfiguration.CPT331ConnectionString);

					string targetDatabase = sqlConnectionStringBuilder.InitialCatalog;
					sqlConnectionStringBuilder.UserID = _options.Username;
					sqlConnectionStringBuilder.Password = _options.Password;

					//	Switch over to master db to do admin type stuff
					sqlConnectionStringBuilder.InitialCatalog = "master";

					using (SqlConnection sqlConnection = new SqlConnection(sqlConnectionStringBuilder.ConnectionString))
					{
						sqlConnection.Open();

						bool isDrop = false;

						if ((Boolean.TryParse(_options.Drop, out isDrop) == true) && (isDrop == true))
						{
							OutputStreams.WriteLine("Dropping database...");

							DropDatabase(sqlConnection, targetDatabase);

							OutputStreams.WriteLine("Database dropped.");
						}

						CreateDatabase(sqlConnection, targetDatabase);
					}

					//	Switch back to target db to run migrations
					sqlConnectionStringBuilder.InitialCatalog = targetDatabase;

					using (SqlConnection sqlConnection = new SqlConnection(sqlConnectionStringBuilder.ConnectionString))
					{
						RunMigration(sqlConnection);
					}
				}

				Environment.ExitCode = ErrorSuccess;
			}
			catch (Exception exception)
			{
				while (exception != null)
				{
					OutputStreams.WriteLine(exception.Message);
					OutputStreams.WriteLine(exception.StackTrace);
					OutputStreams.WriteLine();

					exception = exception.InnerException;
				}

				Environment.ExitCode = ErrorInvalidFunction;
			}

			OutputStreams.WriteLine();
			OutputStreams.WriteLine("Process complete.");
			OutputStreams.WriteLine();
		}

		private static void RunMigration(SqlConnection sqlConnection)
		{
			if ((sqlConnection != null) && (String.IsNullOrEmpty(sqlConnection.ConnectionString) == false))
			{
				ConsoleAnnouncer consoleAnnouncer = new ConsoleAnnouncer { ShowSql = true };
				RunnerContext runnerContext = new RunnerContext(consoleAnnouncer)
				{
					Targets = new[] { MigrationNamespace },
					Database = "SqlServer",
					Connection = sqlConnection.ConnectionString,
					PreviewOnly = false
				};

				TaskExecutor taskExecutor = new TaskExecutor(runnerContext);
				taskExecutor.Execute();
			}
		}
	}
}
