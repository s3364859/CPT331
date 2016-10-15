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
	public static class OffenceCategoryRepository
	{
		public static int AddOffenceCategory(bool isDeleted, bool isVisible, string name)
		{
			int id = 0;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				id = (int)SqlMapper
					.Query(sqlConnection, "Crime.spAddOffenceCategory", new { IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure)
					.Select(m => m.NewID)
					.Single();
			}

			return id;
		}

		public static OffenceCategory GetOffenceCategoryByID(int id)
		{
			OffenceCategory offenceCategory = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offenceCategory = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffenceCategoryByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new OffenceCategory(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.FirstOrDefault();
			}

			return offenceCategory;
		}

		public static List<OffenceCategory> GetOffenceCategories()
		{
			List<OffenceCategory> offenceCategories = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				offenceCategories = SqlMapper
					.Query(sqlConnection, "Crime.spGetOffenceCategory", commandType: CommandType.StoredProcedure)
					.Select(m => new OffenceCategory(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsDeleted, m.IsVisible, m.Name))
					.ToList();
			}

			return offenceCategories;
		}

		public static void UpdateOffenceCategory(int id, bool isDeleted, bool isVisible, string name)
		{
			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				SqlMapper.Execute(sqlConnection, "Crime.spUpdateOffenceCategory", new { ID = id, IsDeleted = isDeleted, IsVisible = isVisible, Name = name }, commandType: CommandType.StoredProcedure);
			}
		}
	}
}
