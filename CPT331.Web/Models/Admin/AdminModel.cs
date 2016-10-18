#region Using References

using System;
using System.Collections.Generic;
using System.Web.Mvc;

using CPT331.Data;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class AdminModel
	{
		private bool _isDelete;

		public bool IsDelete
		{
			get
			{
				return _isDelete;
			}
			set
			{
				_isDelete = value;
			}
		}

		public IEnumerable<SelectListItem> LocalGovernmentAreas
		{
			get
			{
				List<SelectListItem> localGovernmentAreaList = new List<SelectListItem>();
				List<LocalGovernmentAreaState> localGovernmentAreaStates = LocalGovernmentAreaStateRepository.GetLocalGovernmentAreaStates();

				localGovernmentAreaStates.ForEach(m => localGovernmentAreaList.Add(new SelectListItem() { Text = $"{m.Name} ({m.AbbreviatedName})", Value = m.ID.ToString() }));

				return localGovernmentAreaList;
			}
		}

		public IEnumerable<SelectListItem> States
		{
			get
			{
				List<SelectListItem> stateList = new List<SelectListItem>();
				List<State> states = StateRepository.GetStates();

				states.ForEach(m => stateList.Add(new SelectListItem() { Text = $"{m.Name} ({m.AbbreviatedName})", Value = m.ID.ToString() }));

				return stateList;
			}
		}
	}
}
