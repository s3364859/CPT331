using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(CPT331.Web.Startup))]
namespace CPT331.Web
{
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member
}
