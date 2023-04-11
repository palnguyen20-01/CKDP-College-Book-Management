using System;
using System.Collections.Generic;
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
    public partial class HomeWindow : Window
    {
        public HomeWindow()
        {
            InitializeComponent();
        }

        private void test1_click(object sender, RoutedEventArgs e)
        {
            var tmp = new QLHangHoa();
            contenDisplayMain.Content = tmp;
        }

        private void test2_click(object sender, RoutedEventArgs e)
        {
            var tmp = new QLDonHang();
            contenDisplayMain.Content = tmp;
        }
    }
}
