#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class LocalGovernmentAreaState : LocalGovernmentArea
	{
		public LocalGovernmentAreaState(int id, string abbreviatedName, string name, int stateID, string stateName)
			: this(abbreviatedName, DateTime.UtcNow, DateTime.UtcNow, id, false, true, name, stateID, stateName)
		{
		}

		public LocalGovernmentAreaState(string abbreviatedName, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, string name, int stateID, string stateName)
			: base (dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible, name, stateID)
		{
			_abbreviatedName = abbreviatedName;
			_stateName = stateName;
		}

		private readonly string _abbreviatedName;
		private readonly string _stateName;

		public string AbbreviatedName
		{
			get
			{
				return _abbreviatedName;
			}
		}


		public string StateName
		{
			get
			{
				return _stateName;
			}
		}

		public override int GetHashCode()
		{
			int getHashCode = base.GetHashCode();

			if (String.IsNullOrEmpty(_abbreviatedName) == false)
			{
				getHashCode ^= _abbreviatedName.GetHashCode();
			}

			if (String.IsNullOrEmpty(_stateName) == false)
			{
				getHashCode ^= _stateName.GetHashCode();
			}

			return getHashCode;
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			LocalGovernmentAreaState localGovernmentAreaState = value as LocalGovernmentAreaState;

			if (localGovernmentAreaState != null)
			{
				equals =
				(
					(base.Equals(localGovernmentAreaState)) &&
					(_abbreviatedName == localGovernmentAreaState._abbreviatedName) &&
					(_stateName == localGovernmentAreaState._stateName)
				);
			}

			return equals;
		}

		public override string ToString()
		{
			return $"{Name} ({_abbreviatedName} - {_stateName})";
		}
	}
}