using Microsoft.Win32;
using System;
using System.Collections.Generic;
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
    /// Interaction logic for UpdateWindow.xaml
    /// </summary>
    public partial class UpdateWindow : Window
    {
        public Book currentBook;
        FileInfo _selectedImage = null;
        public UpdateWindow(Book old)
        {
            InitializeComponent();
            currentBook = old;
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
