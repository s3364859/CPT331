#region Using References

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "CrimeByCoordinate")]
	public class CrimeByCoordinateModel
	{
		public CrimeByCoordinateModel(int beginYear, int endYear, string name, IEnumerable<OffenceModel> offenceModels)
		{
			_beginYear = beginYear;
			_endYear = endYear;
			_name = name;
			_offenceModels = offenceModels;
		}

		private int _beginYear;
		private int _endYear;
		private string _name;
		private IEnumerable<OffenceModel> _offenceModels;

		[DataMember]
		public int BeginYear
		{
			get
			{
				return _beginYear;
			}
			set
			{
				_beginYear = value;
			}
		}

		[DataMember]
		public int EndYear
		{
			get
			{
				return _endYear;
			}
			set
			{
				_endYear = value;
			}
		}

		[DataMember]
		public string Name
		{
			get
			{
				return _name;
			}
			set
			{
				_name = value;
			}
		}

		[DataMember(Name = "Offences")]
		public IEnumerable<OffenceModel> OffenceModels
		{
			get
			{
				return _offenceModels;
			}
			set
			{
				_offenceModels = value;
			}
		}
	}
}
