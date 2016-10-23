#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Web.Validation;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class LocalGovernmentAreaModel : AdminModel
	{
		public LocalGovernmentAreaModel()
		{
		}

		public LocalGovernmentAreaModel(int id, string name, int stateID)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID)
		{
		}

		public LocalGovernmentAreaModel(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
			_stateID = stateID;
		}

		private DateTime _dateCreatedUtc;
		private DateTime _dateUpdatedUtc;
		private int _id;
		private bool _isDeleted;
		private bool _isVisible;
		private string _name;
		private int _stateID;

		[DataType(DataType.DateTime)]
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

		[DataType(DataType.DateTime)]
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

		[Integer(ErrorMessage = "*")]
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

		[DataType(DataType.Text)]
		[Display(Name = "Name")]
		[Required(ErrorMessage = "*")]
		[StringLength(100, ErrorMessage = "*")]
		public string Name
		{
			get
			{
				return _name;
			}
			set
			{
				_name = value;
			}
		}

		[DataType(DataType.Text)]
		[Display(Name = "State")]
		[Integer(ErrorMessage = "*")]
		[Required(ErrorMessage = "*")]
		[State(ErrorMessage = "*")]
		public int StateID
		{
			get
			{
				return _stateID;
			}
			set
			{
				_stateID = value;
			}
		}
	}
}