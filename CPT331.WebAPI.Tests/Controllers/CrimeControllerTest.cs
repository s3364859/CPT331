#region Using References

using System;
using System.Collections.Generic;

using Microsoft.VisualStudio.TestTools.UnitTesting;

using CPT331.WebAPI.Controllers;
using CPT331.WebAPI.Models;

#endregion

namespace CPT331.WebAPI.Tests.Controllers
{
    [TestClass]
    public class CrimeControllerTest
    {
        [TestMethod]
        public void CrimeByLocation()
        {
            CrimeController controller = new CrimeController();

			CrimeByLocationModel crimeByLocationModel = controller.CrimeByLocation("foo");
   
            Assert.IsNotNull(crimeByLocationModel);
            Assert.IsTrue(crimeByLocationModel.Offences.Count > 0);
        }
    }
}
