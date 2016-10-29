#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a ReadOnlyDataObject type, which contains immutable information obtained fron a data source.
	/// </summary>
	public class ReadOnlyDataObject
	{
		/// <summary>
		/// Constructs a new ReadOnlyDataObject object.
		/// </summary>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		protected ReadOnlyDataObject(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
		}

		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;

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
		/// Gets the unique ID value of the crime.
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
		/// Serves as a hash function for a particular type.
		/// </summary>
		/// <returns>A hash code for the current type.</returns>
		public override int GetHashCode()
		{
			return
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode();
		}

		/// <summary>
		/// Determines object equality.
		/// </summary>
		/// <param name="value">The object to check against.</param>
		/// <returns>Returns true if the object's internals are the same, otherwise false.</returns>
		public override bool Equals(object value)
		{
			bool equals = false;
			ReadOnlyDataObject sqlDataObject = value as ReadOnlyDataObject;

			if (sqlDataObject != null)
			{
				equals =
				(
					(_dateCreatedUtc == sqlDataObject._dateCreatedUtc) &&
					(_dateUpdatedUtc == sqlDataObject._dateUpdatedUtc) &&
					(_id == sqlDataObject._id) &&
					(_isDeleted == sqlDataObject._isDeleted) &&
					(_isVisible == sqlDataObject._isDeleted)
				);
			}

			return equals;
		}
	}
}
