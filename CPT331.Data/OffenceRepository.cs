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
		public static Offence GetOffenceByID(int id)
		{
			Offence offence = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offence = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffenceByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.ParentID))
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
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.ParentID))
					.ToList();
			}

			return offences;
		}
	}
}
