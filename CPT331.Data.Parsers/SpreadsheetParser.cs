#region Using References

using System;
using System.Collections.Generic;

#endregion

namespace CPT331.Data.Parsers
{
	public class SpreadsheetParser : Parser
	{
		public SpreadsheetParser(string fileName)
			: base(fileName)
		{
		}

		//	Change this to return the correct model
		public override List<T> Parse<T>()
		{
			return base.Parse<T>();
		}
	}
}
