#region Using References

using System;
using System.Web.Http;

#endregion

namespace CPT331.WebAPI
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member
    public static class WebApiConfig
    {
		public static void Register(HttpConfiguration httpConfiguration)
		{
			httpConfiguration.MapHttpAttributeRoutes();

			httpConfiguration.Routes.MapHttpRoute(name: "DefaultApi", routeTemplate: "api/{controller}/{id}", defaults: new { id = RouteParameter.Optional });
		}
    }
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member
}
