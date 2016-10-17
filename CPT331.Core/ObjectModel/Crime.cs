#region Using References

using System;
using System.Text;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class Crime
	{
		public Crime(int count, int localGovernmentAreaID, int month, int offenceID, int year)
			: this(count, DateTime.UtcNow, DateTime.UtcNow, -1, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

		public Crime(int count, int id, int localGovernmentAreaID, int month, int offenceID, int year)
			 : this(count, DateTime.UtcNow, DateTime.UtcNow, id, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

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

		public int Count
		{
			get
			{
				return _count;
			}
		}

		public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
		}

		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
		}

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
		}

		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
		}

		public int LocalGovernmentAreaID
		{
			get
			{
				return _localGovernmentAreaID;
			}
		}

		public int Month
		{
			get
			{
				return _month;
			}
		}

		public int OffenceID
		{
			get
			{
				return _offenceID;
			}
		}

		public int Year
		{
			get
			{
				return _year;
			}
		}

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

		public override bool Equals(object value)
		{
			bool equals = false;
			Crime crime = value as Crime;

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
