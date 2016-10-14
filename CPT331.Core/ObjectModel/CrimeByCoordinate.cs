#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class CrimeByCoordinate
	{
		public CrimeByCoordinate(int beginYear, int endYear, string localGovernmentAreaName, int offenceCount, int offenceID, string offenceName)
		{
			_beginYear = beginYear;
			_endYear = endYear;
			_localGovernmentAreaName = localGovernmentAreaName;
			_offenceCount = offenceCount;
			_offenceID = offenceID;
			_offenceName = offenceName;
		}

		private readonly int _beginYear;
		private readonly int _endYear;
		private readonly string _localGovernmentAreaName;
		private readonly int _offenceCount;
		private readonly int _offenceID;
		private readonly string _offenceName;

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

		public string LocalGovernmentAreaName
		{
			get
			{
				return _localGovernmentAreaName;
			}
		}

		public int OffenceCount
		{
			get
			{
				return _offenceCount;
			}
		}

		public int OffenceID
		{
			get
			{
				return _offenceID;
			}
		}

		public string OffenceName
		{
			get
			{
				return _offenceName;
			}
		}

		public override int GetHashCode()
		{
			return
				_beginYear.GetHashCode() ^
				_endYear.GetHashCode() ^
				_localGovernmentAreaName.GetHashCode() ^
				_offenceCount.GetHashCode() ^
				_offenceID.GetHashCode() ^
				_offenceName.GetHashCode();
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			CrimeByCoordinate crimeByCoordinate = value as CrimeByCoordinate;

			if (crimeByCoordinate != null)
			{
				equals =
				(
					(_beginYear == crimeByCoordinate._beginYear) &&
					(_endYear == crimeByCoordinate._endYear) &&
					(_localGovernmentAreaName == crimeByCoordinate._localGovernmentAreaName) &&
					(_offenceCount == crimeByCoordinate._offenceCount) &&
					(_offenceID == crimeByCoordinate._offenceID) &&
					(_offenceName == crimeByCoordinate._offenceName)
				);
			}

			return equals;
		}
	}
}
