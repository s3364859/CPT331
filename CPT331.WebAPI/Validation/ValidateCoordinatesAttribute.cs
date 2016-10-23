#region Using References

using CPT331.Core.ObjectModel;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using System.Web.Http.ModelBinding;

#endregion

namespace CPT331.WebAPI.Validation
{
	public class ValidateCoordinatesAttribute : ActionFilterAttribute
	{
		public override void OnActionExecuting(HttpActionContext httpActionContext)
		{
			ModelState latitudeModelState = null;
			ModelState longitudeModelState = null;

			double latitude = 0;
			double longitude = 0;

			if (httpActionContext.ModelState.TryGetValue("latitude", out latitudeModelState) == false)
			{
				latitudeModelState.Errors.Add(new ArgumentException("Missing latitude value."));
			}

			if (httpActionContext.ModelState.TryGetValue("longitude", out longitudeModelState) == false)
			{
				longitudeModelState.Errors.Add(new ArgumentException("Missing longitude value."));
			}

			if ((latitudeModelState != null) && (longitudeModelState != null))
			{
				if (Double.TryParse(latitudeModelState.Value.AttemptedValue, out latitude) == false)
				{
					latitudeModelState.Errors.Add(new FormatException($"Latitude value of '{latitude}' could not be converted."));
				}

				if (Double.TryParse(longitudeModelState.Value.AttemptedValue, out longitude) == false)
				{
					longitudeModelState.Errors.Add(new FormatException($"Longitude value of '{longitude}' could not be converted."));
				}
			}

			if ((latitude != 0) && (longitude != 0))
			{
				if (Coordinate.IsLatitudeValid(latitude) == false)
				{
					latitudeModelState.Errors.Add(new ArgumentOutOfRangeException($"Latitude value of '{latitude}' is outside the expected range ({Coordinate.LatitudeMinValue} to {Coordinate.LatitudeMaxValue})."));
				}

				if (Coordinate.IsLongitudeValid(longitude) == false)
				{
					longitudeModelState.Errors.Add(new ArgumentOutOfRangeException($"Longitude value of '{longitude}' is outside the expected range ({Coordinate.LongitudeMinValue} to {Coordinate.LongitudeMaxValue})."));
				}
			}

			if (httpActionContext.ModelState.IsValid == false)
			{
				StringBuilder stringBuilder = new StringBuilder();

				foreach (ModelState modelState in httpActionContext.ModelState.Values.Where(m => (m.Errors.Count > 0)))
				{
					foreach (ModelError modelError in modelState.Errors)
					{
						stringBuilder.AppendLine(((modelError.Exception == null) ? modelError.ErrorMessage : modelError.Exception.ToString()));
					}
				}

				HttpResponseMessage httpResponseMessage = new HttpResponseMessage(HttpStatusCode.BadRequest)
				{
					Content = new StringContent(stringBuilder.ToString())
				};

				httpActionContext.Response = httpResponseMessage;
			}

			base.OnActionExecuting(httpActionContext);
		}
	}
}