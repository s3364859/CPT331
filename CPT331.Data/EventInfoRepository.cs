#region Using References

using System;
using System.Collections.Generic;

using CPT331.Core.ObjectModel;
using CPT331.WebAPI.Parsers;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents an EventInfoRepository type, used to manipulate event information.
	/// </summary>
	public static class EventInfoRepository
	{
		static EventInfoRepository()
		{
			_eventFindaWebParser = new EventFindaWebParser();
		}

		private static EventFindaWebParser _eventFindaWebParser;

		/// <summary>
		/// Selects event information from the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated event information.</param>
		/// <returns>Returns an EventInfo object representing the result of the operation.</returns>
		public static EventInfo GetEventByID(int id)
		{
			return _eventFindaWebParser.GetEventByID(id);
		}

		/// <summary>
		/// Selects event information from the underlying data source.
		/// </summary>
		/// <param name="latitude">The latitude to search around.</param>
		/// <param name="longitude">The longitude to search around.</param>
		/// <param name="radius">The radius to include in the search.</param>
		/// <returns>Returns a list of EventInfo objects representing the result of the operation.</returns>
		public static List<EventInfo> GetEventsByCoordinate(double latitude, double longitude, double radius)
		{
			return _eventFindaWebParser.GetEventsByCoordinate(latitude, longitude, radius);
		}
	}
}
