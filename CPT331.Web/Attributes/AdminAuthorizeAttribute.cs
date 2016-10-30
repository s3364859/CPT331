using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CPT331.Core.ObjectModel;

namespace CPT331.Web.Attributes
{
    public class AdminAuthorizeAttribute : System.Web.Mvc.AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            return httpContext.Session[SessionKey.Key] != null;
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectToRouteResult(
                                   new RouteValueDictionary(new { controller = "Account", action = "Login" }));
        }
    }
}