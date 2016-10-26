#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class Offence
	{
        /// <summary>
        /// Initialises a new instance of the Offence class to the values provided.
        /// </summary>
        /// <param name="id">Identification number for the Offence record</param>
        /// <param name="name">The name of the Offence</param>
		public Offence(int id, string name)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, null)
		{
		}

        /// <summary>
        /// Initialises a new instance of the Offence class to the values provided.
        /// </summary>
        /// <param name="dateCreatedUtc">A time stamp indicating when the Offence was created.</param>
        /// <param name="dateUpdatedUtc">A time stamp indicating when the Offence was last updated.</param>
        /// <param name="id">Identification number for the Offence record</param>
        /// <param name="isDeleted">Indicates whether or not the record is deleted</param>
        /// <param name="isVisible">Indicates whether or not the record should be shown in the user interfaces</param>
        /// <param name="name">The name of the Offence</param>
        /// <param name="offenceCategoryID">An identification number for parent offence category</param>
        public Offence(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int? offenceCategoryID)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
		}

		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly string _name;
        private readonly int? _offenceCategoryID;

        public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
		}

		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
		}

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
		}

		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
		}

		public string Name
		{
			get
			{
				return _name;
			}
        }
        public int? OffenceCategoryID
        {
            get
            {
                return _offenceCategoryID;
            }
        }

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

		public override string ToString()
		{
			return _name;
		}
	}
}