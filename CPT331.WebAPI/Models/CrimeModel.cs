#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Crime")]
	public class CrimeModel
	{
		public CrimeModel(int count, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, int localGovernmentAreaID, int month, int offenceID, int year)
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

		private int _count;
		private DateTime _dateCreatedUtc;
		private DateTime _dateUpdatedUtc;
		private int _id;
		private bool _isDeleted;
		private bool _isVisible;
		private int _localGovernmentAreaID;
		private int _month;
		private int _offenceID;
		private int _year;

		[DataMember]
		public int Count
		{
			get
			{
				return _count;
			}
			set
			{
				_count = value;
			}
		}

		[DataMember]
		public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
			set
			{
				_dateCreatedUtc = value;
			}
		}

		[DataMember]
		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
			set
			{
				_dateUpdatedUtc = value;
			}
		}

		[DataMember]
		public int ID
		{
			get
			{
				return _id;
			}
			set
			{
				_id = value;
			}
		}

		[DataMember]
		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
			set
			{
				_isDeleted = value;
			}
		}

		[DataMember]
		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
			set
			{
				_isVisible = value;
			}
		}

		[DataMember]
		public int LocalGovernmentAreaID
		{
			get
			{
				return _localGovernmentAreaID;
			}
			set
			{
				_localGovernmentAreaID = value;
			}
		}

		[DataMember]
		public int Month
		{
			get
			{
				return _month;
			}
			set
			{
				_month = value;
			}
		}

		[DataMember]
		public int OffenceID
		{
			get
			{
				return _offenceID;
			}
			set
			{
				_offenceID = value;
			}
		}

		[DataMember]
		public int Year
		{
			get
			{
				return _year;
			}
			set
			{
				_year = value;
			}
		}
	}
}
