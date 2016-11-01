#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation against existing OffenceCategory records.
    /// </summary>
	public class OffenceCategoryAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks the database for OffenceCategory records based on a specified ID value.
        /// </summary>
        /// <param name="value">The ID value for the Offence record.</param>
        /// <returns>true if the Offence exists; true if the value argument was null; otherwise false.</returns>
        public override bool IsValid(object value)
		{
            bool isValid = false;

            if (value != null)
            {
                int id = 0;

                if (Int32.TryParse(value.ToString(), out id) == true)
                {
                    OffenceCategory localGovernmentArea = DataProvider.OffenceCategoryRepository.GetOffenceCategoryByID(id);

                    isValid = (localGovernmentArea != null);
                }
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }
    }
}
