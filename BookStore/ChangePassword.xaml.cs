using BookStore.View;
using MahApps.Metro.Controls;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace BookStore
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class ChangePassword : MetroWindow
    {
        public static SqlConnection _connection = MainWindow._connection;
        public ChangePassword()
        {
            InitializeComponent();
        }

        private void productOKButton_Click(object sender, RoutedEventArgs e)
        {
            
            if (isValidated())
            {
                string sql =
                "Update Account set password = @new_password, entropy = @entropy where username = @username";
                

                var config = ConfigurationManager.OpenExeConfiguration(
                        ConfigurationUserLevel.None);
                var passwordInBytes = Encoding.UTF8.GetBytes(newPassword.Password);
                var entropy = new byte[20];
                using (var rng = RandomNumberGenerator.Create())
                {
                    rng.GetBytes(entropy);
                }

                var cypherText = ProtectedData.Protect(
                    passwordInBytes,
                    entropy,
                    DataProtectionScope.CurrentUser
                );

                var passwordIn64 = Convert.ToBase64String(cypherText);
                var entropyIn64 = Convert.ToBase64String(entropy);

                config.AppSettings.Settings["Password"].Value = passwordIn64;
                config.AppSettings.Settings["Entropy"].Value = entropyIn64;


                config.Save(ConfigurationSaveMode.Full);
                ConfigurationManager.RefreshSection("appSettings");

                var command = new SqlCommand(sql, MainWindow._connection);

                command.Parameters.Add("@new_password", SqlDbType.NVarChar).Value = passwordIn64;
                command.Parameters.Add("@entropy", SqlDbType.NVarChar).Value = entropyIn64;
                command.Parameters.Add("@username", SqlDbType.NVarChar).Value = currentUsername.Text;        
                command.ExecuteNonQuery();
                DialogResult = true;
            }
        
        }

        private bool isValidated()
        {
            if(newPassword.Password != confirmPassword.Password)
            {
                return false;
            }
            if (newPassword.Password == "")
                return false;
            if (confirmPassword.Password == "")
                return false;
            return true;
        }

        private string getPassword(string username)
        {
            string sql =
                "select password,entropy from ACCOUNT where username = @username";

            var command = new SqlCommand(sql, MainWindow._connection);
            command.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;

            var reader = command.ExecuteReader();

            string password = "";

            while (reader.Read())
            {

                string entropyIn64 = (string)reader["entropy"];
                string passwordIn64 = (string)reader["password"];

                byte[] entropyInBytes = Convert.FromBase64String(entropyIn64);
                byte[] cypherTextInBytes = Convert.FromBase64String(passwordIn64);

                byte[] passwordInBytes = ProtectedData.Unprotect(cypherTextInBytes,
                    entropyInBytes,
                    DataProtectionScope.CurrentUser
                );

                password = Encoding.UTF8.GetString(passwordInBytes);

            }
            reader.Close();
            return password;
        }

        private void authenButton_Click(object sender, RoutedEventArgs e)
        {
            string oldPass = oldPassword.Password;
            if (currentUsername.Text != "" && oldPass != "")
            {
                string temp_password = getPassword(currentUsername.Text);

                if (temp_password != "" && temp_password.Equals(oldPass))
                {
                    currentUsername.IsEnabled = false;
                    oldPassword.IsEnabled = false;

                    newPassword.IsEnabled = true;
                    confirmPassword.IsEnabled = true;
                    OKButton.IsEnabled = true;
                }
            }
        }

        private void changePasswordLoaded(object sender, RoutedEventArgs e)
        {
            currentUsername.Text = MainWindow.username;
            currentUsername.IsEnabled = false;
            newPassword.IsEnabled = false;
            confirmPassword.IsEnabled = false;
            OKButton.IsEnabled = false;
        }
    }
}
