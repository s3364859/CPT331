#region Using References

using CPT331.Core.ObjectModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
    /// <summary>
    /// A representation of the Event model that services the Web API framework. 
    /// </summary>
	[DataContract(Name = "Event")]
	public class EventModel
	{
        #region Constructors
        /// <summary>
        /// Creates an instance of EventModel using the values provided.
        /// </summary>
        /// <param name="address">The address where the event is held.</param>
        /// <param name="beginDateTime">The start time of the event.</param>
        /// <param name="description">A short description of the event.</param>
        /// <param name="endDateTime">The end time of the event.</param>
        /// <param name="id">The unique ID value for the EventModel instance.</param>
        /// <param name="eventCategoryModels">A list of event categories associated to the event.</param>
        /// <param name="eventImageModels">A list of image URLs associated to the event.</param>
        /// <param name="latitude">Specifies the latitude used to look up local events.</param>
        /// <param name="longitude">Specifies the longitude used to look up local events.</param>
        /// <param name="name">The name of the event.</param>
        /// <param name="url">A website link to the full details on the EventFinder page.</param>
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
        #endregion
        
        #region Instance Variables
        private const EventFinderImageFormat BannerImageTransformationID = EventFinderImageFormat.Size650x280;
		private const EventFinderImageFormat ThumbnaiImageTransformationID = EventFinderImageFormat.Size75x75;

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
        #endregion

        #region Public Properties
        /// <summary>
        /// The address where the event is held.
        /// </summary>
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

        /// <summary>
        /// A URL to a large banner image for the event.
        /// </summary>
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

        /// <summary>
        /// The start time of the event.
        /// </summary>
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

        /// <summary>
        /// The event category associated to the event.
        /// </summary>
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

        /// <summary>
        /// A short description of the event.
        /// </summary>
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

        /// <summary>
        /// The end time of the event.
        /// </summary>
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

        /// <summary>
        /// The unique ID value for the EventModel instance.
        /// </summary>
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

        /// <summary>
        /// Specifies the latitude used to look up local events.
        /// </summary>
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

        /// <summary>
        /// Specifies the longitude used to look up local events.
        /// </summary>
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

        /// <summary>
        /// The name of the event.
        /// </summary>
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

        /// <summary>
        /// A URL to a thumbnail image for the event.
        /// </summary>
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

        /// <summary>
        /// A website link to the full details on the EventFinder page.
        /// </summary>
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
        #endregion
    }
}
