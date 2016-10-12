#region Using References

using System;

using CommandLine;
using CommandLine.Text;

#endregion

namespace CPT331.Data.Migration
{
	internal class Options
	{
		private string _drop;
		private string _kml;
		private string _xml;
        private bool _simpleRecoveryModel;
		private IParserState _lastParserState;

		[Option('d', "drop", Required = false, HelpText = "Drop the database and recreate it. Use this option for the initial database creation.")]
		public string Drop
		{
			get
			{
				return _drop;
			}
			set
			{
				_drop = value;
			}
		}

		[Option('k', "kml", Required = false, HelpText = "Process the KML data sources. Use this option to hydrate an empty database.")]
		public string Kml
		{
			get
			{
				return _kml;
			}
			set
			{
				_kml = value;
			}
		}

		[Option('x', "xml", Required = false, HelpText = "Process the XML data sources. Use this option to hydrate an empty database.")]
		public string Xml
		{
			get
			{
				return _xml;
			}
			set
			{
				_xml = value;
			}
		}
        
        [Option('s', "simplelog", Required = false, HelpText = "Use simple transaction log when creating database. Use this option for the development databases.")]
        public bool SimpleRecoveryModel
        {
            get
            {
                return _simpleRecoveryModel;
            }
            set
            {
                _simpleRecoveryModel = value;
            }
        }


		[ParserState]
		public IParserState LastParserState
		{
			get
			{
				return _lastParserState;
			}
			set
			{
				_lastParserState = value;
			}
		}

		[HelpOption]
		public string GetUsage()
		{
			return HelpText.AutoBuild(this, current => HelpText.DefaultParsingErrorsHandler(this, current));
		}
	}
}
