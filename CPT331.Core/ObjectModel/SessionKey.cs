using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CPT331.Core.ObjectModel
{
    /// <summary>
    /// Encapsulates the session key used for the MVC site authentication. 
    /// </summary>
    public static class SessionKey
    {
        /// <summary>
        /// This key is for an admin user session. It's used by the Post 
        /// Login action method and the AdminAutorizeAttribute class. 
        /// </summary>
        public static string Key { get { return _userSessionKey; } }
        private const string _userSessionKey = "User";
    }
}
