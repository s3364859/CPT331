#region Using References

using System;
using System.ComponentModel.DataAnnotations;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation for a calendar month.
    /// </summary>
	public class MonthAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks whether the value being checked is between 1 and 12.
        /// </summary>
        /// <param name="value">The value to be checked.</param>
        /// <returns>true if the value represents a calendar month; otherwise false.</returns>
		public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int month = 0;

				if (Int32.TryParse(value.ToString(), out month) == true)
				{
					isValid = ((month > 0) && (month < 13));
				}
			}

			return isValid;
		}
	}
}
