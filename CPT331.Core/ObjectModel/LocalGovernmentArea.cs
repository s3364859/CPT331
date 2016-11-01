#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a LocalGovernmentArea type, used to describe a local govenment area.
	/// </summary>
	public class LocalGovernmentArea : ReadOnlyDataObject
	{
		/// <summary>
		/// Constructs a new LocalGovernmentArea object.
		/// </summary>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="name">The name of the local government area.</param>
		/// <param name="stateID">The unique ID of the state that the local government area resides in.</param>
		public LocalGovernmentArea(int id, string name, int stateID)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID)
		{
		}

		/// <summary>
		/// Constructs a new LocalGovernmentArea object.
		/// </summary>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		/// <param name="name">The name of the local government area.</param>
		/// <param name="stateID">The unique ID of the state that the local government area resides in.</param>
		public LocalGovernmentArea(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID)
			: base(dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible)
		{
			_name = name;
			_stateID = stateID;
		}

		private readonly string _name;
		private readonly int _stateID;

		/// <summary>
		/// Gets the namne of the local government area.
		/// </summary>
		public string Name
		{
			get
			{
				return _name;
			}
		}

		/// <summary>
		/// Gets the ID of the state that the local government area resides within.
		/// </summary>
		public int StateID
		{
			get
			{
				return _stateID;
			}
		}

		/// <summary>
		/// Serves as a hash function for a particular type.
		/// </summary>
		/// <returns>A hash code for the current type.</returns>
		public override int GetHashCode()
		{
			int getHashCode = base.GetHashCode() ^ _stateID.GetHashCode();

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
			LocalGovernmentArea localGovernmentArea = value as LocalGovernmentArea;

			if (localGovernmentArea != null)
			{
				equals =
				(
					(base.Equals(localGovernmentArea)) &&
					(_name == localGovernmentArea._name) &&
					(_stateID == localGovernmentArea._stateID)
				);
			}

			return equals;
		}

		/// <summary>
		/// Returns a string that represents the current object.
		/// </summary>
		/// <returns>A string that represents the current object.</returns>
		public override string ToString()
		{
			return _name;
		}
	}
}