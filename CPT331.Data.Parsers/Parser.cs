#region Using References

using System;
using System.Collections.Generic;

#endregion

namespace CPT331.Data.Parsers
{
	public class Parser
	{
		public Parser(string fileName)
		{
			_fileName = fileName;
		}

		private readonly string _fileName;

		//	Fill this in later with the actual model required (T)
		public virtual List<T> Parse<T>()
		{
			return null;
		}
	}
}
