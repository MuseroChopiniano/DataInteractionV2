using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace UI
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            var cultureInfo = new CultureInfo("es-AR");
            cultureInfo.NumberFormat.CurrencySymbol = "$";

            CultureInfo.DefaultThreadCurrentCulture = cultureInfo;
            CultureInfo.DefaultThreadCurrentUICulture = cultureInfo;
        }
        void Application_Error(object sender, EventArgs e)
        {
            Exception TheError = Server.GetLastError();
            Server.ClearError();

            // Avoid IIS7 getting in the middle
            Response.TrySkipIisCustomErrors = true;

            if (TheError is HttpException && ((HttpException)TheError).GetHttpCode() == 404)
            {
                Response.Redirect("~/ErrorPage.aspx");
            }
            else
            {
                Response.Redirect("~/ErrorPage.aspx");
            }
        }
    }
}