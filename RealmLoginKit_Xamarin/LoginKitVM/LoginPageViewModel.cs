using System;
using PropertyChanged;

namespace LoginKitModel
{
    /// <summary>
    /// Support editing login information.
    /// </summary>
    /// <remarks>
    /// Isolated in separate assembly so it can be used with Xamarin Forms binding 
    /// or directly in native IOS and Android views.
    /// Depends on PropertyChanged.Fody to provide simple binding notifications.
    /// </remarks>
    [ImplementPropertyChanged]
    public class LoginPageViewModel
    {
        #region Entry Properties
        public string Username { get; set; }
        public string Password { get; set; }
        public bool ShowPassword { get; set; }
        public bool RememberPassword { get; set; }
        #endregion

        #region Overrideable quality checks
        public delegate bool UsernameValidator(string username);
        public delegate bool PasswordValidator(string username, string password);
        public delegate double PasswordQualityChecker(string password);
        public UsernameValidator IsUsernameValid => (u) => u.Trim().Length >= 2;
        public PasswordValidator IsPasswordValid => (u, p) => p.Trim().Length >= 2 && !p.Equals(u);
        public PasswordQualityChecker PasswordQuality => (p) => Math.Min(1.0, p.Length / 12.0); // simple version desires 12 chars
        #endregion

        #region Controls for UI State
        public bool LoginShouldBeEnabled => IsUsernameValid(Username) && IsPasswordValid(Username, Password);
        public bool IsShowPasswordVisible {get;set;} = true;
        public bool IsRememberPasswordVisible {get;set;} = true;
        #endregion

        #region Label Strings for later internationalisation
        public string UsernameLabel { get; set; } = "Username";
        public string PasswordLabel { get; set; } = "Password";
        public string ShowPasswordLabel { get; set; } = "Show Password";
        public string RememberPasswordLabel { get; set; } = "Remember Password";
        #endregion

        private static LoginPageViewModel sInstance;
        public static LoginPageViewModel GetInstance()
        {
            if (sInstance == null)
                sInstance = new LoginPageViewModel();
            return sInstance;
        }

        //TODO work out what backing if any required for login via Facebook, Azure et al, ideally as a series of enabled buttons with routing
    }
}
