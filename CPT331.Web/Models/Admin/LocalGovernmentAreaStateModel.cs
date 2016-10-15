#region Using References

using System;
using System.ComponentModel.DataAnnotations;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class LocalGovernmentAreaStateModel : LocalGovernmentAreaModel
	{
		public LocalGovernmentAreaStateModel()
		{
		}

		public LocalGovernmentAreaStateModel(int id, string abbreviatedName,  string name, int stateID, string stateName)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID, stateName)
		{
		}

		public LocalGovernmentAreaStateModel(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID, string stateName)
			: base (dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible, name, stateID)
		{
			_abbreviatedName = abbreviatedName;
			_stateName = stateName;
		}

		private string _abbreviatedName;
		private string _stateName;

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
	}
}