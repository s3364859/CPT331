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
	public class TasXmlParser : XmlParser
	{
		public TasXmlParser(string dataSourceDirectory)
			 : base(dataSourceDirectory, TAS)
		{
		}

		internal const string TAS = "TAS";

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
