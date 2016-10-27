#region Using References

using System;

#endregion

namespace CPT331.Core.ObjectModel
{
	/// <summary>
	/// Describes the possible states that an EventFinda image format may appear in.
	/// </summary>
    public enum EventFindaImageFormat : int
    {
		/// <summary>
		/// No format selected.
		/// </summary>
		None = 0,
		/// <summary>
		/// The image format is 80 x 80 pixels.
		/// </summary>
		Size80x80 = 2,
		/// <summary>
		/// The image format is 650 x 280 pixels.
		/// </summary>
		Size650x280 = 7,
		/// <summary>
		/// The image format is 190 x 127 pixels.
		/// </summary>
		Size190x127 = 8,
		/// <summary>
		/// The image format is 75 x 75 pixels.
		/// </summary>
		Size75x75 = 15,
		/// <summary>
		/// The image format is 350 x 350 pixels.
		/// </summary>
		Size350x350 = 27
    }
}
