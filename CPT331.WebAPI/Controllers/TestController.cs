#region Using References

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

using CPT331.Data;

using CPT331.WebAPI.Models;

#endregion

namespace CPT331.WebAPI.Controllers
{
    public class TestController : ApiController
    {
		// GET api/<controller>
		public IEnumerable<TestModel> Get()
		{
			return TestRepository
				.GetTests()
				.Select(m => new TestModel(m.ID, m.Value0, m.Value1));
		}

		// GET api/<controller>/5
		public TestModel Get(int id)
		{
			TestModel testModel = null;
			Test test = TestRepository.GetTestByID(id);

			if (test != null)
			{
				testModel = new TestModel(test.ID, test.Value0, test.Value1);
			}

			return testModel;
		}

		// POST api/<controller>
		public void Post(TestModel testModel)
		{
			if (ModelState.IsValid == true)
			{
				TestRepository.AddTest(testModel.Value0, testModel.Value1);
			}
		}

		// PUT api/<controller>/5
		public void Put(TestModel testModel)
		{
			if (ModelState.IsValid == true)
			{
				TestRepository.UpdateTest(testModel.ID, testModel.Value0, testModel.Value1);
			}
		}

		// DELETE api/<controller>/5
		public void Delete(int id)
		{
			TestRepository.DeleteTestByID(id);
		}
    }
}