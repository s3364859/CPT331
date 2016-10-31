using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CPT331.Core.ObjectModel;

namespace CPT331.Web.Attributes
{
    /// <summary>
    /// An MVC Authorisation Filter that can be applied to MVC Actions. This determines if the 
    /// Admin user is authorised, and controls access to protected pages.
    /// </summary>
    public class AdminAuthorizeAttribute : System.Web.Mvc.AuthorizeAttribute
    {
        /// <summary>
        /// A method that determines whether or not a user has been authorised
        /// within a specified HTTP Context.
        /// </summary>
        /// <param name="httpContext">
        /// The HTTP context, which encapsulates all HTTP-specific information about an individual
        /// HTTP request.</param>
        /// <exception cref="System.ArgumentNullException">The httpContext parameter is null.</exception>
        /// <returns>true if the user is authorized; otherwise, false.</returns>
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            return httpContext.Session[SessionKey.Key] != null;
        }

        /// <summary>
        /// Redirects HTTP requests that fail authoristion to the login page. 
        /// </summary>
        /// <param name="filterContext">Encapsulates the information for using System.Web.Mvc.AuthorizeAttribute. The
        /// filterContext object contains the controller, HTTP context, request context,
        /// action result, and route data.</param>
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectToRouteResult(
                                   new RouteValueDictionary(new { controller = "Account", action = "Login" }));
        }
    }
}