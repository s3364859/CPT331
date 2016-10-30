#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	/// <summary>
	/// Represents a KmlParser type, used to manipulate KML data from a file.
	/// </summary>
	public class KmlParser
	{
		/// <summary>
		/// Constructs a new KmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the KML data sources.</param>
		/// <param name="state">The name of the state or territory to process.</param>
		public KmlParser(string dataSourceDirectory, string state)
		{
			_dataSourceDirectory = dataSourceDirectory;
			_fileName = Path.Combine(dataSourceDirectory, $"{state}.kml");
			_state = state;
		}

		private const int WGS84Datum = 4326;

		private readonly string _dataSourceDirectory;
		private readonly string _fileName;
		private readonly string _state;

		internal string DataSourceDirectory
		{
			get
			{
				return _dataSourceDirectory;
			}
		}

		/// <summary>
		/// Commits records to the underlying data source.
		/// </summary>
		/// <param name="coordinates">A list of Coordinate objects containing the information used to update.</param>
		/// <param name="name">The name of the local government area.</param>
		protected void Commit(List<Coordinate> coordinates, string name)
		{
			OutputStreams.WriteLine("Beginning commit...");

			if (coordinates[0] != coordinates[coordinates.Count - 1])
			{
				//	The first and last point must be the same
				coordinates.Add(coordinates[0]);
			}

			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.AppendLine($"DECLARE @@StateID INT = (SELECT ID FROM [Location].State WHERE AbbreviatedName = '{_state}')");
			stringBuilder.AppendLine("DECLARE @@LocalGovernmentAreaID INT");
			stringBuilder.AppendLine("DECLARE @@Area GEOGRAPHY");
			stringBuilder.AppendLine();

			stringBuilder.AppendLine($"SET @@LocalGovernmentAreaID = (SELECT ID FROM [Location].LocalGovernmentArea WHERE StateID = @@StateID AND Name = '{name}')");
			stringBuilder.AppendLine();

			stringBuilder.AppendLine("BEGIN TRAN");
			stringBuilder.AppendLine();

			stringBuilder.Append("SET @@Area = GEOGRAPHY::STGeomFromText('POLYGON((");

			coordinates.ForEach(m => stringBuilder.Append($"{m.Longitude} {m.Latitude}{((m == coordinates[coordinates.Count - 1]) ? "" : ", ")} "));
			stringBuilder.AppendLine($"))', {WGS84Datum});");    //	https://msdn.microsoft.com/en-us/library/hh564259.aspx for anyone who is interested in this number
			stringBuilder.AppendLine();

			stringBuilder.AppendLine("UPDATE [Location].LocalGovernmentArea SET Area = @@Area WHERE ID = @@LocalGovernmentAreaID");

			stringBuilder.AppendLine();
			stringBuilder.AppendLine("COMMIT");
			stringBuilder.AppendLine();

			OutputStreams.WriteLine($"Commiting {coordinates.Count} records");

			AdhocScriptRepository.ExecuteScript(stringBuilder.ToString());
		}

		/// <summary>
		/// Begins parsing opertaions on the KML file.
		/// </summary>
		public void Parse()
		{
			if ((String.IsNullOrEmpty(_fileName) == false) && (File.Exists(_fileName) == true))
			{
				List<Coordinate> coordinates = new List<Coordinate>();

				OnParse(_fileName, coordinates);
			}
		}

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the KML information to parse.</param>
		/// <param name="coordinates">The list of Coordinate objects to serialise the KML information into.</param>
		protected virtual void OnParse(string fileName, List<Coordinate> coordinates)
		{
			//	Upstream implementations will need to hydrate this list themselves
		}
	}
}
