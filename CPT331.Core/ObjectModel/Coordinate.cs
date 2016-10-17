#region Using References

using System;

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

        public static bool TryCoordinate(double latitude, double longitude, out Coordinate output)
        {
            try
            {
                output = new Coordinate(latitude, longitude);
                return true;
            }
            catch {}
            output = null;
            return false;
        }

        private void ValidateCordinate(double latitude, double longitude)
        {
            string errorMessage = "";
            if (latitude < -90 || latitude > 90)
            {
                errorMessage += "\r\nInvalid latitude, must be between -90 and 90.";
            }
            if (longitude < -180 || longitude > 180)
            {
                errorMessage += "\r\nInvalid longitude, must be between -180 and 180.";
            }
            if (errorMessage.Length > 0)
            {
                throw new ArgumentException("Invalid coordinates" + errorMessage);
            }
        }
    }
}
