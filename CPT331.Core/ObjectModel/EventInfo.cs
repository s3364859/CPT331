#region Using References

using System;
using System.Collections.Generic;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an EventInfo type, used to describe EventFinda event information.
	/// </summary>
	public class EventInfo
	{
		/// <summary>
		/// Constructs a new EventInfo object.
		/// </summary>
		/// <param name="address">The address of the event.</param>
		/// <param name="beginDateTime">The date and time the event begins.</param>
		/// <param name="description">A description of the event.</param>
		/// <param name="endDateTime">The date and time the event ends.</param>
		/// <param name="id">The unique ID of the event.</param>
		/// <param name="eventCategories">A list of categories the event belongs to.</param>
		/// <param name="eventImages">A list of images for the event.</param>
		/// <param name="latitude">The latitude of the event venue location.</param>
		/// <param name="longitude">The longitude of the event venue location.</param>
		/// <param name="name">The name of the event</param>
		/// <param name="url">The URI of the event.</param>
		public EventInfo(string address, DateTime beginDateTime, string description, DateTime endDateTime, int id, List<EventCategory> eventCategories, List<EventImage> eventImages, double latitude, double longitude, string name, string url)
		{
			_address = address;
			_beginDateTime = beginDateTime;
			_description = description;
			_endDateTime = endDateTime;
			_eventCategories = eventCategories;
			_eventImages = eventImages;
			_id = id;
			_latitude = latitude;
			_longitude = longitude;
			_name = name;
			_url = url;
		}

		private readonly string _address;
		private readonly DateTime _beginDateTime;
		private readonly string _description;
		private readonly DateTime _endDateTime;
		private readonly int _id;
		private readonly List<EventCategory> _eventCategories;
		private readonly List<EventImage> _eventImages;
		private readonly double _latitude;
		private readonly double _longitude;
		private readonly string _name;
		private readonly string _url;

		/// <summary>
		/// Gets the address of the event.
		/// </summary>
		public string Address
		{
			get
			{
				return _address;
			}
		}

		/// <summary>
		/// Gets the date and time that event begins.
		/// </summary>
		public DateTime BeginDateTime
		{
			get
			{
				return _beginDateTime;
			}
		}

		/// <summary>
		/// Gets the event description.
		/// </summary>
		public string Description
		{
			get
			{
				return _description;
			}
		}

		/// <summary>
		/// Gets the date and time that the event ends.
		/// </summary>
		public DateTime EndDateTime
		{
			get
			{
				return _endDateTime;
			}
		}

		/// <summary>
		/// Gets the unique ID of the event.
		/// </summary>
		public int ID
		{
			get
			{
				return _id;
			}
		}

		/// <summary>
		/// Gets a list of categories that the event belongs to.
		/// </summary>
		public List<EventCategory> EventCategories
		{
			get
			{
				return _eventCategories;
			}
		}

		/// <summary>
		/// Gets a list of images for the event.
		/// </summary>
		public List<EventImage> EventImages
		{
			get
			{
				return _eventImages;
			}
		}

		/// <summary>
		/// Gets the latitude of the event venue location.
		/// </summary>
		public double Latitude
		{
			get
			{
				return _latitude;
			}
		}

		/// <summary>
		/// Gets the longitude of the event venue location.
		/// </summary>
		public double Longitude
		{
			get
			{
				return _longitude;
			}
		}

		/// <summary>
		/// Gets the name of event.
		/// </summary>
		public string Name
		{
			get
			{
				return _name;
			}
		}

		/// <summary>
		/// Gets the URI of the event.
		/// </summary>
		public string Url
		{
			get
			{
				return _url;
			}
		}
	}
}