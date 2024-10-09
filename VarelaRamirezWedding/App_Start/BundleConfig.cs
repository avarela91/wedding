using System.Web;
using System.Web.Optimization;

namespace Wedding
{
    public class BundleConfig
    {
        // Para obtener más información sobre las uniones, visite https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            /*
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));
          */

            // Utilice la versión de desarrollo de Modernizr para desarrollar y obtener información. De este modo, estará
            // para la producción, use la herramienta de compilación disponible en https://modernizr.com para seleccionar solo las pruebas que necesite.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Content/js/modernizr-2.6.2.min.js"));

bundles.Add(new ScriptBundle("~/bundles/bootstrap").IncludeDirectory(
                    "~/Content/js", "*.js", true));


            bundles.Add(new StyleBundle("~/Content/css").IncludeDirectory(
                    "~/Content/css","*.css",true));

        /*    bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                                  "~/Content/js/jquery.min.js",
                                  "~/Content/js/jquery.easing.1.3.js",
                                  "~/Content/js/bootstrap.min.js",
                                  "~/Content/js/jquery.waypoints.min.js",
                                  "~/Content/js/owl.carousel.min.js",
                                  "~/Content/js/jquery.countTo.js",
                                  "~/Content/js/jquery.stellar.min.js",
                                  "~/Content/js/jquery.magnific-popup.min.js",
                                  "~/Content/js/magnific-popup-options.js",
                                  "~/Content/js/simplyCountdown.js",
                                  "~/Content/js/main.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                     "~/Content/css/animate.css",
                     "~/Content/css/icomoon.css",
                     "~/Content/css/bootstrap.css",
                     "~/Content/css/magnific-popup.css",
                     "~/Content/css/owl.carousel.min.css",
                     "~/Content/css/owl.theme.default.min.css",
                     "~/Content/css/style.css"));

            */

        }
    }
}
