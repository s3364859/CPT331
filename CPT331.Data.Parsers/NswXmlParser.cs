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
	public class NswXmlParser : Parser
	{
		public NswXmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, NSW)
		{
		}

		internal const string NSW = "NSW";

		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			Console.WriteLine($"Parsing {NSW} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");
			int year = 1995;

			State nswState = StateRepository.GetStateByAbbreviatedName(NSW);
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(nswState.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

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
