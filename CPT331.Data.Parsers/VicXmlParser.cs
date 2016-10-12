#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;

using CPT331.Core.Extensions;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	public class VicXmlParser : Parser
	{
		public VicXmlParser(string fileName)
			 : base(fileName)
		{
			//	Number of offences by geographic area and offence type, year ending December 2014									
		}

		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			Console.WriteLine("Parsing VIC data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");

			//	The dataset I'm working with has a single year - 2014
			int year = 2014;

			State vicState = StateRepository.GetStateByAbbreviatedName("VIC");
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(vicState.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

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
