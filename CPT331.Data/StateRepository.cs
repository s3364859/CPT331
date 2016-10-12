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
	public static class StateRepository
	{
		public static int AddState(string abbreviatedName, bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, "Location.spAddState", new { AbbreviatedName = abbreviatedName, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		public static State GetStateByAbbreviatedName(string abbreviatedName)
		{
			State state = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				state = SqlMapper
					.Query(sqlConnection, "Location.spGetStateByAbbreviatedName", new { AbbreviatedName = abbreviatedName }, commandType: CommandType.StoredProcedure)
					.Select(m => new State(m.AbbreviatedName, m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return state;
		}

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

		public static void UpdateState(int id, string abbreviatedName, bool isDeleted, bool isVisible, string name)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "Location.spUpdateState", new { ID = id, AbbreviatedName = abbreviatedName, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
