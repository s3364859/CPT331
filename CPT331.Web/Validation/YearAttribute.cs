#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation for a historical calendar year.
    /// </summary>
	public class YearAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks whether the value being checked is between 1 and the present year.
        /// </summary>
        /// <param name="value">The value to be checked.</param>
        /// <returns>true if the value represents a calendar year; otherwise false.</returns>
		public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int year = 0;

				if (Int32.TryParse(value.ToString(), out year) == true)
				{
					isValid = ((year > 0) && (year <= DateTime.Today.Year));
				}
			}

			return isValid;
		}
	}
}
