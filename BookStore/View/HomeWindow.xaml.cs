﻿using Fluent;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Configuration;
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

            currentProductCategoryComboBox.ItemsSource = QLHangHoa._productDAO._categories;

            priceSliderDockPanel.DataContext = QLHangHoa._productDAO._price;

            string closedTab = ConfigurationManager.AppSettings["ClosedTab"]!;
            if (closedTab.Length > 0)
            {
                int numTab = Int32.Parse(closedTab);
                Dispatcher.BeginInvoke((Action)(() => tabs.SelectedIndex = numTab));
            }
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

        private void priceSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            int newValue = (int)priceSlider.Value;
            QLHangHoa._productDAO._price.currentPrice = newValue;
            _product.updatePrice();
            PriceValueChanged?.Invoke(newValue);
        }

        private void productImportButton_Click(object sender, RoutedEventArgs e)
        {
            _product.import();
        }
        private void addOrderButton_Click(object sender, RoutedEventArgs e)
        {
            _orders.addOrder();
        }

        private void deleteOrderButton_Click(object sender, RoutedEventArgs e)
        {
            _orders.deleteOrder();
        }

        private void updateOrderButton_Click(object sender, RoutedEventArgs e)
        {
            _orders.updateOrder();

        }

        private void addProductButton_Click(object sender, RoutedEventArgs e)
        {
            _product.addProduct();
        }

        private void deleteProductButton_Click(object sender, RoutedEventArgs e)
        {
            _product.deleteProduct();
        }

        private void updateProductButton_Click(object sender, RoutedEventArgs e)
        {
            _product.updateProduct();
        }

        private void addCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            _product.addCategory();
        }
        
        private void deleteCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            _product.deleteCategory();
        }

        private void updateCategoryButton_Click(object sender, RoutedEventArgs e)
        {
            _product.updateCategory();
        }

        private void searchProductButton_Click(object sender, RoutedEventArgs e)
        {
            _product.searchProduct(searchProductTextBox.Text);
        }

        private void currentProductCategoryComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            _product.filterCategory(currentProductCategoryComboBox.SelectedIndex);
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            var config = ConfigurationManager.OpenExeConfiguration(
                        ConfigurationUserLevel.None);
            config.AppSettings.Settings["ClosedTab"].Value = tabs.SelectedIndex.ToString();
            config.Save(ConfigurationSaveMode.Full);
            ConfigurationManager.RefreshSection("appSettings");
        }

    }
}
