#region Using References

using System;
using System.Web.Http;

#endregion

namespace CPT331.WebAPI
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);
        }
    }
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member
}
