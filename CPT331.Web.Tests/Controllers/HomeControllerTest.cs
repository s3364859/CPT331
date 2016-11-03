#region Using References

using System;
using System.Web.Mvc;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.Web.Controllers;

#endregion

namespace CPT331.Web.Tests.Controllers
{
	[TestClass]
	public class HomeControllerTest
	{
		public HomeControllerTest()
		{
			_homeController = new HomeController();
		}

		private HomeController _homeController;

		[TestMethod]
		public void HomeControllerTest_About_Get()
		{
			ViewResult viewResult = _homeController.About() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void HomeControllerTest_Contact_Get()
		{
			ViewResult viewResult = _homeController.Contact() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void HomeControllerTest_Home_Get()
		{
			ViewResult viewResult = _homeController.Home() as ViewResult;

			Assert.IsNotNull(viewResult);
		}
	}
}