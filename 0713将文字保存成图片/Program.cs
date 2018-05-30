using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.IO;
using System.Data;
namespace _0713将文字保存成图片
{
    class Program
    {
        static void Main(string[] args)
        {
            //Form1 f1 = new Form1();
            //f1.ShowDialog();
            Program ct = new Program();

            string ft = "";
            string connectionString = "server=MRWANG90HOU;Uid=sa;password=qwe123!@#;Database=index_trademark_wn";//server处可以为localhost（本机的MySQL），//可以为云主机，那么等于号后为ip.Database为你的数据库名称
            //SqlConnection conn = new SqlConnection("Data Source=(192.168.0.232);Initial Catalog=index_trademark;Integrated Security=SSPI;");
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();//打开数据库  
            //创建数据库命令  
            SqlCommand cmd = conn.CreateCommand();
            //创建查询语句  
            //cmd.CommandText = "SELECT distinct un_simplified FROM Chinese_Img where id=22";
            cmd.CommandText = "SELECT distinct words FROM Chinese_words_new where id >= 3535 and id <= 3540";//希腊字母
            //cmd.CommandText = "SELECT distinct words FROM Chinese_words_new where id =103220";//【横眉冷对千夫指  俯首甘为孺子牛】
            //从数据库中读取数据流存入reader中
            SqlDataReader reader = cmd.ExecuteReader();

            //从reader中读取下一行数据,如果没有数据,reader.Read()返回flase  
            while (reader.Read())
            {
                //string un = reader.GetString(reader.GetOrdinal("un_simplified")).Trim();
                string un = reader.GetString(reader.GetOrdinal("words")).Trim();
                


                for (int i = 1; i <= 2; i++)
                {
                    switch (i)
                    {
                        case 1: ft = "黑体"; break;
                        case 2: ft = "宋体"; break;
                    }
                    //增加对词典库中内容的判断：（1）文字个数（2）是否含有特殊字符
                    //if (un.Length <= 4)
                    //{
                    //    ct.CreateImage(un, ft);  //生成图片
                    //    //MessageBox.Show(un.Length.ToString());
                    //}

                    //ct.CreateImage(un, ft);  //生成图片
                    ct.saveToSQL(un, ft, ct.CreateImage(un, ft));  //将image图片存入数据库

                    Console.WriteLine("保存{0}成功！", un);
                }
            }
            conn.Close();
            Console.WriteLine("执行完毕！");
            //
            ct.printPictureFormSQL();
        }
        /// <summary>
        /// 将image图片存入数据库
        /// </summary>
        /// <param name="str">Unicode编码字符串</param>
        /// <returns>汉字字符串</returns>
        private void saveToSQL(string content, string ft, Bitmap image)
        {
            int sum_a = 0;
            //    //try
            //    //{
            //    //string connString = "Data Source = . ;Initial Catalog =hotel;User ID=sa;Pwd=123456";//数据库连接字符串
            //    //SqlConnection connection = new SqlConnection(connString);//创建connection对象
            //    //SqlConnection connection = new SqlConnection("Data Source=(local);Initial Catalog=MySchool;Integrated Security=SSPI;");
            //    SqlConnection connection = new SqlConnection("server=MRWANG90HOU;Uid=sa;password=qwe123!@#;Database=MySchool");

            //    //string connectionString = "server=MRWANG90HOU;Uid=sa;password=qwe123!@#;Database=index_trademark_wn";
            //    string sql = "insert into MySchool.dbo.Images(words,words_image,fonts) values (@words,@words_image,@fonts)";

            //    //Console.WriteLine("存储数据准备执行！");
            //    MessageBox.Show("存储数据准备执行！");
            //    //conn.Open();//打开数据库  
            //    //打开数据库连接
            //    connection.Open();
            //    //创建数据库命令  
            //    SqlCommand command = new SqlCommand(sql, connection);

            //    /*********************************Bitmap => byte[]***********************************/
            //    //Bitmap image = new Bitmap("test.bmp ");
            //    /*
            //    MemoryStream stream = new MemoryStream();
            //        image.Save(stream, ImageFormat.Jpeg);
            //        byte[] mapByte = new Byte[mapStream.Length];
            //        mapStream.Position = 0;
            //        mapStream.Read(mapByte, 0, mapByte.Length);


            //        MemoryStream ms = new MemoryStream();
            //        image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            //        byte[] mybyte = ms.GetBuffer();  //byte[]   bytes=   ms.ToArray(); 这两句都可以，至于区别么，下面有解释
            //        ms.Close();
            //        */

            //byte[] mybyte = PhotoImageInsert(image);

            //MessageBox.Show(content + "\n" + ft + "\n" + mybyte);
            ///*********************************Bitmap => byte[]***********************************/
            //    /*
            //    //图片路径
            //    string picturePath = @"D:\222\黯沮(黑体).jpg"; //注意，这里需要指定保存图片的绝对路径和图片?

            //    //文件的名称，每次必须更换图片的名称，这里很为不便
            //    //创建FileStream对象
            //    FileStream fs = new FileStream(picturePath, FileMode.Open, FileAccess.Read);
            //    //声明Byte数组
            //    Byte[] mybyte = new byte[fs.Length];
            //    //读取数据
            //    fs.Read(mybyte, 0, mybyte.Length);
            //    fs.Close();
            //    */
            //    //转换成二进制数据，并保存到数据库

            //    SqlParameter[] prm =
            //    {
            //            new SqlParameter("@words", SqlDbType.VarBinary, mybyte.Length, ParameterDirection.Input, false, 0, 0, null, DataRowVersion.Current, content),
            //            new SqlParameter("@words_image", SqlDbType.VarBinary, mybyte.Length, ParameterDirection.Input, false, 0, 0, null, DataRowVersion.Current, mybyte),
            //            new SqlParameter("@fonts", SqlDbType.VarBinary, mybyte.Length, ParameterDirection.Input, false, 0, 0, null, DataRowVersion.Current, ft)
            //    };

            //        command.Parameters.Add(prm);
            //        command.ExecuteNonQuery();
            //        connection.Close();
            //        Console.WriteLine("执行完毕！");
            //    //}
            //    //catch (Exception ex)
            //    //{
            //    //    MessageBox.Show(ex.Message);
            //    //    Console.WriteLine("{0}！",ex.Message);
            //    //    //MessageBox.Show(ex.Message);
            //    //}

            try
            {
                byte[] mybyte = PhotoImageInsert(image, content,ft);

                //MessageBox.Show(content + "\n" + ft + "\n" + mybyte);
                string sqlCommandText1 = "insert into MySchool.dbo.Images(words,words_image,fonts) values (@words,@words_image,@fonts)";
                SqlParameter[] cmdParms1 =
                {
                        new SqlParameter("@words",content),
                        new SqlParameter("@words_image",mybyte),
                        new SqlParameter("@fonts",ft)
                };
            
                sum_a = sum_a + DbHelperSQL.ExecuteSql(sqlCommandText1, cmdParms1);
            }
            catch (Exception el)
            {
                MessageBox.Show("增加记录时出错！" + el.Message);
                //MessageBox.Show("请重新选择文件路径");
                //Form1.text_Path02.Focus();
            }
        }
        /// <summary>
        /// 图片转二进制
        /// </summary>
        /// <param name="imgPhoto">图片对象</param>
        /// <returns>二进制</returns>
        public static byte[] PhotoImageInsert(System.Drawing.Bitmap imgPhoto, string content, string ft)
        {
            try
            {
                string path = @"D:\444\" + content.Replace(@"\", "") + "(" + ft + ")" + ".jpg";

                FileStream fs = new FileStream(path, System.IO.FileMode.Open);

                byte[] imgData = new byte[fs.Length];

                fs.Read(imgData, 0, (int)fs.Length);

                //MemoryStream ms = new MemoryStream(imgData);

                //Image img = Image.FromStream(ms);

                //img.Save("bb.jpg");
                fs.Close();
                return imgData;
                
                ////将Image转换成流数据，并保存为byte[]
                //MemoryStream mstream = new MemoryStream(32);
                //imgPhoto.Save(mstream, System.Drawing.Imaging.ImageFormat.Jpeg);
                //byte[] byData = new Byte[mstream.Length];
                ////mstream.Position = 0;
                //mstream.Seek(0, SeekOrigin.Begin);
                //mstream.Read(byData, 0, byData.Length);
                //mstream.Close();
                ////mstream.Dispose();
                //return byData;
            }
            catch (Exception e)
            {
                MessageBox.Show("PhotoImageInsert" + e.Message.ToString());
                //throw e;
                return null;
            }
        }

        private Bitmap CreateImage(string content,string ft)
        {
            //判断字符串不等于空和null
            if (content == null || content.Trim() == String.Empty) {
                MessageBox.Show("content == null || content.Trim() == String.Empty");
                return null;
            }
            //string ch = ToGB2312(content);
            string ch = content;
            
            //对字符串内容长度进行判断
            //Console.WriteLine("字符串内容长度为：{0}", content.Length);
            
            int len = content.Length;
            

            //创建一个位图对象
            Bitmap image = new Bitmap(100*len, 100, System.Drawing.Imaging.PixelFormat.Format32bppArgb);//(int)Math.Ceiling((content.Length * 550.0))

            //设置dpi
            //image.SetResolution(300,300);

            //创建Graphics
            Graphics g = Graphics.FromImage(image);

            //消除文本的锯齿
            g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

            //消除线条的锯齿
            //g.SmoothingMode = SmoothingMode.AntiAlias;
            //g.InterpolationMode = InterpolationMode.HighQualityBicubic; 
            //g.CompositingQuality = CompositingQuality.HighQuality; 

            try
            { 
                //清空图片背景颜色
                g.Clear(Color.White);
                Font font = new Font(ft, 73, FontStyle.Regular);
                g.DrawString(ch, font, new SolidBrush(Color.Black), -16, 0);

                //设置保存路径
                //MessageBox.Show("设置保存路径");
                image.Save(@"D:\444\"+content.Replace(@"\","") + "(" + ft + ")" + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch(System.ArgumentException ex)
            {
                MessageBox.Show("CreateImage" + ex.Message.ToString());
                return null;
            }
            finally
            {
                g.Dispose();
                image.Dispose();
                //return image;
            }
            return image;
        }

        /// <summary>
        /// 将Unicode编码转换为汉字字符串
        /// </summary>
        /// <param name="str">Unicode编码字符串</param>
        /// <returns>汉字字符串</returns>
        public static string ToGB2312(string str)
        {
            //最直接的方法Regex.Unescape(str);
            StringBuilder strResult = new StringBuilder();
            if (!string.IsNullOrEmpty(str))
            {
                string[] strlist = str.Replace("\\", "").Split('u');
                try
                {
                    for (int i = 1; i < strlist.Length; i++)
                    {
                        int charCode = Convert.ToInt32(strlist[i], 16);
                        strResult.Append((char)charCode);
                    }
                }
                catch (FormatException ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
            return strResult.ToString();
        }
        //弹出图片窗体
        //private void ShowSelectedPicture(string path)
        //{
        //    FileStream fs = File.OpenRead(path); //OpenRead
        //    int filelength = 0;
        //    filelength = (int)fs.Length; //获得文件长度 
        //    Byte[] image = new Byte[filelength]; //建立一个字节数组 
        //    BitmapImage bitmapImage = new BitmapImage();
        //    bitmapImage.BeginInit();
        //    bitmapImage.StreamSource = new MemoryStream(image);
        //    bitmapImage.EndInit();
        //    var pictureWindow = new PictureWindow();//自己创建的窗口
        //    pictureWindow.myImage.Source = bitmapImage;//myImage窗口中的图片空间
        //    //pictureWindow.myImage.Width = bitmapImage.PixelWidth;
        //    //pictureWindow.myImage.Height = bitmapImage.PixelHeight;
        //    pictureWindow.WindowStartupLocation = WindowStartupLocation.CenterScreen;
        //    pictureWindow.ShowDialog();
        //}


        private void printPictureFormSQL()
        {
            string ft = "";
            string connectionString = "server=MRWANG90HOU;Uid=sa;password=qwe123!@#;Database=MySchool";//server处可以为localhost（本机的MySQL），//可以为云主机，那么等于号后为ip.Database为你的数据库名称
            //SqlConnection conn = new SqlConnection("Data Source=(192.168.0.232);Initial Catalog=index_trademark;Integrated Security=SSPI;");
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();//打开数据库  
            //创建数据库命令  
            SqlCommand cmd = conn.CreateCommand();
            //创建查询语句  
            cmd.CommandText = "SELECT words_image FROM Images where 1=1";
            //从数据库中读取数据流存入reader中
            SqlDataReader reader = cmd.ExecuteReader();

            //从reader中读取下一行数据,如果没有数据,reader.Read()返回flase  
            while (reader.Read())
            {
                //string un = reader.GetString(reader.GetOrdinal("un_simplified")).Trim();
                string un = reader.GetString(reader.GetOrdinal("words_image")).Trim();

                MessageBox.Show(un);
                //for (int i = 1; i <= 2; i++)
                //{
                //    switch (i)
                //    {
                //        case 1: ft = "黑体"; break;
                //        case 2: ft = "宋体"; break;
                //    }
                //    //ByteArrayToImage(un);
                //}
            }
            conn.Close();
            Console.WriteLine("执行完毕！");
        }
        public Image ByteArrayToImage(byte[] b)
        {
            MemoryStream ms = new MemoryStream(b);
            Image img = Image.FromStream(ms);
            return img;
        }
    }
}
