#region Using References

using System;
using System.Web.Mvc;

using CPT331.Data;

#endregion

namespace CPT331.Web.Actions
{
    /// <summary>
    /// Provides facilities to export data from the database a CSV export.
    /// </summary>
	public class ExportDataActionResult : ActionResult
	{
        /// <summary>
        /// Creates an instance of ExportDataActionResult using the values provided.
        /// </summary>
        /// <param name="filename">The filename for the CSV export.</param>
        /// <param name="Repository">The repository to be exported as CSV.</param>
		public ExportDataActionResult(string filename, Repository Repository)
		{
			_filename = filename;
			_repository = Repository;
		}

		private const string ContentDisposition = "Content-Disposition";
		private const string CsvContentType = "text/csv";

		private string _filename;
		private Repository _repository;

        /// <summary>
        /// Exports a database table as a Comma Separated Values (CSV) file.
        /// </summary>
        /// <param name="controllerContext">The context in which the result is executed. The context information includes
        /// the controller, HTTP content, request context, and route data.</param>
        public override void ExecuteResult(ControllerContext controllerContext)
		{
			if ((String.IsNullOrEmpty(_filename) == false) && (_repository != null))
			{
				controllerContext.HttpContext.Response.ContentType = CsvContentType;
				controllerContext.HttpContext.Response.AddHeader(ContentDisposition, $"attachment;filename={_filename}");

				_repository.Export(controllerContext.HttpContext.Response.OutputStream);
			}
		}
	}
}
