﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.IO;

namespace _0713将文字保存成图片
{
    class Program
    {
        static void Main(string[] args)
        {
            Program ct = new Program();
            string ft = "";
            string connectionString = "server=192.168.0.232;Uid=sa;password=qwe123!@#;Database=index_trademark";//server处可以为localhost（本机的MySQL），//可以为云主机，那么等于号后为ip.Database为你的数据库名称
            //SqlConnection conn = new SqlConnection("Data Source=(192.168.0.232);Initial Catalog=index_trademark;Integrated Security=SSPI;");
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();//打开数据库  
            //创建数据库命令  
            SqlCommand cmd = conn.CreateCommand();
            //创建查询语句  
            //cmd.CommandText = "SELECT distinct un_simplified FROM Chinese_Img where id=22";
            cmd.CommandText = "SELECT distinct words FROM Chinese_words where id<=100";
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
                    ct.CreateImage(un, ft);  //生成图片
                    Console.WriteLine("保存{0}成功！", un);
                }
            }
            conn.Close();
            Console.WriteLine("执行完毕！");
        }

        private void CreateImage(string content,string ft)
        {
            //判断字符串不等于空和null
            if (content == null || content.Trim() == String.Empty)
                return;
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
                image.Save(@"D:\222\"+content.Replace(@"\","") + "(" + ft + ")" + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch(System.ArgumentException ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
            finally
            {
                g.Dispose();
                image.Dispose();
            }
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
    }
}
