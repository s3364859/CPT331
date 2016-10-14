#region Using References

using System;
using System.Collections.Generic;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class EventInfo
	{
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

		public string Address
		{
			get
			{
				return _address;
			}
		}

		public DateTime BeginDateTime
		{
			get
			{
				return _beginDateTime;
			}
		}

		public string Description
		{
			get
			{
				return _description;
			}
		}

		public DateTime EndDateTime
		{
			get
			{
				return _endDateTime;
			}
		}

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public List<EventCategory> EventCategories
		{
			get
			{
				return _eventCategories;
			}
		}

		public List<EventImage> EventImages
		{
			get
			{
				return _eventImages;
			}
		}

		public double Latitude
		{
			get
			{
				return _latitude;
			}
		}

		public double Longitude
		{
			get
			{
				return _longitude;
			}
		}

		public string Name
		{
			get
			{
				return _name;
			}
		}

		public string Url
		{
			get
			{
				return _url;
			}
		}
	}
}