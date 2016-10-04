#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class EventImage
	{
		public EventImage(int height, string url, int width)
		{
			_height = height;
			_url = url;
			_width = width;
		}

		private readonly int _height;
		private readonly string _url;
		private readonly int _width;

		public int Height
		{
			get
			{
				return _height;
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
