#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an Offence type, used to describe an offence.
	/// </summary>
	public class Offence : ReadOnlyDataObject
	{
        /// <summary>
        /// Initialises a new instance of the Offence class to the values provided.
        /// </summary>
        /// <param name="id">Identification number for the Offence record.</param>
        /// <param name="name">The name of the Offence.</param>
		public Offence(int id, string name)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, null)
		{
		}

        /// <summary>
        /// Initialises a new instance of the Offence class to the values provided.
        /// </summary>
        /// <param name="dateCreatedUtc">A time stamp indicating when the Offence was created.</param>
        /// <param name="dateUpdatedUtc">A time stamp indicating when the Offence was last updated.</param>
        /// <param name="id">Identification number for the Offence record.</param>
        /// <param name="isDeleted">Indicates whether or not the record is deleted.</param>
        /// <param name="isVisible">Indicates whether or not the record should be shown in the user interfaces.</param>
        /// <param name="name">The name of the Offence.</param>
        /// <param name="offenceCategoryID">An identification number for parent offence category.</param>
        public Offence(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int? offenceCategoryID)
			: base(dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible)
		{
			_name = name;
			_offenceCategoryID = offenceCategoryID;
		}

		private readonly string _name;
        private readonly int? _offenceCategoryID;

		/// <summary>
		/// Gets the name of the offence.
		/// </summary>
		public string Name
		{
			get
			{
				return _name;
			}
        }

		/// <summary>
		/// Gets the ID of the offence category.
		/// </summary>
		public int? OffenceCategoryID
        {
            get
            {
                return _offenceCategoryID;
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
			Offence offence = value as Offence;

			if (offence != null)
			{
				equals =
				(
					(base.Equals(offence)) &&
					(_name == offence._name) &&
                    (_offenceCategoryID == offence._offenceCategoryID)
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