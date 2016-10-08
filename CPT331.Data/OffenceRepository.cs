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
	public static class OffenceRepository
	{
		public static int AddOffence(bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, "Crime.spAddOffence", new { IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		public static Offence GetOffenceByID(int id)
		{
			Offence offence = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offence = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffenceByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return offence;
		}

		public static List<Offence> GetOffences()
		{
			List<Offence> offences = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offences = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffence", commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.ToList();
			}

			return offences;
		}

		public static void UpdateOffence(int id, bool isDeleted, bool isVisible, string name)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "Crime.spUpdateOffence", new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
