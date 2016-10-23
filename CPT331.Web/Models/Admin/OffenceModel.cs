#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Web.Validation;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class OffenceModel : AdminModel
    {
        public OffenceModel()
        {
        }

		public OffenceModel(string name)
			: this(DateTime.UtcNow, DateTime.UtcNow, -1, false, true, name)
		{
		}

		public OffenceModel(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
		}

		private DateTime _dateCreatedUtc;
		private DateTime _dateUpdatedUtc;
		private int _id;
		private bool _isDeleted;
		private bool _isVisible;
		private string _name;

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
	}
}