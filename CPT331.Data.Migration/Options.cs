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
