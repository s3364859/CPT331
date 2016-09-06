using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CPT331.Web.Startup))]
namespace CPT331.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
