#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class Location
	{
		public Location(int id, string name, int stateID)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID)
		{
		}

		public Location(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID)
		{
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
			_stateID = stateID;
		}

		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly string _name;
		private readonly int _stateID;

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

		public int StateID
		{
			get
			{
				return _stateID;
			}
		}

		public override int GetHashCode()
		{
			int getHashCode =
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode() ^
				_stateID.GetHashCode();

			if (String.IsNullOrEmpty(_name) == false)
			{
				getHashCode ^= _name.GetHashCode();
			}

			return getHashCode;
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			Location location = value as Location;

			if (location != null)
			{
				equals =
				(
					(_dateCreatedUtc == location._dateCreatedUtc) &&
					(_dateUpdatedUtc == location._dateUpdatedUtc) &&
					(_id == location._id) &&
					(_isDeleted == location._isDeleted) &&
					(_isVisible == location._isDeleted) &&
					(_name == location._name) &&
					(_stateID == location._stateID)
				);
			}

			return equals;
		}
	}
}