#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an EventImage type, used to describe an EventFinda image.
	/// </summary>
	public class EventImage
	{
		/// <summary>
		/// Constructs a new EventImage object.
		/// </summary>
		/// <param name="height">The height of the image.</param>
		/// <param name="transformationID">The transformation ID of the image. <see cref="EventFindaImageFormat"/></param>
		/// <param name="url">The URI the image is available at.</param>
		/// <param name="width">The width of the image.</param>
		public EventImage(int height, EventFindaImageFormat transformationID, string url, int width)
		{
			_height = height;
			_transformationID = transformationID;
			_url = url;
			_width = width;
		}

		private readonly int _height;
		private readonly EventFindaImageFormat _transformationID;
		private readonly string _url;
		private readonly int _width;

		/// <summary>
		/// Gets the height of the image.
		/// </summary>
		public int Height
		{
			get
			{
				return _height;
			}
		}

		/// <summary>
		/// Gets the EventFinda image format.
		/// </summary>
		public EventFindaImageFormat TransformationID
		{
			get
			{
				return _transformationID;
			}
		}

		/// <summary>
		/// Gets the URI that the image is available at.
		/// </summary>
		public string Url
		{
			get
			{
				return _url;
			}
		}

		/// <summary>
		/// Gets the width of the image.
		/// </summary>
		public int Width
		{
			get
			{
				return _width;
			}
		}
	}
}
