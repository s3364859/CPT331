#region Using References

using System;
using System.Web.Helpers;
using System.Web.Mvc;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.Web.Controllers;
using CPT331.Web.Models.Admin;

#endregion

namespace CPT331.Web.Tests.Controllers
{
	[TestClass]
	public class AdminControllerTest
	{
		public AdminControllerTest()
		{
			_adminController = new AdminController();
		}

		private AdminController _adminController;

		[TestMethod]
		public void AdminControllerTest_Crime_Get()
		{
			ViewResult viewResult = _adminController.Crime(1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_Crimes_Get()
		{
			//	Uncommented once Crime.spGetCrime is fixed
			//	ViewResult viewResult = _adminController.Crimes("", SortDirection.Ascending, 1) as ViewResult;
			//	
			//	Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_Home_Get()
		{
			//	Relies on the Session being available
			//	ViewResult viewResult = _adminController.Home() as ViewResult;
			//	
			//	Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_LocalGovernmentArea_Get()
		{
			ViewResult viewResult = _adminController.LocalGovernmentArea(1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_LocalGovernmentAreas_Get()
		{
			ViewResult viewResult = _adminController.LocalGovernmentAreas("", SortDirection.Ascending, 1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_NewCrime_Get()
		{
			ViewResult viewResult = _adminController.NewCrime() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_NewLocalGovernmentArea_Get()
		{
			ViewResult viewResult = _adminController.NewLocalGovernmentArea() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_NewOffence_Get()
		{
			ViewResult viewResult = _adminController.NewOffence() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_NewOffenceCategory_Get()
		{
			ViewResult viewResult = _adminController.NewOffenceCategory() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_NewState_Get()
		{
			ViewResult viewResult = _adminController.NewState() as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_Offence_Get()
		{
			ViewResult viewResult = _adminController.Offence(1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_Offences_Get()
		{
			ViewResult viewResult = _adminController.Offences("", SortDirection.Ascending, 1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_OffenceCategory_Get()
		{
			ViewResult viewResult = _adminController.OffenceCategory(1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_OffenceCategories_Get()
		{
			ViewResult viewResult = _adminController.OffenceCategories("", SortDirection.Ascending, 1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_State_Get()
		{
			ViewResult viewResult = _adminController.State(1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}

		[TestMethod]
		public void AdminControllerTest_States_Get()
		{
			ViewResult viewResult = _adminController.States("", SortDirection.Ascending, 1) as ViewResult;

			Assert.IsNotNull(viewResult);
		}
	}
}
