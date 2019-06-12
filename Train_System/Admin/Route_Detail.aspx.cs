using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
namespace Train_System
{
    public partial class Route_Detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Bound();
        }


        public void Bound()
        {

            string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
            SqlConnection conn = new SqlConnection(con1);

            SqlCommand cmd = new SqlCommand(@"select r.Root_Id, CONCAT(sou.St_Name,' to ',des.St_Name) as Route
from route as r
left join Stations as sou
on sou.Station_Id = r.source_id
left join Stations as des
on des.Station_Id = r.Destination_Id
", conn);
            conn.Open();
            DropDownList1.DataSource = cmd.ExecuteReader();
            DropDownList1.DataTextField = "Route";
            DropDownList1.DataValueField = "Root_Id";
            DropDownList1.DataBind();
            conn.Close();


            SqlCommand cmd1 = new SqlCommand("select St_Name,Station_Id from Stations", conn);
            conn.Open();
            DropDownList2.DataSource = cmd1.ExecuteReader();
            DropDownList2.DataTextField = "St_Name";
            DropDownList2.DataValueField = "Station_Id";
            DropDownList2.DataBind();
            conn.Close();

            

        }


        [WebMethod]
        public static string Insert(string rou, string sta, string det, string ser)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("insert into Route_Detail values(@rou,@sts,@det,@ser)", conn);

                cmd.Parameters.AddWithValue("@rou", Convert.ToInt32(rou));
                cmd.Parameters.AddWithValue("@sts", Convert.ToInt32(sta));
                cmd.Parameters.AddWithValue("@det", Convert.ToString(det));
                cmd.Parameters.AddWithValue("@ser", Convert.ToString(ser));


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


public class Route_Details
{
    public int Detail_Id { get; set; }
    public string Service { get; set; }
    public string St_Name { get; set; }
    public string Route_name { get; set; }

}