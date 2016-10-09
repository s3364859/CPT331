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

		public static List<CrimeByCoordinate> GetCrimesByCoordinate(double latitude, double longitude)
		{
			List<CrimeByCoordinate> crimeByCoordinates = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				crimeByCoordinates = SqlMapper
					.Query(sqlConnection, "Crime.spGetCrimesByCoordinate", commandType: CommandType.StoredProcedure, param: new { Latitude = latitude, Longitude = longitude })
					.Select(m => new CrimeByCoordinate(m.BeginYear, m.EndYear, m.Name, m.OffenceCount, m.OffenceID, m.Offence))
					.ToList();
			}

			return crimeByCoordinates;
		}
	}
}
