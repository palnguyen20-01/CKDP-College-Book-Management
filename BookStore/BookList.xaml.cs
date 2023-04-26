using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Common;
using System.Data;
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
    /// Interaction logic for BookList.xaml
    /// </summary>
    public partial class BookList : Window
    {
        public BookList()
        {
            InitializeComponent();
        }
        ObservableCollection<Book> _Books = null;
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            BookDao dao = new BookDao();
            _Books = dao.GetAll();
            booksComboBox.ItemsSource = _Books;
        }

        private void addButton_Click(object sender, RoutedEventArgs e)
        {
            var screen = new AddWindow();
            if (screen.ShowDialog() == true)
            {
                _Books.Add(screen.currentBook);
            }
        }

        private void deleteButton_Click(object sender, RoutedEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            deleteItem(_Books[i]);
            _Books.RemoveAt(i);
        }

        private void deleteItem(Book book) {
            String sql = "delete from book where name=@name";
            var command = new SqlCommand(sql, MainWindow._connection);
            command.Parameters.Add("@name", SqlDbType.NVarChar).Value = book.Name;
            command.ExecuteNonQuery();
        }
        private void updateItem(Book book,string old_name) {
            String sql = "update book set name=@name,image=@image,publish=@publish,author=@author where name=@old_name";
            var command = new SqlCommand(sql, MainWindow._connection);
            command.Parameters.Add("@old_name", SqlDbType.NVarChar).Value = old_name;
            command.Parameters.Add("@name", SqlDbType.NVarChar).Value = book.Name;
            command.Parameters.Add("@image", SqlDbType.NVarChar).Value = book.Image;
            command.Parameters.Add("@publish", SqlDbType.NVarChar).Value = book.Publish;
            command.Parameters.Add("@author", SqlDbType.NVarChar).Value = book.Author;
            command.ExecuteNonQuery();
        }



        private void updateButton_Click(object sender, RoutedEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            var screen = new UpdateWindow((Book)_Books[i].Clone());
            string old_name = _Books[i].Name;
            if (screen.ShowDialog() == true)
            {
                _Books[i] = screen.currentBook;
            }
            updateItem(_Books[i], old_name);

        }

        private void deleteItem_Click(object sender, RoutedEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            deleteItem(_Books[i]);
            _Books.RemoveAt(i);
        }

        private void booksListView_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            MessageBox.Show(_Books[i].Name);
        }

        private void editItem_Click(object sender, RoutedEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            _Books[i].Name = "Data Binding List";
            _Books[i].Author = "Trần Duy Quang";
            _Books[i].Image = "Images/7.jpg";
            _Books[i].Publish = "2023";
        }

        private void viewItem_Click(object sender, RoutedEventArgs e)
        {
            int i = booksComboBox.SelectedIndex;
            MessageBox.Show(_Books[i].Name);
        }
    }
}
