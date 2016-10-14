#region Using References

using System;

#endregion

namespace CPT331.Data.Parsers
{
	public static class ParserFactory
	{
		public static string[] SupportedKmlParserNames =
		{
			ActKmlParser.ACT,
			NswKmlParser.NSW,
			NtKmlParser.NT,
			QldKmlParser.QLD,
			SaKmlParser.SA,
			VicKmlParser.VIC
		};

		public static string[] SupportedXmlParserNames =
		{
			ActXmlParser.ACT,
			NswXmlParser.NSW,
			NtXmlParser.NT,
			QldXmlParser.QLD,
			SaXmlParser.SA,
			VicXmlParser.VIC
		};

		public static KmlParser NewKmlParser(string dataSourceDirectory, string name)
		{
			KmlParser parser = null;

			switch (name.ToUpper())
			{
				case ActKmlParser.ACT:
					parser = new ActKmlParser(dataSourceDirectory);
					break;

				case NswKmlParser.NSW:
					parser = new NswKmlParser(dataSourceDirectory);
					break;

				case NtKmlParser.NT:
					parser = new NtKmlParser(dataSourceDirectory);
					break;

				case QldKmlParser.QLD:
					parser = new QldKmlParser(dataSourceDirectory);
					break;

				case SaKmlParser.SA:
					parser = new SaKmlParser(dataSourceDirectory);
					break;

				case VicKmlParser.VIC:
					parser = new VicKmlParser(dataSourceDirectory);
					break;
			}

			return parser;
		}

		public static XmlParser NewXmlParser(string dataSourceDirectory, string name)
		{
			XmlParser parser = null;

			switch (name.ToUpper())
			{
				case ActXmlParser.ACT:
					parser = new ActXmlParser(dataSourceDirectory);
					break;

				case NswXmlParser.NSW:
					parser = new NswXmlParser(dataSourceDirectory);
					break;

				case NtXmlParser.NT:
					parser = new NtXmlParser(dataSourceDirectory);
					break;

				case QldXmlParser.QLD:
					parser = new QldXmlParser(dataSourceDirectory);
					break;

				case SaXmlParser.SA:
					parser = new SaXmlParser(dataSourceDirectory);
					break;

				case VicXmlParser.VIC:
					parser = new VicXmlParser(dataSourceDirectory);
					break;
			}

			return parser;
		}
	}
}
