using System;

namespace LoginKitModel
{
    /// <summary>
    /// Support editing login information.
    /// </summary>
    /// <remarks>
    /// Isolated in separate assembly so it can be used with Xamarin Forms binding 
    /// or directly in native IOS and Android views.
    /// </remarks>
    public class LoginPageViewModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public bool ShowPassword { get; set; }
        //TODO review notes for additional support methods
        //TODO work out what backing if any required for login via Facebook, Azure et al
        //TODO decide if callback for password quality feedback is linked here

    }
}
