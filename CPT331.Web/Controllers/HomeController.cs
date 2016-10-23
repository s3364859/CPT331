using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CPT331.Web.Controllers
{
	public class HomeController : Controller
	{
		public ActionResult Home()
		{
            ViewBag.Title = "Home";
            return View();
		}

		public ActionResult About()
		{
            ViewBag.Title = "About";
			return View();
		}

		public ActionResult Contact()
		{
            ViewBag.Title = "Contact";
			ViewBag.Message = "Contact information of one of our group members here?";
			return View();
		}
	}
}