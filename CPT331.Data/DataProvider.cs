#region Using References

using System;

#endregion

namespace CPT331.Data
{
	/// <summary>
	/// Represents a DataProvider type, used as a repository factory.
	/// </summary>
	public static class DataProvider
	{
		private static AdhocScriptRepository _adhocScriptRepository = null;
		private static CrimeOffenceLocalGovernmentAreaStateRepository _crimeOffenceLocalGovernmentAreaStateRepository = null;
		private static CrimeRepository _crimeRepository = null;
		private static EventInfoRepository _eventInfoRepository = null;
		private static LocalGovernmentAreaRepository _localGovernmentAreaRepository = null;
		private static LocalGovernmentAreaStateRepository _localGovernmentAreaStateRepository = null;
		private static OffenceCategoryRepository _offenceCategoryRepository = null;
		private static OffenceRepository _offenceRepository = null;
		private static StateRepository _stateRepository = null;
		private static UserRepository _userRepository = null;

		/// <summary>
		/// Gets the AdhocScriptRepository repository object.
		/// </summary>
		public static AdhocScriptRepository AdhocScriptRepository
		{
			get
			{
				return GetDataRepository(_adhocScriptRepository);
			}
		}

		/// <summary>
		/// Gets the CrimeOffenceLocalGovernmentAreaStateRepository repository object.
		/// </summary>
		public static CrimeOffenceLocalGovernmentAreaStateRepository CrimeOffenceLocalGovernmentAreaStateRepository
		{
			get
			{
				return GetDataRepository(_crimeOffenceLocalGovernmentAreaStateRepository);
			}
		}

		/// <summary>
		/// Gets the CrimeRepository repository object.
		/// </summary>
		public static CrimeRepository CrimeRepository
		{
			get
			{
				return GetDataRepository(_crimeRepository);
			}
		}

		/// <summary>
		/// Gets the EventInfoRepository repository object.
		/// </summary>
		public static EventInfoRepository EventInfoRepository
		{
			get
			{
				return GetDataRepository(_eventInfoRepository);
			}
		}

		/// <summary>
		/// Gets the LocalGovernmentAreaRepository repository object.
		/// </summary>
		public static LocalGovernmentAreaRepository LocalGovernmentAreaRepository
		{
			get
			{
				return GetDataRepository(_localGovernmentAreaRepository);
			}
		}

		/// <summary>
		/// Gets the LocalGovernmentAreaStateRepository repository object.
		/// </summary>
		public static LocalGovernmentAreaStateRepository LocalGovernmentAreaStateRepository
		{
			get
			{
				return GetDataRepository(_localGovernmentAreaStateRepository);
			}
		}

		/// <summary>
		/// Gets the OffenceCategoryRepository repository object.
		/// </summary>
		public static OffenceCategoryRepository OffenceCategoryRepository
		{
			get
			{
				return GetDataRepository(_offenceCategoryRepository);
			}
		}

		/// <summary>
		/// Gets the OffenceRepository repository object.
		/// </summary>
		public static OffenceRepository OffenceRepository
		{
			get
			{
                return GetDataRepository(_offenceRepository);
			}
		}

		/// <summary>
		/// Gets the StateRepository repository object.
		/// </summary>
		public static StateRepository StateRepository
		{
			get
            {
                return GetDataRepository(_stateRepository);
			}
		}

		/// <summary>
		/// Gets the UserRepository repository object.
		/// </summary>
		public static UserRepository UserRepository
		{
			get
			{
                return GetDataRepository(_userRepository);
            }
		}

        private static T GetDataRepository<T>(T instanceVariable) where T : Repository, new()
        {
            if(instanceVariable == null)
            {
                instanceVariable = new T();
            }
            return instanceVariable;
        }
	}
}