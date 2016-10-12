#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	public class KmlParser
	{
		public KmlParser(string dataSourceDirectory, string state)
		{
			_fileName = Path.Combine(dataSourceDirectory, $"{state}.kml");
			_state = state;
		}

		private readonly string _fileName;
		private readonly string _state;

		protected void Commit(List<Coordinate> coordinates, string name)
		{
			Console.WriteLine("Beginning commit...");

			coordinates = coordinates.Distinct().ToList();

			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.AppendLine($"DECLARE @@StateID INT = (SELECT ID FROM [Location].State WHERE AbbreviatedName = '{_state}')");
			stringBuilder.AppendLine("DECLARE @@LocalGovernmentArea INT");
			stringBuilder.AppendLine();

			stringBuilder.AppendLine($"SET @@LocalGovernmentArea = (SELECT ID FROM [Location].LocalGovernmentArea WHERE StateID = @@StateID AND Name = '{name}')");
			stringBuilder.AppendLine();

			stringBuilder.AppendLine("BEGIN TRAN");
			stringBuilder.AppendLine();

			coordinates.ForEach(m => stringBuilder.AppendLine($"INSERT INTO [Location].LocalGovernmentAreaBoundary (LocalGovernmentAreaID, Latitude, Longitude) VALUES (@@LocalGovernmentArea, {m.Latitude}, {m.Longitude})"));

			stringBuilder.AppendLine();
			stringBuilder.AppendLine("COMMIT");
			stringBuilder.AppendLine();

			Console.WriteLine($"  Commiting {coordinates.Count} records");

			AdhocScriptRepository.ExecuteScript(stringBuilder.ToString());

			Console.WriteLine("Commit completed");
		}

		public void Parse()
		{
			if ((String.IsNullOrEmpty(_fileName) == false) && (File.Exists(_fileName) == true))
			{
				List<Coordinate> coordinates = new List<Coordinate>();

				OnParse(_fileName, coordinates);
			}
		}

		protected virtual void OnParse(string fileName, List<Coordinate> coordinates)
		{
			//	Upstream implementations will need to hydrate this list themselves
		}
	}
}
