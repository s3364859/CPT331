#region Using References

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Event")]
	public class EventModel
	{
		public EventModel(string address, DateTime beginDateTime, string description, DateTime endDateTime, int id, IEnumerable<EventCategoryModel> eventCategoryModels, IEnumerable<ImageModel> eventImageModels, double latitude, double longitude, string name, string url)
		{
			_address = address;
			_beginDateTime = beginDateTime;
			_description = description;
			_endDateTime = endDateTime;
			_eventCategoryModels = eventCategoryModels;
			_eventImageModels = eventImageModels;
			_id = id;
			_latitude = latitude;
			_longitude = longitude;
			_name = name;
			_url = url;
		}

		private string _address;
		private DateTime _beginDateTime;
		private string _description;
		private DateTime _endDateTime;
		private int _id;
		private IEnumerable<EventCategoryModel> _eventCategoryModels;
		private IEnumerable<ImageModel> _eventImageModels;
		private double _latitude;
		private double _longitude;
		private string _name;
		private string _url;

		[DataMember]
		public string Address
		{
			get
			{
				return _address;
			}
			set
			{
				_address = value;
			}
		}

		[DataMember]
		public DateTime BeginDateTime
		{
			get
			{
				return _beginDateTime;
			}
			set
			{
				_beginDateTime = value;
			}
		}

		[DataMember]
		public string Description
		{
			get
			{
				return _description;
			}
			set
			{
				_description = value;
			}
		}

		[DataMember]
		public DateTime EndDateTime
		{
			get
			{
				return _endDateTime;
			}
			set
			{
				_endDateTime = value;
			}
		}

		[DataMember]
		public int ID
		{
			get
			{
				return _id;
			}
			set
			{
				_id = value;
			}
		}

		[DataMember(Name = "Categories")]
		public IEnumerable<EventCategoryModel> EventCategoryModels
		{
			get
			{
				return _eventCategoryModels;
			}
			set
			{
				_eventCategoryModels = value;
			}
		}

		[DataMember(Name = "Images")]
		public IEnumerable<ImageModel> EventImageModels
		{
			get
			{
				return _eventImageModels;
			}
			set
			{
				_eventImageModels = value;
			}
		}

		[DataMember]
		public double Latitude
		{
			get
			{
				return _latitude;
			}
			set
			{
				_latitude = value;
			}
		}

		[DataMember]
		public double Longitude
		{
			get
			{
				return _longitude;
			}
			set
			{
				_longitude = value;
			}
		}

		[DataMember]
		public string Name
		{
			get
			{
				return _name;
			}
			set
			{
				_name = value;
			}
		}

		[DataMember]
		public string Url
		{
			get
			{
				return _url;
			}
			set
			{
				_url = value;
			}
		}
	}
}
