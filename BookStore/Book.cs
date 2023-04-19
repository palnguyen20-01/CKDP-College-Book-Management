using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.Common;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace BookStore
{
    public class Book : INotifyPropertyChanged, ICloneable
    {
        public string Name { get; set; }
        public string Image { get; set; }
        public string Publish { get; set; }
        public string Author { get; set; }
        public string Type { get; set; }
        public string Price { get; set; }

        public event PropertyChangedEventHandler? PropertyChanged;

        public object Clone()
        {
            return MemberwiseClone();
        }
    }

    class BookDao
    {
        

        public ObservableCollection<Book> GetAll()
        {
            

            var list = new ObservableCollection<Book>();
            string sql =
                "select * from BOOK";

            var command = new SqlCommand(sql, MainWindow._connection);
            

            var reader = command.ExecuteReader();

            while (reader.Read())
            {
                string name = (string)reader["name"];
                string image = (string)reader["image"];
                string publish = (string)reader["publish"];
                string author = (string)reader["author"];

                list.Add(new Book()
                {
                    Name = name,
                    Image = image,
                    Publish = publish,
                    Author = author
                });
            }

            reader.Close();
            return list;
        }
    }
}
