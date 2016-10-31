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
	/// Represents an StateRepository type, used to manipulate state data.
	/// </summary>
	public static class StateRepository
	{
		/// <summary>
		/// The Location.spAddState stored procedure name.
		/// </summary>
		public const string LocationSpAddState = "Location.spAddState";

		/// <summary>
		/// The Location.spGetStateByAbbreviatedName stored procedure name.
		/// </summary>
		public const string LocationSpGetStateByAbbreviatedName = "Location.spGetStateByAbbreviatedName";

		/// <summary>
		/// The Location.spGetStateByID stored procedure name.
		/// </summary>
		public const string LocationSpGetStateByID = "Location.spGetStateByID";

		/// <summary>
		/// The Location.spGetState stored procedure name.
		/// </summary>
		public const string LocationSpGetState = "Location.spGetState";

		/// <summary>
		/// The Location.spUpdateState stored procedure name.
		/// </summary>
		public const string LocationSpUpdateState = "Location.spUpdateState";

		/// <summary>
		/// Inserts state or territory information into the underlying data source.
		/// </summary>
		/// <param name="abbreviatedName">The state or territory name in abbreviated form.</param>
		/// <param name="isDeleted">Specifies whether the offence category is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the offence category is flagged as visible.</param>
		/// <param name="name">The name of the state or territory.</param>
		/// <returns></returns>
		public static int AddState(string abbreviatedName, bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, LocationSpAddState, new { AbbreviatedName = abbreviatedName, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		/// <summary>
		/// Selects state or territory information from the underlying data source.
		/// </summary>
		/// <param name="abbreviatedName">The state or territory name in abbreviated form.</param>
		/// <returns>Returns a State object representing the result of the operation.</returns>
		public static State GetStateByAbbreviatedName(string abbreviatedName)
		{
			State state = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				state = SqlMapper
					.Query(sqlConnection, LocationSpGetStateByAbbreviatedName, new { AbbreviatedName = abbreviatedName }, commandType: CommandType.StoredProcedure)
					.Select(m => new State(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return state;
		}

		/// <summary>
		/// Selects state or territory information from the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the corresponding state or territory information.</param>
		/// <returns>Returns a State object representing the result of the operation.</returns>
		public static State GetStateByID(int id)
		{
			State state = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				state = SqlMapper
					.Query(sqlConnection, "Location.spGetStateByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new State(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return state;
		}

		/// <summary>
		/// Selects all state or territory information from the underlying data source.
		/// </summary>
		/// <returns>Returns a list of State objects representing the result of the operation.</returns>
		public static List<State> GetStates()
		{
			List<State> states = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				states = SqlMapper
					.Query(sqlConnection, "Location.spGetState", commandType: CommandType.StoredProcedure)
					.Select(m => new State(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.ToList();
			}

			return states;
		}

		/// <summary>
		/// Updates state or territory information in the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated state or territory.</param>
		/// <param name="abbreviatedName">The state or territory name in abbreviated form.</param>
		/// <param name="isDeleted">Specifies whether the offence category is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the offence category is flagged as visible.</param>
		/// <param name="name">The name of the state or territory.</param>
		public static void UpdateState(int id, string abbreviatedName, bool isDeleted, bool isVisible, string name)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "Location.spUpdateState", new { ID = id, AbbreviatedName = abbreviatedName, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
