#region Using References

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

using Dapper;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;
using System.Reflection;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents a Repository type, used to manipulate data.
	/// </summary>
	public class Repository
	{
		/// <summary>
		/// Defines the amount of time in seconds that a command operation should wait before timing out.
		/// </summary>
		public const int DefaultCommandTimeout = 300;

		/// <summary>
		/// Executes SQL against the underlying data source.
		/// </summary>
		/// <param name="sql">The SQL to execute.</param>
		/// <returns>Returns the number of rows affected</returns>
		public int ExecuteScript(string sql)
		{
			return ExecuteScript(sql, DefaultCommandTimeout);
		}

		/// <summary>
		/// Executes SQL against the underlying data source.
		/// </summary>
		/// <param name="sql">The SQL to execute.</param>
		/// <param name="commandTimeout">Specifies the amount of time in seconds the command is permitted to wait before throwing an exception.</param>
		/// <returns>Returns the number of rows affected</returns>
		public int ExecuteScript(string sql, int commandTimeout)
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

		/// <summary>
		/// Begins an export operation to a stream.
		/// </summary>
		/// <param name="stream">The stream to export to.</param>
		public void Export(Stream stream)
		{
			if (stream != null)
			{
				List<ReadOnlyDataObject> readOnlyDataObjects = new List<ReadOnlyDataObject>();

				OnExport(readOnlyDataObjects, stream);
			}
		}

		/// <summary>
		/// Exports a list of ReadOnlyDataObject types to a stream.
		/// </summary>
		/// <param name="readOnlyDataObjects">The list of ReadOnlyDataObject objects to export.</param>
		/// <param name="stream">The stream to export the ReadOnlyDataObject list to.</param>
		protected virtual void OnExport(List<ReadOnlyDataObject> readOnlyDataObjects, Stream stream)
		{
			if ((readOnlyDataObjects != null) && (readOnlyDataObjects.Count > 0))
			{
				using (StreamWriter streamWriter = new StreamWriter(stream))
				{
					ReadOnlyDataObject headerReadOnlyDataObject = readOnlyDataObjects[0];
					List<PropertyInfo> propertyInfos = headerReadOnlyDataObject.GetType().GetProperties().ToList<PropertyInfo>();

					//	Header
					propertyInfos.ForEach(m => streamWriter.Write($"{m.Name},"));
					streamWriter.WriteLine();

					// Rows

					foreach (ReadOnlyDataObject readOnlyDataObject in readOnlyDataObjects)
					{
						propertyInfos.ForEach(m => streamWriter.Write($"\"{m.GetValue(readOnlyDataObject)}\","));
						streamWriter.WriteLine();
					}
				}
			}
		}
	}
}
