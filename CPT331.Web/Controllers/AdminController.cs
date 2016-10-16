#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Helpers;

using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.Web.Models.Admin;

#endregion

namespace CPT331.Web.Controllers
{
    public class AdminController : Controller
    {
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Home()
        {
            // User isn't logged in. 
            if (Session["user"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            return View();
        }

        [AcceptVerbs(HttpVerbs.Get)]
		public ActionResult NewOffence()
		{
			return View(new OffenceModel());
		}

		[AcceptVerbs(HttpVerbs.Post)]
		public ActionResult NewOffence(OffenceModel offenceModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				OffenceRepository.AddOffence(offenceModel.IsDeleted, offenceModel.IsVisible, offenceModel.Name);

				actionResult = RedirectToAction("Offences", "Admin");
			}
			else
			{
				actionResult = View(offenceModel);
			}

			return actionResult;
		}

		[AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Offence(int id)
        {
			OffenceModel offenceModel = null;
			Offence offence = OffenceRepository.GetOffenceByID(id);

			if (offence != null)
			{
				offenceModel = new OffenceModel(offence.DateCreatedUtc, offence.DateUpdatedUtc, offence.ID, offence.IsDeleted, offence.IsVisible, offence.Name);
			}

			return View(offenceModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Offence(OffenceModel offenceModel)
        {
            ActionResult actionResult = null;

            if (ModelState.IsValid == true)
            {
                if (offenceModel.IsDelete == true)
				{
					//	Can't delete them at this time
                }
                else
                {
					OffenceRepository.UpdateOffence(offenceModel.ID, offenceModel.IsDeleted, offenceModel.IsVisible, offenceModel.Name);
                }

                actionResult = RedirectToAction("Offences", "Admin");
            }
            else
            {
                actionResult = View(offenceModel);
            }

            return actionResult;
        }

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult Offences(string sortBy, SortDirection? sortDirection, int? page)
		{
			IEnumerable<Offence> offences = OffenceRepository.GetOffences();

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "Date":
						if (sort == SortDirection.Ascending)
						{
							offences = offences.OrderBy(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						else
						{
							offences = offences.OrderByDescending(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							offences = offences.OrderBy(m => (m.ID));
						}
						else
						{
							offences = offences.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							offences = offences.OrderBy(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						else
						{
							offences = offences.OrderByDescending(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							offences = offences.OrderBy(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						else
						{
							offences = offences.OrderByDescending(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						break;

					case "Name":
						if (sort == SortDirection.Ascending)
						{
							offences = offences.OrderBy(m => (m.Name));
						}
						else
						{
							offences = offences.OrderByDescending(m => (m.Name));
						}
						break;
				}
			}

			return View(offences);
		}

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult NewState()
		{
			return View(new StateModel());
		}

		[AcceptVerbs(HttpVerbs.Post)]
		public ActionResult NewState(StateModel stateModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				StateRepository.AddState(stateModel.AbbreviatedName, stateModel.IsDeleted, stateModel.IsVisible, stateModel.Name);

				actionResult = RedirectToAction("States", "Admin");
			}
			else
			{
				actionResult = View(stateModel);
			}

			return actionResult;
		}

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult State(int id)
		{
			StateModel stateModel = null;
			State state = StateRepository.GetStateByID(id);

			if (state != null)
			{
				stateModel = new StateModel(state.AbbreviatedName, state.DateCreatedUtc, state.DateUpdatedUtc, state.ID, state.IsDeleted, state.IsVisible, state.Name);
			}

			return View(stateModel);
		}

		[AcceptVerbs(HttpVerbs.Post)]
		public ActionResult State(StateModel stateModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				if (stateModel.IsDelete == true)
				{
					//	Can't delete them at this time
				}
				else
				{
					StateRepository.UpdateState(stateModel.ID, stateModel.AbbreviatedName, stateModel.IsDeleted, stateModel.IsVisible, stateModel.Name);
				}

				actionResult = RedirectToAction("States", "Admin");
			}
			else
			{
				actionResult = View(stateModel);
			}

			return actionResult;
		}

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult States(string sortBy, SortDirection? sortDirection, int? page)
		{
			IEnumerable<State> states = StateRepository.GetStates();

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "AbbreviatedName":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.AbbreviatedName));
						}
						else
						{
							states = states.OrderByDescending(m => (m.AbbreviatedName));
						}
						break;

					case "Date":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						else
						{
							states = states.OrderByDescending(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.ID));
						}
						else
						{
							states = states.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						else
						{
							states = states.OrderByDescending(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						else
						{
							states = states.OrderByDescending(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						break;

					case "Name":
						if (sort == SortDirection.Ascending)
						{
							states = states.OrderBy(m => (m.Name));
						}
						else
						{
							states = states.OrderByDescending(m => (m.Name));
						}
						break;
				}
			}

			return View(states);
		}
	}
}