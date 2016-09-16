#region Using References

using System;
using System.Web.Mvc;

using CPT331.Data;

using CPT331.Web.Models.Admin;
using System.Collections;
using System.Collections.Generic;

#endregion

namespace CPT331.Web.Controllers
{
    public class AdminController : Controller
    {		
		[AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Home()
        {
            return View();
        }

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult NewTest()
		{
			return View(new TestModel());
		}

		[AcceptVerbs(HttpVerbs.Post)]
		public ActionResult NewTest(TestModel testModel)
		{
			ActionResult actionResult = null;

			if (ModelState.IsValid == true)
			{
				TestRepository.AddTest(testModel.Value0, testModel.Value1);

				actionResult = RedirectToAction("Tests", "Admin");
			}
			else
			{
				actionResult = View(testModel);
			}

			return actionResult;
		}

		[AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Test(int id)
        {
			TestModel testModel = null;
			Test test = TestRepository.GetTestByID(id);

			if (test != null)
			{
				testModel = new TestModel(test.ID, test.Value0, test.Value1);
			}

			return View(testModel);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Test(TestModel testModel)
        {
            ActionResult actionResult = null;

            if (ModelState.IsValid == true)
            {
                if (testModel.IsDelete == true)
				{
					TestRepository.DeleteTestByID(testModel.ID);
                }
                else
                {
					TestRepository.UpdateTest(testModel.ID, testModel.Value0, testModel.Value1);
                }

                actionResult = RedirectToAction("Tests", "Admin");
            }
            else
            {
                actionResult = View(testModel);
            }

            return actionResult;
        }

		[AcceptVerbs(HttpVerbs.Get)]
		public ActionResult Tests()
		{
			IEnumerable<Test> tests = TestRepository.GetTests();

			return View(tests);
		}
	}
}