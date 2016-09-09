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
		private string _password;
		private string _username;

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

		[Option('p', "password", Required = true, HelpText = "The password for the credentials used to create the database.")]
		public string Password
		{
			get
			{
				return _password;
			}
			set
			{
				_password = value;
			}
		}

		[Option('u', "username", Required = true, HelpText = "The username for the credentials used to create the database.")]
		public string Username
		{
			get
			{
				return _username;
			}
			set
			{
				_username = value;
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
