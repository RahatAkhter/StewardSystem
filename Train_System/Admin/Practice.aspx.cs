using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;
namespace Train_System.Admin
{
    public partial class Practice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                                status = x.GetInt32(5),
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

    }
}