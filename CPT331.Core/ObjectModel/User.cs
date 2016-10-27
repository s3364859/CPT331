#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class User
	{
		public User(int id, string password, string username)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, true, false, password, username)
		{
		}

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

		public bool IsActive
		{
			get
			{
				return _isActive;
			}
		}

		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
		}

		public string Password
		{
			get
			{
				return _password;
			}
		}

		public string Username
		{
			get
			{
				return _username;
			}
		}

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