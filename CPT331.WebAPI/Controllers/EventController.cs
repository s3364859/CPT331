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
	public class EventController : ApiController
	{
		private const string SortFieldDateTime = "DATETIME";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

		[HttpGet]
		[Route("api/Event/{id}")]
		public EventModel Event(int id)
		{
			EventInfo eventInfo = EventRepository.GetEventByID(id);

			return ToEventModel(eventInfo);
		}

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

		private static EventModel ToEventModel(EventInfo eventInfo)
		{
			return new EventModel
			(
				eventInfo.Address,
				eventInfo.BeginDateTime,
				eventInfo.Description,
				eventInfo.EndDateTime,
				eventInfo.ID,
				eventInfo.EventCategories.Select(m => new EventCategoryModel(m.ID, m.Name)),
				eventInfo.EventImages.Select(m => new ImageModel(m.Height, m.Url, m.Width)),
				eventInfo.Latitude,
				eventInfo.Longitude,
				eventInfo.Name,
				eventInfo.Url
			);
		}
	}
}
