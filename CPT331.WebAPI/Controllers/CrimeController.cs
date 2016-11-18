#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.UI.WebControls;

using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.WebAPI.Models;
using CPT331.WebAPI.Validation;

#endregion

namespace CPT331.WebAPI.Controllers
{
    /// <summary>
    ///    A RESTful API controller that provides methods that respond to HTTP requests 
    ///    that are related to the EventGuardian Crime data.
    /// </summary>
	public class CrimeController : ApiController
	{
		private const int DefaultNumberOfCrimeRecords = 6;
		private const string OtherCrimesName = "Other";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

        /// <summary>
        /// Provides crime data object based on a specified ID.
        /// </summary>
        /// <param name="id">The unique ID value of the crime data record.</param>
        /// <returns>A single crime record.</returns>
		[HttpGet]
		[Route("api/Crime/{id}")]
		public CrimeModel Crime(int id)
		{
			Crime crime = DataProvider.CrimeRepository.GetCrimeByID(id);

			return new CrimeModel
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

        /// <summary>
        /// Provides Local Government Area crime statistics on a based values specified. 
        /// </summary>
        /// <param name="latitude">Specifies the latitude used to look up the corresponding local government area.</param>
        /// <param name="longitude">Specifies the longitude used to look up the corresponding local government area.</param>
        /// <param name="count">The maximum number of offences to show.</param>
        /// <param name="sortBy">The name of Offence property used to sort the data object.</param>
        /// <param name="sortDirection">The sort order of the data returned; as ascending or descending.</param>
        /// <returns>Crime statistics.</returns>
		[HttpGet]
		[Route("api/Crime/CrimesByCoordinate")]
		[ValidateCoordinates]
		public CrimeByCoordinateModel CrimesByCoordinate(double latitude, double longitude, int count = DefaultNumberOfCrimeRecords, string sortBy = "", SortDirection? sortDirection = null)
		{
			CrimeByCoordinateModel crimeByCoordinateModel = null;
			List<CrimeByCoordinate> crimeByCoordinates = DataProvider.CrimeRepository.GetCrimesByCoordinate(latitude, longitude);

            if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
            {
                crimeByCoordinates = SortCrimeByCoordinates(crimeByCoordinates, sortBy, sortDirection).ToList();
            }

            Dictionary<string, double> offenceValues = new Dictionary<string, double>();
            if(crimeByCoordinates.Count > 0)
            { 
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

                List<OffenceModel> offenceModels = offenceValues
                    .OrderByDescending(m => (m.Value))
                    .Take(count)
                    .Select(m => new OffenceModel(m.Key, m.Value)).ToList();

                total = offenceModels.Sum(m => (m.Value));
                offenceModels.Add(new OffenceModel(OtherCrimesName, (1 - total)));

                crimeByCoordinateModel = new CrimeByCoordinateModel(beginYear, endYear, localGovernmentAreaName, offenceModels);
            }
            return crimeByCoordinateModel;
		}

        /// <summary>
        /// A Coordinate &amp; column sorting provider for the controller actions
        /// </summary>
        /// <param name="crimeByCoordinates">List of crimes to be sorted.</param>
        /// <param name="sortBy">The name of CrimeModel property used to sort the data.</param>
        /// <param name="sortDirection">The sort order of the data returned; as ascending or descending.</param>
        /// <returns>A list of Crimes sorted by Coordinate and the specified property.</returns>
		private static IEnumerable<CrimeByCoordinate> SortCrimeByCoordinates(IEnumerable<CrimeByCoordinate> crimeByCoordinates, string sortBy, SortDirection? sortDirection)
		{
			SortDirection direction = ((sortDirection.HasValue == true) ? sortDirection.Value : SortDirection.Ascending);

			switch (sortBy.ToUpper())
			{
				case SortFieldID:
					crimeByCoordinates = ((sortDirection.Value == SortDirection.Ascending) ? crimeByCoordinates.OrderBy(m => (m.OffenceID)) : crimeByCoordinates.OrderByDescending(m => (m.OffenceID)));
					break;
			
				case SortFieldName:
					crimeByCoordinates = ((sortDirection.Value == SortDirection.Ascending) ? crimeByCoordinates.OrderBy(m => (m.OffenceName)) : crimeByCoordinates.OrderByDescending(m => (m.OffenceName)));
					break;
			}

			return crimeByCoordinates;
		}
	}
}
