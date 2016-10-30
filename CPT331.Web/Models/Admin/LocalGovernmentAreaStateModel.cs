#region Using References

using System;
using System.ComponentModel.DataAnnotations;

#endregion

namespace CPT331.Web.Models.Admin
{
    /// <summary>
    /// A representation of LocalGovernmentArea and State, combined into a single model that services the MVC framework. 
    /// </summary>
	public class LocalGovernmentAreaStateModel : LocalGovernmentAreaModel
    {
        #region Constructors
        /// <summary>
        /// Creates an instance of LocalGovernmentAreaStateModel using default values.
        /// </summary>
		public LocalGovernmentAreaStateModel()
		{
		}

        /// <summary>
        /// Creates an instance of LocalGovernmentAreaStateModel using the values provided.
        /// </summary>
        /// <param name="id">The unique ID value of the LocalGovernmentAreaStateModel instance.</param>
        /// <param name="abbreviatedName">A two or three letter abbreviation of the state/territory.</param>
        /// <param name="name">The name of the Local Government Area.</param>
        /// <param name="stateID">An ID number representing state/territory of the Local Government Area.</param>
        /// <param name="stateName">The full name of the state/territory.</param>
		public LocalGovernmentAreaStateModel(int id, string abbreviatedName,  string name, int stateID, string stateName)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID, stateName)
		{
		}

        /// <summary>
        /// Creates an instance of LocalGovernmentAreaStateModel using the values provided.
        /// </summary>
        /// <param name="abbreviatedName">A two or three letter abbreviation of the state/territory.</param>
        /// <param name="dateCreatedUtc">The date when the record was created.</param>
        /// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
        /// <param name="id">The unique ID value for the LocalGovernmentAreaStateModel instance.</param>
        /// <param name="isDeleted">Specifies whether the instance is flagged as deleted.</param>
        /// <param name="isVisible">Specifies whether the instance is flagged as visible.</param>
        /// <param name="name">The name of the Local Government Area.</param>
        /// <param name="stateID">An ID number representing state/territory of the Local Government Area.</param>
        /// <param name="stateName">The full name of the state/territory.</param>
        public LocalGovernmentAreaStateModel(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID, string stateName)
			: base (dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible, name, stateID)
		{
			_abbreviatedName = abbreviatedName;
			_stateName = stateName;
		}
        #endregion
        
        #region Instance Variables
        private string _abbreviatedName;
		private string _stateName;
        #endregion

        #region Public Properties
        /// <summary>
        /// A two or three letter abbreviation of the state/territory.
        /// </summary>
        [DataType(DataType.Text)]
		[Display(Name = "Abbreviated Name")]
		[Required(ErrorMessage = "*")]
		public string AbbreviatedName
		{
			get
			{
				return _abbreviatedName;
			}
			set
			{
				_abbreviatedName = value;
			}
		}

        /// <summary>
        /// The full name of the state/territory.
        /// </summary>
		[DataType(DataType.Text)]
		[Display(Name = "State Name")]
		[Required(ErrorMessage = "*")]
		public string StateName
		{
			get
			{
				return _stateName;
			}
			set
			{
				_stateName = value;
			}
		}
        #endregion
    }
}