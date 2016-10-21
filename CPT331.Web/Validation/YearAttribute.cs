#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
	public class YearAttribute : ValidationAttribute
	{
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
