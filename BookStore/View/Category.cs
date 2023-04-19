using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.View
{
    public class Category : INotifyPropertyChanged
    {
        public string CategoryID { get; set; }
        public string CategoryName { get; set; }

        public event PropertyChangedEventHandler? PropertyChanged;
    }
}
