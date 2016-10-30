#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
    /// <summary>
    /// Provides validation against existing LocalGovernmentArea records.
    /// </summary>
	public class LocalGovernmentAreaAttribute : ValidationAttribute
	{
        /// <summary>
        /// Checks the database for LocalGovernmentAreas records based on a specified ID value.
        /// </summary>
        /// <param name="value">The ID value for the LocalGovernmentArea record.</param>
        /// <returns>true if the LocalGovernmentArea exists; otherwise false.</returns>
		public override bool IsValid(object value)
		{
			bool isValid = false;

			if (value != null)
			{
				int id = 0;

				if (Int32.TryParse(value.ToString(), out id) == true)
				{
					LocalGovernmentArea localGovernmentArea = DataProvider.LocalGovernmentAreaRepository.GetLocalGovernmentAreaByID(id);

					isValid = (localGovernmentArea != null);
				}
			}

			return isValid;
		}
	}
}
