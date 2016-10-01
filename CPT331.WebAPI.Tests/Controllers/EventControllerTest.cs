#region Using References

using System;
using System.Collections.Generic;
using System.Linq;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.Core.ObjectModel;
using CPT331.WebAPI.Controllers;

#endregion

namespace CPT331.WebAPI.Tests.Controllers
{
    [TestClass]
    public class EventControllerTest
    {
		[TestMethod]
		public void Event()
		{
			EventController eventController = new EventController();
			EventInfo eventInfo = eventController.Event(214829);

			Assert.IsNotNull(eventInfo);
		}

		[TestMethod]
        public void EventsByCoordinate()
        {
			EventController eventController = new EventController();

			//	-37.8249002,144.9965308 => Richmond, Melbourne
			IEnumerable<EventInfo> events = eventController.EventsByCoordinate(-37.8249002, 144.9965308, 10);

			Assert.IsNotNull(events);
			Assert.IsTrue(events.Count() > 0);
		}
	}
}
