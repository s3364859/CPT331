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
		private static AdhocScriptRepository _adhocScriptRepository;
		private static CrimeRepository _crimeRepository;
		private static EventInfoRepository _eventInfoRepository;
		private static LocalGovernmentAreaRepository _localGovernmentAreaRepository;
		private static LocalGovernmentAreaStateRepository _localGovernmentAreaStateRepository;
		private static OffenceCategoryRepository _offenceCategoryRepository;
		private static OffenceRepository _offenceRepository;
		private static StateRepository _stateRepository;
		private static UserRepository _userRepository;

		/// <summary>
		/// Gets the AdhocScriptRepository repository object.
		/// </summary>
		public static AdhocScriptRepository AdhocScriptRepository
		{
			get
			{
				if (_adhocScriptRepository == null)
				{
					_adhocScriptRepository = new AdhocScriptRepository();
				}

				return _adhocScriptRepository;
			}
		}

		/// <summary>
		/// Gets the CrimeRepository repository object.
		/// </summary>
		public static CrimeRepository CrimeRepository
		{
			get
			{
				if (_crimeRepository == null)
				{
					_crimeRepository = new CrimeRepository();
				}

				return _crimeRepository;
			}
		}

		/// <summary>
		/// Gets the EventInfoRepository repository object.
		/// </summary>
		public static EventInfoRepository EventInfoRepository
		{
			get
			{
				if (_eventInfoRepository == null)
				{
					_eventInfoRepository = new EventInfoRepository();
				}

				return _eventInfoRepository;
			}
		}

		/// <summary>
		/// Gets the LocalGovernmentAreaRepository repository object.
		/// </summary>
		public static LocalGovernmentAreaRepository LocalGovernmentAreaRepository
		{
			get
			{
				if (_localGovernmentAreaRepository == null)
				{
					_localGovernmentAreaRepository = new LocalGovernmentAreaRepository();
				}

				return _localGovernmentAreaRepository;
			}
		}

		/// <summary>
		/// Gets the LocalGovernmentAreaStateRepository repository object.
		/// </summary>
		public static LocalGovernmentAreaStateRepository LocalGovernmentAreaStateRepository
		{
			get
			{
				if (_localGovernmentAreaStateRepository == null)
				{
					_localGovernmentAreaStateRepository = new LocalGovernmentAreaStateRepository();
				}

				return _localGovernmentAreaStateRepository;
			}
		}

		/// <summary>
		/// Gets the OffenceCategoryRepository repository object.
		/// </summary>
		public static OffenceCategoryRepository OffenceCategoryRepository
		{
			get
			{
				if (_offenceCategoryRepository == null)
				{
					_offenceCategoryRepository = new OffenceCategoryRepository();
				}

				return _offenceCategoryRepository;
			}
		}

		/// <summary>
		/// Gets the OffenceRepository repository object.
		/// </summary>
		public static OffenceRepository OffenceRepository
		{
			get
			{
				if (_offenceRepository == null)
				{
					_offenceRepository = new OffenceRepository();
				}

				return _offenceRepository;
			}
		}

		/// <summary>
		/// Gets the StateRepository repository object.
		/// </summary>
		public static StateRepository StateRepository
		{
			get
			{
				if (_stateRepository == null)
				{
					_stateRepository = new StateRepository();
				}

				return _stateRepository;
			}
		}

		/// <summary>
		/// Gets the UserRepository repository object.
		/// </summary>
		public static UserRepository UserRepository
		{
			get
			{
				if (_userRepository == null)
				{
					_userRepository = new UserRepository();
				}

				return _userRepository;
			}
		}
	}
}