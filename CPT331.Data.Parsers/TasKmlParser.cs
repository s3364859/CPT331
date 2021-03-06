﻿#region Using References

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
	/// <summary>
	/// Represents a TasKmlParser type, used to manipulate KML data from a file.
	/// </summary>
	public class TasKmlParser : KmlParser
	{
		/// <summary>
		/// Constructs a new TasKmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the KML data sources.</param>
		public TasKmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, TAS)
		{
		}

		internal const string TAS = "TAS";

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the KML information to parse.</param>
		/// <param name="coordinates">The list of Coordinate objects to serialise the KML information into.</param>
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

						coordinates.Add(Coordinate.FromValues(Double.Parse(coordinateParts[1]), Double.Parse(coordinateParts[0])));
					}
				}

				base.Commit(coordinates, name);
			}

			base.OnParse(fileName, coordinates);
		}
	}
}