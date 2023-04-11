using Microsoft.Data.SqlClient;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.IO;
using System.Linq;
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

namespace BookStore
{
    /// <summary>
    /// Interaction logic for AddWindow.xaml
    /// </summary>
    public partial class AddWindow : Window
    {
        public delegate void
            AddBookHandler(int newValue);
        public event
            AddBookHandler AddBook;

        public Book currentBook;
        FileInfo _selectedImage = null;

        public AddWindow()
        {
            InitializeComponent();
            currentBook = new Book();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            DataContext = currentBook;
        }

        private void okButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = true;
            var folder = AppDomain.CurrentDomain.BaseDirectory;
            string path = $"{folder}Images/{_selectedImage.Name}";
            if (!File.Exists(path))
            {
                File.Copy(_selectedImage.FullName, path);
            }
            currentBook.Image = $"Images/{_selectedImage.Name}";
            insertBook();
        }

        private void insertBook()
        {
            String sql = "INSERT INTO BOOK (name,image,publish,author) VALUES (@name, @image,@publish,@author)";
            var command = new SqlCommand(sql, MainWindow._connection);
            command.Parameters.Add("@name", SqlDbType.NVarChar).Value = currentBook.Name;
            command.Parameters.Add("@image", SqlDbType.NVarChar).Value = currentBook.Image;
            command.Parameters.Add("@publish", SqlDbType.NVarChar).Value = currentBook.Publish;
            command.Parameters.Add("@author", SqlDbType.NVarChar).Value = currentBook.Author;

            command.ExecuteNonQuery();
        }

        private void browseButton_Click(object sender, RoutedEventArgs e)
        {
            var screen = new OpenFileDialog();

            if (screen.ShowDialog() == true)
            {
                _selectedImage = new FileInfo(screen.FileName);
                var bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.UriSource = new Uri(screen.FileName, UriKind.Absolute);
                bitmap.EndInit();
                bookImage.Source = bitmap;
            }
        }
    }
}

