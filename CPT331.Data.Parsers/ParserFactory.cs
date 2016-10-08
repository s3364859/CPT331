#region Using References

using System;

#endregion

namespace CPT331.Data.Parsers
{
	public static class ParserFactory
	{
		public static string[] SupportedParserNames =
		{
			ActXmlParser.ACT,
			NswXmlParser.NSW,
			NtXmlParser.NT,
			QldXmlParser.QLD,
			VicXmlParser.VIC
		};

		public static Parser NewParser(string dataSourceDirectory, string name)
		{
			Parser parser = null;

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

				case VicXmlParser.VIC:
					parser = new VicXmlParser(dataSourceDirectory);
					break;
			}

			return parser;
		}
	}
}
