using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace CPT331.Web.Models.Account
{
    /// <summary>
	/// Represents a User type, used to describe the properties of a user.
	/// </summary>
    public class UserModel
    {
        private readonly string _user = "CPT331 Admin";
        /// <summary>
        /// The default administration user.
        /// </summary>
        public string User { get { return _user; } }

        /// <summary>
        /// Represents the unique name of the user.
        /// </summary>
        [Required]
        [Display(Name = "User")]
        public string LoginName { get; set; }

        /// <summary>
        /// A string of characters used in the user authentication process.
        /// </summary>
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }   
    }
}