#region Using References

using System;
using System.ComponentModel.DataAnnotations;

using CPT331.Core.ObjectModel;
using CPT331.Data;

#endregion

namespace CPT331.Web.Validation
{
	public class IntegerAttribute : ValidationAttribute
	{
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
