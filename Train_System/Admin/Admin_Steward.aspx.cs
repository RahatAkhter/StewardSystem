using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.IO;
namespace Train_System
{
    public partial class Admin_Steward : System.Web.UI.Page
    {
        public static int? ST_ID;
        public static int? STUP_ID;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static string Insert(string name,string email,string p1,string p2, string gen,string age)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("insert into Users Output inserted.User_Id  values(@name, @email, @pass, @age, null, @gen)", conn);

                cmd.Parameters.AddWithValue("@name",name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@pass", p1);
                cmd.Parameters.AddWithValue("@age", age);
                cmd.Parameters.AddWithValue("@gen", gen);

                conn.Open();
              ST_ID=Convert.ToInt32(  cmd.ExecuteScalar());
                conn.Close();

                SqlCommand cmd1 = new SqlCommand("insert into steward values(@uid,0)",conn);
                cmd1.Parameters.AddWithValue("@uid",ST_ID);
                conn.Open();
                cmd1.ExecuteNonQuery();
                conn.Close();

                return ST_ID.ToString();

            }

            catch (Exception ex)
            {

                return ex.ToString();
            }


        }


        [WebMethod]
        public static string Update(string name, string email, string p1, string p2, string gen, string age,string id)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("update Users set User_Name=@name, Email=@email,Password=@pass,Age=@age,gender=@gen where User_Id=@id", conn);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@pass", p1);
                cmd.Parameters.AddWithValue("@age", age);
                cmd.Parameters.AddWithValue("@gen", gen);
                cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));


                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                STUP_ID = Convert.ToInt32(id);
                return "Save";

            }

            catch (Exception ex)
            {

                return ex.ToString();
            }


        }


        [WebMethod]
        public static List<Steward> Get_Data(string id)
        {
            List<Steward> list_det = new List<Steward>();


            DataTable dt = getdata(Convert.ToInt32(id));
            for (Int32 i = 0; i < dt.Rows.Count; i++)
            {
                Steward u = new Steward();
                
                u.User_Name = dt.Rows[i]["User_Name"].ToString();
                u.User_Id =Convert.ToInt32( dt.Rows[i]["User_Id"]);
                u.Email = dt.Rows[i]["Email"].ToString();
                u.Age = dt.Rows[i]["Age"].ToString();
                u.Password = dt.Rows[i]["Password"].ToString();
                u.gender= dt.Rows[i]["gender"].ToString();

                list_det.Add(u);
            }
            return list_det;

        }





        private static DataTable getdata(int id)
        {

            string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
            SqlConnection conn = new SqlConnection(con1);
            SqlCommand cmd = new SqlCommand(@"select * from Users where User_Id=@id", conn);
            cmd.Parameters.AddWithValue("@id",id);
            conn.Open();
            DataTable dt = new DataTable();
            SqlDataReader dr = cmd.ExecuteReader();
            dt.Load(dr);
            dr.Close();
            conn.Close();

            return dt;

        }



        protected void btn_img_save_Click1(object sender, EventArgs e)
        {
            try
            {


                if (FileUpload2.PostedFile != null && STUP_ID != null)
                {



                    string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

                    string imgFile = Path.GetFileName(FileUpload2.PostedFile.FileName);
                    //FileUpload1.SaveAs("C:/Users/rahat/Desktop/bootstrpe/Image/" + imgFile);
                    //C:\Users\rahat\source\repos\signalR\signalR\Image
                    FileUpload2.SaveAs(Server.MapPath("Image/"+imgFile));

                    SqlConnection conn = new SqlConnection(con1);
                    SqlCommand cmd = new SqlCommand("update Users set Img=@path where User_Id=@user_id", conn);
                    cmd.Parameters.AddWithValue("@path", "Image/" + imgFile);
                    cmd.Parameters.AddWithValue("@user_id", STUP_ID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    conn.Dispose();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Image Inserted Successfully')", true);


                }
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : '+'" + ex.Message + "')", true);
            }
        }



        protected void btn_img_save_Click(object sender, EventArgs e)
        {
            try
            {


                if (FileUpload1.PostedFile != null && ST_ID!=null)
                {



                    string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

                    string imgFile = Path.GetFileName(FileUpload1.PostedFile.FileName);
                    //FileUpload1.SaveAs("C:/Users/rahat/Desktop/bootstrpe/Image/" + imgFile);
                    //C:\Users\rahat\source\repos\signalR\signalR\Image
                    FileUpload1.SaveAs(Server.MapPath("Image/" + imgFile));

                    SqlConnection conn = new SqlConnection(con1);
                    SqlCommand cmd = new SqlCommand("update Users set Img=@path where User_Id=@user_id", conn);
                    cmd.Parameters.AddWithValue("@path", "Image/" + imgFile);
                    cmd.Parameters.AddWithValue("@user_id", ST_ID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    conn.Dispose();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Image Inserted Successfully')", true);


                }
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error : '+'" + ex.Message + "')", true);
            }
        }


    }
}