#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	public class NswXmlParser : Parser
	{
		public NswXmlParser(string fileName)
			: base(fileName)
		{
		}

		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");
			int year = 1995;

			State nswState = StateRepository.GetStateByAbbreviatedName("NSW");
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(nswState.ID);
			List<Offence> offences = OffenceRepository.GetOffences();

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string localGovernmentAreaName = xmlNode.ChildNodes[0].InnerText.Trim();
				string offenceName = xmlNode.ChildNodes[1].InnerText.Trim();
				string suboffenceName = xmlNode.ChildNodes[2].InnerText.Trim();

				//	Console.WriteLine($"{localGovernmentAreaName}: {offenceName} ({suboffenceName})");

				Offence offence = null;
				LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.ToUpper() == localGovernmentAreaName.ToUpper())).FirstOrDefault();

				if (String.IsNullOrEmpty(offenceName) == false)
				{
					offence = offences.Where(m => (m.Name.ToUpper() == offenceName.ToUpper())).FirstOrDefault();
				}

				if (String.IsNullOrEmpty(suboffenceName) == false)
				{
					offence = offences.Where(m => (m.Name.ToUpper() == suboffenceName.ToUpper())).FirstOrDefault();
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
