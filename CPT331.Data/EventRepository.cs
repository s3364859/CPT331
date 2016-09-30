#region Using References

using System;
using System.Collections.Generic;

using CPT331.Core.ObjectModel;
using CPT331.WebAPI.Parsers;

#endregion

namespace CPT331.Data
{
	public static class EventRepository
	{
		static EventRepository()
		{
			_eventFindaWebParser = new EventFindaWebParser();
		}

		private static EventFindaWebParser _eventFindaWebParser;

		public static EventInfo GetEventByID(int id)
		{
			return _eventFindaWebParser.GetEventByID(id);
		}

		public static List<EventInfo> GetEventsByCoordinate(double latitude, double longitude, double radius)
		{
			return _eventFindaWebParser.GetEventsByCoordinate(latitude, longitude, radius);
		}

		public static List<EventInfo> GetEventsByLocation(string name, int postcode)
		{
			return _eventFindaWebParser.GetEventsByLocation(name, postcode);
		}
	}
}
