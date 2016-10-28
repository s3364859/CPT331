#region Using References

using System;
using System.Text;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a Crime type, used to describe information about a crime.
	/// </summary>
	public class Crime
	{
        /// <summary>
        /// Instantiate a Crime object using the values provided.
        /// </summary>
        /// <param name="count">The number of crimes recorded in a given area, time and category.</param>
        /// <param name="localGovernmentAreaID">An ID number that represents the local goverment area.</param>
        /// <param name="month">The month the crimes were commited.</param>
        /// <param name="offenceID">An ID number representing the type of crime.</param>
        /// <param name="year">The year the crimes were commited</param>
        /// <seealso cref="Crime(int count, int id, int localGovernmentAreaID, int month, int offenceID, int year)"/>
		public Crime(int count, int localGovernmentAreaID, int month, int offenceID, int year)
			: this(count, DateTime.UtcNow, DateTime.UtcNow, -1, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

		/// <summary>
		/// Instantiate a Crime object using the values provided.
		/// </summary>
		/// <param name="count">The number of crimes recorded in a given area, time and category.</param>
		/// <param name="id">The unique ID value.</param>
		/// <param name="localGovernmentAreaID">An ID number that represents the local goverment area.</param>
		/// <param name="month">The month the crimes were commited.</param>
		/// <param name="offenceID">An ID number representing the type of crime.</param>
		/// <param name="year">The year the crimes were commited</param>
		public Crime(int count, int id, int localGovernmentAreaID, int month, int offenceID, int year)
			 : this(count, DateTime.UtcNow, DateTime.UtcNow, id, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

        /// <summary>
        /// Instantiate a Crime object using the values provided.
        /// </summary>
        /// <param name="count">The number of crimes recorded in a given area, time and category.</param>
        /// <param name="dateCreatedUtc">The date when the record was created.</param>
        /// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
        /// <param name="id">An ID number that represents the Crime record.</param>
        /// <param name="isDeleted">A boolean value indicating a deleted record.</param>
        /// <param name="isVisible">A boolean value indicating a hidden record.</param>
        /// <param name="localGovernmentAreaID">An ID number that represents the local goverment area.</param>
        /// <param name="month">The month the crimes were commited.</param>
        /// <param name="offenceID">An ID number representing the type of crime.</param>
        /// <param name="year">The year the crimes were commited</param>
        public Crime(int count, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, int localGovernmentAreaID, int month, int offenceID, int year)
		{
			_count = count;
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_localGovernmentAreaID = localGovernmentAreaID;
			_month = month;
			_offenceID = offenceID;
			_year = year;
		}

		private readonly int _count;
		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly int _localGovernmentAreaID;
		private readonly int _month;
		private readonly int _offenceID;
		private readonly int _year;

		/// <summary>
		/// Gets the crime count value.
		/// </summary>
		public int Count
		{
			get
			{
				return _count;
			}
		}

		/// <summary>
		/// Gets the date the record was created.
		/// </summary>
		public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
		}

		/// <summary>
		/// Gets the date the record was updated.
		/// </summary>
		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
		}

		/// <summary>
		/// Gets the unique ID value of the crime.
		/// </summary>
		public int ID
		{
			get
			{
				return _id;
			}
		}

		/// <summary>
		/// Gets a boolean value indicating whether this record has been soft-deleted.
		/// </summary>
		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
		}

		/// <summary>
		/// Gets a boolean value indicating whether this record should be visible.
		/// </summary>
		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
		}

		/// <summary>
		/// Gets the ID of the related local government area.
		/// </summary>
		public int LocalGovernmentAreaID
		{
			get
			{
				return _localGovernmentAreaID;
			}
		}

		/// <summary>
		/// Gets the month of the crime data.
		/// </summary>
		public int Month
		{
			get
			{
				return _month;
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
		/// Gets the year of the crime data.
		/// </summary>
		public int Year
		{
			get
			{
				return _year;
			}
		}

        /// <summary>
        /// Returns a Hashcode for this instance.
        /// </summary>
        /// <returns>A 32-bit signed integer hash code.</returns>
        public override int GetHashCode()
		{
			return
				_count.GetHashCode() ^
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode() ^
				_localGovernmentAreaID.GetHashCode() ^
				_month.GetHashCode() ^
				_offenceID.GetHashCode() ^
				_year.GetHashCode();
		}
        
        /// <summary>
        /// Returns a value indicating whether this instance is equal to a specified CPT331.Core.ObjectModel.Crime.
        /// </summary>
        /// <param name="obj">A CPT331.Core.ObjectModel.Crime value to compare to this instance.</param>
        /// <returns>True if obj has the same value as this instance; otherwise, false.</returns>
        public override bool Equals(object obj)
		{
			bool equals = false;
			Crime crime = obj as Crime;

			if (crime != null)
			{
				equals =
				(
					(_count == crime._count) &&
					(_dateCreatedUtc == crime._dateCreatedUtc) &&
					(_dateUpdatedUtc == crime._dateUpdatedUtc) &&
					(_id == crime._id) &&
					(_isDeleted == crime._isDeleted) &&
					(_isVisible == crime._isDeleted) &&
					(_localGovernmentAreaID == crime._localGovernmentAreaID) &&
					(_month == crime._month) &&
					(_offenceID == crime._offenceID) &&
					(_year == crime._year)
				);
			}

			return equals;
		}
        
        /// <summary>
        /// Converts the Crime instance to an equivalent string representation.
        /// </summary>
        /// <returns>The string representation of the value of this instance.</returns>
        public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();

			stringBuilder.Append($"{_count}");

			if ((_year > 0) && (_month > 0))
			{
				DateTime dateTime = new DateTime(_year, _month, 1);

				stringBuilder.Append($" ({dateTime.ToString("MMM yyyy")})");
			}

			return stringBuilder.ToString();
		}
	}
}
