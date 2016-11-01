#region Using References

using System;
using System.Diagnostics;

#endregion

namespace CPT331.Core.Logging
{
	/// <summary>
	/// Represents a wrapper for writing to the standard output streams.
	/// </summary>
	public static class OutputStreams
	{
		/// <summary>
		/// Writes the current line terminator to the standard output stream as well as to the trace listeners in the System.Diagnostics.Debug.Listeners collection.
		/// </summary>
		public static void WriteLine()
		{
			Console.WriteLine();
			Debug.WriteLine("");
		}

		/// <summary>
		/// Writes the specified string value and the current line terminator to the standard output stream as well as to the trace listeners in the System.Diagnostics.Debug.Listeners collection.
		/// </summary>
		/// <param name="value">The string to output.</param>
		public static void WriteLine(string value)
		{
			WriteLine(value, true);
		}

		/// <summary>
		/// Writes the current line terminator to the standard output stream as well as to the trace listeners in the System.Diagnostics.Debug.Listeners collection.
		/// </summary>
		/// <param name="value">The string to output.</param>
		/// <param name="isIncludeTimestamp">Specifies whether to write a timestamp to the output.</param>
		public static void WriteLine(string value, bool isIncludeTimestamp)
		{
			string message = ((isIncludeTimestamp == true) ? $"{DateTime.Now.ToString("yyyy-MMM-dd @ HH:mm:ss")} {value}" : value);

			Console.WriteLine(message);
			Debug.WriteLine(message);
		}
	}
}
