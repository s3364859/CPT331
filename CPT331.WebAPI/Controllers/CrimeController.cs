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
		public IEnumerable<Crime> CrimesByCoordinate(double latitude, double longitude, double radius, string sortBy = "", SortDirection? sortDirection = null)
		{
			IEnumerable<Crime> crimes = CrimeRepository.GetCrimesByCoordinate(latitude, longitude, radius);

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				crimes = SortCrimes(crimes, sortBy, sortDirection);
			}

			return crimes;
		}

		[HttpGet]
		[Route("api/Crime/CrimeByLocation")]
		public CrimeByLocationModel CrimeByLocation(string location)
		{
			CrimeByLocationModel crimeByLocationModel = null;
			LocalGovernmentArea localGovernmentArea = null;

			List<LocalGovernmentArea> localGovermentAreas = LocalGovernmentAreaRepository.GetLocalGovernmentAreas();

			if (localGovermentAreas.Any(m => (m.Name.EqualsIgnoreCase(location) == true)) == true)
			{
				localGovernmentArea = localGovermentAreas.Where(m => (m.Name.EqualsIgnoreCase(location))).FirstOrDefault();
			}

			Random random = new Random();

			if (localGovernmentArea == null)
			{
				localGovernmentArea = localGovermentAreas[random.Next(0, (localGovermentAreas.Count - 1))];
			}

			List<Offence> offences = OffenceRepository.GetOffences();

			int beginYear = random.Next(2010, 2016);
			int endYear = random.Next(beginYear, 2016);

			Dictionary<string, double> offenceValues = new Dictionary<string, double>();

			int upper = random.Next(3, 6);
			for (int i = 0; i < upper; i++)
			{
				List<Offence> otherOffences = offences.Where(m => (offenceValues.ContainsKey(m.Name) == false)).ToList();
				Offence offence = otherOffences[random.Next(0, (otherOffences.Count - 1))];

				offenceValues.Add(offence.Name, random.Next(1, 1000));
			}

			double total = offenceValues.Sum(m => (m.Value));

			for (int i = 0; i < offenceValues.Count; i++)
			{
				string key = offenceValues.Keys.ElementAt(i);

				offenceValues[key] /= total;
			}

			crimeByLocationModel = new CrimeByLocationModel(beginYear, endYear, localGovernmentArea.Name, offenceValues);

			return crimeByLocationModel;
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
