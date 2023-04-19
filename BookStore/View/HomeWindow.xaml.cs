using Fluent;
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
    /// <summary>
    /// Interaction logic for HomeWindow.xaml
    /// </summary>
    public partial class HomeWindow : RibbonWindow
    {
        public HomeWindow()
        {
            InitializeComponent();
        }

        //MasterDataUserControl _master;
        //OrdersUserConrol _orders;
        //ReportUserControl _report;
        private void RibbonWindow_Loaded(object sender, RoutedEventArgs e)
        {
            /*tabs.Items.Clear();

            _master = new MasterDataUserControl();
            _orders = new OrdersUserConrol();
            _report = new ReportUserControl();

            var screens = new ObservableCollection<TabItem>()
            {
                new TabItem() { Content = _master },
                new TabItem() { Content = _orders },
                new TabItem() { Content = _report }
            };
            tabs.ItemsSource = screens;*/
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
    }
}
