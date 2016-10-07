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
	public class QldXmlParser : Parser
	{
		public QldXmlParser(string fileName)
			: base(fileName)
		{
		}

		protected override void OnParse(string fileName, List<Crime> crimes)
		{
			Console.WriteLine("Parsing QLD data...");

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNode qldXmlNode = xmlDocument.SelectSingleNode("/Workbook/Worksheet/Table/Row[position() = 1]");

			State qldState = StateRepository.GetStateByAbbreviatedName("QLD");
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(qldState.ID);
			Dictionary<string, Offence> offences = new Dictionary<string, Offence>();
			OffenceRepository.GetOffences().ForEach(m => offences.Add(m.Name.ToUpper(), m));

			List<string> offenceNames = new List<string>();
			qldXmlNode.ChildNodes.OfType<XmlNode>().Skip(2).ToList().ForEach(m => offenceNames.Add(m.InnerText));

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");

			foreach (XmlNode xmlNode in xmlNodeList)
			{
				string localGovernmentAreaName = xmlNode.ChildNodes[0].InnerText.Trim();
				string dateTimeValue = xmlNode.ChildNodes[1].InnerText.Trim();

				DateTime dateTime = DateTime.MinValue;

				if (DateTime.TryParse(dateTimeValue, out dateTime) == false)
				{
					//	Can't really use this, but should the whole thing fall over because of it?

					throw new Exception($"Date time parse choked: {dateTimeValue}");
				}

				for (int i = 0, j = 2; i < offenceNames.Count; i++, j++)
				{
					string offenceName = offenceNames[i].ToUpper();
					double countDouble = 0;
					int count = 0;

					//	These must be some kind of averaged data - you can't have half a crime for example.
					if (Double.TryParse(xmlNode.ChildNodes[j].InnerText, out countDouble) == true)
					{
						count = Convert.ToInt32(countDouble);
					}

					LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();
					Offence offence = null;

					if ((String.IsNullOrEmpty(offenceName) == false) && (offences.ContainsKey(offenceName) == true))
					{
						offence = offences[offenceName];
					}

					crimes.Add(new Crime(count, localGovernmentArea.ID, dateTime.Month, offence.ID, dateTime.Year));
				}
			}

			base.OnParse(fileName, crimes);
		}
	}
}
