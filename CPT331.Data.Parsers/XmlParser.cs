#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

using CPT331.Core.Logging;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	/// <summary>
	/// Represents an XmlParser type, used to manipulate XML data from a file.
	/// </summary>
	public class XmlParser
	{
		/// <summary>
		/// Constructs a new XmlParser object.
		/// </summary>
		/// <param name="dataSourceDirectory">The path to the directory containing the XML data sources.</param>
		/// <param name="state">The name of the state or territory to process.</param>
		public XmlParser(string dataSourceDirectory, string state)
		{
			_fileName = Path.Combine(dataSourceDirectory, $"{state}.xml");
			_state = state;
		}

		private readonly string _fileName;
		private readonly string _state;

		private void Commit(List<Crime> crimes)
		{
			OutputStreams.WriteLine("Beginning commit...");

			//	This takes too long with massive lists
			//	crimes = crimes.Distinct().ToList();

			while (crimes.Count > 0)
			{
				int toTake = 100000;
				List<Crime> crimesToCommit = crimes.Take(toTake).ToList();

				StringBuilder stringBuilder = new StringBuilder();

				stringBuilder.AppendLine();
				stringBuilder.AppendLine("BEGIN TRAN");
				stringBuilder.AppendLine();

				crimesToCommit.ForEach(m => stringBuilder.AppendLine($"EXEC Crime.spAddCrime @LocalGovernmentAreaID = {m.LocalGovernmentAreaID}, @OffenceID = {m.OffenceID}, @Count = {m.Count}, @Month = {m.Month}, @Year = {m.Year}"));

				stringBuilder.AppendLine();
				stringBuilder.AppendLine("COMMIT");
				stringBuilder.AppendLine();

				OutputStreams.WriteLine($"Commiting {crimesToCommit.Count} records, {(crimes.Count - crimesToCommit.Count)} left");

				AdhocScriptRepository.ExecuteScript(stringBuilder.ToString());

				crimes.RemoveRange(0, crimesToCommit.Count);
			}

			OutputStreams.WriteLine("Commit completed");
		}

		/// <summary>
		/// Begins parsing opertaions on the XML file.
		/// </summary>
		public void Parse()
		{
			if ((String.IsNullOrEmpty(_fileName) == false) && (File.Exists(_fileName) == true))
			{
				List<Crime> crimes = new List<Crime>();

				OnParse(_fileName, crimes);

				if (crimes.Count > 0)
				{
					Commit(crimes);
				}
			}
		}

		/// <summary>
		/// Performs parsing operations and constructs a list of Coordinate objects as the result.
		/// </summary>
		/// <param name="fileName">The path to the file containing the XML information to parse.</param>
		/// <param name="crimes">The list of Crime objects to serialise the XML information into.</param>
		protected virtual void OnParse(string fileName, List<Crime> crimes)
		{
			//	Upstream implementations will need to hydrate this list themselves
		}
	}
}
