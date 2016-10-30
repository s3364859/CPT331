#region Using References

using System;
using System.Xml;

#endregion

namespace CPT331.Core.Extensions
{
	/// <summary>
	/// Provides System.Xml.XmlNode type extensions.
	/// </summary>
	public static class XmlNodeExtensions
	{
		/// <summary>
		/// Converts the InnerText of an XmlNode to a System.DateTime value.
		/// </summary>
		/// <param name="xmlNode">The XmlNode value.</param>
		/// <returns>Returns a System.DateTime representation for a successful conversion, otherwise DateTime.MinValue.</returns>
		public static DateTime AsDateTime(this XmlNode xmlNode)
		{
			DateTime dateTime = DateTime.MinValue;
			DateTime.TryParse(xmlNode.AsString(), out dateTime);

			return dateTime;
		}

		/// <summary>
		/// Converts the InnerText of an XmlNode to a System.Double value.
		/// </summary>
		/// <param name="xmlNode">The XmlNode value.</param>
		/// <returns>Returns a System.Double representation for a successful conversion, otherwise 0.</returns>
		public static double AsDouble(this XmlNode xmlNode)
		{
			double value = 0;
			Double.TryParse(xmlNode.AsString(), out value);

			return value;
		}

		/// <summary>
		/// Converts the InnerText of an XmlNode to a System.Int32 value.
		/// </summary>
		/// <param name="xmlNode">The XmlNode value.</param>
		/// <returns>Returns a System.Int32 representation for a successful conversion, otherwise 0.</returns>
		public static int AsInt32(this XmlNode xmlNode)
		{
			int value = 0;
			Int32.TryParse(xmlNode.AsString(), out value);

			return value;
		}

		/// <summary>
		/// Selects the InnerText value from an XmlNode, removing any CDATA markup.
		/// </summary>
		/// <param name="xmlNode">The XmlNode value.</param>
		/// <returns>Returns a System.String representing the operation.</returns>
		public static string AsString(this XmlNode xmlNode)
		{
			string asString = "";

			if ((xmlNode != null) && (xmlNode.HasChildNodes == true))
			{
				asString = xmlNode.SelectSingleNode("text()").InnerText
					.Replace("<![CDATA[", "")
					.Replace("]]>", "");
			}

			return asString;
		}
	}
}
