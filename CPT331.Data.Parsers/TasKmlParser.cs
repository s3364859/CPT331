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
	public class TasKmlParser : KmlParser
	{
		public TasKmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, TAS)
		{
		}

		internal const string TAS = "TAS";

		protected override void OnParse(string fileName, List<Coordinate> coordinates)
		{
			OutputStreams.WriteLine($"Parsing {TAS} data...");

			string name = "Tasmania";
			OutputStreams.WriteLine($"Processing {name}...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Document/Placemark");
			foreach (XmlNode xmlNode in xmlNodeList)
			{
				XmlNodeList coordinateXmlNodes = xmlNode.SelectNodes("Polygon/outerBoundaryIs/LinearRing/coordinates");
				string coordinateValues = "";

				foreach (XmlNode coordinateXmlNode in coordinateXmlNodes)
				{
					coordinateValues = $"{coordinateValues} {coordinateXmlNode.InnerText}";
				}

				string[] coordinateLines = coordinateValues.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
				foreach (string coordinateLine in coordinateLines)
				{
					string coordinateLineValue = coordinateLine
						.Replace(Environment.NewLine, "")
						.Replace("\n", "")
						.Replace("\t", "");

					if (String.IsNullOrEmpty(coordinateLineValue) == false)
					{
						string[] coordinateParts = coordinateLineValue.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

						coordinates.Add(new Coordinate(Double.Parse(coordinateParts[1]), Double.Parse(coordinateParts[0])));
					}
				}

				coordinates.Reverse();

				base.Commit(coordinates, name);
			}

			base.OnParse(fileName, coordinates);
		}
	}
}