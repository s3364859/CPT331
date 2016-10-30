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
	/// Represents an TasXmlParser type, used to manipulate XML data from a file.
	/// </summary>
	public class TasXmlParser : XmlParser
	{
		/// <summary>
		/// Constructs a new TasXmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the XML data sources.</param>
		public TasXmlParser(string dataSourceDirectory)
			 : base(dataSourceDirectory, TAS)
		{
		}

		internal const string TAS = "TAS";

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the XML information to parse.</param>
		/// <param name="crimes">The list of Crime objects to serialise the XML information into.</param>
		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			OutputStreams.WriteLine($"Parsing {TAS} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");

			State state = StateRepository.GetStateByAbbreviatedName(TAS);
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(state.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				//	string localGovernmentAreaName = xmlNode.ChildNodes[0].InnerText.Trim();
				string localGovernmentAreaName = "Tasmania";
				string offenceName = xmlNode.ChildNodes[0].InnerText.Trim().ToUpper();

				LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();
				Offence offence = null;
				
				if ((String.IsNullOrEmpty(offenceName) == false) && (offences.ContainsKey(offenceName) == true))
				{
					offence = offences[offenceName];
				}
				
				for (int i = 1, j = 2005; i < (xmlNode.ChildNodes.Count - 1); i++, j++)
				{
					int count = Convert.ToInt32(xmlNode.ChildNodes[i].InnerText);
				
					crimes.Add(new Crime(count, localGovernmentArea.ID, 1, offence.ID, j));
				}
			}

			base.OnParse(fileName, crimes);
		}
	}
}
