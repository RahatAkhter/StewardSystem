using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Configuration;

namespace Train_System.Admin
{
    public partial class Steward_Train : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Bound();
        }


        public void Bound()
        {
            string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
            SqlConnection conn = new SqlConnection(con1);

            SqlCommand cmd = new SqlCommand("select train_id,train_detail from Train", conn);
            conn.Open();
            DropDownList1.DataSource = cmd.ExecuteReader();
            DropDownList1.DataTextField = "train_detail";
            DropDownList1.DataValueField = "train_id";
            DropDownList1.DataBind();
            conn.Close();



            SqlCommand cmd1 = new SqlCommand(@"select u.User_Name,s.st_Id
from Users as u
left join Steward as s
on s.st_id=u.User_Id", conn);
            conn.Open();
            DropDownList2.DataSource = cmd1.ExecuteReader();
            DropDownList2.DataTextField = "User_Name";
            DropDownList2.DataValueField = "st_Id";
            DropDownList2.DataBind();
            conn.Close();
            //select s.St_Name,s.Station_Id from Stations as s
            SqlCommand cmd2 = new SqlCommand(@"select s.St_Name,s.Station_Id from Stations as s", conn);
            conn.Open();
            DropDownList3.DataSource = cmd2.ExecuteReader();
            DropDownList3.DataTextField = "St_Name";
            DropDownList3.DataValueField = "Station_Id";
            DropDownList3.DataBind();
            conn.Close();


            SqlCommand cmd3 = new SqlCommand(@"select s.St_Name,s.Station_Id from Stations as s", conn);
            conn.Open();
            DropDownList4.DataSource = cmd3.ExecuteReader();
            DropDownList4.DataTextField = "St_Name";
            DropDownList4.DataValueField = "Station_Id";
            DropDownList4.DataBind();
            conn.Close();


        }

        [WebMethod]
        public static IEnumerable<Stewrad_Data> Get_Data()
        {
                using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(@"
select ts.train_steward_id,ts.train_id,u.User_Name,source.St_Name,destination.St_Name,t.status,Cast(ts.Date as nvarchar) as Date,Cast(ts.time_in as nvarchar) as Timein,Cast(ts.time_out as nvarchar) as Timeout,
Cast(isnull(ts.checkin,'00:00')as nvarchar)as Checkin,Cast(isnull(ts.checkout,'00:00') as nvarchar)as Checkout ,sta.St_Name as train_At
from Train_Steward as ts
left join Train as t
on t.train_id=ts.train_id
left join steward as s
on ts.steward_id=s.st_Id
left join Users as u
on u.User_Id=s.st_Id
left join Stations as source
on source.Station_Id=ts.source_id
left join Stations as destination
on destination.Station_Id=ts.destination
left join Stations as sta
on sta.Station_Id=t.station", connection))
                    {
                        command.Notification = null;
                        SqlDependency.Start(ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString);
                        SqlDependency dependency = new SqlDependency(command);
                        dependency.OnChange += new OnChangeEventHandler(dependency_OnChange);

                        if (connection.State == ConnectionState.Closed)
                            connection.Open();
                    
                        using (var reader = command.ExecuteReader())
                            return reader.Cast<IDataRecord>()
                                .Select(x => new Stewrad_Data()
                                {
                                    steward_id = x.GetInt32(0),
                                    train_id = x.GetInt32(1),
                                    uname = x.GetString(2),
                                    source = x.GetString(3),
                                    destination = x.GetString(4),
                                    status= x.GetInt32(5),
                                    date = x.GetString(6),
                                    
                                    time_in = x.GetString(7),
                                    time_out = x.GetString(8),
                                    checkin = x.GetString(9),
                                    checkout = x.GetString(10),
                                    train_At = x.GetString(11)

                                }).ToList();



                    }
                }
            
        }



        private static void dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            MyHub.show();
        }


        [WebMethod]
        public static string Insert(string timein, string tout, string tid, string uid,string s_id,string date,string desti)
        {
            try
            {
                string con1 = System.Configuration.ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;
                SqlConnection conn = new SqlConnection(con1);
                SqlCommand cmd = new SqlCommand("insert into Train_Steward values(@tid,@uid,@tin,@tout,@sid,@did,@date,@checkin,@checkout)", conn);

                cmd.Parameters.AddWithValue("@tid", Convert.ToInt32(tid));
                cmd.Parameters.AddWithValue("@uid", Convert.ToInt32(uid));
                cmd.Parameters.AddWithValue("@tin", SqlDbType.Time).Value = timein;
                cmd.Parameters.AddWithValue("@tout", SqlDbType.Time).Value = tout;
                cmd.Parameters.AddWithValue("@sid", Convert.ToInt32(s_id));
                cmd.Parameters.AddWithValue("@did", Convert.ToInt32(desti));
                cmd.Parameters.AddWithValue("@date",SqlDbType.Date).Value=date;
                cmd.Parameters.AddWithValue("@checkin", SqlDbType.Time).Value=DBNull.Value;
                cmd.Parameters.AddWithValue("@checkout", SqlDbType.Time).Value=DBNull.Value;





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

public class Stewrad_Data
{

    public int steward_id { get; set; }
    public int train_id { get; set; }
    public string uname { get; set; }
    public string source { get; set; }
    public string destination { get; set; }
    public int status { get; set; }
    public string date { get; set; }
    public string time_in { get; set; }
    public string time_out { get; set; }
    public string checkin { get; set; }
    public string checkout { get; set; }
    public string train_At { get; set; }
}