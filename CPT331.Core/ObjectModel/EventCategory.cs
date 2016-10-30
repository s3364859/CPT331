#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an EventCategory type, used to describe information about an event category.
	/// </summary>
	public class EventCategory
	{
		/// <summary>
		/// Constructs a new EventCategory object.
		/// </summary>
		/// <param name="id">The ID of the event category.</param>
		/// <param name="name">The name of the event category.</param>
		public EventCategory(int id, string name)
		{
			_id = id;
			_name = name;
		}

		private readonly int _id;
		private readonly string _name;

		/// <summary>
		/// Gets the ID of the category.
		/// </summary>
		public int ID
		{
			get
			{
				return _id;
			}
		}

		/// <summary>
		/// Gets the name of the category.
		/// </summary>
		public string Name
		{
			get
			{
				return _name;
			}
		}
	}
}
