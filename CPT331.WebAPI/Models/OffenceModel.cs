#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
	[DataContract(Name = "Offence")]
	public class OffenceModel
	{
		public OffenceModel(string name, double value)
		{
			_name = name;
			_value = value;
		}

		private string _name;
		private double _value;

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

		[DataMember]
		public double Value
		{
			get
			{
				return _value;
			}
			set
			{
				_value = value;
			}
		}
	}
}
