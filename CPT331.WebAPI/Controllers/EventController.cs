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
	public class EventController : ApiController
	{
		private const string SortFieldDateTime = "DATETIME";
		private const string SortFieldID = "ID";
		private const string SortFieldName = "NAME";

		[HttpGet]
		[Route("api/Event/{id}")]
		public EventInfo Event(int id)
		{
			return EventRepository.GetEventByID(id);
		}

		[HttpGet]
		[Route("api/Event/EventsByCoordinate")]
		public IEnumerable<EventInfo> EventsByCoordinate(double latitude, double longitude, double radius, string sortBy = "", SortDirection? sortDirection = null)
		{
			IEnumerable<EventInfo> events = EventRepository.GetEventsByCoordinate(latitude, longitude, radius);

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				events = SortEvents(events, sortBy, sortDirection);
			}

			return events;
		}

		[HttpGet]
		[Route("api/Event/EventsByLocation")]
		public IEnumerable<EventInfo> EventsByLocation(string name, int postcode, string sortBy = "", SortDirection? sortDirection = null)
		{
			IEnumerable<EventInfo> events = EventRepository.GetEventsByLocation(name, postcode);

			if ((String.IsNullOrEmpty(sortBy) == false) && (sortDirection.HasValue == true))
			{
				events = SortEvents(events, sortBy, sortDirection);
			}

			return events;
		}

		private static IEnumerable<EventInfo> SortEvents(IEnumerable<EventInfo> events, string sortBy, SortDirection? sortDirection)
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
	}
}
