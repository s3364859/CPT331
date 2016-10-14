#region Using References

using System;

#endregion

namespace CPT331.Web.Models.Admin
{
	public class AdminModel
	{
		private bool _isDelete;

		public bool IsDelete
		{
			get
			{
				return _isDelete;
			}
			set
			{
				_isDelete = value;
			}
		}
	}
}
