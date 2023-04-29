using BookStore.View;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
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
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BookStore
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        
        public MainWindow()
        {
            InitializeComponent();
        }
        public static SqlConnection _connection;
        public static string username;
        private void connectButton_Click(object sender, RoutedEventArgs e)
        {
            // Lấy mã nguồn về cần làm 2 chuyện
            // 1. Chuẩn bị database và lấy username, password cần thiết.
            // 2. Xóa đi file config mặc định bởi vì nó lưu mật khẩu đã
            // // được mã hóa theo username trên máy thầy

            username = usernameTextBox.Text;
            string password = passwordBox.Password;

            var secret = new ConfigurationBuilder().AddUserSecrets<MainWindow>().Build();
            var connectionString = secret.GetSection("MyDB:ConnectionString").Value;
            connectionString = connectionString.Replace("@Catalog", "BookStore");
            _connection = new SqlConnection(connectionString);

            try
            {
                _connection.Open();
                string temp_password = getPassword(username);

                if (temp_password != "" && temp_password.Equals(password))
                {
                    if (rememberCheckBox.IsChecked == true)
                    {
                        // Lưu username và pass
                        var config = System.Configuration.ConfigurationManager.OpenExeConfiguration(
                            ConfigurationUserLevel.None);
                        config.AppSettings.Settings["Username"].Value = usernameTextBox.Text;

                        // Ma hoa mat khau
                        var passwordInBytes = Encoding.UTF8.GetBytes(password);
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

                        //insert(username, passwordIn64, entropyIn64);
                        config.Save(ConfigurationSaveMode.Full);
                        System.Configuration.ConfigurationManager.RefreshSection("appSettings");
                    }

                    HomeWindow home = new HomeWindow();
                    home.Show();
                    this.Close();
                }

                
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Cannot connect to database. Reason: {ex.Message}");
            }
        }
        private void insert(string username, string password, string entropy)
        {
            string sql = "INSERT INTO ACCOUNT VALUES (@username, @password,@entropy)";
            var command = new SqlCommand(sql, _connection);
            command.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;
            command.Parameters.Add("@password", SqlDbType.NVarChar).Value = password;
            command.Parameters.Add("@entropy", SqlDbType.NVarChar).Value = entropy;

            command.ExecuteNonQuery();
        }

        private string getPassword(string username)
        {
            string sql =
                "select password,entropy from ACCOUNT where username = @username";

            var command = new SqlCommand(sql, _connection);
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

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string username = System.Configuration.ConfigurationManager.AppSettings["Username"]!;
            string passwordIn64 = System.Configuration.ConfigurationManager.AppSettings["Password"]!;
            string entropyIn64 = System.Configuration.ConfigurationManager.AppSettings["Entropy"]!;

            if (passwordIn64.Length != 0)
            {
                byte[] entropyInBytes = Convert.FromBase64String(entropyIn64);
                byte[] cypherTextInBytes = Convert.FromBase64String(passwordIn64);

                byte[] passwordInBytes = ProtectedData.Unprotect(cypherTextInBytes,
                    entropyInBytes,
                    DataProtectionScope.CurrentUser
                );

                string password = Encoding.UTF8.GetString(passwordInBytes);

                usernameTextBox.Text = username;
                passwordBox.Password = password;
            }



        }

        private void selectButton_Click(object sender, RoutedEventArgs e)
        {
            int selected = 3;
            string sql =
                "select id, name from Category where id = @id";

            var command = new SqlCommand(sql, _connection);
            command.Parameters.Add("@id", SqlDbType.Int).Value = selected;

            var reader = command.ExecuteReader();

            while (reader.Read())
            {
                int id = (int)reader["id"];
                string name = (string)reader["name"];

                MessageBox.Show($"{id} - {name}");
            }

            reader.Close();
        }

        private void deleteButton_Click(object sender, RoutedEventArgs e)
        {
            int selected = 3;
            string sql = "delete from Category where id = @id";
            var command = new SqlCommand(sql, _connection);
            command.Parameters.Add("@id", SqlDbType.Int).Value = selected;

            int rows = command.ExecuteNonQuery();

            if (rows > 0)
            {
                MessageBox.Show($"Category {selected} is deleted");
            }
        }

        private void homeWindow_Click(object sender, RoutedEventArgs e)
        {
            var p = new HomeWindow();
            p.Show();
        }

        

        private void RevenueProfitDashBoardWindow_Click(object sender, RoutedEventArgs e)
        {
            var p = new IncomeProfitDashBoard();
            p.Show();
        }

        private void Border_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
        }

        private void ButtonMinimize_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.MainWindow.WindowState = WindowState.Minimized;
        }

        private void WindowStateButton_Click(object sender, RoutedEventArgs e)
        {
            if (Application.Current.MainWindow.WindowState != WindowState.Maximized)
                Application.Current.MainWindow.WindowState = WindowState.Maximized;
            else Application.Current.MainWindow.WindowState = WindowState.Normal;
        }
        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void Border_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
        }
    }
}

