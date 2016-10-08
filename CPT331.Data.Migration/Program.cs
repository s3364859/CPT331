#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using CommandLine;

using FluentMigrator.Runner.Announcers;
using FluentMigrator.Runner.Initialization;

using CPT331.Core;
using CPT331.Core.Extensions;
using CPT331.Core.Logging;
using CPT331.Data.Parsers;

using CommandLineParser = CommandLine.Parser;
using XmlDataSourceParser = CPT331.Data.Parsers.Parser;

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
				if (CommandLineParser.Default.ParseArguments(arguments, _options) == true)
				{
					SqlConnectionStringBuilder sqlConnectionStringBuilder = new SqlConnectionStringBuilder(ApplicationConfiguration.CPT331ConnectionString);

					string targetDatabase = sqlConnectionStringBuilder.InitialCatalog;

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

					//	Import data if required
					if (String.IsNullOrEmpty(_options.Process) == false)
					{
						OutputStreams.WriteLine("Processing XML data sources...");

						ProcessXmlDataSources(_options.Process);

						OutputStreams.WriteLine("Processing complete.");
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

		private static void ProcessXmlDataSources(string dataSources)
		{
			List<string> dataSourceNames = new List<string>();
			List<XmlDataSourceParser> parsers = new List<XmlDataSourceParser>();

			if (dataSources.EqualsIgnoreCase("ALL") == true)
			{
				dataSourceNames.AddRange(ParserFactory.SupportedParserNames);
			}
			else
			{
				dataSources.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList().ForEach(m => dataSourceNames.Add(m.ToUpper().Trim()));
			}

			dataSourceNames = dataSourceNames.Distinct().OrderBy(m => (m)).ToList();
			dataSourceNames.ForEach(m => parsers.Add(ParserFactory.NewParser(ApplicationConfig.Default.CrimeDataFolder, m)));

			parsers.AsParallel().ForAll(m => m.Parse());
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
