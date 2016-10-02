#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class State
	{
		public State(string abbreviatedName, int id, string name)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name)
		{
		}

		public State(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name)
		{
			_abbreviatedName = abbreviatedName;
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_name = name;
		}

		private readonly string _abbreviatedName;
		private readonly DateTime _dateCreatedUtc;
		private readonly DateTime _dateUpdatedUtc;
		private readonly int _id;
		private readonly bool _isDeleted;
		private readonly bool _isVisible;
		private readonly string _name;

		public string AbbreviatedName
		{
			get
			{
				return _abbreviatedName;
			}
		}

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

		public override int GetHashCode()
		{
			int getHashCode =
				_dateCreatedUtc.GetHashCode() ^
				_dateUpdatedUtc.GetHashCode() ^
				_id.GetHashCode() ^
				_isDeleted.GetHashCode() ^
				_isVisible.GetHashCode();

			if (String.IsNullOrEmpty(_abbreviatedName) == false)
			{
				getHashCode ^= _abbreviatedName.GetHashCode();
			}

			if (String.IsNullOrEmpty(_name) == false)
			{
				getHashCode ^= _name.GetHashCode();
			}

			return getHashCode;
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			State state = value as State;

			if (state != null)
			{
				equals =
				(
					(_abbreviatedName == state._abbreviatedName) &&
					(_dateCreatedUtc == state._dateCreatedUtc) &&
					(_dateUpdatedUtc == state._dateUpdatedUtc) &&
					(_id == state._id) &&
					(_isDeleted == state._isDeleted) &&
					(_isVisible == state._isDeleted) &&
					(_name == state._name)
				);
			}

			return equals;
		}
	}
}