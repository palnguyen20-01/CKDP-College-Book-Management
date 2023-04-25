using DocumentFormat.OpenXml.Office.Word;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using static System.Runtime.InteropServices.JavaScript.JSType;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace BookStore
{

    public class Order : INotifyPropertyChanged, ICloneable
    {
        public int id { get; set; }
        public DateOnly date { get; set; }
        public int totalPrice { get; set; }
        public string username { get; set; }
      
        public event PropertyChangedEventHandler? PropertyChanged;

        public object Clone()
        {
            return MemberwiseClone();
        }
    }



    class OrderDao
    {
        public OrderDao() {
            this.connectDb();
        }
        public SqlConnection _connection;

        private void connectDb()
        {
            string connectionString = $"""
                Server = .\sqlexpress;
                Database = BookStore;
                TrustServerCertificate=True;
                Trusted_Connection=true;                
                """;
            _connection = new SqlConnection(connectionString);
            try
            {
                _connection.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Cannot connect to database. Reason: {ex.Message}");
            }
        }

        public ObservableCollection<Order> GetAll()
        {
            var list = new ObservableCollection<Order>();
            string sql =
                "select * from ORDERS";

            var command = new SqlCommand(sql, _connection);


            var reader = command.ExecuteReader();

            while (reader.Read())
            {
                int id =(int) reader["id"];
                DateOnly date =(DateOnly) reader["date"];
                int totalPrice = (int)reader["totalPrice"];
                string username = (string)reader["username"];

                list.Add(new Order()
                {
                    id = id,
                    date = date,
                    totalPrice = totalPrice,
                    username = username
                });
            }

            reader.Close();
            return list;
        }

        public void insert(int id,DateOnly date, string username , int totalPrice=0)
        {
            string sql = "INSERT INTO ORDERS VALUES (@id,@date, @totalPrice,@username)";
            
            var command = new SqlCommand(sql, _connection);
  
            
            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            command.Parameters.Add("@date", SqlDbType.Date).Value = date;
            command.Parameters.Add("@totalPrice", SqlDbType.Int).Value = totalPrice;
            command.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;

            command.ExecuteNonQuery();

        }
        public void delete(int id)
        {
            string sql = "delete from orders where id=@id";
            var command = new SqlCommand(sql,_connection);
            command.Parameters.Add("@id", SqlDbType.NVarChar).Value = id;
            command.ExecuteNonQuery();
        }

        public int count()
        {
            string sql = "SELECT COUNT(*) FROM ORDERS";
            var command = new SqlCommand(sql, _connection);

            int count = (int)command.ExecuteScalar();
            return count;
        }

        public void updateTotalPrice(int id,int totalPrice) {
            string sql = "UPDATE ORDERS SET totalPrice = @totalPrice WHERE id=@id";

            var command = new SqlCommand(sql, _connection);

            command.Parameters.Add("@id", SqlDbType.Int).Value = id;
            command.Parameters.Add("@totalPrice", SqlDbType.Int).Value = totalPrice;
            

            command.ExecuteNonQuery();
        }
    }
}
