#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class OffenceCategory
	{
		public OffenceCategory(int id, string name)
			: this(DateTime.UtcNow, DateTime.UtcNow, id, false, true, name)
		{
		}

		public OffenceCategory(DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name)
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

			if (String.IsNullOrEmpty(_name) == false)
			{
				getHashCode ^= _name.GetHashCode();
			}

			return getHashCode;
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			OffenceCategory offenceCategory = value as OffenceCategory;

			if (offenceCategory != null)
			{
				equals =
				(
					(_dateCreatedUtc == offenceCategory._dateCreatedUtc) &&
					(_dateUpdatedUtc == offenceCategory._dateUpdatedUtc) &&
					(_id == offenceCategory._id) &&
					(_isDeleted == offenceCategory._isDeleted) &&
					(_isVisible == offenceCategory._isDeleted) &&
					(_name == offenceCategory._name)
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