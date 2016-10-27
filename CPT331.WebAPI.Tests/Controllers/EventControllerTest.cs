#region Using References

using System;
using System.Collections.Generic;
using System.Linq;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.WebAPI.Controllers;
using CPT331.WebAPI.Models;

#endregion

namespace CPT331.WebAPI.Tests.Controllers
{
    [TestClass]
    public class EventControllerTest
    {
		[TestMethod]
		public void EventControllerTest_Event()
		{
			EventController eventController = new EventController();
			EventModel eventModel = eventController.Event(0);

			Assert.IsNotNull(eventModel);
		}

		[TestMethod]
        public void EventControllerTest_EventsByCoordinate()
        {
			EventController eventController = new EventController();

			//	-37.8249002,144.9965308 => Richmond, Melbourne
			IEnumerable<EventModel> eventModels = eventController.EventsByCoordinate(-37.8249002, 144.9965308, 10);

			Assert.IsNotNull(eventModels);
			Assert.IsTrue(eventModels.Count() > 0);
		}
	}
}
