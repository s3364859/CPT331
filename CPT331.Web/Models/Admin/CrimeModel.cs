#region Using References

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class CrimeModel : AdminModel
	{
		public CrimeModel()
		{
		}

		public CrimeModel(int count, int localGovernmentAreaID, int month, int offenceID, int year)
			: this(count, DateTime.UtcNow, DateTime.UtcNow, -1, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

		public CrimeModel(int count, int id, int localGovernmentAreaID, int month, int offenceID, int year)
			 : this(count, DateTime.UtcNow, DateTime.UtcNow, id, false, true, localGovernmentAreaID, month, offenceID, year)
		{
		}

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

		[DataType(DataType.Text)]
		[Display(Name = "Count")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Date Created")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Date Updated")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Deleted")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Visible")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Month")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Offence")]
		[Required(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Year")]
		[Required(ErrorMessage = "*")]
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
