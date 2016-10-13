#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class Coordinate
	{
		public Coordinate(double latitude, double longitude)
		{
			_latitude = latitude;
			_longitude = longitude;
		}

		private readonly double _latitude;
		private readonly double _longitude;

		public double Latitude
		{
			get
			{
				return _latitude;
			}
		}

		public double Longitude
		{
			get
			{
				return _longitude;
			}
		}

		public override bool Equals(object value)
		{
			bool equals = false;

			Coordinate coordinate = value as Coordinate;
			if (coordinate != null)
			{
				equals =
				(
					(coordinate._latitude == _latitude) &&
					(coordinate._longitude == _longitude)
				);
			}

			return equals;
		}

		public override int GetHashCode()
		{
			return _latitude.GetHashCode() ^ _longitude.GetHashCode();
		}

		public override string ToString()
		{
			return $"Latitude = {_latitude}, Longitude = {_longitude}";
		}
	}
}
