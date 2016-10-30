#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a User type, used to describe the properties of a user.
	/// </summary>
	public class User
	{
		/// <summary>
		/// Constructs a new User type.
		/// </summary>
		/// <param name="id">The unique ID of the user.</param>
		/// <param name="password">The user password value.</param>
		/// <param name="username">The username value.</param>
		public User(int id, string password, string username)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, true, false, password, username)
		{
		}

		/// <summary>
		/// Constructs a new User type.
		/// </summary>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the user.</param>
		/// <param name="isActive">A boolean value indicating an active record.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="password">The user password value.</param>
		/// <param name="username">The username value.</param>
		public User(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isActive, bool isDeleted, string password, string username)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isActive = isActive;
			_isDeleted = isDeleted;
			_password = password;
			_username = username;
		}

		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isActive;
		private readonly bool _isDeleted;
		private readonly string _password;
		private readonly string _username;

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
		/// Gets a boolean value indicating whether this record is considered active.
		/// </summary>
		public bool IsActive
		{
			get
			{
				return _isActive;
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
		/// Gets the password value.
		/// </summary>
		public string Password
		{
			get
			{
				return _password;
			}
		}

		/// <summary>
		/// Gets the username value.
		/// </summary>
		public string Username
		{
			get
			{
				return _username;
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
				_isActive.GetHashCode() ^
				_isDeleted.GetHashCode();

			if (String.IsNullOrEmpty(_password) == false)
			{
				getHashCode ^= _password.GetHashCode();
			}

			if (String.IsNullOrEmpty(_username) == false)
			{
				getHashCode ^= _username.GetHashCode();
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
			User user = value as User;

			if (user != null)
			{
				equals =
				(
					(_dateCreatedUtc == user._dateCreatedUtc) &&
					(_dateUpdatedUtc == user._dateUpdatedUtc) &&
					(_id == user._id) &&
					(_isActive == user._isActive) &&
					(_isDeleted == user._isDeleted) &&
					(_password == user._password) &&
					(_username == user._username)
				);
			}

			return equals;
		}
	}
}