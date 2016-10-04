#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class LocalGovernmentAreaLocation
	{
		public LocalGovernmentAreaLocation(int localGovernmentAreaID, int locationID)
		{
			_localGovernmentAreaID = localGovernmentAreaID;
			_locationID = locationID;

		}

		private readonly int _localGovernmentAreaID;
		private readonly int _locationID;

		public int LocalGovernmentAreaID
		{
			get
			{
				return _localGovernmentAreaID;
			}
		}

		public int LocationID
		{
			get
			{
				return _locationID;
			}
		}

		public override int GetHashCode()
		{
			return _localGovernmentAreaID.GetHashCode() ^ _locationID.GetHashCode();
		}

		public override bool Equals(object value)
		{
			bool equals = false;
			LocalGovernmentAreaLocation localGovernmentAreaLocation = value as LocalGovernmentAreaLocation;

			if (localGovernmentAreaLocation != null)
			{
				equals =
				(
					(_localGovernmentAreaID == localGovernmentAreaLocation._localGovernmentAreaID) &&
					(_locationID == localGovernmentAreaLocation._locationID)
				);
			}

			return equals;
		}
	}
}