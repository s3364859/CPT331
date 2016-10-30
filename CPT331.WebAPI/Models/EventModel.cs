#region Using References

using CPT331.Core.ObjectModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Event")]
	public class EventModel
	{
		public EventModel(string address, DateTime beginDateTime, string description, DateTime endDateTime, int id, List<EventCategoryModel> eventCategoryModels, List<ImageModel> eventImageModels, double latitude, double longitude, string name, string url)
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

			if ((_eventCategoryModels != null) && (_eventCategoryModels.Count > 0))
			{
				_category = _eventCategoryModels[0].Name;
			}

			if ((_eventImageModels != null) && (_eventImageModels.Count > 0))
			{
				ImageModel bannerImageModel = _eventImageModels.Where(m => (m.TransformationID == BannerImageTransformationID)).FirstOrDefault();
				if (bannerImageModel != null)
				{
					_bannerUrl = bannerImageModel.Url;
				}

				ImageModel thumbnailImageModel = _eventImageModels.Where(m => (m.TransformationID == ThumbnaiImageTransformationID)).FirstOrDefault();
				if (thumbnailImageModel != null)
				{
					_thumbnailUrl = thumbnailImageModel.Url;
				}
			}
		}

		private const EventFindaImageFormat BannerImageTransformationID = EventFindaImageFormat.Size650x280;
		private const EventFindaImageFormat ThumbnaiImageTransformationID = EventFindaImageFormat.Size75x75;

		private string _address;
		private string _bannerUrl;
		private DateTime _beginDateTime;
		private string _category;
		private string _description;
		private DateTime _endDateTime;
		private int _id;
		private List<EventCategoryModel> _eventCategoryModels;
		private List<ImageModel> _eventImageModels;
		private double _latitude;
		private double _longitude;
		private string _name;
		private string _thumbnailUrl;
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
		public string BannerUrl
		{
			get
			{
				return _bannerUrl;
			}
			set
			{
				//	Required by the silly framework
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
		public string Category
		{
			get
			{
				return _category;
			}
			set
			{
				//	Required by the silly framework
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
		public string ThumbnailUrl
		{
			get
			{
				return _thumbnailUrl;
			}
			set
			{
				//	Required by the silly framework
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
