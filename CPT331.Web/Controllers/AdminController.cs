#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Helpers;

using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.Web.Models.Admin;
using CPT331.Web.Attributes;
using CPT331.Web.Actions;

#endregion

namespace CPT331.Web.Controllers
{
    [AdminAuthorize]
    public class AdminController : Controller
    {
		[HttpGet]
		public ActionResult Crime(uint id)
		{
			CrimeModel crimeModel = null;
			Crime crime = DataProvider.CrimeRepository.GetCrimeByID((int)(id));

			if (crime != null)
			{
				crimeModel = new CrimeModel
				(
					crime.Count,
					crime.DateCreatedUtc,
					crime.DateUpdatedUtc,
					crime.ID,
					crime.IsDeleted,
					crime.IsVisible,
					crime.LocalGovernmentAreaID,
					crime.Month,
					crime.OffenceID,
					crime.Year
				);
			}

			return View(crimeModel);
		}

        [HttpPost]
        public ActionResult Crime(CrimeModel crimeModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				if (crimeModel.IsDelete == true)
				{
					//	Can't delete them at this time
				}
				else
				{
					DataProvider.CrimeRepository.UpdateCrime
					(
						crimeModel.ID,
						crimeModel.LocalGovernmentAreaID,
						crimeModel.OffenceID,
						crimeModel.Count,
						crimeModel.Month,
						crimeModel.Year,
						crimeModel.IsDeleted,
						crimeModel.IsVisible
					);
				}

				actionResult = RedirectToAction("Offences", "Admin");
			}
			else
			{
				actionResult = View(crimeModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult Crimes(string sortBy, SortDirection? sortDirection, uint? page)
		{
			IEnumerable<Crime> crimes = DataProvider.CrimeRepository.GetCrimes();

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "Date":
						if (sort == SortDirection.Ascending)
						{
							crimes = crimes.OrderBy(m => (m.DateCreatedUtc));	//	.ThenBy(m => (m.Name));
						}
						else
						{
							crimes = crimes.OrderByDescending(m => (m.DateCreatedUtc));	//	.ThenBy(m => (m.Name));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							crimes = crimes.OrderBy(m => (m.ID));
						}
						else
						{
							crimes = crimes.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							crimes = crimes.OrderBy(m => (m.IsDeleted));	//	.ThenBy(m => (m.Name));
						}
						else
						{
							crimes = crimes.OrderByDescending(m => (m.IsDeleted));	//	.ThenBy(m => (m.Name));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							crimes = crimes.OrderBy(m => (m.IsVisible));	//	.ThenBy(m => (m.Name));
						}
						else
						{
							crimes = crimes.OrderByDescending(m => (m.IsVisible));	//	.ThenBy(m => (m.Name));
						}
						break;

					//	case "Name":
					//		if (sort == SortDirection.Ascending)
					//		{
					//			crimes = crimes.OrderBy(m => (m.Name));
					//		}
					//		else
					//		{
					//			crimes = crimes.OrderByDescending(m => (m.Name));
					//		}
					//		break;
				}
			}

			return View(crimes);
		}

		[HttpGet]
		public ActionResult ExportLocalGovernmentAreas()
		{
			return new ExportDataActionResult("LocalGovernmentAreas.csv", DataProvider.LocalGovernmentAreaRepository);
		}

		[HttpGet]
		public ActionResult ExportOffenceCategories()
		{
			return new ExportDataActionResult("OffenceCateogories.csv", DataProvider.OffenceCategoryRepository);
		}

		[HttpGet]
		public ActionResult ExportOffences()
		{
			return new ExportDataActionResult("Offences.csv", DataProvider.OffenceRepository);
		}

		[HttpGet]
		public ActionResult ExportStates()
		{
			return new ExportDataActionResult("States.csv", DataProvider.StateRepository);
		}

		[HttpGet]
        public ActionResult Home()
		{
			return View();
		}

        [HttpGet]
        public ActionResult LocalGovernmentArea(uint id)
		{
			LocalGovernmentAreaModel localGovernmentAreaModel = null;
			LocalGovernmentArea localGovernmentArea = DataProvider.LocalGovernmentAreaRepository.GetLocalGovernmentAreaByID((int)(id));

			if (localGovernmentArea != null)
			{
				localGovernmentAreaModel = new LocalGovernmentAreaModel
				(
					localGovernmentArea.DateCreatedUtc,
					localGovernmentArea.DateUpdatedUtc,
					localGovernmentArea.ID,
					localGovernmentArea.IsDeleted,
					localGovernmentArea.IsVisible,
					localGovernmentArea.Name,
					localGovernmentArea.StateID
				);
			}

			return View(localGovernmentAreaModel);
		}

        [HttpPost]
        public ActionResult LocalGovernmentArea(LocalGovernmentAreaModel localGovernmentAreaModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				if (localGovernmentAreaModel.IsDelete == true)
				{
					//	Can't delete them at this time
				}
				else
				{
					DataProvider.LocalGovernmentAreaRepository.UpdateLocalGovernmentArea
					(
						localGovernmentAreaModel.ID,
						localGovernmentAreaModel.IsDeleted,
						localGovernmentAreaModel.IsVisible,
						localGovernmentAreaModel.Name,
						localGovernmentAreaModel.StateID
					);
				}

				actionResult = RedirectToAction("LocalGovernmentAreas", "Admin");
			}
			else
			{
				actionResult = View(localGovernmentAreaModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult LocalGovernmentAreas(string sortBy, SortDirection? sortDirection, uint? page)
		{
			IEnumerable<LocalGovernmentAreaState> localGovernmentAreaStates = DataProvider.LocalGovernmentAreaStateRepository.GetLocalGovernmentAreaStates();

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "Date":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.DateCreatedUtc)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.DateCreatedUtc)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.ID));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.IsDeleted)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.IsDeleted)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.IsVisible)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.IsVisible)).ThenBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						break;

					case "Name":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.Name)).ThenBy(m => (m.StateName));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.Name)).ThenBy(m => (m.StateName));
						}
						break;

					case "StateName":
						if (sort == SortDirection.Ascending)
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderBy(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						else
						{
							localGovernmentAreaStates = localGovernmentAreaStates.OrderByDescending(m => (m.StateName)).ThenBy(m => (m.Name));
						}
						break;
				}
			}

			return View(localGovernmentAreaStates);
		}

        [HttpGet]
        public ActionResult NewCrime()
		{
			return View(new CrimeModel());
		}

        [HttpPost]
        public ActionResult NewCrime(CrimeModel crimeModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				DataProvider.CrimeRepository.AddCrime(crimeModel.Count, crimeModel.LocalGovernmentAreaID, crimeModel.Month, crimeModel.OffenceID, crimeModel.Year);

				actionResult = RedirectToAction("Crimes", "Admin");
			}
			else
			{
				actionResult = View(crimeModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult NewLocalGovernmentArea()
		{
			return View(new LocalGovernmentAreaModel());
		}

        [HttpPost]
        public ActionResult NewLocalGovernmentArea(LocalGovernmentAreaModel localGovernmentAreaModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				DataProvider.LocalGovernmentAreaRepository.AddLocalGovernmentArea(localGovernmentAreaModel.IsDeleted, localGovernmentAreaModel.IsVisible, localGovernmentAreaModel.Name, localGovernmentAreaModel.StateID);

				actionResult = RedirectToAction("LocalGovernmentAreas", "Admin");
			}
			else
			{
				actionResult = View(localGovernmentAreaModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult NewOffence()
		{
			return View(new OffenceModel());
		}

        [HttpPost]
        public ActionResult NewOffence(OffenceModel offenceModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				DataProvider.OffenceRepository.AddOffence(offenceModel.IsDeleted, offenceModel.IsVisible, offenceModel.Name);

				actionResult = RedirectToAction("Offences", "Admin");
			}
			else
			{
				actionResult = View(offenceModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult NewOffenceCategory()
		{
			return View(new OffenceCategoryModel());
		}

        [HttpPost]
        public ActionResult NewOffenceCategory(OffenceCategoryModel offenceCategoryModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				DataProvider.OffenceCategoryRepository.AddOffenceCategory(offenceCategoryModel.IsDeleted, offenceCategoryModel.IsVisible, offenceCategoryModel.Name);

				actionResult = RedirectToAction("OffenceCategories", "Admin");
			}
			else
			{
				actionResult = View(offenceCategoryModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult NewState()
		{
			return View(new StateModel());
		}

        [HttpPost]
        public ActionResult NewState(StateModel stateModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				DataProvider.StateRepository.AddState(stateModel.AbbreviatedName, stateModel.IsDeleted, stateModel.IsVisible, stateModel.Name);

				actionResult = RedirectToAction("States", "Admin");
			}
			else
			{
				actionResult = View(stateModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult Offence(uint id)
		{
			OffenceModel offenceModel = null;
			Offence offence = DataProvider.OffenceRepository.GetOffenceByID((int)(id));

			if (offence != null)
			{
				offenceModel = new OffenceModel(offence.DateCreatedUtc, offence.DateUpdatedUtc, offence.ID, offence.IsDeleted, offence.IsVisible, offence.Name, offence.OffenceCategoryID);
			}

			return View(offenceModel);
		}

        [HttpPost]
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
					DataProvider.OffenceRepository.UpdateOffence(offenceModel.ID, offenceModel.IsDeleted, offenceModel.IsVisible, offenceModel.Name, offenceModel.OffenceCategoryID);
				}

				actionResult = RedirectToAction("Offences", "Admin");
			}
			else
			{
				actionResult = View(offenceModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult Offences(string sortBy, SortDirection? sortDirection, uint? page)
		{
			IEnumerable<Offence> offences = DataProvider.OffenceRepository.GetOffences();

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

        [HttpGet]
        public ActionResult OffenceCategory(uint id)
		{
			OffenceCategoryModel offenceCategoryModel = null;
			OffenceCategory offenceCategory = DataProvider.OffenceCategoryRepository.GetOffenceCategoryByID((int)(id));

			if (offenceCategory != null)
			{
				offenceCategoryModel = new OffenceCategoryModel(offenceCategory.DateCreatedUtc, offenceCategory.DateUpdatedUtc, offenceCategory.ID, offenceCategory.IsDeleted, offenceCategory.IsVisible, offenceCategory.Name);
			}

			return View(offenceCategoryModel);
		}

        [HttpPost]
        public ActionResult OffenceCategory(OffenceCategoryModel offenceCategoryModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				if (offenceCategoryModel.IsDelete == true)
				{
					//	Can't delete them at this time
				}
				else
				{
					DataProvider.OffenceCategoryRepository.UpdateOffenceCategory(offenceCategoryModel.ID, offenceCategoryModel.IsDeleted, offenceCategoryModel.IsVisible, offenceCategoryModel.Name);
				}

				actionResult = RedirectToAction("OffenceCategories", "Admin");
			}
			else
			{
				actionResult = View(offenceCategoryModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult OffenceCategories(string sortBy, SortDirection? sortDirection, uint? page)
		{
			IEnumerable<OffenceCategory> offenceCategories = DataProvider.OffenceCategoryRepository.GetOffenceCategories();

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "Date":
						if (sort == SortDirection.Ascending)
						{
							offenceCategories = offenceCategories.OrderBy(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						else
						{
							offenceCategories = offenceCategories.OrderByDescending(m => (m.DateCreatedUtc)).ThenBy(m => (m.Name));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							offenceCategories = offenceCategories.OrderBy(m => (m.ID));
						}
						else
						{
							offenceCategories = offenceCategories.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							offenceCategories = offenceCategories.OrderBy(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						else
						{
							offenceCategories = offenceCategories.OrderByDescending(m => (m.IsDeleted)).ThenBy(m => (m.Name));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							offenceCategories = offenceCategories.OrderBy(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						else
						{
							offenceCategories = offenceCategories.OrderByDescending(m => (m.IsVisible)).ThenBy(m => (m.Name));
						}
						break;

					case "Name":
						if (sort == SortDirection.Ascending)
						{
							offenceCategories = offenceCategories.OrderBy(m => (m.Name));
						}
						else
						{
							offenceCategories = offenceCategories.OrderByDescending(m => (m.Name));
						}
						break;
				}
			}

			return View(offenceCategories);
		}

        [HttpGet]
        public ActionResult State(uint id)
		{
			StateModel stateModel = null;
			State state = DataProvider.StateRepository.GetStateByID((int)(id));

			if (state != null)
			{
				stateModel = new StateModel(state.AbbreviatedName, state.DateCreatedUtc, state.DateUpdatedUtc, state.ID, state.IsDeleted, state.IsVisible, state.Name);
			}

			return View(stateModel);
		}

        [HttpPost]
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
					DataProvider.StateRepository.UpdateState(stateModel.ID, stateModel.AbbreviatedName, stateModel.IsDeleted, stateModel.IsVisible, stateModel.Name);
				}

				actionResult = RedirectToAction("States", "Admin");
			}
			else
			{
				actionResult = View(stateModel);
			}

			return actionResult;
		}

        [HttpGet]
        public ActionResult States(string sortBy, SortDirection? sortDirection, uint? page)
		{
			IEnumerable<State> states = DataProvider.StateRepository.GetStates();

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