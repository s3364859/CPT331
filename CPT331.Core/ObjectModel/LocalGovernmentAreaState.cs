#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a LocalGovernmentAreaState, used to describe local government area and state information.
	/// </summary>
	public class LocalGovernmentAreaState : LocalGovernmentArea
	{
		/// <summary>
		/// Constructs a new LocalGovernmentAreaState object.
		/// </summary>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="abbreviatedName">The abbreviated name of the state or territory.</param>
		/// <param name="name">The name of the local government area.</param>
		/// <param name="stateID">The unique ID of the state or territory.</param>
		/// <param name="stateName">The name of the state or territory.</param>
		public LocalGovernmentAreaState(int id, string abbreviatedName, string name, int stateID, string stateName)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID, stateName)
		{
		}

		/// <summary>
		/// Constructs a new LocalGovernmentAreaState object.
		/// </summary>
		/// <param name="abbreviatedName">The abbreviated name of the state or territory.</param>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		/// <param name="name">The name of the local government area.</param>
		/// <param name="stateID">The unique ID of the state or territory.</param>
		/// <param name="stateName">The name of the state or territory.</param>
		public LocalGovernmentAreaState(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID, string stateName)
			: base (dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible, name, stateID)
		{
			_abbreviatedName = abbreviatedName;
			_stateName = stateName;
		}

		private readonly string _abbreviatedName;
		private readonly string _stateName;

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
		/// Gets the name of the state or territory.
		/// </summary>
		public string StateName
		{
			get
			{
				return _stateName;
			}
		}

		/// <summary>
		/// Serves as a hash function for a particular type.
		/// </summary>
		/// <returns>A hash code for the current type.</returns>
		public override int GetHashCode()
		{
			int getHashCode = base.GetHashCode();

			if (String.IsNullOrEmpty(_abbreviatedName) == false)
			{
				getHashCode ^= _abbreviatedName.GetHashCode();
			}

			if (String.IsNullOrEmpty(_stateName) == false)
			{
				getHashCode ^= _stateName.GetHashCode();
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
			LocalGovernmentAreaState localGovernmentAreaState = value as LocalGovernmentAreaState;

			if (localGovernmentAreaState != null)
			{
				equals =
				(
					(base.Equals(localGovernmentAreaState)) &&
					(_abbreviatedName == localGovernmentAreaState._abbreviatedName) &&
					(_stateName == localGovernmentAreaState._stateName)
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
			return $"{Name} ({_abbreviatedName} - {_stateName})";
		}
	}
}