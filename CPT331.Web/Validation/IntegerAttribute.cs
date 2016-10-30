#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation for the Interger type (System.Int32).
    /// </summary>
	public class IntegerAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks whether the value specified is a valid Integer number.
        /// </summary>
        /// <param name="value">The value to be checked.</param>
        /// <returns>true if the value is valid; otherwise false.</returns>
		public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int integer = 0;

				isValid = Int32.TryParse(value.ToString(), out integer);
			}

			return isValid;
		}
	}
}
