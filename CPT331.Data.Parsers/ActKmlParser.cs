#region Using References

using System;
using System.Collections.Generic;
using System.Xml;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	public class ActKmlParser : KmlParser
	{
		public ActKmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, ACT)
		{
		}

		internal const string ACT = "ACT";

		protected override void OnParse(string fileName, List<Coordinate> coordinates)
		{
			OutputStreams.WriteLine($"Parsing {ACT} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Document/Placemark");
			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string name = xmlNode.SelectSingleNode("name").InnerText;
				OutputStreams.WriteLine($"Processing {name}...");

				XmlNode coordinateXmlNode = xmlNode.SelectSingleNode("Polygon/outerBoundaryIs/LinearRing/coordinates");
				string coordinateValues = coordinateXmlNode.InnerText;

				coordinates.Clear();

				string[] coordinateLines = coordinateValues.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
				foreach (string coordinateLine in coordinateLines)
				{
					string[] coordinateParts = coordinateLine.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

					coordinates.Add(Coordinate.FromValues(Double.Parse(coordinateParts[1]), Double.Parse(coordinateParts[0])));
				}

				base.Commit(coordinates, name);
			}

			base.OnParse(fileName, coordinates);
		}
	}
}
