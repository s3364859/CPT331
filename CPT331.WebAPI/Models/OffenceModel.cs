#region Using References

using System;
using System.Runtime.Serialization;

#endregion

namespace CPT331.WebAPI.Models
{
    /// <summary>
    /// A representation of the Offence model that services the Web API framework. 
    /// </summary>
	[DataContract(Name = "Offence")]
	public class OffenceModel
    {
        /// <summary>
        /// Creates an instance of OffenceModel using the values provided.
        /// </summary>
        /// <param name="name">The name of the Offense.</param>
        /// <param name="value">The number of offenses proportionate to other offenses.</param>
		public OffenceModel(string name, double value)
		{
			_name = name;
			_value = value;
		}

		private string _name;
		private double _value;

        /// <summary>
        /// The name of the Offense.
        /// </summary>
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

        /// <summary>
        /// The number of offenses proportionate to other offenses.
        /// </summary>
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
