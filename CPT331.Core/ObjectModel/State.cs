#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a State type, used to describe the properties of a state or territory.
	/// </summary>
	public class State
	{
		/// <summary>
		/// Constructs a new State object.
		/// </summary>
		/// <param name="abbreviatedName">The abbreviated name of the state or territory.</param>
		/// <param name="id">The unique ID of the state or territory.</param>
		/// <param name="name">The name of the state or territory.</param>
		public State(string abbreviatedName, int id, string name)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name)
		{
		}

		/// <summary>
		/// Constructs a new State object.
		/// </summary>
		/// <param name="abbreviatedName">The abbreviated name of the state or territory.</param>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the state or territory.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		/// <param name="name">The name of the state or territory.</param>
		public State(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name)
		{
			_abbreviatedName = abbreviatedName;
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
		}

		private readonly string _abbreviatedName;
		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly string _name;

		/// <summary>
		/// Gets the state name or territory in abbreviated form.
		/// </summary>
		public string AbbreviatedName
		{
			get
			{
				return _abbreviatedName;
			}
		}

		/// <summary>
		/// Gets the date the record was created.
		/// </summary>
		public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
		}

		/// <summary>
		/// Gets the date the record was updated.
		/// </summary>
		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
		}

		/// <summary>
		/// Gets the unique ID value of the record.
		/// </summary>
		public int ID
		{
			get
			{
				return _id;
			}
		}

		/// <summary>
		/// Gets a boolean value indicating whether this record has been soft-deleted.
		/// </summary>
		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
		}

		/// <summary>
		/// Gets a boolean value indicating whether this record should be visible.
		/// </summary>
		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
		}

		/// <summary>
		/// Gets the name of the state or territory.
		/// </summary>
		public string Name
		{
			get
			{
				return _name;
			}
		}

		/// <summary>
		/// Serves as a hash function for a particular type.
		/// </summary>
		/// <returns>A hash code for the current type.</returns>
		public override int GetHashCode()
		{
			int getHashCode =
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode();

			if (String.IsNullOrEmpty(_abbreviatedName) == false)
			{
				getHashCode ^= _abbreviatedName.GetHashCode();
			}

			if (String.IsNullOrEmpty(_name) == false)
			{
				getHashCode ^= _name.GetHashCode();
			}

			return getHashCode;
		}

		/// <summary>
		/// Determines object equality.
		/// </summary>
		/// <param name="value">The object to check against.</param>
		/// <returns>Returns true if the object's internals are the same, otherwise false.</returns>
		public override bool Equals(object value)
		{
			bool equals = false;
			State state = value as State;

			if (state != null)
			{
				equals =
				(
					(_abbreviatedName == state._abbreviatedName) &&
					(_dateCreatedUtc == state._dateCreatedUtc) &&
					(_dateUpdatedUtc == state._dateUpdatedUtc) &&
					(_id == state._id) &&
					(_isDeleted == state._isDeleted) &&
					(_isVisible == state._isDeleted) &&
					(_name == state._name)
				);
			}

			return equals;
		}
	}
}