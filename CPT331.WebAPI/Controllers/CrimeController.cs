#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.UI.WebControls;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.WebAPI.Controllers
{
	public class CrimeController : ApiController
	{
		private const string SortFieldDateTime = "DATETIME";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

		[HttpGet]
		[Route("api/Event/{id}")]
		public Crime Crime(int id)
		{
			return CrimeRepository.GetCrimeByID(id);
		}

		[HttpGet]
		[Route("api/Event/EventsByCoordinate")]
		public IEnumerable<Crime> CrimesByCoordinate(double latitude, double longitude, double radius, string sortBy = "", SortDirection? sortDirection = null)
		{
			IEnumerable<Crime> crimes = CrimeRepository.GetCrimesByCoordinate(latitude, longitude, radius);

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				crimes = SortCrimes(crimes, sortBy, sortDirection);
			}

			return crimes;
		}

		private static IEnumerable<Crime> SortCrimes(IEnumerable<Crime> events, string sortBy, SortDirection? sortDirection)
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

			return events;
		}
	}
}
