#region Using References

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

using Dapper;

#endregion

namespace CPT331.Data
{
	public static class TestRepository
	{
		public static List<Test> GetTests()
		{
			List<Test> getTests = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				getTests = SqlMapper
					.Query(sqlConnection, "dbo.spGetTest")
					.Select(m => new Test(m.ID, m.Value0, m.Value1))
					.ToList();
			}

			return getTests;
		}
	}
}
