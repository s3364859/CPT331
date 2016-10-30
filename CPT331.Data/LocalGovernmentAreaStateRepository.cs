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
	/// <summary>
	/// Represents an LocalGovernmentAreaStateRepository type, used to local government area and state or territory data.
	/// </summary>
	public class LocalGovernmentAreaStateRepository : Repository
	{
		/// <summary>
		/// The Location.spGetLocalGovernmentAreaState stored procedure name.
		/// </summary>
		public const string LocationSpGetLocalGovernmentAreaState = "Location.spGetLocalGovernmentAreaState";

		/// <summary>
		/// Selects all local government area and state or territory information from the underlying data source.
		/// </summary>
		/// <returns>Returns a list of LocalGovernmentAreaState objects representing the result of the operation.</returns>
		public List<LocalGovernmentAreaState> GetLocalGovernmentAreaStates()
		{
			List<LocalGovernmentAreaState> localGovernmentAreaStates = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreaStates = SqlMapper
					.Query(sqlConnection, LocationSpGetLocalGovernmentAreaState, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentAreaState(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID, m.StateName))
					.ToList();
			}

			return localGovernmentAreaStates;
		}
	}
}
