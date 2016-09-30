#region Using References

using System;
using System.Web.Http;

#endregion

namespace CPT331.WebAPI
{
    public static class WebApiConfig
    {
		public static void Register(HttpConfiguration httpConfiguration)
		{
			httpConfiguration.MapHttpAttributeRoutes();

			httpConfiguration.Routes.MapHttpRoute(name: "DefaultApi", routeTemplate: "api/{controller}/{id}", defaults: new { id = RouteParameter.Optional });
		}
    }
}
