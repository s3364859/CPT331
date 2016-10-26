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
    /// The OffenceRepository class provides access to the Offence table in Event-Guardian database.
    /// </summary>
	public static class OffenceRepository
	{
        /// <summary>
        /// Inserts a new record inside the Offence table of the Event-Guardian database.
        /// </summary>
        /// <param name="isDeleted">Indicates whether or not the record is deleted</param>
        /// <param name="isVisible">Indicates whether or not the record should be shown in the user interfaces</param>
        /// <param name="name">The name of the offense</param>
        /// <returns>Offence ID number</returns>
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

        /// <summary>
        /// Searches the Event-Guardian database for an Offence record with a specified Offence ID.
        /// </summary>
        /// <param name="id">Identification number for the Offence record</param>
        /// <returns>An Offence record with the specified ID, or null if no matches were found</returns>
		public static Offence GetOffenceByID(int id)
		{
			Offence offence = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offence = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffenceByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.OffenceCategoryID))
					.FirstOrDefault();
			}

			return offence;
		}

        /// <summary>
        /// Retreives a full list of Offenses inside the Event-Guardian database.
        /// </summary>
        /// <returns>A List of Offence records</returns>
        public static List<Offence> GetOffences()
		{
			List<Offence> offences = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offences = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffence", commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.OffenceCategoryID))
					.ToList();
			}

			return offences;
		}

        /// <summary>
        /// Updates an Offence record inside the Event-Guardian database, using the ID and values provided. 
        /// </summary>
        /// <param name="id">ID indicating the Offence record to be updated</param>
        /// <param name="isDeleted">New value for the IsDeleted column</param>
        /// <param name="isVisible">New value for the IsVisible column</param>
        /// <param name="name">New value for the Name column</param>
        public static void UpdateOffence(int id, bool isDeleted, bool isVisible, string name, int? offenceCategoryID)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "Crime.spUpdateOffence", new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name, OffenceCategoryID = offenceCategoryID }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
