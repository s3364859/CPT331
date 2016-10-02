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
	public static class LocalGovernmentAreaRepository
	{
		public static LocalGovernmentArea GetLocalGovernmentAreaByID(int id)
		{
			LocalGovernmentArea localGovernmentArea = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentArea = SqlMapper
					.Query(sqlConnection, "Location.spGetLocalGovernmentAreaByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.FirstOrDefault();
			}

			return localGovernmentArea;
		}

		public static List<LocalGovernmentArea> GetLocalGovernmentAreasByStateID(int stateID)
		{
			List<LocalGovernmentArea> localGovernmentAreas = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreas = SqlMapper
					.Query(sqlConnection, "Location.spGetLocalGovernmentAreasByStateID", new { StateID = stateID }, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.ToList();
			}

			return localGovernmentAreas;
		}

		public static List<LocalGovernmentArea> GetLocalGovernmentAreas()
		{
			List<LocalGovernmentArea> localGovernmentAreas = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreas = SqlMapper
					.Query(sqlConnection, "Location.spGetLocalGovernmentArea", commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.ToList();
			}

			return localGovernmentAreas;
		}
	}
}
