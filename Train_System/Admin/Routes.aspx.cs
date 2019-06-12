using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
namespace Train_System.Admin
{
    public partial class Routes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Bound();
        }


        public void Bound()
        {

            string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
            SqlConnection conn = new SqlConnection(con1);

            SqlCommand cmd = new SqlCommand("select St_Name,Station_Id from Stations",conn);
            conn.Open();
            DropDownList1.DataSource = cmd.ExecuteReader();
            DropDownList1.DataTextField = "St_Name";
            DropDownList1.DataValueField = "Station_Id";
            DropDownList1.DataBind();
            conn.Close();


            SqlCommand cmd1 = new SqlCommand("select St_Name,Station_Id from Stations", conn);
            conn.Open();
            DropDownList2.DataSource = cmd1.ExecuteReader();
            DropDownList2.DataTextField = "St_Name";
            DropDownList2.DataValueField = "Station_Id";
            DropDownList2.DataBind();
            conn.Close();


            SqlCommand cmd2 = new SqlCommand("select St_Name,Station_Id from Stations", conn);
            conn.Open();
            DropDownList3.DataSource = cmd2.ExecuteReader();
            DropDownList3.DataTextField = "St_Name";
            DropDownList3.DataValueField = "Station_Id";
            DropDownList3.DataBind();
            conn.Close();



            SqlCommand cmd3 = new SqlCommand("select St_Name,Station_Id from Stations", conn);
            conn.Open();
            DropDownList4.DataSource = cmd3.ExecuteReader();
            DropDownList4.DataTextField = "St_Name";
            DropDownList4.DataValueField = "Station_Id";
            DropDownList4.DataBind();
            conn.Close();

        }



        [WebMethod]
        public static string Insert(string des, string sou,string t1,string t2)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("insert into route values(@sou,@des,@s_time,@etime)", conn);

                cmd.Parameters.AddWithValue("@sou", Convert.ToInt32(sou));
                cmd.Parameters.AddWithValue("@des", Convert.ToInt32(des));
                cmd.Parameters.AddWithValue("@s_time",SqlDbType.Time).Value=t1;
                cmd.Parameters.AddWithValue("@etime", SqlDbType.Time).Value=t2;


                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Save";
            }

            catch (Exception ex)
            {

                return ex.ToString();
            }


        }



        [WebMethod]
        public static string Update(string des, string sou, string t1, string t2,string id)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("update route set source_id=@sou,Destination_Id=@des,s_time=@t1,e_time=@t2 where Root_Id=@id", conn);

                cmd.Parameters.AddWithValue("@sou", Convert.ToInt32(sou));
                cmd.Parameters.AddWithValue("@des", Convert.ToInt32(des));
                cmd.Parameters.AddWithValue("@t1", SqlDbType.Time).Value = t1;
                cmd.Parameters.AddWithValue("@t2", SqlDbType.Time).Value = t2;
                cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));


                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                return "Save";
            }

            catch (Exception ex)
            {

                return ex.ToString();
            }


        }


    }
}


public class Route
{

    public int Root_Id { get; set; }
    public string source { get; set; }
    public string destination { get; set; }
    public string s_time { get; set; }
    public string e_time { get; set; }
}