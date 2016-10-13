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
        public void CrimesByCoordinate()
        {
            CrimeController controller = new CrimeController();

			CrimeByCoordinateModel crimeByCoordinateModel = controller.CrimesByCoordinate(151.1743105, -33.9112549);
   
            Assert.IsNotNull(crimeByCoordinateModel);
        }
    }
}
