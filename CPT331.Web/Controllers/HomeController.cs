using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CPT331.Web.Controllers
{
    /// <summary>
    ///    A controller that provides methods that respond to HTTP requests that are related 
    ///    to the EventGuardian home page.
    /// </summary>
	public class HomeController : Controller
	{
        /// <summary>
        /// Provides the home page for the EventGuardian website.
        /// </summary>
        /// <returns>The 'Home' view.</returns>
		public ActionResult Home()
		{
            ViewBag.Title = "Home";
            return View();
		}

        /// <summary>
        /// Provides the About Us page for the EventGuardian website.
        /// </summary>
        /// <returns>The 'About Us' view.</returns>
        public ActionResult About()
		{
            ViewBag.Title = "About";
			return View();
		}

        /// <summary>
        /// Provides the Contacts page for the EventGuardian website.
        /// </summary>
        /// <returns>The 'Contacts' view.</returns>
        public ActionResult Contact()
		{
            ViewBag.Title = "Contact";
			ViewBag.Message = "Contact information of one of our group members here?";
			return View();
		}
	}
}