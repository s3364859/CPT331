#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
    /// <summary>
    /// A representation of the Crime model that services the Web API framework. 
    /// </summary>
	[DataContract(Name = "Crime")]
	public class CrimeModel
	{
        /// <summary>
        /// Creates an instance of CrimeModel using the values provided.
        /// </summary>
        /// <param name="count">The number of crimes recorded in a given area, time and category.</param>
        /// <param name="dateCreatedUtc">The date when the record was created.</param>
        /// <param name="dateUpdatedUtc">The date when the record was last updated.</param>
        /// <param name="id">The unique ID value for the CrimeModel instance.</param>
        /// <param name="isDeleted">Specifies whether the instance is flagged as deleted.</param>
        /// <param name="isVisible">Specifies whether the instance is flagged as visible.</param>
        /// <param name="localGovernmentAreaID">An ID number that represents the local goverment area.</param>
        /// <param name="month">The month when the crimes were commited.</param>
        /// <param name="offenceID">An ID number representing the type of crime.</param>
        /// <param name="year">The year when the crimes were commited.</param>
		public CrimeModel(int count, DateTime dateCreatedUtc, DateTime dateUpdatedUtc, int id, bool isDeleted, bool isVisible, int localGovernmentAreaID, int month, int offenceID, int year)
		{
			_count = count;
			_dateCreatedUtc = dateCreatedUtc;
			_dateUpdatedUtc = dateUpdatedUtc;
			_id = id;
			_isDeleted = isDeleted;
			_isVisible = isVisible;
			_localGovernmentAreaID = localGovernmentAreaID;
			_month = month;
			_offenceID = offenceID;
			_year = year;
		}

		private int _count;
		private DateTime _dateCreatedUtc;
		private DateTime _dateUpdatedUtc;
		private int _id;
		private bool _isDeleted;
		private bool _isVisible;
		private int _localGovernmentAreaID;
		private int _month;
		private int _offenceID;
		private int _year;

        /// <summary>
        /// The number of crimes recorded in a given area, time and category.
        /// </summary>
		[DataMember]
		public int Count
		{
			get
			{
				return _count;
			}
			set
			{
				_count = value;
			}
		}

        /// <summary>
        /// The date when the record was created.
        /// </summary>
		[DataMember]
		public DateTime DateCreatedUtc
		{
			get
			{
				return _dateCreatedUtc;
			}
			set
			{
				_dateCreatedUtc = value;
			}
		}

        /// <summary>
        /// The date when the record was last updated.
        /// </summary>
		[DataMember]
		public DateTime DateUpdatedUtc
		{
			get
			{
				return _dateUpdatedUtc;
			}
			set
			{
				_dateUpdatedUtc = value;
			}
		}

        /// <summary>
        /// The unique ID value for the CrimeModel instance.
        /// </summary>
		[DataMember]
		public int ID
		{
			get
			{
				return _id;
			}
			set
			{
				_id = value;
			}
		}

        /// <summary>
        /// Specifies whether the instance is flagged as deleted.
        /// </summary>
        [DataMember]
		public bool IsDeleted
		{
			get
			{
				return _isDeleted;
			}
			set
			{
				_isDeleted = value;
			}
		}

        /// <summary>
        /// Specifies whether the instance is flagged as visible.
        /// </summary>
        [DataMember]
		public bool IsVisible
		{
			get
			{
				return _isVisible;
			}
			set
			{
				_isVisible = value;
			}
		}

        /// <summary>
        /// An ID number that represents the local goverment area.
        /// </summary>
        [DataMember]
		public int LocalGovernmentAreaID
		{
			get
			{
				return _localGovernmentAreaID;
			}
			set
			{
				_localGovernmentAreaID = value;
			}
		}

        /// <summary>
        /// The month when the crimes were commited.
        /// </summary>
        [DataMember]
		public int Month
		{
			get
			{
				return _month;
			}
			set
			{
				_month = value;
			}
		}

        /// <summary>
        /// An ID number representing the type of crime.
        /// </summary>
        [DataMember]
		public int OffenceID
		{
			get
			{
				return _offenceID;
			}
			set
			{
				_offenceID = value;
			}
		}

        /// <summary>
        /// The year when the crimes were commited.
        /// </summary>
        [DataMember]
		public int Year
		{
			get
			{
				return _year;
			}
			set
			{
				_year = value;
			}
		}
	}
}
