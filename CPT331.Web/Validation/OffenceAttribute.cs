#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation against existing Offence records.
    /// </summary>
    public class OffenceAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks the database for Offence records based on a specified ID value.
        /// </summary>
        /// <param name="value">The ID value for the Offence record.</param>
        /// <returns>true if the Offence exists; otherwise false.</returns>
        public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int id = 0;

				if (Int32.TryParse(value.ToString(), out id) == true)
				{
					Offence offence = DataProvider.OffenceRepository.GetOffenceByID(id);

					isValid = (offence != null);
				}
			}

			return isValid;
		}
	}
}
