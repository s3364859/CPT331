#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.UI.WebControls;

using CPT331.Core.ObjectModel;
using CPT331.Data;
using CPT331.WebAPI.Models;
using CPT331.WebAPI.Validation;
using Swashbuckle.Swagger.Annotations;

#endregion

namespace CPT331.WebAPI.Controllers
{
    /// <summary>
    ///    A RESTful API controller that provides methods that respond to HTTP requests 
    ///    that are related to the EventGuardian Event data.
    /// </summary>
	public class EventController : ApiController
	{
		private const string SortFieldDateTime = "DATETIME";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

        /// <summary>
        /// Provides an event data object based on a specified ID.
        /// </summary>
        /// <param name="id">The unique ID value of the event data record.</param>
        /// <returns>A single event record.</returns>
		[HttpGet]
		[Route("api/Event/{id}")]
        [SwaggerResponse(HttpStatusCode.NotFound, "Event Finder data not found.")]
        public EventModel Event(uint id)
		{
			EventModel eventModel = ToEventModel(EventRepository.GetEventByID((int)(id)));

			if (eventModel == null)
			{
				throw new HttpResponseException(new HttpResponseMessage(HttpStatusCode.NotFound)
				{
					Content = new StringContent("Data not found.")
				});
			}

			return eventModel;
		}

        /// <summary>
        /// Provides a list of events within a specified proximity of the coordinates provided.
        /// </summary>
        /// <param name="latitude">Specifies the latitude used to look up local events.</param>
        /// <param name="longitude">Specifies the longitude used to look up local events.</param>
        /// <param name="radius">The radius from the latitude/longitude used to look up local events.</param>
        /// <param name="sortBy">The name of EventModel property used to sort the data object.</param>
        /// <param name="sortDirection">The sort order of the data returned; as ascending or descending.</param>
        /// <returns>A list of local Events.</returns>
		[HttpGet]
		[Route("api/Event/EventsByCoordinate")]
		[ValidateCoordinates]
		public IEnumerable<EventModel> EventsByCoordinate(double latitude, double longitude, double radius, string sortBy = "", SortDirection? sortDirection = null)
		{
            IEnumerable<EventInfo> events = EventRepository.GetEventsByCoordinate(latitude, longitude, radius);
			IEnumerable<EventModel> eventModels = events.Select(m => ToEventModel(m));

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				eventModels = SortEvents(eventModels, sortBy, sortDirection);
			}

			return eventModels;
        }

        /// <summary>
        /// A sorting provider for the controller actions
        /// </summary>
        /// <param name="events">List of events to be sorted.</param>
        /// <param name="sortBy">The name of EventModel property used to sort the data.</param>
        /// <param name="sortDirection">The sort order of the data returned; as ascending or descending.</param>
        /// <returns>A list of Events sorted by the specified property.</returns>
		private static IEnumerable<EventModel> SortEvents(IEnumerable<EventModel> events, string sortBy, SortDirection? sortDirection)
		{
			SortDirection direction = ((sortDirection.HasValue == true) ? sortDirection.Value : SortDirection.Ascending);

			switch (sortBy.ToUpper())
			{
				case SortFieldID:
					events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.ID)) : events.OrderByDescending(m => (m.ID)));
					break;

				case SortFieldDateTime:
					events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.BeginDateTime)).ThenBy(m => (m.Name)) : events.OrderByDescending(m => (m.BeginDateTime)).ThenBy(m => (m.Name)));
					break;

				case SortFieldName:
					events = ((sortDirection.Value == SortDirection.Ascending) ? events.OrderBy(m => (m.Name)) : events.OrderByDescending(m => (m.Name)));
					break;
			}

			return events;
		}

        /// <summary>
        /// Converts an EventInfo instance into an instance of EventModel.
        /// </summary>
        /// <param name="eventInfo"></param>
        /// <returns></returns>
		private static EventModel ToEventModel(EventInfo eventInfo)
		{
			EventModel eventModel = null;

			if (eventInfo != null)
			{
				eventModel = new EventModel
				(
					eventInfo.Address,
					eventInfo.BeginDateTime,
					eventInfo.Description,
					eventInfo.EndDateTime,
					eventInfo.ID,
					eventInfo.EventCategories.Select(m => new EventCategoryModel(m.ID, m.Name)).ToList(),
					eventInfo.EventImages.Select(m => new ImageModel(m.Height, m.TransformationID, m.Url, m.Width)).ToList(),
					eventInfo.Latitude,
					eventInfo.Longitude,
					eventInfo.Name,
					eventInfo.Url
				);
			}

			return eventModel;
		}
	}
}
