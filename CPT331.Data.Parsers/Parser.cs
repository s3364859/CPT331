#region Using References

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data.Parsers
{
	public class Parser
	{
		public Parser(string fileName)
		{
			_fileName = fileName;
		}

		private readonly string _fileName;

		private void Commit(List<Crime> crimes)
		{
			Console.WriteLine("Beginning commit...");

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

				Console.WriteLine($"  Commiting {crimesToCommit.Count} records, {(crimes.Count - crimesToCommit.Count)} left");

				AdhocScriptRepository.ExecuteScript(stringBuilder.ToString());

				crimes.RemoveRange(0, crimesToCommit.Count);
			}

			Console.WriteLine("Commit completed");
		}

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

		protected virtual void OnParse(string fileName, List<Crime> crimes)
		{
			//	Upstream implementations will need to hydrate this list themselves
		}
	}
}
