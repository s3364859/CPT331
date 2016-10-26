#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class EventImage
	{
		public EventImage(int height, EventFinderImageFormat transformationID, string url, int width)
		{
			_height = height;
			_transformationID = transformationID;
			_url = url;
			_width = width;
		}

		private readonly int _height;
		private readonly EventFinderImageFormat _transformationID;
		private readonly string _url;
		private readonly int _width;

		public int Height
		{
			get
			{
				return _height;
			}
		}

		public EventFinderImageFormat TransformationID
		{
			get
			{
				return _transformationID;
			}
		}

		public string Url
		{
			get
			{
				return _url;
			}
		}

		public int Width
		{
			get
			{
				return _width;
			}
		}
	}
}
