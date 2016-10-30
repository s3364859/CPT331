#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
    /// <summary>
    /// A representation of the Category model that services the Web API framework. 
    /// </summary>
	[DataContract(Name = "Category")]
	public class EventCategoryModel
    {
        /// <summary>
        /// Creates an instance of CrimeModel using the values provided.
        /// </summary>
        /// <param name="id">The unique ID value for the EventCategoryModel instance.</param>
        /// <param name="name">The name of the Event Category.</param>
		public EventCategoryModel(int id, string name)
		{
			_id = id;
			_name = name;
		}

		private int _id;
		private string _name;

        /// <summary>
        /// The unique ID value for the EventCategoryModel instance.
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
        /// The name of the Event Category.
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
	}
}
