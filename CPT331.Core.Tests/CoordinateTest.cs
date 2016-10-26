#region Using References

using System;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Core.Tests
{
	[TestClass]
	public class CoordinateTest
	{
		public CoordinateTest()
		{
			_random = new Random();
		}

		private Random _random;

		[TestMethod]
		public void CoordinateTest_InvalidLatitude()
		{
			double latitude = (_random.NextDouble() * 100000);

			Assert.IsFalse(Coordinate.IsLatitudeValid(latitude));
		}

		[TestMethod]
		public void CoordinateTest_InvalidLongitude()
		{
			double longitude = (_random.NextDouble() * 100000);

			Assert.IsFalse(Coordinate.IsLongitudeValid(longitude));
		}

		[TestMethod]
		public void CoordinateTest_ValidLatitude()
		{
			double latitude = (double)(_random.Next((int)(Coordinate.LatitudeMinValue), (int)(Coordinate.LatitudeMaxValue)));

			Assert.IsTrue(Coordinate.IsLatitudeValid(latitude));
		}

		[TestMethod]
		public void CoordinateTest_ValidLongitude()
		{
			double longitude = (double)(_random.Next((int)(Coordinate.LongitudeMinValue), (int)(Coordinate.LongitudeMaxValue)));

			Assert.IsTrue(Coordinate.IsLongitudeValid(longitude));
		}
	}
}
