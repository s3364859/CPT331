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
	public static class LocalGovernmentAreaStateRepository
	{
		public static List<LocalGovernmentAreaState> GetLocalGovernmentAreaStates()
		{
			List<LocalGovernmentAreaState> localGovernmentAreaStates = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreaStates = SqlMapper
					.Query(sqlConnection, "Location.spGetLocalGovernmentAreaState", commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentAreaState(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID, m.StateName))
					.ToList();
			}

			return localGovernmentAreaStates;
		}
	}
}
