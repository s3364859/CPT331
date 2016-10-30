#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a CrimeByCoordinate type, used to describe aggregated information about a crime.
	/// </summary>
	public class CrimeByCoordinate
	{
		/// <summary>
		/// Constructs a new CrimeByCoordinate object.
		/// </summary>
		/// <param name="beginYear">The begin year of the data range.</param>
		/// <param name="endYear">The end year of the data range.</param>
		/// <param name="localGovernmentAreaName">The name of the local government area.</param>
		/// <param name="offenceCount">The number of offences committed.</param>
		/// <param name="offenceID">The ID of the offence.</param>
		/// <param name="offenceName">The name of the offence.</param>
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

		/// <summary>
		/// Gets the begin year of the data range.
		/// </summary>
		public int BeginYear
		{
			get
			{
				return _beginYear;
			}
		}

		/// <summary>
		/// Gets the end year of the data range.
		/// </summary>
		public int EndYear
		{
			get
			{
				return _endYear;
			}
		}

		/// <summary>
		/// Gets the local government area name.
		/// </summary>
		public string LocalGovernmentAreaName
		{
			get
			{
				return _localGovernmentAreaName;
			}
		}

		/// <summary>
		/// Gets the count of offences.
		/// </summary>
		public int OffenceCount
		{
			get
			{
				return _offenceCount;
			}
		}

		/// <summary>
		/// Gets the ID of the related offence.
		/// </summary>
		public int OffenceID
		{
			get
			{
				return _offenceID;
			}
		}

		/// <summary>
		/// Gets the name of the offence.
		/// </summary>
		public string OffenceName
		{
			get
			{
				return _offenceName;
			}
		}

		/// <summary>
		/// Serves as a hash function for a particular type.
		/// </summary>
		/// <returns>A hash code for the current type.</returns>
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

		/// <summary>
		/// Determines object equality.
		/// </summary>
		/// <param name="value">The object to check against.</param>
		/// <returns>Returns true if the object's internals are the same, otherwise false.</returns>
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
