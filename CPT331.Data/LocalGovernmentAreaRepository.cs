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
	/// Represents an LocalGovernmentAreaRepository type, used to manipulate local government area data.
	/// </summary>
	public static class LocalGovernmentAreaRepository
	{
		/// <summary>
		/// The Location.spAddLocalGovernmentArea stored procedure name.
		/// </summary>
		public const string LocationSpAddLocalGovernmentArea = "Location.spAddLocalGovernmentArea";

		/// <summary>
		/// The Location.spGetLocalGovernmentAreaByID stored procedure name.
		/// </summary>
		public const string LocationSpGetLocalGovernmentAreaByID = "Location.spGetLocalGovernmentAreaByID";

		/// <summary>
		/// The Location.spGetLocalGovernmentAreasByStateID stored procedure name.
		/// </summary>
		public const string LocationSpGetLocalGovernmentAreasByStateID = "Location.spGetLocalGovernmentAreasByStateID";

		/// <summary>
		/// The Location.spGetLocalGovernmentArea stored procedure name.
		/// </summary>
		public const string LocationSpGetLocalGovernmentArea = "Location.spGetLocalGovernmentArea";

		/// <summary>
		/// The Location.spUpdateLocalGovernmentArea stored procedure name.
		/// </summary>
		public const string LocationSpUpdateLocalGovernmentArea = "Location.spUpdateLocalGovernmentArea";

		/// <summary>
		/// Inserts local government area information into the underlying data source.
		/// </summary>
		/// <param name="isDeleted">Specifies whether the local government area is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the local government area is flagged as visible.</param>
		/// <param name="name">Specifies the name of the local government area.</param>
		/// <param name="stateID">Specifies the ID of the associated state.</param>
		/// <returns>Returns the newly created ID for a successful operation, otherwise returns 0.</returns>
		public static int AddLocalGovernmentArea(bool isDeleted, bool isVisible, string name, int stateID)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, LocationSpAddLocalGovernmentArea, new { IsDeleted = isDeleted, IsVisible = isVisible, Name = name, StateID = stateID }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		/// <summary>
		/// Selects local government area information from the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated local government area.</param>
		/// <returns>Returns a LocalGovernmentArea object representing the result of the operation.</returns>
		public static LocalGovernmentArea GetLocalGovernmentAreaByID(int id)
		{
			LocalGovernmentArea localGovernmentArea = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentArea = SqlMapper
					.Query(sqlConnection, LocationSpGetLocalGovernmentAreaByID, new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.FirstOrDefault();
			}

			return localGovernmentArea;
		}

		/// <summary>
		/// Selects local government area information from the underlying data source.
		/// </summary>
		/// <param name="stateID">The ID of the associated state that the local government area resides in.</param>
		/// <returns>Returns a list of LocalGovernmentArea objects representing the result of the operation.</returns>
		public static List<LocalGovernmentArea> GetLocalGovernmentAreasByStateID(int stateID)
		{
			List<LocalGovernmentArea> localGovernmentAreas = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreas = SqlMapper
					.Query(sqlConnection, LocationSpGetLocalGovernmentAreasByStateID, new { StateID = stateID }, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.ToList();
			}

			return localGovernmentAreas;
		}

		/// <summary>
		/// Selects all local government area information from the underlying data source.
		/// </summary>
		/// <returns>Returns a list of LocalGovernmentArea objects representing the result of the operation.</returns>
		public static List<LocalGovernmentArea> GetLocalGovernmentAreas()
		{
			List<LocalGovernmentArea> localGovernmentAreas = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				localGovernmentAreas = SqlMapper
					.Query(sqlConnection, LocationSpGetLocalGovernmentArea, commandType: CommandType.StoredProcedure)
					.Select(m => new LocalGovernmentArea(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.StateID))
					.ToList();
			}

			return localGovernmentAreas;
		}

		/// <summary>
		/// Updates local government area information in the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated local government area.</param>
		/// <param name="isDeleted">Specifies whether the local government area is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the local government area is flagged as visible.</param>
		/// <param name="name">Specifies the name of the local government area.</param>
		/// <param name="stateID">Specifies the ID of the associated state.</param>
		public static void UpdateLocalGovernmentArea(int id, bool isDeleted, bool isVisible, string name, int stateID)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, LocationSpUpdateLocalGovernmentArea, new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name, StateID = stateID }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
