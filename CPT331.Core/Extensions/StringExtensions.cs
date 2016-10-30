#region Using References

using System;
using System.Security.Cryptography;
using System.Text;

#endregion

namespace CPT331.Core.Extensions
{
	/// <summary>
	/// Provides System.String type extensions.
	/// </summary>
	public static class StringExtensions
	{
		/// <summary>
		/// Performs a case-insensitive comparison.
		/// </summary>
		/// <param name="value">The string to compare.</param>
		/// <param name="compareTo">The string to compare to.</param>
		/// <returns>Returns true for a match, otherwise false.</returns>
		public static bool EqualsIgnoreCase(this string value, string compareTo)
		{
			return value.Equals(compareTo, StringComparison.OrdinalIgnoreCase);
		}

		/// <summary>
		/// Generates a hash from the supplied value.
		/// </summary>
		/// <param name="value">The value to hash.</param>
		/// <returns>Returns a hashed representation of the supplied value.</returns>
		public static string Hash(this string value)
		{
			string hash = "";

			if (String.IsNullOrEmpty(value) == false)
			{
				SHA1CryptoServiceProvider _sha1CryptoServiceProvider = new SHA1CryptoServiceProvider();
				byte[] bytes = Encoding.UTF8.GetBytes(value);
				hash = Convert.ToBase64String(_sha1CryptoServiceProvider.ComputeHash(bytes));
			}

			return hash;
		}
	}
}
