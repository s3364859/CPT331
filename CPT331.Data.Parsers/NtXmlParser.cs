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
	public class NtXmlParser : XmlParser
	{
		public NtXmlParser(string dataSourceDirectory)
			: base(dataSourceDirectory, NT)
		{
		}

		internal const string NT = "NT";

		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			OutputStreams.WriteLine($"Parsing {NT} data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table");

			State state = StateRepository.GetStateByAbbreviatedName(NT);
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(state.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				XmlNode localGovermentAreaXmlNode = xmlNode.SelectSingleNode("Row[position() = 1]");
				string localGovernmentAreaName = localGovermentAreaXmlNode.InnerText.Trim();
				LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();

				List<DateTime> dateTimeList = new List<DateTime>();
				XmlNodeList datesXmlNodeList = xmlNode.SelectNodes("Row[position() = 2]/Cell[position() > 1]");
				datesXmlNodeList.OfType<XmlNode>().ToList().ForEach(m => dateTimeList.Add(DateTime.Parse(m.InnerText)));

				XmlNodeList offenceXmlNodeList = xmlNode.SelectNodes("Row[position() > 2]");
				foreach (XmlNode offenceXmlNode in offenceXmlNodeList)
				{
					Offence offence = null;
					string offenceName = offenceXmlNode.ChildNodes[0].InnerText.Trim().ToUpper();

					if ((String.IsNullOrEmpty(offenceName) == false) && (offences.ContainsKey(offenceName) == true))
					{
						offence = offences[offenceName];
					}

					for (int i = 0, j = 1; j < offenceXmlNode.ChildNodes.Count; i++, j++)
					{
						int count = Convert.ToInt32(offenceXmlNode.ChildNodes[j].InnerText);
						DateTime dateTime = dateTimeList[i];

						crimes.Add(new Crime(count, localGovernmentArea.ID, dateTime.Month, offence.ID, dateTime.Year));
					}
				}
			}

			base.OnParse(fileName, crimes);
		}
	}
}
