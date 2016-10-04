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
	public static class CrimeRepository
	{
		public static int AddCrime(int count, int localGovernmentAreaID, int month, int offenceID, int year)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, "Crime.spAddCrime", new { Count = count, LocalGovernmentAreaID = localGovernmentAreaID, Month = month, OffenceID = offenceID, Year = year }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		public static Crime GetCrimeByID(int id)
		{
			Crime crime = null;

			//	using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			//	{
			//		crime = SqlMapper
			//			.Query(sqlConnection, "dbo.spGetCrimeByID", new { ID = id }, commandType: CommandType.StoredProcedure)
			//			.Select(m => new Test(m.ID, m.Value0, m.Value1))
			//			.FirstOrDefault();
			//	}

			return crime;
		}

		public static List<Crime> GetCrimesByCoordinate(double latitude, double longitude, double radius)
		{
			List<Crime> crimes = null;

			//	using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			//	{
			//		crimes = SqlMapper
			//			.Query(sqlConnection, "dbo.spGetCrimesByCoordinate", commandType: CommandType.StoredProcedure, param: new { Latitude = latitude, Longitude = longitude, Radius = radius })
			//			.Select(m => new Crime())
			//			.ToList();
			//	}

			return crimes;
		}
	}
}
