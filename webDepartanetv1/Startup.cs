using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(webDepartanetv1.Startup))]
namespace webDepartanetv1
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
