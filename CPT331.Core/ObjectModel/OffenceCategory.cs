#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an OffenceCategory type, used to describe an offence category.
	/// </summary>
	public class OffenceCategory : ReadOnlyDataObject
	{
		/// <summary>
		/// Constructs a new OffenceCategory object.
		/// </summary>
		/// <param name="id">The ID of the offence category record.</param>
		/// <param name="name">The name of the offence category.</param>
		public OffenceCategory(int id, string name)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name)
		{
		}

		/// <summary>
		/// Constructs a new OffenceCategory object.
		/// </summary>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The ID of the offence category record.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		/// <param name="name">The name of the offence category.</param>
		public OffenceCategory(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name)
			: base(dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible)
		{
			_name = name;
		}

		private readonly string _name;

		/// <summary>
		/// Gets the name of the offence category.
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
			int getHashCode = base.GetHashCode();

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
			OffenceCategory offenceCategory = value as OffenceCategory;

			if (offenceCategory != null)
			{
				equals =
				(
					(base.Equals(offenceCategory)) &&
					(_name == offenceCategory._name)
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