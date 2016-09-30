#region Using References

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

using Dapper;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data
{
	public static class TestRepository
	{
		public static int AddTest(string value0, string value1)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, "dbo.spAddTest", new { Value0 = value0, Value1 = value1 }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		public static void DeleteTestByID(int id)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "dbo.spDeleteTestByID", new { ID = id }, commandType: CommandType.StoredProcedure);
			}
		}

		public static Test GetTestByID(int id)
        {
            Test test = null;

            using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
            {
                test = SqlMapper
                    .Query(sqlConnection, "dbo.spGetTestByID", new { ID = id }, commandType: CommandType.StoredProcedure)
                    .Select(m => new Test(m.ID, m.Value0, m.Value1))
                    .FirstOrDefault();
            }

            return test;
        }

        public static List<Test> GetTests()
		{
			List<Test> getTests = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				getTests = SqlMapper
					.Query(sqlConnection, "dbo.spGetTest", commandType: CommandType.StoredProcedure)
					.Select(m => new Test(m.ID, m.Value0, m.Value1))
					.ToList();
			}

			return getTests;
		}

		public static void UpdateTest(int id, string value0, string value1)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "dbo.spUpdateTest", new { ID = id, Value0 = value0, Value1 = value1 }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
