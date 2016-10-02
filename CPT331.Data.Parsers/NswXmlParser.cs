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
	public class NswXmlParser
	{
		public NswXmlParser(string filename)
		{
			_filename = filename;
		}

		private readonly string _filename;

		public void Parse()
		{
			if ((String.IsNullOrEmpty(_filename) == false) && (File.Exists(_filename) == true))
			{
				XmlDocument xmlDocument = new XmlDocument();
				xmlDocument.Load(_filename);

				XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/Workbook/Worksheet/Table/Row[position() > 1]");
				int year = 1995;

				State nswState = StateRepository.GetStateByAbbreviatedName("NSW");
				List<LocalGovernmentArea> localGovernmentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreasByStateID(nswState.ID);
				List<Offence> offences = OffenceRepository.GetOffences();

				List<Crime> crimes = new List<Crime>();

				foreach (XmlNode xmlNode in xmlNodeList)
				{
					string localGovernmentAreaName = xmlNode.ChildNodes[0].InnerText.Trim();
					string offenceName = xmlNode.ChildNodes[1].InnerText.Trim();
					string suboffenceName = xmlNode.ChildNodes[2].InnerText.Trim();

					Console.WriteLine($"{localGovernmentAreaName}: {offenceName} ({suboffenceName})");

					LocalGovernmentArea localGovernmentArea = localGovernmentAreas.Where(m => (m.Name == localGovernmentAreaName)).FirstOrDefault();
					Offence offence = null;

					if (String.IsNullOrEmpty(offenceName) == false)
					{
						offence = offences.Where(m => (m.Name == offenceName)).FirstOrDefault();
					}

					if (String.IsNullOrEmpty(suboffenceName) == false)
					{
						offence = offences.Where(m => (m.Name == suboffenceName)).FirstOrDefault();
					}

					DateTime dateTime = new DateTime(year, 1, 1);

					for (int i = 3; i < xmlNode.ChildNodes.Count; i++)
					{
						int count = Convert.ToInt32(xmlNode.ChildNodes[i].InnerText);

						CrimeRepository.AddCrime(count, localGovernmentArea.ID, dateTime.Month, offence.ID, dateTime.Year);

						dateTime = dateTime.AddMonths(1);
					}
				}
			}
		}
	}
}
