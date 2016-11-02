#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Helpers;

using CPT331.Core;
using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.Web.Models.Admin;
using CPT331.Web.Actions;
using CPT331.Web.Attributes;

#endregion

namespace CPT331.Web.Controllers
{
	/// <summary>
	///    A controller that provides methods that respond to HTTP requests that are related 
	///    to the administration portal.
	/// </summary>
	/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to methods in this controller.</permission>
	[AdminAuthorize]
	public class AdminController : Controller
	{
		/// <summary>
		/// Provides a landing page for the administration portal.
		/// </summary>
		/// <returns>The 'Admin/Home' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult Home()
		{
			return View();
		}

		#region Crime Model

		/// <summary>
		/// Provides an editor page for an existing Crime record.
		/// </summary>
		/// <param name="id">The unique ID for the Crime record.</param>
		/// <returns>The 'Edit Crime' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult Crime(uint id)
		{
			CrimeModel crimeModel = null;
			CrimeOffenceLocalGovernmentAreaState crimeOffenceLocalGovernmentAreaState = DataProvider.CrimeOffenceLocalGovernmentAreaStateRepository.GetCrimeOffenceLocalGovernmentAreaStateByID((int)(id));

			if (crimeOffenceLocalGovernmentAreaState != null)
			{
				crimeModel = new CrimeModel
				(
					crimeOffenceLocalGovernmentAreaState.Count,
					crimeOffenceLocalGovernmentAreaState.DateCreatedUtc,
					crimeOffenceLocalGovernmentAreaState.DateUpdatedUtc,
					crimeOffenceLocalGovernmentAreaState.ID,
					crimeOffenceLocalGovernmentAreaState.IsDeleted,
					crimeOffenceLocalGovernmentAreaState.IsVisible,
					crimeOffenceLocalGovernmentAreaState.LocalGovernmentAreaID,
					crimeOffenceLocalGovernmentAreaState.Month,
					crimeOffenceLocalGovernmentAreaState.OffenceID,
					crimeOffenceLocalGovernmentAreaState.Year
				);
			}

			return View(crimeModel);
		}

		/// <summary>
		/// Updates an existing Crime record based on values posted from the 'Edit Crime' view.
		/// </summary>
		/// <param name="crimeModel">An instance of CrimeModel that contains new values to be updated.</param>
		/// <returns>The 'Edit Crime' view, with the updated values, and validation errors.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

				actionResult = RedirectToAction("Crimes", "Admin");
			}
			else
			{
				actionResult = View(crimeModel);
			}

			return actionResult;
		}

        /// <summary>
        /// Exports the Crimes table as CSV.
        /// </summary>
        /// <returns>Crimes.csv</returns>
        [HttpGet]
		public ActionResult ExportCrimes()
		{
			return new ExportDataActionResult("Crimes.csv", DataProvider.CrimeRepository);
		}

		/// <summary>
		/// Provides an editor page for a new Crime record.
		/// </summary>
		/// <returns>The 'New Crime' view.</returns>
		[HttpGet]
		public ActionResult NewCrime()
		{
			return View(new CrimeModel());
		}

		/// <summary>
		/// Inserts a Crime record based on values posted from the 'New Crime' view.
		/// </summary>
		/// <param name="crimeModel">An instance of CrimeModel that contains new values to be inserted.</param>
		/// <returns>The 'Edit Crime' view when the model is valid; otherwise 'New Crime' view with the errors listed.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpPost]
		[Route("{controller}/Crime}")]
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

		/// <summary>
		/// Provides a paginated table view of Crime data, with links to edit individual records.
		/// </summary>
		/// <param name="sortBy">The name of Crime property used to sort the table view.</param>
		/// <param name="sortDirection">The sort order for the view; as ascending or descending.</param>
		/// <param name="page">A number indicating the page of data to be fetched from the database.</param>
		/// <returns>The 'Crimes List' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult Crimes(string sortBy, SortDirection? sortDirection, uint? page)
		{
			int pageValue = (((page.HasValue == true) ? ((int)(page.Value - 1)) : 0) * ApplicationConfiguration.Default.DataTakeSize);

			IEnumerable<CrimeOffenceLocalGovernmentAreaState> crimeOffenceLocalGovernmentAreaStates = DataProvider.CrimeOffenceLocalGovernmentAreaStateRepository.GetCrimeOffenceLocalGovernmentAreaStates(pageValue, ApplicationConfiguration.Default.DataTakeSize, sortBy, sortDirection.ToString());

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				SortDirection sort = sortDirection.Value;

				switch (sortBy)
				{
					case "Count":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.Count));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.Count));
						}
						break;

					case "Date":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.DateCreatedUtc));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.DateCreatedUtc));
						}
						break;

					case "ID":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.ID));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.ID));
						}
						break;

					case "IsDeleted":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.IsDeleted));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.IsDeleted));
						}
						break;

					case "IsVisible":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.IsVisible));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.IsVisible));
						}
						break;

					case "LocalGovernmentAreaName":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.LocalGovernmentAreaName));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.LocalGovernmentAreaName));
						}
						break;

					case "Month":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.Month));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.Month));
						}
						break;

					case "OffenceName":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.OffenceName));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.OffenceName));
						}
						break;

					case "StateName":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.StateName));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.StateName));
						}
						break;

					case "Year":
						if (sort == SortDirection.Ascending)
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderBy(m => (m.Year));
						}
						else
						{
							crimeOffenceLocalGovernmentAreaStates = crimeOffenceLocalGovernmentAreaStates.OrderByDescending(m => (m.Year));
						}
						break;
				}
			}

			return View(crimeOffenceLocalGovernmentAreaStates);
		}

		#endregion

		#region LocalGovernmentArea Model

		/// <summary>
		/// Exports the ExportLocalGovernmentAreas table as CSV.
		/// </summary>
		/// <returns>LocalGovernmentAreas.csv</returns>
		[HttpGet]
		public ActionResult ExportLocalGovernmentAreas()

		{
			return new ExportDataActionResult("LocalGovernmentAreas.csv", DataProvider.LocalGovernmentAreaRepository);
		}

		/// <summary>
		/// Provides an editor page for an existing LocalGovernmentArea record.
		/// </summary>
		/// <param name="id">The unique ID for the LocalGovernmentArea record.</param>
		/// <returns>The 'Edit LocalGovernmentArea' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Updates an existing LocalGovernmentArea record based on values posted from the 'Edit LocalGovernmentArea' view.
		/// </summary>
		/// <param name="localGovernmentAreaModel">An instance of LocalGovernmentAreaModel that contains new values to be updated.</param>
		/// <returns>The 'Edit LocalGovernmentArea' view, with the updated values.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides an editor page for a new LocalGovernmentArea record.
		/// </summary>
		/// <returns>The 'New LocalGovernmentArea' view.</returns>
		[HttpGet]
		public ActionResult NewLocalGovernmentArea()
		{
			return View(new LocalGovernmentAreaModel());
		}

		/// <summary>
		/// Inserts a new LocalGovernmentArea record based on values posted from the 'New LocalGovernmentArea' view.
		/// </summary>
		/// <param name="localGovernmentAreaModel">An instance of LocalGovernmentAreaModel that contains new values to be inserted.</param>
		/// <returns>The 'Edit LocalGovernmentArea' view when the model is valid; otherwise 'Edit LocalGovernmentArea' view with the errors listed.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides a paginated table view of LocalGovernmentAreas data, with links to edit individual records.
		/// </summary>
		/// <param name="sortBy">The name of LocalGovernmentAreas property used to sort the table view.</param>
		/// <param name="sortDirection">The sort order for the view; as ascending or descending.</param>
		/// <param name="page">A number indicating the page of data to be fetched from the database.</param>
		/// <returns>The 'LocalGovernmentAreas List' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		#endregion

		#region Offence Model

		/// <summary>
		/// Exports the Offenses table as CSV.
		/// </summary>
		/// <returns>Offences.csv</returns>
		[HttpGet]
		public ActionResult ExportOffences()
		{
			return new ExportDataActionResult("Offences.csv", DataProvider.OffenceRepository);
		}

		/// <summary>
		/// Provides an editor page for an existing Offence record.
		/// </summary>
		/// <param name="id">The unique ID for the Offence record.</param>
		/// <returns>The 'Edit Offence' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Updates an existing Offence record based on values posted from the 'Edit Offence' view.
		/// </summary>
		/// <param name="offenceModel">An instance of OffenceModel that contains new values to be updated.</param>
		/// <returns>The 'Edit Offence' view, with the updated values.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides an editor page for a new Offence record.
		/// </summary>
		/// <returns>The 'New Offence' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult NewOffence()
		{
			return View(new OffenceModel());
		}

		/// <summary>
		/// Inserts a new Offence record based on values posted from the 'New Offence' view.
		/// </summary>
		/// <param name="offenceModel">An instance of OffenceModel that contains new values to be inserted.</param>
		/// <returns>The 'Edit Offence' view when the model is valid; otherwise 'Edit Offence' view with the errors listed.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides a paginated table view of Offences data, with links to edit individual records.
		/// </summary>
		/// <param name="sortBy">The name of Offences property used to sort the table view.</param>
		/// <param name="sortDirection">The sort order for the view; as ascending or descending.</param>
		/// <param name="page">A number indicating the page of data to be fetched from the database.</param>
		/// <returns>The 'Offences List' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		#endregion

		#region OffenceCategory Model

		/// <summary>
		/// Exports the OffenceCateogories table as CSV.
		/// </summary>
		/// <returns>OffenceCateogories.csv</returns>
		[HttpGet]
		public ActionResult ExportOffenceCategories()
		{
			return new ExportDataActionResult("OffenceCateogories.csv", DataProvider.OffenceCategoryRepository);
		}

		/// <summary>
		/// Provides an editor page for an existing OffenceCategory record.
		/// </summary>
		/// <param name="id">The unique ID for the OffenceCategory record.</param>
		/// <returns>The 'Edit OffenceCategory' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Updates an existing OffenceCategory record based on values posted from the 'Edit OffenceCategory' view.
		/// </summary>
		/// <param name="offenceCategoryModel">An instance of OffenceCategoryModel that contains new values to be updated.</param>
		/// <returns>The 'Edit OffenceCategory' view, with the updated values.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides an editor page for a new OffenceCategory record.
		/// </summary>
		/// <returns>The 'New OffenceCategory' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult NewOffenceCategory()
		{
			return View(new OffenceCategoryModel());
		}

		/// <summary>
		/// Inserts a new OffenceCategory record based on values posted from the 'New OffenceCategory' view.
		/// </summary>
		/// <param name="offenceCategoryModel">An instance of OffenceCategoryModel that contains new values to be inserted.</param>
		/// <returns>The 'Edit OffenceCategory' view when the model is valid; otherwise 'Edit OffenceCategory' view with the errors listed.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides a paginated table view of OffenceCategory data, with links to edit individual records.
		/// </summary>
		/// <param name="sortBy">The name of OffenceCategory property used to sort the table view.</param>
		/// <param name="sortDirection">The sort order for the view; as ascending or descending.</param>
		/// <param name="page">A number indicating the page of data to be fetched from the database.</param>
		/// <returns>The 'OffenceCategory List' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		#endregion

		#region State Model

		/// <summary>
		/// Exports the States table as CSV.
		/// </summary>
		/// <returns>States.csv</returns>
		[HttpGet]
		public ActionResult ExportStates()
		{
			return new ExportDataActionResult("States.csv", DataProvider.StateRepository);
		}

		/// <summary>
		/// Provides an editor page for an existing State record.
		/// </summary>
		/// <param name="id">The unique ID for the State record.</param>
		/// <returns>The 'Edit State' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Updates an existing State record based on values posted from the 'Edit State' view.
		/// </summary>
		/// <param name="stateModel">An instance of StateModel that contains new values to be updated.</param>
		/// <returns>The 'Edit State' view, with the updated values.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides an editor page for a new State record.
		/// </summary>
		/// <returns>The 'New State' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
		[HttpGet]
		public ActionResult NewState()
		{
			return View(new StateModel());
		}

		/// <summary>
		/// Inserts a new State record based on values posted from the 'New State' view.
		/// </summary>
		/// <param name="stateModel">An instance of StateModel that contains new values to be inserted.</param>
		/// <returns>The 'Edit State' view when the model is valid; otherwise 'Edit State' view with the errors listed.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		/// <summary>
		/// Provides a paginated table view of States data, with links to edit individual records.
		/// </summary>
		/// <param name="sortBy">The name of States property used to sort the table view.</param>
		/// <param name="sortDirection">The sort order for the view; as ascending or descending.</param>
		/// <param name="page">A number indicating the page of data to be fetched from the database.</param>
		/// <returns>The 'States List' view.</returns>
		/// <permission cref="AdminAuthorizeAttribute">Only authorised personnel have access to this method.</permission>
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

		#endregion
	}
}