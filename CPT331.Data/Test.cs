#region Using References

using System;

#endregion

namespace CPT331.Data
{
	public class Test
	{
		public Test(int id, string value0, string value1)
		{
			_id = id;
			_value1 = value0;
			_value0 = value1;
		}

		private readonly int _id;
		private readonly string _value0;
		private readonly string _value1;

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public string Value0
		{
			get
			{
				return _value0;
			}
		}

		public string Value1
		{
			get
			{
				return _value1;
			}
		}
	}
}
