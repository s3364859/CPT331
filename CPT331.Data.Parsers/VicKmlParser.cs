#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;
using System.IO;

#endregion

namespace CPT331.Data.Parsers
{
	public class VicKmlParser : KmlParser
	{
		public VicKmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, VIC)
		{
		}

		internal const string VIC = "VIC";

		protected override void OnParse(string fileName, List<Coordinate> coordinates)
		{
			OutputStreams.WriteLine($"Parsing {VIC} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Document/Placemark");
			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string name = xmlNode.SelectSingleNode("name").InnerText;
				Console.WriteLine(name);
				//	OutputStreams.WriteLine($"Processing {name}...");
				//	
				//	XmlNodeList coordinateXmlNodes = xmlNode.SelectNodes("Polygon/outerBoundaryIs/LinearRing/coordinates | MultiGeometry/Polygon/outerBoundaryIs/LinearRing/coordinates");
				//	string coordinateValues = "";
				//	
				//	foreach (XmlNode coordinateXmlNode in coordinateXmlNodes)
				//	{
				//		coordinateValues = $"{coordinateValues} {coordinateXmlNode.InnerText}";
				//	}
				//	
				//	coordinates.Clear();
				//	
				//	string[] coordinateLines = coordinateValues.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
				//	foreach (string coordinateLine in coordinateLines)
				//	{
				//		string[] coordinateParts = coordinateLine.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
				//	
				//		coordinates.Add(new Coordinate(Double.Parse(coordinateParts[1]), Double.Parse(coordinateParts[0])));
				//	}
				//	
				//	base.Commit(coordinates, name);
			}

			base.OnParse(fileName, coordinates);
		}
	}
}
