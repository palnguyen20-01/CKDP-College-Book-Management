﻿using DocumentFormat.OpenXml.Packaging;
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
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BookStore.View
{
    public partial class QLHangHoa : UserControl
    {
        public QLHangHoa()
        {
            InitializeComponent();
        }

        List<Category> _categories = null;
        ObservableCollection<Book> _books = null;
        private void UserControl_Initialized(object sender, EventArgs e)
        {
            _books = new ObservableCollection<Book>();
            productListView.ItemsSource = _books;
            _categories = new List<Category>() { new Category() { CategoryID = "0", CategoryName = "All" } };
        }

        public void getCategories(ObservableCollection<Category> categories)
        {
            foreach(var category in _categories)
            {
                categories.Add(category);
            }
        }

        public void import()
        {
            string filename = "";
            OpenFileDialog openFileDialog = new OpenFileDialog();
            if (openFileDialog.ShowDialog() == true)
            {
                filename = openFileDialog.FileName;
            }

            if (filename.IsNullOrEmpty()) return;

            var document = SpreadsheetDocument.Open(filename, false);
            var wbPart = document.WorkbookPart!;
            var sheets = wbPart.Workbook.Descendants<Sheet>()!;

            //Read Product Sheet
            var sheet = sheets.FirstOrDefault(s => s.Name == "Product");
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

                    Cell imageCell = cells.FirstOrDefault(c => c?.CellReference == $"C{row}")!;
                    string imageID = imageCell!.InnerText;
                    string image = stringTable.SharedStringTable.ElementAt(int.Parse(imageID)).InnerText;

                    Cell authorCell = cells.FirstOrDefault(c => c?.CellReference == $"D{row}")!;
                    string authorID = authorCell!.InnerText;
                    string author = stringTable.SharedStringTable.ElementAt(int.Parse(authorID)).InnerText;

                    Cell publishCell = cells.FirstOrDefault(c => c?.CellReference == $"E{row}")!;
                    string publish = publishCell!.InnerText;

                    Cell typeCell = cells.FirstOrDefault(c => c?.CellReference == $"F{row}")!;
                    string type = typeCell!.InnerText;

                    Cell priceCell = cells.FirstOrDefault(c => c?.CellReference == $"G{row}")!;
                    string price = priceCell!.InnerText;

                    _books.Add(new Book() { Name = name, Author = author, Image = image, Publish = publish, Type = type , Price = price});
                }
                row++;

            } while (idCell?.InnerText.Length > 0);

            //Read Category Sheet
            sheet = sheets.FirstOrDefault(s => s.Name == "Category");
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

                    _categories.Add(new Category() { CategoryID = idCell.InnerText, CategoryName = name});
                }
                row++;

            } while (idCell?.InnerText.Length > 0);

        }
    }
}