#region Using References

using System;
using System.Security.Cryptography;
using System.Text;

#endregion

namespace CPT331.Core.Extensions
{
	public static class StringExtensions
	{
		private static SHA1CryptoServiceProvider _sha1CryptoServiceProvider;

		public static bool EqualsIgnoreCase(this string value, string compareTo)
		{
			return value.Equals(compareTo, StringComparison.OrdinalIgnoreCase);
		}

		public static string Hash(this string value)
		{
			if (_sha1CryptoServiceProvider == null)
			{
				_sha1CryptoServiceProvider = new SHA1CryptoServiceProvider();
			}

			byte[] bytes = Encoding.UTF8.GetBytes(value);
			return Convert.ToBase64String(_sha1CryptoServiceProvider.ComputeHash(bytes));
		}
	}
}
