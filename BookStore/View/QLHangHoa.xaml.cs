﻿using BookStore.View.Class;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Vml;
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BookStore.View
{
    public partial class QLHangHoa : System.Windows.Controls.UserControl
    {
        public QLHangHoa()
        {
            InitializeComponent();
        }

        List<Category> _categories = null;
        ObservableCollection<Book> _books = null;
        DBContext _db;

        public Price _price = null;

        private void UserControl_Initialized(object sender, EventArgs e)
        {
            _books = new ObservableCollection<Book>();
            productListView.ItemsSource = _books;
            _categories = new List<Category>() { new Category() { CategoryID = 0, CategoryName = "All" } };
            _db = new DBContext();
            if (!_db.Database.CanConnect())
            {
                System.Windows.Forms.MessageBox.Show("DB connection is bad");
            }
            
            //Read Book data
            List<Book> _temp_books = _db.getAllBooks();
            foreach(var book in _temp_books)
            {
                _books.Add(book);
            }

            //Read Category data
            _categories = _db.getCategories();

            //Read Price data
            _price = new Price();
            resetPrice();
        }

        public void getCategories(ObservableCollection<Category> categories)
        {
            foreach(var category in _categories)
            {
                categories.Add(category);
            }
        }

        public Price getPrice()
        {
            return _price;
        }

        public void import()
        {
            string filename = "";
            Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog();
            openFileDialog.Filter = "Excel files (*.csv;*.xlsx)|*.csv;*.xlsx|All files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == true)
            {
                filename = openFileDialog.FileName;
            }

            if (filename.IsNullOrEmpty() || !filename.EndsWith(".xlsx")) return;

            //delete _books
            _books.Clear();

            //delete db
            _db.Categories.RemoveRange(_db.Categories);
            _db.Books.RemoveRange(_db.Books);
            _db.SaveChanges();

            var document = SpreadsheetDocument.Open(filename, false);
            var wbPart = document.WorkbookPart!;
            var sheets = wbPart.Workbook.Descendants<Sheet>()!;

            //Read Category Sheet
            var sheet = sheets.FirstOrDefault(s => s.Name == "Category");
            var wsPart = (WorksheetPart)(wbPart!.GetPartById(sheet.Id!));
            var stringTable = wbPart.GetPartsOfType<SharedStringTablePart>().FirstOrDefault()!;
            var cells = wsPart.Worksheet.Descendants<Cell>();

            Cell idCell;
            int row = 2;
            do
            {
                idCell = cells.FirstOrDefault(c => c?.CellReference == $"A{row}")!;

                if (idCell?.InnerText.Length > 0)
                {
                    Cell nameCell = cells.FirstOrDefault(c => c?.CellReference == $"B{row}")!;
                    string nameID = nameCell!.InnerText;
                    string name = stringTable.SharedStringTable.ElementAt(int.Parse(nameID)).InnerText;

                    var category = new Category() { CategoryID = int.Parse(idCell.InnerText), CategoryName = name };
                    _categories.Add(category);
                    _db.insertCategory(category);
                }
                row++;

            } while (idCell?.InnerText.Length > 0);

            //Read Product Sheet
            sheet = sheets.FirstOrDefault(s => s.Name == "Product");
            wsPart = (WorksheetPart)(wbPart!.GetPartById(sheet.Id!));
            stringTable = wbPart.GetPartsOfType<SharedStringTablePart>().FirstOrDefault()!;
            cells = wsPart.Worksheet.Descendants<Cell>();
            
            row = 2;
            do
            {
                idCell = cells.FirstOrDefault(c => c?.CellReference == $"A{row}")!;

                if (idCell?.InnerText.Length > 0)
                {
                    Cell nameCell = cells.FirstOrDefault(c => c?.CellReference == $"B{row}")!;
                    string nameID = nameCell!.InnerText;
                    string name = stringTable.SharedStringTable.ElementAt(int.Parse(nameID)).InnerText;

                    Cell imageCell = cells.FirstOrDefault(c => c?.CellReference == $"C{row}")!;
                    string imageID = imageCell!.InnerText;
                    string image = stringTable.SharedStringTable.ElementAt(int.Parse(imageID)).InnerText;

                    Cell authorCell = cells.FirstOrDefault(c => c?.CellReference == $"D{row}")!;
                    string authorID = authorCell!.InnerText;
                    string author = stringTable.SharedStringTable.ElementAt(int.Parse(authorID)).InnerText;

                    Cell publishCell = cells.FirstOrDefault(c => c?.CellReference == $"E{row}")!;
                    string publish = publishCell!.InnerText;

                    Cell categoryIDCell = cells.FirstOrDefault(c => c?.CellReference == $"F{row}")!;
                    string categoryID = categoryIDCell!.InnerText;

                    Cell priceCell = cells.FirstOrDefault(c => c?.CellReference == $"G{row}")!;
                    string price = priceCell!.InnerText;

                    Cell rawPriceCell = cells.FirstOrDefault(c => c?.CellReference == $"H{row}")!;
                    string rawPrice = rawPriceCell!.InnerText;

                    var book = new Book() { ID = int.Parse(idCell!.InnerText), Name = name, Author = author, Image = image, Publish = publish, CategoryID = int.Parse(categoryID), Price = price, RawPrice = rawPrice };
                    _books.Add(book);
                    _db.insertBook(book);
                }
                row++;

            } while (idCell?.InnerText.Length > 0);
            resetPrice();
        }

        private void resetPrice()
        {
            _price.maxPrice = _books.Max(book => int.Parse(book.Price));
            _price.minPrice = _books.Min(book => int.Parse(book.Price));
            _price.currentPrice = _price.maxPrice;
        }

        public void addProduct()
        {
            int productID = 0;
            if(_books.Count > 0)
            {
                productID = _books.Last().ID + 1;
            }
            AddProduct addProduct = new AddProduct(productID, _categories);
            bool? result = addProduct.ShowDialog();
            if (result == true)
            {
                _books.Add(addProduct.book);
                _db.insertBook(addProduct.book);
                resetPrice();
            }
        }

        public void deleteProduct()
        {

        }

        public void updateProduct()
        {

        }

        public void addCategory()
        {

        }

        public void deleteCategory()
        {

        }

        public void updateCategory()
        {

        }

    }
}