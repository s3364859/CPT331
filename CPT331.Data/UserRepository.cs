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
	public static class UserRepository
	{
		public static User GetUserByID(int id)
		{
			User user = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				user = SqlMapper
					.Query(sqlConnection, "Registration.spGetUserByID", new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.FirstOrDefault();
			}

			return user;
		}

		public static User GetUserByUsername(string username)
		{
			User user = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				user = SqlMapper
					.Query(sqlConnection, "Registration.spGetUserByUsername", new { Username = username }, commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.FirstOrDefault();
			}

			return user;
		}

		public static List<User> GetUsers()
		{
			List<User> users = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				users = SqlMapper
					.Query(sqlConnection, "Registration.spGetUser", commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.ToList();
			}

			return users;
		}
	}
}
