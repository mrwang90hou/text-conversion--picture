namespace _0713将文字保存成图片
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.link_to_sql = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.Check_btn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // link_to_sql
            // 
            this.link_to_sql.Location = new System.Drawing.Point(712, 12);
            this.link_to_sql.Name = "link_to_sql";
            this.link_to_sql.Size = new System.Drawing.Size(125, 32);
            this.link_to_sql.TabIndex = 1;
            this.link_to_sql.Text = "链接数据库";
            this.link_to_sql.UseVisualStyleBackColor = true;
            this.link_to_sql.Click += new System.EventHandler(this.link_to_sql_Click);
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.ItemHeight = 12;
            this.listBox1.Location = new System.Drawing.Point(12, 104);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(614, 484);
            this.listBox1.TabIndex = 14;
            // 
            // Check_btn
            // 
            this.Check_btn.Location = new System.Drawing.Point(702, 104);
            this.Check_btn.Name = "Check_btn";
            this.Check_btn.Size = new System.Drawing.Size(125, 50);
            this.Check_btn.TabIndex = 15;
            this.Check_btn.Text = "预处理";
            this.Check_btn.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1034, 600);
            this.Controls.Add(this.Check_btn);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.link_to_sql);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button link_to_sql;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button Check_btn;
    }
}