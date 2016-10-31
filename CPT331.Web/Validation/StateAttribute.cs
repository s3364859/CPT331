#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation against existing State records.
    /// </summary>
	public class StateAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks the database for State records based on a specified ID value.
        /// </summary>
        /// <param name="value">The ID value for the State record.</param>
        /// <returns>true if the State exists; otherwise false.</returns>
        public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int id = 0;

				if (Int32.TryParse(value.ToString(), out id) == true)
				{
					State state = StateRepository.GetStateByID(id);

					isValid = (state != null);
				}
			}

			return isValid;
		}
	}
}
