#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class EventCategory
	{
		public EventCategory(int id, string name)
		{
			_id = id;
			_name = name;
		}

		private readonly int _id;
		private readonly string _name;

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public string Name
		{
			get
			{
				return _name;
			}
		}
	}
}
