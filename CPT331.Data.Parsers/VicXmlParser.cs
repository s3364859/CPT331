#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;

using CPT331.Core.Extensions;
using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	/// <summary>
	/// Represents an VicXmlParser type, used to manipulate XML data from a file.
	/// </summary>
	public class VicXmlParser : XmlParser
	{
		/// <summary>
		/// Constructs a new VicXmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the XML data sources.</param>
		public VicXmlParser(string dataSourceDirectory)
			 : base(dataSourceDirectory, VIC)
		{
		}

		internal const string VIC = "VIC";

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the XML information to parse.</param>
		/// <param name="crimes">The list of Crime objects to serialise the XML information into.</param>
		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			OutputStreams.WriteLine($"Parsing {VIC} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");

			//	The dataset I'm working with has a single year - 2014
			int year = 2014;

			State state = DataProvider.StateRepository.GetStateByAbbreviatedName(VIC);
			List<LocalGovernmentArea> localGovernmentAreas = DataProvider.LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(state.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			DataProvider.OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string localGovernmentAreaName = xmlNode.ChildNodes[2].InnerText.Trim();
				string offenceName = xmlNode.ChildNodes[3].InnerText.Trim().ToUpper();
				string suboffenceName = xmlNode.ChildNodes[4].InnerText.Trim().ToUpper();
				int count = Convert.ToInt32(xmlNode.ChildNodes[5].InnerText);

				LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();
				Offence offence = null;

				if ((String.IsNullOrEmpty(offenceName) == false) && (offences.ContainsKey(offenceName) == true))
				{
					offence = offences[offenceName];
				}

				if ((String.IsNullOrEmpty(suboffenceName) == false) && (offences.ContainsKey(offenceName) == true))
				{
					offence = offences[suboffenceName];
				}

				//	We only have crime data per year, so it will always be added in on 01/01/YYYY
				crimes.Add(new Crime(count, localGovernmentArea.ID, 1, offence.ID, year));
			}

			base.OnParse(fileName, crimes);
		}
	}
}
