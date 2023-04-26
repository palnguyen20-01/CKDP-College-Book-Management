using MahApps.Metro.Controls;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using Button = System.Windows.Controls.Button;
using MessageBox = System.Windows.MessageBox;

namespace BookStore
{
    /// <summary>
    /// Interaction logic for AddNewOrder.xaml
    /// </summary>
    /// 
    class BookDetail : Book
    {
        public int quantity { get; set; }
        public int id { get; set; }

    }
    public partial class AddNewOrder : MetroWindow
    {
        ObservableCollection<Order> _Order = null;
        OrderDao dao=null;
        ObservableCollection<BookDetail> books = new ObservableCollection<BookDetail>();

        public AddNewOrder()
        {
            InitializeComponent();
            dao = new OrderDao();
            BookDetail book = new BookDetail();
            book.id = 1;
            book.Name = "Ky Thuat Lap Trinh";
            book.Author = "Dinh Ba Tien";
            book.Publish = "2002";
            book.Price = "500000";
            book.Image = "Images/1.jpg";
            book.quantity = 2;
            books.Add(book);

            BookDetail book1 = new BookDetail();
            book1.id = 2;
            book1.Name = "Lap Trinh Window";
            book1.Author = "Tran Duy Quang";
            book1.Publish = "2022";
            book1.Price = "600000";
            book1.Image = "Images/2.jpg";
            book1.quantity = 5;
            books.Add(book1);
            productsListView.ItemsSource = books;

        }

        private void saveOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            if (dateTxt.Text != "" && nameTxt.Text != "")
            {
                var dateTime = DateTime.Parse(dateTxt.Text);

                var date = DateOnly.FromDateTime(dateTime);
                string username=nameTxt.Text;
                int newOrderId = dao.count() + 1;
                dao.insert(newOrderId,date, username);

                OrderDetailDao orderDetailDao = new OrderDetailDao();
                int totalPrice = 0;
                foreach(BookDetail i in books)
                {
                    orderDetailDao.insert(newOrderId, i.id, i.quantity, int.Parse(i.Price));
                    totalPrice += int.Parse(i.Price);
                }

                dao.updateTotalPrice(newOrderId, totalPrice);

                MessageBox.Show("Save successful !!!","Information",MessageBoxButton.OK, MessageBoxImage.Information);
                
                this.Close();
            }
            else
            {
                MessageBox.Show("Please fill the blank !!!", "Information", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void productsListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void EditProductsButton_Click(object sender, RoutedEventArgs e)
        {
            Button b = sender as Button;

            BookDetail book = b.CommandParameter as BookDetail;


        }
    }
}
