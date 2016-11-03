#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Represents a CrimeOffenceLocalGovernmentAreaState type, used to describe information about a crime, offence, local government area, and state or territory.
	/// </summary>
	public class CrimeOffenceLocalGovernmentAreaState : Crime
	{
		/// <summary>
		/// Constructs a new CrimeOffenceLocalGovernmentAreaState object.
		/// </summary>
		/// <param name="count">The number of crimes recorded in a given area, time and category.</param>
		/// <param name="dateCreatedUtc">The date when the record was created.</param>
		/// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
		/// <param name="id">The unique ID of the local government area.</param>
		/// <param name="isDeleted">A boolean value indicating a deleted record.</param>
		/// <param name="isVisible">A boolean value indicating a hidden record.</param>
		/// <param name="localGovernmentAreaID">An ID number that represents the local goverment area.</param>
		/// <param name="localGovernmentAreaName">The name of the local government area.</param>
		/// <param name="month">The month the crimes were commited.</param>
		/// <param name="offenceID">An ID number representing the type of crime.</param>
		/// <param name="offenceName">The name of the offence.</param>
		/// <param name="stateID">The unique ID of the state or territory.</param>
		/// <param name="stateName">The name of the state or territory.</param>
		/// <param name="year">The year the crimes were commited</param>
		public CrimeOffenceLocalGovernmentAreaState(int count, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, int localGovernmentAreaID, string localGovernmentAreaName, int month, int offenceID, string offenceName, int stateID, string stateName, int year)
			: base(count, dateCreatedUtc, dateUpdatedUtc, id, isDeleted, isVisible, localGovernmentAreaID, month, offenceID, year)
		{
			_localGovernmentAreaName = localGovernmentAreaName;
			_offenceID = offenceID; ;
			_offenceName = offenceName;
			_stateID = stateID;
			_stateName = stateName;
		}

		private readonly string _localGovernmentAreaName;
		private readonly int _offenceID;
		private readonly string _offenceName;
		private readonly int _stateID;
		private readonly string _stateName;

		/// <summary>
		/// Gets the name of the local government area.
		/// </summary>
		public string LocalGovernmentAreaName
		{
			get
			{
				return _localGovernmentAreaName;
			}
		}

		/// <summary>
		/// Gets the name of the offence.
		/// </summary>
		public string OffenceName
		{
			get
			{
				return _offenceName;
			}
		}

		/// <summary>
		/// Gets the ID of the state that the local government area resides within.
		/// </summary>
		public int StateID
		{
			get
			{
				return _stateID;
			}
		}

		/// <summary>
		/// Gets the name of the state or territory.
		/// </summary>
		public string StateName
		{
			get
			{
				return _stateName;
			}
		}
	}
}
