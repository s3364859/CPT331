#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents an Offence type, used to describe an offence.
	/// </summary>
	public class Offence
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
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
			_offenceCategoryID = offenceCategoryID;
		}

		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly string _name;
        private readonly int? _offenceCategoryID;

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
			int getHashCode =
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode();

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
					(_dateCreatedUtc == offence._dateCreatedUtc) &&
					(_dateUpdatedUtc == offence._dateUpdatedUtc) &&
					(_id == offence._id) &&
					(_isDeleted == offence._isDeleted) &&
					(_isVisible == offence._isDeleted) &&
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