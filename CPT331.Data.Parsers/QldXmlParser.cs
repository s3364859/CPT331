#region Using References

using System;
using System.Collections.Generic;
using System.IO;
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
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.Load(fileName);

			XmlNode qldXmlNode = xmlDocument.SelectSingleNode("/Workbook/Worksheet/Table/Row[position() = 1]");

			State qldState = StateRepository.GetStateByAbbreviatedName("QLD");
			List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(qldState.ID);
			List<Offence> offences = OffenceRepository.GetOffences();

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
					Console.WriteLine($"Date time parse choked: {dateTimeValue}");

					throw new Exception($"Date time parse choked: {dateTimeValue}");
				}

				for (int i = 0, j = 2; i < offenceNames.Count; i++, j++)
				{
					string offenceName = offenceNames[i];
					double countDouble = 0;
					int count = 0;

					//	These must be some kind of averaged data - you can't have half a crime for example.
					if (Double.TryParse(xmlNode.ChildNodes[j].InnerText, out countDouble) == true)
					{
						count = Convert.ToInt32(countDouble);
					}

					//	Console.WriteLine($"{localGovernmentAreaName}: {offenceName} - {count}");

					LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name.EqualsIgnoreCase(localGovernmentAreaName) == true)).FirstOrDefault();
					Offence offence = null;

					if (String.IsNullOrEmpty(offenceName) == false)
					{
						offence = offences.Where(m => (m.Name.EqualsIgnoreCase(offenceName) == true)).FirstOrDefault();
					}

					crimes.Add(new Crime(count, localGovernmentArea.ID, dateTime.Month, offence.ID, dateTime.Year));
				}
			}

			base.OnParse(fileName, crimes);
		}
	}
}
