#region Using References

using System;
using System.Web.Mvc;

using CPT331.Data;

#endregion

namespace CPT331.Web.Actions
{
	public class ExportDataActionResult : ActionResult
	{
		public ExportDataActionResult(string filename, Repository Repository)
		{
			_filename = filename;
			_repository = Repository;
		}

		private const string ContentDisposition = "Content-Disposition";
		private const string CsvContentType = "text/csv";

		private string _filename;
		private Repository _repository;

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
