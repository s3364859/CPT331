#region Using References

using System;
using System.Collections.Generic;

#endregion

namespace CPT331.WebAPI.Models
{
	public class CrimeByLocationModel
	{
		public CrimeByLocationModel(int beginYear, int endYear, string name, Dictionary<string, double> offences)
		{
			_beginYear = beginYear;
			_endYear = endYear;
			_name = name;
			_offences = offences;
		}

		private readonly int _beginYear;
		private readonly int _endYear;
		private readonly string _name;
		private readonly Dictionary<string, double> _offences;

		public int BeginYear
		{
			get
			{
				return _beginYear;
			}
		}

		public int EndYear
		{
			get
			{
				return _endYear;
			}
		}

		public string Name
		{
			get
			{
				return _name;
			}
		}

		public Dictionary<string, double> Offences
		{
			get
			{
				return _offences;
			}
		}
	}
}
