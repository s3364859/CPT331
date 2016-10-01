#region Using References

using System;
using System.Xml;

#endregion

namespace CPT331.Core.Extensions
{
	public static class XmlNodeExtensions
	{
		public static DateTime AsDateTime(this XmlNode xmlNode)
		{
			DateTime dateTime = DateTime.MinValue;
			DateTime.TryParse(xmlNode.AsString(), out dateTime);

			return dateTime;
		}

		public static int AsInt32(this XmlNode xmlNode)
		{
			int value = 0;
			Int32.TryParse(xmlNode.AsString(), out value);

			return value;
		}

		public static string AsString(this XmlNode xmlNode)
		{
			string asString = "";

			if (xmlNode != null)
			{
				asString = xmlNode.SelectSingleNode("text()").InnerText
					.Replace("<![CDATA[", "")
					.Replace("]]>", "");
			}

			return asString;
		}
	}
}
