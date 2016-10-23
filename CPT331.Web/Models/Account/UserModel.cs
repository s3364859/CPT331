using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace CPT331.Web.Models.Account
{
    public class UserModel
    {
        private readonly string _user = "CPT331 Admin";
        public string User { get { return _user; } }

        [Required]
        [Display(Name = "User")]
        public string LoginName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }   
    }
}