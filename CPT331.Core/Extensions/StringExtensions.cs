#region Using References

using System;

#endregion

namespace CPT331.Core.Extensions
{
	public static class StringExtensions
	{
		public static bool EqualsIgnoreCase(this string value, string compareTo)
		{
			return value.Equals(compareTo, StringComparison.OrdinalIgnoreCase);
		}
	}
}
