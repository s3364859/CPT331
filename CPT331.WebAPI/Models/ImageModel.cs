#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Image")]
	public class ImageModel
	{
		public ImageModel(int height, int transformationID, string url, int width)
		{
			_height = height;
			_transformationID = transformationID;
			_url = url;
			_width = width;
		}

		private int _height;
		private readonly int _transformationID;
		private string _url;
		private int _width;

		[DataMember]
		public int Height
		{
			get
			{
				return _height;
			}
			set
			{
				_height = value;
			}
		}

		internal int TransformationID
		{
			get
			{
				return _transformationID;
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

		[DataMember]
		public int Width
		{
			get
			{
				return _width;
			}
			set
			{
				_width = value;
			}
		}
	}
}
