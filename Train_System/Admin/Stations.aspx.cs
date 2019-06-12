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
namespace Train_System.Admin
{
    public partial class Stations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static string Insert(string name, string City)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("insert into Stations values(@name,@city)", conn);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@city",City);
                
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
        public static string Update(string id,string name,string city)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("update Stations set St_Name=@name,city=@city where Station_Id=@id", conn);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@city", city);
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


        [WebMethod]
        public static List<Station> GetData(string id)
        {
            List<Station> list_det = new List<Station>();


            DataTable dt = getdata(Convert.ToInt32(id));
            for (Int32 i = 0; i < dt.Rows.Count; i++)
            {
                Station u = new Station();

                u.St_Name = dt.Rows[i]["St_Name"].ToString();
                u.Station_Id = Convert.ToInt32(dt.Rows[i]["Station_Id"]);
                u.city = dt.Rows[i]["city"].ToString();
                
                list_det.Add(u);
            }
            return list_det;

        }





        private static DataTable getdata(int id)
        {

            string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
            SqlConnection conn = new SqlConnection(con1);
            SqlCommand cmd = new SqlCommand(@"select * from Stations where Station_Id=@id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            conn.Open();
            DataTable dt = new DataTable();
            SqlDataReader dr = cmd.ExecuteReader();
            dt.Load(dr);
            dr.Close();
            conn.Close();

            return dt;

        }




    }
}
public class Station
{

    public int Station_Id { get; set; }
    public string St_Name { get; set; }
    public string city { get; set; }
}