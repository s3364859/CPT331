#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Category")]
	public class EventCategoryModel
	{
		public EventCategoryModel(int id, string name)
		{
			_id = id;
			_name = name;
		}

		private int _id;
		private string _name;

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
