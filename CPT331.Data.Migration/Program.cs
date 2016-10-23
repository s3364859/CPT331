#region Using References

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using FluentMigrator.Runner.Announcers;
using FluentMigrator.Runner.Initialization;

using CPT331.Core;
using CPT331.Core.Extensions;
using CPT331.Core.Logging;
using CPT331.Data.Parsers;

using CommandLineParser = CommandLine.Parser;
using KmlDataSourceParser = CPT331.Data.Parsers.KmlParser;
using XmlDataSourceParser = CPT331.Data.Parsers.XmlParser;
using System.IO;

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

		private static void CheckGeography(SqlConnection sqlConnection)
		{
			OutputStreams.WriteLine($"Checking geography...");

			StringBuilder stringBuilder = new StringBuilder();

			//	Automatically correct any geography nasties - this could cause some geography to shift slightly
			stringBuilder.AppendLine("UPDATE Location.LocalGovernmentArea SET Area = Area.MakeValid() WHERE Area.STIsValid() = 0;");

			ExecuteNonQuery(sqlConnection, stringBuilder.ToString());

			OutputStreams.WriteLine("Check completed");
		}

		private static void CreateDatabase(SqlConnection sqlConnection, string databaseName)
		{
			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.AppendLine($"IF NOT EXISTS(SELECT database_id FROM sys.databases WHERE name = '{databaseName}')");
			stringBuilder.AppendLine("BEGIN");
			stringBuilder.AppendLine($"\tCREATE DATABASE [{databaseName}]");
            stringBuilder.AppendLine("END");

            if (_options.SimpleRecoveryModel == true)
            {
                stringBuilder.AppendLine($"ALTER DATABASE [{databaseName}] SET RECOVERY SIMPLE;");
            }

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
					SqlConnectionStringBuilder sqlConnectionStringBuilder = new SqlConnectionStringBuilder(ApplicationConfiguration.Default.CPT331ConnectionString);

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

					//	Import KML data if required
					if (String.IsNullOrEmpty(_options.Kml) == false)
					{
						ProcessKmlDataSources(_options.Kml);

						using (SqlConnection sqlConnection = new SqlConnection(sqlConnectionStringBuilder.ConnectionString))
						{
							sqlConnection.Open();

							CheckGeography(sqlConnection);
						}
					}

					//	Import XML data if required
					if (String.IsNullOrEmpty(_options.Xml) == false)
					{
						ProcessXmlDataSources(_options.Xml);
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

		private static void ProcessKmlDataSources(string dataSources)
		{
			OutputStreams.WriteLine("Processing KML data sources...");

			List<string> dataSourceNames = new List<string>();
			List<KmlDataSourceParser> parsers = new List<KmlDataSourceParser>();

			if (dataSources.EqualsIgnoreCase("ALL") == true)
			{
				dataSourceNames.AddRange(ParserFactory.SupportedKmlParserNames);
			}
			else
			{
				dataSources.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList().ForEach(m => dataSourceNames.Add(m.ToUpper().Trim()));
			}

			dataSourceNames = dataSourceNames.Distinct().OrderBy(m => (m)).ToList();
			dataSourceNames.ForEach(m => parsers.Add(ParserFactory.NewKmlParser(Path.Combine(ApplicationConfiguration.Default.MigrationDataSourceDirectory, "KML Data Sources"), m)));

			parsers.ForEach(m => m.Parse());

			OutputStreams.WriteLine("Processing complete.");
		}

		private static void ProcessXmlDataSources(string dataSources)
		{
			OutputStreams.WriteLine("Processing XML data sources...");

			List<string> dataSourceNames = new List<string>();
			List<XmlDataSourceParser> parsers = new List<XmlDataSourceParser>();

			if (dataSources.EqualsIgnoreCase("ALL") == true)
			{
				dataSourceNames.AddRange(ParserFactory.SupportedXmlParserNames);
			}
			else
			{
				dataSources.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList().ForEach(m => dataSourceNames.Add(m.ToUpper().Trim()));
			}

			dataSourceNames = dataSourceNames.Distinct().OrderBy(m => (m)).ToList();
			dataSourceNames.ForEach(m => parsers.Add(ParserFactory.NewXmlParser(Path.Combine(ApplicationConfiguration.Default.MigrationDataSourceDirectory, "XML Data Sources"), m)));

			parsers.ForEach(m => m.Parse());

			OutputStreams.WriteLine("Processing complete.");
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
