using Fluent;
using Microsoft.Win32;
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
using System.Windows.Shapes;

namespace BookStore.View
{
    public partial class HomeWindow : RibbonWindow
    {
        public delegate void PriceValueChangedHandler(int newValue);
        public event PriceValueChangedHandler PriceValueChanged;

        public HomeWindow()
        {
            InitializeComponent();
        }

        TrangChu _dashBoard;
        QLHangHoa _product;
        QLDonHang _orders;
        BCThongKe _report;
        ObservableCollection<Category> _categories = new ObservableCollection<Category>();
        Price _price;

        private void RibbonWindow_Loaded(object sender, RoutedEventArgs e)
        {
            tabs.Items.Clear();

            _dashBoard = new TrangChu();
            _product = new QLHangHoa();
            _orders = new QLDonHang();
            _report = new BCThongKe();

            var screens = new ObservableCollection<TabItem>()
            {
                new TabItem() { Content = _dashBoard },
                new TabItem() { Content = _product },
                new TabItem() { Content = _orders },
                new TabItem() { Content = _report }
            };
            tabs.ItemsSource = screens;

            categoryCombobox.ItemsSource = _categories;

            _price = new Price()
            {
                minPrice = 0,
                maxPrice = 1000000,
                currentPrice = 1000000
            };
            priceTextBlock.DataContext = _price;
            minPriceTextBlock.DataContext = _price;
            maxPriceTextBlock.DataContext = _price;
        }

        private void BackstageTabItem_MouseDown(object sender, MouseButtonEventArgs e)
        {
            var result = MessageBox.Show("Are you sure you want to quit?",
                "Confirmation", MessageBoxButton.YesNo);

            if (result == MessageBoxResult.Yes)
            {
                Application.Current.Shutdown();
            }
        }

        private void updateCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            //_master.Update("Duc");
        }

        private void addCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            //_master.Insert("Long");
        }

        private void deleteCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            //_master.Delete("Tien");
        }

        private void priceSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            int newValue = (int)priceSlider.Value;
            _price.currentPrice = newValue;
            PriceValueChanged?.Invoke(newValue);
        }

        private void productImportButton_Click(object sender, RoutedEventArgs e)
        {
            _product.import();
            _product.getCategories(_categories);
        }

        private void addOrderButton_Click(object sender, RoutedEventArgs e)
        {
            AddNewOrder addNewOrder = new AddNewOrder();
            addNewOrder.Show();
        }
    }
}
