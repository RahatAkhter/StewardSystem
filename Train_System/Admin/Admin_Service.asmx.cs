using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace Train_System.Admin
{
    /// <summary>
    /// Summary description for Admin_Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Admin_Service : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetAll_Stations(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            List<Station> listEmployees = new List<Station>();
            int filteredCount = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetStations", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramDisplayLength = new SqlParameter()
                {
                    ParameterName = "@DisplayLength",
                    Value = displayLength
                };
                cmd.Parameters.Add(paramDisplayLength);

                SqlParameter paramDisplayStart = new SqlParameter()
                {
                    ParameterName = "@DisplayStart",
                    Value = displayStart
                };
                cmd.Parameters.Add(paramDisplayStart);

                SqlParameter paramSortCol = new SqlParameter()
                {
                    ParameterName = "@SortCol",
                    Value = sortCol
                };
                cmd.Parameters.Add(paramSortCol);

                SqlParameter paramSortDir = new SqlParameter()
                {
                    ParameterName = "@SortDir",
                    Value = sortDir
                };
                cmd.Parameters.Add(paramSortDir);

                SqlParameter paramSearchString = new SqlParameter()
                {
                    ParameterName = "@Search",
                    Value = string.IsNullOrEmpty(search) ? null : search
                };
                cmd.Parameters.Add(paramSearchString);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Station s = new Station();
                    s.Station_Id = Convert.ToInt32(rdr["Station_Id"]);
                    filteredCount = Convert.ToInt32(rdr["TotalCount"]);
                    s.St_Name = rdr["St_Name"].ToString();
                    s.city = rdr["city"].ToString();
                    
                    listEmployees.Add(s);
                }
            }

            var result = new
            {
                iTotalRecords = GetStationTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listEmployees
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(result));

        }

        private int GetStationTotalCount()
        {
            int totalEmployeeCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select Count(*) from Stations", con);
                con.Open();
                totalEmployeeCount = (int)cmd.ExecuteScalar();
            }
            return totalEmployeeCount;



        }


        // here we get engines

        [WebMethod]
        public void GetAll_Engines(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            List<Engine> listEmployees = new List<Engine>();
            int filteredCount = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetEngines", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramDisplayLength = new SqlParameter()
                {
                    ParameterName = "@DisplayLength",
                    Value = displayLength
                };
                cmd.Parameters.Add(paramDisplayLength);

                SqlParameter paramDisplayStart = new SqlParameter()
                {
                    ParameterName = "@DisplayStart",
                    Value = displayStart
                };
                cmd.Parameters.Add(paramDisplayStart);

                SqlParameter paramSortCol = new SqlParameter()
                {
                    ParameterName = "@SortCol",
                    Value = sortCol
                };
                cmd.Parameters.Add(paramSortCol);

                SqlParameter paramSortDir = new SqlParameter()
                {
                    ParameterName = "@SortDir",
                    Value = sortDir
                };
                cmd.Parameters.Add(paramSortDir);

                SqlParameter paramSearchString = new SqlParameter()
                {
                    ParameterName = "@Search",
                    Value = string.IsNullOrEmpty(search) ? null : search
                };
                cmd.Parameters.Add(paramSearchString);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Engine s = new Engine();
                    s.eng_id = Convert.ToInt32(rdr["eng_id"]);
                    filteredCount = Convert.ToInt32(rdr["TotalCount"]);
                    s.e_name = rdr["e_name"].ToString();
                    s.year_of_manu =Convert.ToDateTime( rdr["year_of_manufacture"]);
                    s.status = Convert.ToInt32(rdr["status"]);
                    s.chasis_no = Convert.ToString(rdr["chachis_no"]);

                    s.modal_num = Convert.ToString(rdr["modal_no"]);
                    listEmployees.Add(s);
                }
            }

            var result = new
            {
                iTotalRecords = GetEnginesTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listEmployees
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(result));

        }

        private int GetEnginesTotalCount()
        {
            int totalEmployeeCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select Count(*) from Engine", con);
                con.Open();
                totalEmployeeCount = (int)cmd.ExecuteScalar();
            }
            return totalEmployeeCount;



        }




        // get routes
        [WebMethod]
        public void GetAll_Routes(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            List<Route> listEmployees = new List<Route>();
            int filteredCount = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetRoute", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramDisplayLength = new SqlParameter()
                {
                    ParameterName = "@DisplayLength",
                    Value = displayLength
                };
                cmd.Parameters.Add(paramDisplayLength);

                SqlParameter paramDisplayStart = new SqlParameter()
                {
                    ParameterName = "@DisplayStart",
                    Value = displayStart
                };
                cmd.Parameters.Add(paramDisplayStart);

                SqlParameter paramSortCol = new SqlParameter()
                {
                    ParameterName = "@SortCol",
                    Value = sortCol
                };
                cmd.Parameters.Add(paramSortCol);

                SqlParameter paramSortDir = new SqlParameter()
                {
                    ParameterName = "@SortDir",
                    Value = sortDir
                };
                cmd.Parameters.Add(paramSortDir);

                SqlParameter paramSearchString = new SqlParameter()
                {
                    ParameterName = "@Search",
                    Value = string.IsNullOrEmpty(search) ? null : search
                };
                cmd.Parameters.Add(paramSearchString);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Route s = new Route();
                    s.Root_Id = Convert.ToInt32(rdr["Root_Id"]);
                    filteredCount = Convert.ToInt32(rdr["TotalCount"]);
                    s.source = rdr["source"].ToString();
                    s.destination = rdr["destination"].ToString();
                    s.s_time = rdr["s_time"].ToString();
                    s.e_time = rdr["e_time"].ToString();

                    listEmployees.Add(s);
                }
            }

            var result = new
            {
                iTotalRecords = GetTRoutesTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listEmployees
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(result));

        }

        private int GetTRoutesTotalCount()
        {
            int totalEmployeeCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select Count(*) from route", con);
                con.Open();
                totalEmployeeCount = (int)cmd.ExecuteScalar();
            }
            return totalEmployeeCount;



        }

        //get route Detail
        // get routes
        [WebMethod]
        public void GetAll_Routes_Detail(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            List<Route_Details> listEmployees = new List<Route_Details>();
            int filteredCount = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetRoute_Detail", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramDisplayLength = new SqlParameter()
                {
                    ParameterName = "@DisplayLength",
                    Value = displayLength
                };
                cmd.Parameters.Add(paramDisplayLength);

                SqlParameter paramDisplayStart = new SqlParameter()
                {
                    ParameterName = "@DisplayStart",
                    Value = displayStart
                };
                cmd.Parameters.Add(paramDisplayStart);

                SqlParameter paramSortCol = new SqlParameter()
                {
                    ParameterName = "@SortCol",
                    Value = sortCol
                };
                cmd.Parameters.Add(paramSortCol);

                SqlParameter paramSortDir = new SqlParameter()
                {
                    ParameterName = "@SortDir",
                    Value = sortDir
                };
                cmd.Parameters.Add(paramSortDir);

                SqlParameter paramSearchString = new SqlParameter()
                {
                    ParameterName = "@Search",
                    Value = string.IsNullOrEmpty(search) ? null : search
                };
                cmd.Parameters.Add(paramSearchString);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Route_Details s = new Route_Details();
                    s.Detail_Id = Convert.ToInt32(rdr["Detail_Id"]);
                    filteredCount = Convert.ToInt32(rdr["TotalCount"]);
                    s.Service = rdr["Service"].ToString();
                    s.St_Name = rdr["St_Name"].ToString();
                    s.Route_name = rdr["Route_name"].ToString();
                    
                    listEmployees.Add(s);
                }
            }

            var result = new
            {
                iTotalRecords = GetTRoutesDetailTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listEmployees
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(result));

        }

        private int GetTRoutesDetailTotalCount()
        {
            int totalEmployeeCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select Count(*) from Route_Detail", con);
                con.Open();
                totalEmployeeCount = (int)cmd.ExecuteScalar();
            }
            return totalEmployeeCount;



        }






        [WebMethod]
        public void GetAll_Users(int iDisplayLength, int iDisplayStart, int iSortCol_0, string sSortDir_0, string sSearch)
        {
            int displayLength = iDisplayLength;
            int displayStart = iDisplayStart;
            int sortCol = iSortCol_0;
            string sortDir = sSortDir_0;
            string search = sSearch;

            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            List<Steward> listEmployees = new List<Steward>();
            int filteredCount = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_GetUser", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramDisplayLength = new SqlParameter()
                {
                    ParameterName = "@DisplayLength",
                    Value = displayLength
                };
                cmd.Parameters.Add(paramDisplayLength);

                SqlParameter paramDisplayStart = new SqlParameter()
                {
                    ParameterName = "@DisplayStart",
                    Value = displayStart
                };
                cmd.Parameters.Add(paramDisplayStart);

                SqlParameter paramSortCol = new SqlParameter()
                {
                    ParameterName = "@SortCol",
                    Value = sortCol
                };
                cmd.Parameters.Add(paramSortCol);

                SqlParameter paramSortDir = new SqlParameter()
                {
                    ParameterName = "@SortDir",
                    Value = sortDir
                };
                cmd.Parameters.Add(paramSortDir);

                SqlParameter paramSearchString = new SqlParameter()
                {
                    ParameterName = "@Search",
                    Value = string.IsNullOrEmpty(search) ? null : search
                };
                cmd.Parameters.Add(paramSearchString);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Steward users = new Steward();
                    users.User_Id = Convert.ToInt32(rdr["User_Id"]);
                    filteredCount = Convert.ToInt32(rdr["TotalCount"]);
                    users.User_Name = rdr["User_Name"].ToString();
                    users.Age = rdr["Age"].ToString();
                    users.Password = rdr["Password"].ToString();
                    users.Email = rdr["Email"].ToString();
                    users.Img = Convert.ToString(rdr["Img"]);
                    users.gender = rdr["gender"].ToString();
                    
                    listEmployees.Add(users);
                }
            }

            var result = new
            {
                iTotalRecords = GetEmployeeTotalCount(),
                iTotalDisplayRecords = filteredCount,
                aaData = listEmployees
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(result));

        }

        private int GetEmployeeTotalCount()
        {
            int totalEmployeeCount = 0;
            string cs = ConfigurationManager.ConnectionStrings["DBMS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new
                    SqlCommand("select Count(*) from Users as u inner join steward as s on s.User_Id = u.User_Id ", con);
                con.Open();
                totalEmployeeCount = (int)cmd.ExecuteScalar();
            }
            return totalEmployeeCount;



        }

    }
}
public class Steward
{
    public int User_Id { get; set; }
    public string User_Name { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
    public string Age { get; set; }
    public string Img { get; set; }
    public string gender { get; set; }

}

public class Engine
{

    public int eng_id { get; set; }
    public string e_name { get; set; }
    public DateTime year_of_manu { get; set; }
    public string chasis_no { get; set; }
    public string modal_num { get; set; }
    public int status { get; set; }
}