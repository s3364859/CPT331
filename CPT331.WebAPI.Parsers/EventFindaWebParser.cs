#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;

using CPT331.Core;
using CPT331.Core.Extensions;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.WebAPI.Parsers
{
	public class EventFindaWebParser : WebParser
	{
		public EventFindaWebParser()
			: base(ApplicationConfiguration.Default.EventFindaUrl, ApplicationConfiguration.Default.EventFindaUsername, ApplicationConfiguration.Default.EventFindaPassword)
		{
		}

		private const string EventsEndPoint = "events.xml";
		private const int Offset = 0;
		private const int Rows = 20;

		public EventInfo GetEventByID(int id)
		{
			Dictionary<string, string> queryString = new Dictionary<string, string>();
			queryString.Add("id", id.ToString());

			string request = base.Request(EventsEndPoint, queryString);

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(request);

			XmlNode xmlNode = xmlDocument.SelectSingleNode("/events/event");

			return ToEvent(xmlNode);
		}

		public List<EventInfo> GetEventsByCoordinate(double latitude, double longitude, double radius)
		{
			Dictionary<string, string> queryString = new Dictionary<string, string>();
			queryString.Add("offset", Offset.ToString());
			queryString.Add("point", $"{latitude},{longitude}");
			queryString.Add("radius", $"{radius}");
			queryString.Add("rows", Rows.ToString());

			string request = base.Request(EventsEndPoint, queryString);

			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(request);

			int eventCount = Convert.ToInt32(xmlDocument.SelectSingleNode("/events/@count").InnerText);

			List<EventInfo> events = new List<EventInfo>();

			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("/events/event");
			xmlNodeList.OfType<XmlNode>().ToList().ForEach(m => events.Add(ToEvent(m)));

			return events;
		}

		public List<EventInfo> GetEventsByLocation(string name, int postcode)
		{
			return new List<EventInfo>();
		}

		private static EventInfo ToEvent(XmlNode xmlNode)
		{
			EventInfo eventInfo = null;

			if (xmlNode != null)
			{
				XmlNode addressXmlNode = xmlNode.SelectSingleNode("address");
				XmlNode beginDateTimeXmlNode = xmlNode.SelectSingleNode("datetime_start");
				XmlNode descriptionXmlNode = xmlNode.SelectSingleNode("description");
				XmlNode endDateTimeXmlNode = xmlNode.SelectSingleNode("datetime_end");
				XmlNode idXmlNode = xmlNode.SelectSingleNode("id");
				XmlNode eventCategoryXmlNode = xmlNode.SelectSingleNode("category");
				XmlNodeList eventImagesXmlNodeList = xmlNode.SelectNodes("images/image/transforms/transform");
				XmlNode latitudeXmlNode = xmlNode.SelectSingleNode("point/lat");
				XmlNode longitudeXmlNode = xmlNode.SelectSingleNode("point/lng");
				XmlNode nameXmlNode = xmlNode.SelectSingleNode("name");
				XmlNode urlXmlNode = xmlNode.SelectSingleNode("url");

				string address = addressXmlNode.AsString();
				DateTime beginDateTime = beginDateTimeXmlNode.AsDateTime();
				string description = descriptionXmlNode.AsString();
				DateTime endDateTime = endDateTimeXmlNode.AsDateTime();
				int id = idXmlNode.AsInt32();
				EventCategory eventCategory = ToEventCategory(eventCategoryXmlNode);
				List<EventImage> eventImages = new List<EventImage>();
				eventImagesXmlNodeList.OfType<XmlNode>().ToList().ForEach(m => eventImages.Add(ToEventImage(m)));

				double latitude = latitudeXmlNode.AsDouble();
				double longitude = longitudeXmlNode.AsDouble();

				string name = nameXmlNode.AsString();
				string url = urlXmlNode.AsString();

				eventInfo = new EventInfo
				(
					address,
					beginDateTime,
					description,
					endDateTime,
					id,
					new List<EventCategory>(new EventCategory[] { eventCategory }),
					eventImages,
					latitude,
					longitude,
					name,
					url
				);
			}

			return eventInfo;
		}

		private static EventCategory ToEventCategory(XmlNode xmlNode)
		{
			EventCategory eventCategory = null;

			if (xmlNode != null)
			{
				XmlNode idXmlNode = xmlNode.SelectSingleNode("id");
				XmlNode nameXmlNode = xmlNode.SelectSingleNode("name");

				int id = idXmlNode.AsInt32();
				string name = nameXmlNode.AsString();

				eventCategory = new EventCategory
				(
					id,
					name
				);
			}

			return eventCategory;
		}

		private static EventImage ToEventImage(XmlNode xmlNode)
		{
			EventImage eventImage = null;

			if (xmlNode != null)
			{
				XmlNode heightXmlNode = xmlNode.SelectSingleNode("height");
				XmlNode transformXmlNode = xmlNode.SelectSingleNode("transformation_id");
				XmlNode urlXmlNode = xmlNode.SelectSingleNode("url");
				XmlNode widthXmlNode = xmlNode.SelectSingleNode("width");

				int height = heightXmlNode.AsInt32();
				int transformationID = 0;
				Int32.TryParse(transformXmlNode.InnerText, out transformationID);

				string url = urlXmlNode.AsString();
				int width = widthXmlNode.AsInt32();

				eventImage = new EventImage
				(
					height,
					transformationID,
					url,
					width
				);
			}

			return eventImage;
		}
	}
}
