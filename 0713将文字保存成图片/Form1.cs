using Microsoft.Data.ConnectionUI;
using System;
using System.Windows.Forms;

namespace _0713将文字保存成图片
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public static string connStr = null;
        private void link_to_sql_Click(object sender, EventArgs e)
        {
            connStr = GetDatabaseConnectionString();
        }

        #region 链接数据库
        private static string GetDatabaseConnectionString()//链接数据库
        {
            try
            {
                string result = null;
                //数据库链接
                DataConnectionDialog dialog = new DataConnectionDialog();
                dialog.DataSources.Clear();
                //添加数据源列表，可以向窗口中添加所需要的数据源类型 必须至少有一项
                //dialog.DataSources.Add(DataSource.AccessDataSource);    //Access
                dialog.DataSources.Add(DataSource.SqlDataSource);       //Sql Server
                                                                        //dialog.DataSources.Add(DataSource.OracleDataSource);    //Oracle
                                                                        //dialog.DataSources.Add(DataSource.OdbcDataSource);      //Odbc
                                                                        //dialog.DataSources.Add(DataSource.SqlFileDataSource);   //Sql Server File
                                                                        //设置默认数据提供程序
                dialog.SelectedDataSource = DataSource.SqlDataSource;
                dialog.SelectedDataProvider = DataProvider.SqlDataProvider;
                //dialog.ConnectionString = @"Data Source=.\sqlserver;Initial Catalog=Index_TradeMark;Integrated Security=True";//也可以设置默认连接字符串
                dialog.ConnectionString = @"Data Source=.\sqlserver;Initial Catalog=Index_TradeMark;Integrated Security=True";
                //只能通过DataConnectionDialog类的静态方法show出对话框，不能用dialog.Show()或者dialog.ShowDialog()来呈现对话框
                if (DataConnectionDialog.Show(dialog) == DialogResult.OK)
                {
                    result = dialog.ConnectionString;
                }
                if (result != null)
                {
                    MessageBox.Show("已经成功链接到数据库", "链接数据库成功！");
                }
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
    }
}
