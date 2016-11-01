#region Using References

using System;

#endregion

namespace CPT331.Data.Parsers
{
	/// <summary>
	/// Represents a ParserFactory type, used to construct KmlParser and XmlParser objects from the corresponding name definition.
	/// </summary>
	public static class ParserFactory
	{
		/// <summary>
		/// Defines a list of supported KML parser name definitionss.
		/// </summary>
		public static string[] SupportedKmlParserNames =
		{
			ActKmlParser.ACT,
			NswKmlParser.NSW,
			NtKmlParser.NT,
			QldKmlParser.QLD,
			SaKmlParser.SA,
			TasKmlParser.TAS,
			VicKmlParser.VIC,
			WaKmlParser.WA
		};

		/// <summary>
		/// Defines a list of supported XML parser name definitionss.
		/// </summary>
		public static string[] SupportedXmlParserNames =
		{
			ActXmlParser.ACT,
			NswXmlParser.NSW,
			NtXmlParser.NT,
			QldXmlParser.QLD,
			SaXmlParser.SA,
			TasXmlParser.TAS,
			VicXmlParser.VIC,
			WaXmlParser.WA
		};

		/// <summary>
		/// Constructs new KmlParser objects from the corresponding name definition.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the KML data sources.</param>
		/// <param name="name">The supported KmlParser name definition.</param>
		/// <returns>Returns a new KmlParser object for a successful operation, otherwise null.</returns>
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

				case TasKmlParser.TAS:
					parser = new TasKmlParser(dataSourceDirectory);
					break;

				case VicKmlParser.VIC:
					parser = new VicKmlParser(dataSourceDirectory);
					break;

				case WaKmlParser.WA:
					parser = new WaKmlParser(dataSourceDirectory);
					break;
			}

			return parser;
		}

		/// <summary>
		/// Constructs new XmlParser objects from the corresponding name definition.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the KML data sources.</param>
		/// <param name="name">The supported XmlParser name definition.</param>
		/// <returns>Returns a new XmlParser object for a successful operation, otherwise null.</returns>
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

				case TasXmlParser.TAS:
					parser = new TasXmlParser(dataSourceDirectory);
					break;

				case VicXmlParser.VIC:
					parser = new VicXmlParser(dataSourceDirectory);
					break;

				case WaXmlParser.WA:
					parser = new WaXmlParser(dataSourceDirectory);
					break;
			}

			return parser;
		}
	}
}
