using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
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
using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using LiveCharts;
using LiveCharts.Defaults;
using LiveCharts.Wpf;
using Microsoft.Identity.Client;

namespace BookStore
{
    /// <summary>
    /// Interaction logic for IncomeProfitDashBoard.xaml
    /// </summary>
    /// 
    public partial class IncomeProfitDashBoard : Window
    {
        Random Random = new Random();  
        public Double randomInRange(Double min, Double max)
        {
            return Random.Next() % (max - min) + min;
        }
        public string[] LabelColumns => new[] { "January", "February", "March", "April", "May","June","July" ,"August","September","October","November","December"};
        public ChartValues<ObservableValue> GetAll(Double min, Double max)
        {
            var  ColumnsUI = new ChartValues<ObservableValue>();
            for (int i = 0;i < 12; i++)
            {
                var numGen = randomInRange(min, max);
                ColumnsUI.Add(new ObservableValue(numGen));
            }
        
            return ColumnsUI;

        }
        ChartValues<ObservableValue> ColumnUIRevenues= null;
        ChartValues<ObservableValue> ColumnUIProfits= null;

        public String ShowParseLabelRevenue(ChartPoint label)
        {
            Double yRevenue =  label.Y;

            Double yProfit = ColumnUIProfits[Convert.ToInt32(label.X)].Value;


            Double MaxRevenue = ColumnUIRevenues.Max(o => o.Value);
            Double MinRevenue = ColumnUIRevenues.Min(o => o.Value);

            Double MaxProfit = ColumnUIProfits.Max(o => o.Value);
            Double MinProfit = ColumnUIProfits.Min(o => o.Value);

            if (yRevenue == MaxRevenue || yRevenue == MinRevenue ||
                yProfit == MaxProfit || yProfit == MinProfit) {
                return $"{yRevenue}";
            };
            return "";
        }
        public String ShowParseLabelProfit(ChartPoint label)
        {
            Double yProfit = label.Y;

            Double yRevenue = ColumnUIRevenues[Convert.ToInt32(label.X)].Value;

            Double MaxRevenue = ColumnUIRevenues.Max(o => o.Value);
            Double MinRevenue = ColumnUIRevenues.Min(o => o.Value);

            Double MaxProfit = ColumnUIProfits.Max(o => o.Value);
            Double MinProfit = ColumnUIProfits.Min(o => o.Value);

            if (yRevenue == MaxRevenue || yRevenue == MinRevenue ||
                yProfit == MaxProfit || yProfit == MinProfit)
            {
                return $"{yRevenue}";
            };
            return "";
        }

        public SeriesCollection ColumnSeriesCollection => new SeriesCollection
        {
            new ColumnSeries
            {
                Title = "Revenues",
                Values = ColumnUIRevenues,
                Fill = Brushes.DeepSkyBlue,
                LabelPoint=ShowParseLabelRevenue,
                //LabelPoint = label => Math.Abs(label.Y - ColumnUIProfits.Max(o => o.Value))<0.1 || Math.Abs(label.Y - ColumnUIProfits.Min(o => o.Value))<0.1 ? $"{label.Y}" : "??",
                DataLabels=true
            },
             new ColumnSeries
            {
                Title = "Profit",
                Values = ColumnUIProfits,
                Fill = Brushes.LightSeaGreen,
                LabelPoint=ShowParseLabelProfit,

                DataLabels=true

            }
        };


        //public class ObservableValue : INotifyPropertyChanged, ICloneable
        //{

        //    public double value { get; set; }


        //    public event PropertyChangedEventHandler? PropertyChanged;
        //    public object Clone()
        //    {
        //        return MemberwiseClone();
        //    }
        //    protected virtual void OnPropertyChanged(string propertyName = null)
        //    {
        //        //Raise PropertyChanged event
        //        if (PropertyChanged != null)
        //            PropertyChanged.Invoke(this, new PropertyChangedEventArgs(propertyName));
        //    }

        //}


        public ObservableValue CostUI = new ObservableValue(0.3);
        public ObservableValue ProfitUI = new ObservableValue(0.7);

        public SeriesCollection PieSeriesCollection => new SeriesCollection
        {
            new PieSeries
            {
                Title = "Cost",
                Values = new ChartValues<ObservableValue> { CostUI  },
                Fill = Brushes.OrangeRed,
                DataLabels = true,
                LabelPoint = label => $"{label.Participation:P}"
            },
             new PieSeries
            {
                Title = "Profit",
                Values = new ChartValues<ObservableValue> { ProfitUI },
                Fill = Brushes.LightSeaGreen,
                DataLabels = true,
                LabelPoint = label => $"{label.Participation:P}"
            }
        };
        // todo load DAO
        private void ColumnSeries_OnDataClick(object sender, ChartPoint chartPoint)
        {
            //var selectedSeries = (ColumnSeries)sender;
            //var xvalue = chartpoint.x;
            try
            {
                var Revenue = ColumnUIRevenues[chartPoint.Key].Value;
                var Profit = ColumnUIProfits[chartPoint.Key].Value;
                var Costpc = (Revenue - Profit) * 1.0 / Profit;
                var Profitpc = Profit * 1.0 / Revenue;
                CostUI.Value = Costpc;
                ProfitUI.Value = Profitpc;
                ColumnUIRevenues[chartPoint.Key].Value = 1;

            }
            catch (Exception  ex) {
                MessageBox.Show(ex.Message.ToString());

            }


            //CostUI.Value = Costpc;
            //ProfitUI.Value = Profitpc;



            //var yValue1 = selectedSeries.Values[chartPoint.Key];
            //var yValue2 = ((ColumnSeries)IPChart.Series[1]).Values[chartPoint.Key];
        }
        public IncomeProfitDashBoard()
        {
            InitializeComponent();
            ColumnUIRevenues = GetAll(10.3,20.3);
            ColumnUIProfits = GetAll(5.1,9.1);
            IPChart.DataClick += ColumnSeries_OnDataClick;
            DataContext = this;
        }
       
    }
}
