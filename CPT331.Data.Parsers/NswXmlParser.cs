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
	/// Represents an NswXmlParser type, used to manipulate XML data from a file.
	/// </summary>
	public class NswXmlParser : XmlParser
	{
		/// <summary>
		/// Constructs a new NswXmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the XML data sources.</param>
		public NswXmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, NSW)
		{
		}

		internal const string NSW = "NSW";

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the XML information to parse.</param>
		/// <param name="crimes">The list of Crime objects to serialise the XML information into.</param>
		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			OutputStreams.WriteLine($"Parsing {NSW} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");
			int year = 1995;

			State state = DataProvider.StateRepository.GetStateByAbbreviatedName(NSW);
			List<LocalGovernmentArea> localGovernmentAreas = DataProvider.LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(state.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			DataProvider.OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string localGovernmentAreaName = xmlNode.ChildNodes[0].InnerText.Trim();
				string offenceName = xmlNode.ChildNodes[1].InnerText.Trim().ToUpper();
				string suboffenceName = xmlNode.ChildNodes[2].InnerText.Trim().ToUpper();

				Offence offence = null;
				LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();

				if ((String.IsNullOrEmpty(offenceName) == false) && (offences.ContainsKey(offenceName) == true))
				{
					offence = offences[offenceName];
				}

				if ((String.IsNullOrEmpty(suboffenceName) == false) && (offences.ContainsKey(offenceName) == true))
				{
					offence = offences[suboffenceName];
				}

				DateTime dateTime = new DateTime(year, 1, 1);

				for (int i = 3; i < xmlNode.ChildNodes.Count; i++)
				{
					int count = Convert.ToInt32(xmlNode.ChildNodes[i].InnerText);

					crimes.Add(new Crime(count, localGovernmentArea.ID, dateTime.Month, offence.ID, dateTime.Year));

					dateTime = dateTime.AddMonths(1);
				}
			}

			base.OnParse(fileName, crimes);
		}
	}
}
