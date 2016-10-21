#region Using References

using System;
using System.ComponentModel.DataAnnotations;

#endregion

namespace CPT331.Web.Validation
{
	public class MonthAttribute : ValidationAttribute
	{
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
