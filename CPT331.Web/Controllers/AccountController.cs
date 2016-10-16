using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CPT331.Web.Models.Account;

namespace CPT331.Web.Controllers
{
    public class AccountController : Controller
    {
        // GET: Login
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Login()
        {
            ViewBag.Title = "Admin";
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(string loginName, string password)
        {
            if ("administrator".Equals(loginName) && "Rgx53r$t5r".Equals(password))
            {
                Session["user"] = new UserModel() { LoginName = loginName, Password = password };
                return RedirectToAction("Home", "Admin");
            }
            return View();
        }
    }
}