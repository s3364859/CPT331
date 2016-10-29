#region Using References

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

using Dapper;

using CPT331.Core;
using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents a CrimeOffenceLocalGovernmentAreaStateRepository type, used to manipulate crime, offence, local government area, and state or territory data.
	/// </summary>
	public class CrimeOffenceLocalGovernmentAreaStateRepository : Repository
	{
		/// <summary>
		/// The Crime.spGetCrimeOffenceLocalGovernmentAreaStateByID stored procedure name.
		/// </summary>
		public const string CrimeSpGetCrimeOffenceLocalGovernmentAreaStateByID = "Crime.spGetCrimeOffenceLocalGovernmentAreaStateByID";

		/// <summary>
		/// The Crime.spGetCrimeOffenceLocalGovernmentAreaState stored procedure name.
		/// </summary>
		public const string CrimeSpGetCrimeOffenceLocalGovernmentAreaState = "Crime.spGetCrimeOffenceLocalGovernmentAreaState";

		/// <summary>
		/// Selects crime information from the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated crime information.</param>
		/// <returns>Returns a Crime object representing the result of the operation.</returns>
		public CrimeOffenceLocalGovernmentAreaState GetCrimeOffenceLocalGovernmentAreaStateByID(int id)
		{
			CrimeOffenceLocalGovernmentAreaState crimeOffenceLocalGovernmentAreaState = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				crimeOffenceLocalGovernmentAreaState = SqlMapper
					.Query(sqlConnection, CrimeSpGetCrimeOffenceLocalGovernmentAreaStateByID, new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new CrimeOffenceLocalGovernmentAreaState
					(
						m.Count,
						m.DateCreatedUtc,
						m.DateUpdatedUtc,
						m.ID,
						m.IsDeleted,
						m.IsVisible,
						m.LocalGovernmentAreaID,
						m.LocalGovernmentAreaName,
						m.Month,
						m.OffenceID,
						m.OffenceName,
						m.StateID,
						m.StateName,
						m.Year
					))
					.FirstOrDefault();
			}

			return crimeOffenceLocalGovernmentAreaState;
		}

		/// <summary>
		/// Gets all crime information from the database.
		/// </summary>
		/// <returns>Returns a list of Crime objects representing the result of the operation.</returns>
		public List<CrimeOffenceLocalGovernmentAreaState> GetCrimeOffenceLocalGovernmentAreaStates(int skip, int take, string orderBy, string sortDirection)
		{
			List<CrimeOffenceLocalGovernmentAreaState> crimeOffenceLocalGovernmentAreaStates = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				crimeOffenceLocalGovernmentAreaStates = SqlMapper
					.Query(sqlConnection, CrimeSpGetCrimeOffenceLocalGovernmentAreaState, new { Skip = skip, Take = take, OrderBy = orderBy, SortDirection = sortDirection }, commandType: CommandType.StoredProcedure)
					.Select(m => new CrimeOffenceLocalGovernmentAreaState
					(
						m.Count,
						m.DateCreatedUtc,
						m.DateUpdatedUtc,
						m.ID,
						m.IsDeleted,
						m.IsVisible,
						m.LocalGovernmentAreaID,
						m.LocalGovernmentAreaName,
						m.Month,
						m.OffenceID,
						m.OffenceName,
						m.StateID,
						m.StateName,
						m.Year
					))
					.ToList();
			}

			return crimeOffenceLocalGovernmentAreaStates;
		}
	}
}
