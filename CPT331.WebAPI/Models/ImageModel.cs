#region Using References

using CPT331.Core.ObjectModel;
using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
    /// <summary>
    /// A representation of the EventImage model that services the Web API framework. 
    /// </summary>
	[DataContract(Name = "Image")]
	public class ImageModel
	{
        /// <summary>
        /// Creates an instance of ImageModel using the values provided.
        /// </summary>
        /// <param name="height">The height of the image.</param>
        /// <param name="transformationID">An EventFinder image tranformation type.</param>
        /// <param name="url">The URL of the image.</param>
        /// <param name="width">The width of the image.</param>
		public ImageModel(int height, EventFinderImageFormat transformationID, string url, int width)
		{
			_height = height;
			_transformationID = transformationID;
			_url = url;
			_width = width;
		}

		private int _height;
		private readonly EventFinderImageFormat _transformationID;
		private string _url;
		private int _width;

        /// <summary>
        /// The height of the image.
        /// </summary>
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

        /// <summary>
        /// An EventFinder image tranformation type.
        /// </summary>
		internal EventFinderImageFormat TransformationID
		{
			get
			{
				return _transformationID;
			}
		}

        /// <summary>
        /// The URL of the image.
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

        /// <summary>
        /// The width of the image.
        /// </summary>
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
