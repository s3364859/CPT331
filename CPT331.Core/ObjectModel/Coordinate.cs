#region Using References

using System;
using System.Text;

#endregion

namespace CPT331.Core.ObjectModel
{
	public class Coordinate
	{
		public Coordinate(double latitude, double longitude)
		{
            ValidateCordinate(latitude, longitude);

			_latitude = latitude;
			_longitude = longitude;
		}

		public const double LatitudeMaxValue = 90;
		public const double LatitudeMinValue = -90;
		public const double LongitudeMaxValue = 180;
		public const double LongitudeMinValue = -180;

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

		public static bool IsLatitudeValid(double latitude)
		{
			return
			(
				(latitude >= LatitudeMinValue) &&
				(latitude <= LatitudeMaxValue)
			);
		}

		public static bool IsLongitudeValid(double longitude)
		{
			return
			(
				(longitude >= LongitudeMinValue) &&
				(longitude <= LongitudeMaxValue)
			);
		}

		public static bool IsValid(Coordinate value)
		{
			return IsValid(value._latitude, value._longitude);
		}

		public static bool IsValid(double latitude, double longitude)
		{
			return (IsLatitudeValid(latitude) && IsLongitudeValid(longitude));
		}

		public override string ToString()
		{
			return $"Latitude = {_latitude}, Longitude = {_longitude}";
		}

        public static bool TryCoordinate(double latitude, double longitude, out Coordinate output)
        {
			if (IsValid(latitude, longitude) == true)
			{
				output = new Coordinate(latitude, longitude);
			}
			else
			{
				output = null;
			}

			return (output != null);
        }

        private void ValidateCordinate(double latitude, double longitude)
        {
			if (IsValid(latitude, longitude) == false)
			{
				StringBuilder stringBuilder = new StringBuilder(); ;

				if (IsLatitudeValid(latitude) == false)
				{
					stringBuilder.AppendLine($"Invalid latitude, must be between {LatitudeMinValue} and {LatitudeMaxValue}.");
				}

				if (IsLongitudeValid(longitude) == false)
				{
					stringBuilder.AppendLine($"Invalid longitude, must be between {LongitudeMinValue} and {LongitudeMaxValue}.");
				}

				if (stringBuilder.Length > 0)
				{
					throw new ArgumentException($"Invalid coordinates: {stringBuilder.ToString()}");
				}
			}
        }
    }
}
