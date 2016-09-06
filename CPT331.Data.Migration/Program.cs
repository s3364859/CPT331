#region Using References

using System;
using System.Data;
using System.Data.SqlClient;

using CommandLine;

using FluentMigrator.Runner.Announcers;
using FluentMigrator.Runner.Initialization;

#endregion

namespace CPT331.Data.Migration
{
	public class Program
	{
		private const int ErrorSuccess = 0;
		private const int ErrorInvalidFunction = 1;
		private const string MigrationNamespace = "CPT331.Data.Migration";

		private static readonly Options _options;

		private static void DropDatabase(SqlConnection sqlConnection, string databaseName)
		{
			string sql = String.Format("DROP DATABASE {0};", databaseName);

			ExecuteNonQuery(sqlConnection, sql);
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
			Console.WriteLine();
			Console.WriteLine("CPT331 Database Migrator.");
			Console.WriteLine();

			try
			{
				if (Parser.Default.ParseArguments(arguments, _options) == true)
				{
					SqlConnectionStringBuilder sqlConnectionStringBuilder = new SqlConnectionStringBuilder(ApplicationConfiguration.CPT331ConnectionString);
					using (SqlConnection sqlConnection = new SqlConnection(sqlConnectionStringBuilder.ConnectionString))
					{
						sqlConnection.Open();

						bool isDrop = false;

						if ((Boolean.TryParse(_options.Drop, out isDrop) == true) && (isDrop == true))
						{
							DropDatabase(sqlConnection, sqlConnectionStringBuilder.InitialCatalog);

							Console.WriteLine("Database dropped.");
						}

						RunMigration(sqlConnection);
					}
				}

				Environment.ExitCode = ErrorSuccess;
			}
			catch (Exception exception)
			{
				while (exception != null)
				{
					Console.WriteLine(exception.Message);
					Console.WriteLine(exception.StackTrace);
					Console.WriteLine();

					exception = exception.InnerException;
				}

				Environment.ExitCode = ErrorInvalidFunction;
			}

			Console.WriteLine();
			Console.WriteLine("Process complete.");
			Console.WriteLine();
		}

		private static void RunMigration(SqlConnection sqlConnection)
		{
			if ((sqlConnection != null) && (String.IsNullOrEmpty(sqlConnection.ConnectionString) == false))
			{
				ConsoleAnnouncer consoleAnnouncer = new ConsoleAnnouncer { ShowSql = true };
				RunnerContext runnerContext = new RunnerContext(consoleAnnouncer)
				{
					Targets = new[] { MigrationNamespace },
					Connection = sqlConnection.ConnectionString,
					PreviewOnly = false
				};

				TaskExecutor taskExecutor = new TaskExecutor(runnerContext);
				taskExecutor.Execute();
			}
		}
	}
}
