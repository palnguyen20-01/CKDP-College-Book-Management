using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BookStore.View
{
    /// <summary>
    /// Interaction logic for QLDonHang.xaml
    /// </summary>
    public partial class QLDonHang : UserControl
    {

        ObservableCollection<Order> _orders;
        OrderDao orderDao;
        public QLDonHang()
        {
            InitializeComponent();
            orderDao = new OrderDao();
            
            updateOrderList();

        }

        private void DeleteOrderButton_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;

            Order order = button.CommandParameter as Order;
            if (System.Windows.MessageBox.Show("Do you want to delete this order?", "Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
            deleteItem(order);
            }
        }
        
        public void deleteOrder()
        {
            int index=ordersListView.SelectedIndex;
            if (index == -1) return;
            if (System.Windows.MessageBox.Show("Do you want to delete this order?", "Confirmation", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                deleteItem(_orders[index]);
            }
        }

        private void deleteItem(Order order)
        {
            OrderDetailDao dao = new OrderDetailDao();
            dao.deleteAllByOrderId(order.id);
            orderDao.delete(order.id);
            _orders.Remove(order);

        }

        private void updateOrder_MouseClick(object sender, MouseButtonEventArgs e)
        {
            int selectedOrderIndex = ordersListView.SelectedIndex;
            if (selectedOrderIndex == -1) return;
            UpdateOrder updateOrder = new UpdateOrder(_orders[selectedOrderIndex]);
            bool? result=updateOrder.ShowDialog();

            if (result == true)
            {
                updateOrderList();
            }
        }

        public void updateOrder()
        {
            int selectedOrderIndex = ordersListView.SelectedIndex;
            if (selectedOrderIndex == -1) return;
            UpdateOrder updateOrder = new UpdateOrder(_orders[selectedOrderIndex]);
            bool? result = updateOrder.ShowDialog();

            if (result == true)
            {
                updateOrderList();
            }
        }

        public void addOrder()
        {
            AddNewOrder addNewOrder = new AddNewOrder();
            bool? result = addNewOrder.ShowDialog();

            if (result == true)
            {
                updateOrderList();
            }
        }

        public void updateOrderList()
        {
            _orders = orderDao.GetAll();
            ordersListView.ItemsSource = _orders;

        }
    }
}
