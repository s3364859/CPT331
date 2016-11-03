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
	/// Represents a UserRepository type, used to manipulate user data.
	/// </summary>
	public class UserRepository : Repository
	{
		/// <summary>
		/// The Registration.spGetUser stored procedure name.
		/// </summary>
		public const string RegistrationSpGetUser = "Registration.spGetUser";

		/// <summary>
		/// The Registration.spGetUserByID stored procedure name.
		/// </summary>
		public const string RegistrationSpGetUserByID = "Registration.spGetUserByID";
		
		/// <summary>
		/// The Registration.spGetUserByUsername stored procedure name.
		/// </summary>
		public const string RegistrationSpGetUserByUsername = "Registration.spGetUserByUsername";

		/// <summary>
		/// Selects a user from the underlying data souce.
		/// </summary>
		/// <param name="id">The ID of the associated user.</param>
		/// <returns>Returns a User object representing the result of the operation.</returns>
		public User GetUserByID(int id)
		{
			User user = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				user = SqlMapper
					.Query(sqlConnection, RegistrationSpGetUserByID, new { ID = id }, commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.FirstOrDefault();
			}

			return user;
		}

		/// <summary>
		/// Selects a user from the underlying data souce.
		/// </summary>
		/// <param name="username">The username of theassociated user.</param>
		/// <returns>Returns a User object representing the result of the operation.</returns>
		public User GetUserByUsername(string username)
		{
			User user = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				user = SqlMapper
					.Query(sqlConnection, RegistrationSpGetUserByUsername, new { Username = username }, commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.FirstOrDefault();
			}

			return user;
		}

		/// <summary>
		/// Selects all users from the underlying data source.
		/// </summary>
		/// <returns>Returns a list of User objects representing the result of the operation.</returns>
		public List<User> GetUsers()
		{
			List<User> users = null;

			using (SqlConnection sqlConnection = SqlConnectionFactory.NewSqlConnetion())
			{
				users = SqlMapper
					.Query(sqlConnection, RegistrationSpGetUser, commandType: CommandType.StoredProcedure)
					.Select(m => new User(m.DateCreatedUtc, m.DateUpdatedUtc, m.ID, m.IsActive, m.IsDeleted, m.Password, m.Username))
					.ToList();
			}

			return users;
		}
	}
}
