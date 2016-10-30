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
	/// Represents an OffenceCategoryRepository type, used to manipulate offence category data.
	/// </summary>
	public static class OffenceCategoryRepository
	{
		/// <summary>
		/// The Crime.spAddOffenceCategory stored procedure name.
		/// </summary>
		public const string CrimeSpAddOffenceCategory = "Crime.spAddOffenceCategory";

		/// <summary>
		/// The Crime.spGetOffenceCategoryByID stored procedure name.
		/// </summary>
		public const string CrimeSpGetOffenceCategoryByID = "Crime.spGetOffenceCategoryByID";
		
		/// <summary>
		/// The Crime.spGetOffenceCategory stored procedure name.
		/// </summary>
		public const string CrimeSpGetOffenceCategory = "Crime.spGetOffenceCategory";
		
		/// <summary>
		/// The Crime.spUpdateOffenceCategory stored procedure name.
		/// </summary>
		public const string CrimeSpUpdateOffenceCategory = "Crime.spUpdateOffenceCategory";
	
		/// <summary>
		/// Inserts offence category information into the underlying data source.
		/// </summary>
		/// <param name="isDeleted">Specifies whether the offence category is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the offence category is flagged as visible.</param>
		/// <param name="name">Specifies the name of the offence category.</param>
		/// <returns>Returns the newly created ID for a successful operation, otherwise returns 0.</returns>
		public static int AddOffenceCategory(bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, CrimeSpAddOffenceCategory, new { IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		/// <summary>
		/// Selects offence category from the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated offence category.</param>
		/// <returns>Returns an OffenceCategory object representing the result of the operation.</returns>
		public static OffenceCategory GetOffenceCategoryByID(int id)
		{
			OffenceCategory offenceCategory = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offenceCategory = SqlMapper
					.Query(sqlConnection, CrimeSpGetOffenceCategoryByID, new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new OffenceCategory(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return offenceCategory;
		}

		/// <summary>
		/// Selects all offence categories from the underlying data source.
		/// </summary>
		/// <returns>Returns a list of OffenceCategory objects representing the result of the operation.</returns>
		public static List<OffenceCategory> GetOffenceCategories()
		{
			List<OffenceCategory> offenceCategories = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offenceCategories = SqlMapper
					.Query(sqlConnection, CrimeSpGetOffenceCategory, commandType: CommandType.StoredProcedure)
					.Select(m => new OffenceCategory(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.ToList();
			}

			return offenceCategories;
		}

		/// <summary>
		/// Updates offence category information in the underlying data source.
		/// </summary>
		/// <param name="id">The ID of the associated offence category.</param>
		/// <param name="isDeleted">Specifies whether the offence category is flagged as deleted.</param>
		/// <param name="isVisible">Specifies whether the offence category is flagged as visible.</param>
		/// <param name="name">Specified the name of the offence category.</param>
		public static void UpdateOffenceCategory(int id, bool isDeleted, bool isVisible, string name)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, CrimeSpUpdateOffenceCategory, new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
