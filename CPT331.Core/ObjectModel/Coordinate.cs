#region Using References

using System;
using System.Text;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a Coordinate type, used to describe information about a GPS coordinate.
	/// </summary>
	public class Coordinate
	{
		private Coordinate(double latitude, double longitude)
		{
			_latitude = latitude;
			_longitude = longitude;
		}

		/// <summary>
		/// Represents the largest possible value of a latitude. This field is constant.
		/// </summary>
		public const double LatitudeMaxValue = 90;
		/// <summary>
		/// Represents the smallest possible value of a latitude. This field is constant.
		/// </summary>
		public const double LatitudeMinValue = -90;
		/// <summary>
		/// Represents the largest possible value of a longitude. This field is constant.
		/// </summary>
		public const double LongitudeMaxValue = 180;
		/// <summary>
		/// Represents the smallest possible value of a longitude. This field is constant.
		/// </summary>
		public const double LongitudeMinValue = -180;

		private readonly double _latitude;
		private readonly double _longitude;

		/// <summary>
		/// Gets the latitude value of the coordinate.
		/// </summary>
		public double Latitude
		{
			get
			{
				return _latitude;
			}
		}

		/// <summary>
		/// Gets the longitude value of the coordinate.
		/// </summary>
		public double Longitude
		{
			get
			{
				return _longitude;
			}
		}

        /// <summary>
        /// Returns a value indicating whether this instance is equal to a specified CPT331.Core.ObjectModel.Coordinate.
        /// </summary>
        /// <param name="obj">A CPT331.Core.ObjectModel.Coordinate value to compare to this instance.</param>
        /// <returns>true if obj has the same value as this instance; otherwise, false.</returns>
        public override bool Equals(object obj)
		{
			bool equals = false;

			Coordinate coordinate = obj as Coordinate;
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

        /// <summary>
        /// Returns a Hashcode for this instance.
        /// </summary>
        /// <returns>A 32-bit signed integer hash code.</returns>
		public override int GetHashCode()
		{
			return _latitude.GetHashCode() ^ _longitude.GetHashCode();
		}

        /// <summary>
        /// Determines whether the latitude value specified is valid.
        /// </summary>
        /// <param name="latitude">The angular distance of a place north or south of the earth's equator, ranging from -90 to 90.</param>
        /// <returns>Returns true if the value is valid; otherwise false.</returns>
		public static bool IsLatitudeValid(double latitude)
		{
			return
			(
				(latitude >= LatitudeMinValue) &&
				(latitude <= LatitudeMaxValue)
			);
		}

        /// <summary>
        /// Determines whether the longitude value specified is valid.
        /// </summary>
        /// <param name="longitude">The angular distance of a place east or west of the Greenwich meridian, ranging from -180 to 180.</param>
        /// <returns>Returns true if the value is valid; otherwise false.</returns>
		public static bool IsLongitudeValid(double longitude)
		{
			return
			(
				(longitude >= LongitudeMinValue) &&
				(longitude <= LongitudeMaxValue)
			);
		}

        /// <summary>
        /// Determines whether the coordindate values specified are valid.
        /// </summary>
        /// <param name="latitude">The angular distance of a place north or south of the earth's equator, ranging from -90 to 90.</param>
        /// <param name="longitude">The angular distance of a place east or west of the Greenwich meridian, ranging from -180 to 180.</param>
        /// <returns>Returns true if both values are valid; otherwise false.</returns>
		public static bool IsValid(double latitude, double longitude)
		{
			return (IsLatitudeValid(latitude) && IsLongitudeValid(longitude));
		}

        /// <summary>
        /// Factory method that constructs Coorindate object using the specified values.
        /// </summary>
        /// <param name="latitude">The angular distance of a place north or south of the earth's equator, ranging from -90 to 90.</param>
        /// <param name="longitude">The angular distance of a place east or west of the Greenwich meridian, ranging from -180 to 180.</param>
        /// <exception cref="ArgumentException">Values specified do not translate into valid geographical coordinates.</exception>
        /// <returns>An instance of Coorindate if the specified values are valid; otherwise null.</returns>
		public static Coordinate FromValues(double latitude, double longitude)
		{
			Coordinate coordinate = null;

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
			else
			{
				coordinate = new Coordinate(latitude, longitude);	
			}

			return coordinate;
		}

		/// <summary>
		/// Converts the coordinate values to an equivalent string representation.
		/// </summary>
		/// <returns>The string representation of the value of this instance.</returns>
		public override string ToString()
		{
			return $"Latitude = {_latitude}, Longitude = {_longitude}";
		}
    }
}
