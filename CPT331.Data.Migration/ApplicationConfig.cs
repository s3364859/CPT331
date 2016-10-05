using System.Configuration;
using System.Text.RegularExpressions;
namespace CPT331.Data.Migration
{
     internal sealed class ApplicationConfig : ApplicationSettingsBase
    {
        public ApplicationConfig()
        {
        }

        private static ApplicationConfig defaultInstance = ((ApplicationConfig)(Synchronized(new ApplicationConfig())));

        public static ApplicationConfig Default
        {
            get
            {
                return defaultInstance;
            }
        }

        [ApplicationScopedSetting()]
        [DefaultSettingValue("D:\\Downloads\\Crime Data\\")]
        public string CrimeDataFolder
        {
            get
            {
                string path = (string)(this["CrimeDataFolder"]);
                path += Regex.IsMatch(path, @"(\/|\\)$") ? "" : @"\";
                return path;
            }
        }
    }
}
