#region Using References

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;

using Dapper;

using CPT331.Core.ObjectModel;

#endregion

namespace CPT331.Data
{
    /// <summary>
    /// The OffenceRepository class provides access to the Offence table in Event-Guardian database.
    /// </summary>
	public class OffenceRepository : Repository
	{
		/// <summary>
		/// The Crime.spAddOffence stored procedure name.
		/// </summary>
		public const string CrimeSpAddOffence = "Crime.spAddOffence";

		/// <summary>
		/// The Crime.spGetOffenceByID stored procedure name.
		/// </summary>
		public const string CrimeSpGetOffenceByID = "Crime.spGetOffenceByID";
		
		/// <summary>
		/// The Crime.spGetOffence stored procedure name.
		/// </summary>
		public const string CrimeSpGetOffence = "Crime.spGetOffence";
		
		/// <summary>
		/// The Crime.spUpdateOffence stored procedure name.
		/// </summary>
		public const string CrimeSpUpdateOffence = "Crime.spUpdateOffence";

        /// <summary>
        /// Inserts a new record inside the Offence table of the Event-Guardian database.
        /// </summary>
        /// <param name="isDeleted">Indicates whether or not the record is deleted</param>
        /// <param name="isVisible">Indicates whether or not the record should be shown in the user interfaces</param>
        /// <param name="name">The name of the offence</param>
        /// <returns>Offence ID number</returns>
		public int AddOffence(bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, CrimeSpAddOffence, new { IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
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
		public Offence GetOffenceByID(int id)
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
        /// Retreives a full list of Offences inside the Event-Guardian database.
        /// </summary>
        /// <returns>A List of Offence records</returns>
        public List<Offence> GetOffences()
		{
			List<Offence> offences = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offences = SqlMapper
					.Query(sqlConnection, CrimeSpGetOffence, commandType: CommandType.StoredProcedure)
					.Select(m => new Offence(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name, m.OffenceCategoryID))
					.ToList();
			}

			return offences;
		}

		/// <summary>
		/// Exports a list of ReadOnlyDataObject types to a stream.
		/// </summary>
		/// <param name="readOnlyDataObjects">The list of ReadOnlyDataObject objects to export.</param>
		/// <param name="stream">The stream to export the ReadOnlyDataObject list to.</param>
		protected override void OnExport(List<ReadOnlyDataObject> readOnlyDataObjects, Stream stream)
		{
			readOnlyDataObjects = GetOffences().ToList<ReadOnlyDataObject>();

			base.OnExport(readOnlyDataObjects, stream);
		}

		/// <summary>
		/// Updates an Offence record inside the Event-Guardian database, using the ID and values provided. 
		/// </summary>
		/// <param name="id">ID indicating the Offence record to be updated</param>
		/// <param name="isDeleted">New value for the IsDeleted column</param>
		/// <param name="isVisible">New value for the IsVisible column</param>
		/// <param name="name">New value for the Name column</param>
		/// <param name="offenceCategoryID">The ID of the corresponding offence category.</param>
		public void UpdateOffence(int id, bool isDeleted, bool isVisible, string name, int? offenceCategoryID)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, CrimeSpUpdateOffence, new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name, OffenceCategoryID = offenceCategoryID }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
