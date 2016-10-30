using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CPT331.Web.Models.Account;
using CPT331.Web.Attributes;
using CPT331.Data;
using CPT331.Core.ObjectModel;
using CPT331.Core.Logging;
using CPT331.Core.Extensions;

namespace CPT331.Web.Controllers
{
    [AdminAuthorize]
    public class AccountController : Controller
    {
        // GET: Login
        [AllowAnonymous]
        [HttpGet]
        public ActionResult Login()
        {
            ViewBag.Title = "Admin";
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(string loginName, string password)
        {
            User user = UserRepository.GetUserByUsername("administrator");
            if (loginName == user.Username && StringExtensions.Hash(password) == user.Password)
            {
                Session[SessionKey.Key] = new UserModel() { LoginName = loginName, Password = password };
                return RedirectToAction("Home", "Admin");
            }
            return View();
        }

        [HttpGet]
        public ActionResult SignOut()
        {
            ViewBag.Message = "Logging off...";
            ModelState.Clear();
            Session.Clear();
            return RedirectToAction("Login", "Account");
        }
    }
}