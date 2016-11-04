#region Using References

using System;
using System.Collections.Generic;
using System.Xml;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;
using System.Reflection;
using System.IO;

#endregion

namespace CPT331.Data.Parsers
{
	/// <summary>
	/// Represents a NtKmlParser type, used to manipulate KML data from a file.
	/// </summary>
	public class NtKmlParser : KmlParser
	{
		/// <summary>
		/// Constructs a new NtKmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the KML data sources.</param>
		public NtKmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, NT)
		{
		}

		internal const string NT = "NT";
        private const string GeographyNTBalanceResource = "CPT331.Data.Parsers.Resources.GeographyNTBalance.sql";

        /// <summary>
        /// Performs parsing operations and constructs a list of Coordinate objects as the result.
        /// </summary>
        /// <param name="fileName">The path to the file containing the KML information to parse.</param>
        /// <param name="coordinates">The list of Coordinate objects to serialise the KML information into.</param>
        protected override void OnParse(string fileName, List<Coordinate> coordinates)
		{
			OutputStreams.WriteLine($"Parsing {NT} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Document/Placemark");
			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string name = xmlNode.SelectSingleNode("ExtendedData/Data[@name = 'Region']").InnerText;
				OutputStreams.WriteLine($"Processing {name}...");

				XmlNodeList coordinateXmlNodes = xmlNode.SelectNodes("Polygon/outerBoundaryIs/LinearRing/coordinates | MultiGeometry/Polygon/outerBoundaryIs/LinearRing/coordinates");
				string coordinateValues = "";

				foreach (XmlNode coordinateXmlNode in coordinateXmlNodes)
				{
					coordinateValues = $"{coordinateValues} {coordinateXmlNode.InnerText}".Trim();
				}

				coordinates.Clear();

				string[] coordinateLines = coordinateValues.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
				foreach (string coordinateLine in coordinateLines)
				{
					string[] coordinateParts = coordinateLine.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

					coordinates.Add(Coordinate.FromValues(Double.Parse(coordinateParts[1]), Double.Parse(coordinateParts[0])));
				}

				base.Commit(coordinates, name);
			}

            BuildNTBalanceLocalGovernmentArea();

            base.OnParse(fileName, coordinates);
		}

        private void BuildNTBalanceLocalGovernmentArea()
        {
            var assembly = Assembly.GetExecutingAssembly();
            string ntBalanceQuery;
            using (Stream stream = assembly.GetManifestResourceStream(GeographyNTBalanceResource))
            using (StreamReader reader = new StreamReader(stream))
            {
                ntBalanceQuery = reader.ReadToEnd();
            }
            DataProvider.AdhocScriptRepository.ExecuteScript(ntBalanceQuery);
        }
	}
}
