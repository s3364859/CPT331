#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Web.Validation;

#endregion

namespace CPT331.Web.Models.Admin
{
    /// <summary>
    /// A representation of the LocalGovernmentArea model that services the MVC framework. 
    /// </summary>
	public class LocalGovernmentAreaModel : AdminModel
    {
        #region Constructors
        /// <summary>
        /// Creates an instance of LocalGovernmentAreaModel using default values.
        /// </summary>
        public LocalGovernmentAreaModel()
		{
		}

        /// <summary>
        /// Creates an instance of LocalGovernmentAreaModel using the values provided.
        /// </summary>
        /// <param name="id">The unique ID value of the LocalGovernmentAreaModel instance.</param>
        /// <param name="name">The name of the Local Government Area.</param>
        /// <param name="stateID">An ID number representing the state that the Local Government Area belongs to.</param>
		public LocalGovernmentAreaModel(int id, string name, int stateID)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID)
		{
		}

        /// <summary>
        /// Creates an instance of LocalGovernmentAreaModel using the values provided.
        /// </summary>
        /// <param name="dateCreatedUtc">The date when the record was created.</param>
        /// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
        /// <param name="id">The unique ID value of the LocalGovernmentAreaModel instance.</param>
        /// <param name="isDeleted">Specifies whether the instance is flagged as deleted.</param>
        /// <param name="isVisible">Specifies whether the instance is flagged as visible.</param>
        /// <param name="name">The name of the Local Government Area.</param>
        /// <param name="stateID">An ID number representing state/territory of the Local Government Area.</param>
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
        #endregion
        
        #region Instance Variables
        private DateTime _dateCreatedUtc;
		private DateTime _dateUpdatedUtc;
		private int _id;
		private bool _isDeleted;
		private bool _isVisible;
		private string _name;
		private int _stateID;
        #endregion

        #region Public Properties
        /// <summary>
        /// The date when the record was created.
        /// </summary>
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

        /// <summary>
        /// The date when the record was last updated.
        /// </summary>
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

        /// <summary>
        /// The unique ID value For the LocalGovernmentAreaModel instance.
        /// </summary>
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

        /// <summary>
        /// Specifies whether the instance is flagged as deleted.
        /// </summary>
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

        /// <summary>
        /// Specifies whether the instance is flagged as Visible.
        /// </summary>
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

        /// <summary>
        /// The name of the Local Government Area.
        /// </summary>
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

        /// <summary>
        /// An ID number representing state/territory of the Local Government Area.
        /// </summary>
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
        #endregion
    }
}