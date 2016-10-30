using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace CPT331.Web
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member
    public class RouteConfig
	{
		public static void RegisterRoutes(RouteCollection routes)
		{
			routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

			routes.MapRoute(
				name: "Default",
				url: "{controller}/{action}/{id}",
				defaults: new { controller = "Home", action = "Home", id = UrlParameter.Optional }
			);
		}
    }
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member
}
