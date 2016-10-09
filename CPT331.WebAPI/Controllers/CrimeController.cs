#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.UI.WebControls;

using CPT331.Core.Extensions;
using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.WebAPI.Models;

#endregion

namespace CPT331.WebAPI.Controllers
{
	public class CrimeController : ApiController
	{
		private const string SortFieldDateTime = "DATETIME";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

		[HttpGet]
		[Route("api/Crime/{id}")]
		public Crime Crime(int id)
		{
			return CrimeRepository.GetCrimeByID(id);
		}

		[HttpGet]
		[Route("api/Crime/CrimesByCoordinate")]
		public CrimeByCoordinateModel CrimesByCoordinate(double latitude, double longitude, string sortBy = "", SortDirection? sortDirection = null)
		{
			List<CrimeByCoordinate> crimeByCoordinates = CrimeRepository.GetCrimesByCoordinate(latitude, longitude);

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				crimeByCoordinates = SortCrimeByCoordinates(crimeByCoordinates, sortBy, sortDirection).ToList();
			}

			CrimeByCoordinateModel crimeByCoordinateModel = null;
			Dictionary<string, double> offenceValues = new Dictionary<string, double>();

			crimeByCoordinates.ForEach(m => offenceValues.Add(m.OffenceName, m.OffenceCount));

			int beginYear = crimeByCoordinates.Min(m => (m.BeginYear));
			int endYear = crimeByCoordinates.Max(m => (m.EndYear));
			string localGovernmentAreaName = crimeByCoordinates.Select(m => (m.LocalGovernmentAreaName)).FirstOrDefault();
			double total = offenceValues.Sum(m => (m.Value));

			for (int i = 0; i < offenceValues.Count; i++)
			{
				string key = offenceValues.Keys.ElementAt(i);

				offenceValues[key] /= total;
			}

			crimeByCoordinateModel = new CrimeByCoordinateModel(beginYear, endYear, localGovernmentAreaName, offenceValues.OrderByDescending(m => (m.Value)).Take(6).ToDictionary(m => m.Key, m => m.Value));

			return crimeByCoordinateModel;
		}

		private static IEnumerable<CrimeByCoordinate> SortCrimeByCoordinates(IEnumerable<CrimeByCoordinate> crimeByCoordinates, string sortBy, SortDirection? sortDirection)
		{
			SortDirection direction = ((sortDirection.HasValue == true) ? sortDirection.Value : SortDirection.Ascending);

			//	switch (sortBy.ToUpper())
			//	{
			//		case SortFieldID:
			//			events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.ID)) : events.OrderByDescending(m => (m.ID)));
			//			break;
			//	
			//		case SortFieldDateTime:
			//			events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.BeginDateTime)).ThenBy(m => (m.Name)) : events.OrderByDescending(m => (m.BeginDateTime)).ThenBy(m => (m.Name)));
			//			break;
			//	
			//		case SortFieldName:
			//			events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.Name)) : events.OrderByDescending(m => (m.Name)));
			//			break;
			//	}

			return crimeByCoordinates;
		}
	}
}
