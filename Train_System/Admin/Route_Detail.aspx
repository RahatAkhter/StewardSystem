<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Route_Detail.aspx.cs" Inherits="Train_System.Route_Detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

              $('#datatable').DataTable({
          "aLengthMenu": [[10, 25, 50, 100,5], [10, 25, 50, 100, 5]],
                "iDisplayLength": 5,
                columns: [
           
                   { 'data': 'Detail_Id' },
                    { 'data': 'Service' },
                    { 'data': 'St_Name' },
                    { 'data': 'Route_name' },

                    {
                        'data': 'Detail_Id',
                        'render': function (webSite) {
                            
                            return ' <button type="button" class=" btn btn-primary" value="'+webSite+'" onclick="Edit(this.value);">Edit</button>';
                        }
                        

                    }       
                                        
                    ],
                bServerSide: true,
                sAjaxSource: 'Admin_Service.asmx/GetAll_Routes_Detail',
                sServerMethod: 'post'
            });
        });

        function Save() {

             var ddl = document.getElementById("<%=DropDownList1.ClientID%>");
        var Route = ddl.options[ddl.selectedIndex].value;

             var ddl1 = document.getElementById("<%=DropDownList2.ClientID%>");
            var Station = ddl1.options[ddl1.selectedIndex].value;

            var det = $('#det').val();
            var ser = $('#Ser').val();

            alert(Route + "" + Station + "" + det + "" + ser);

             $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                 url: 'Route_Detail.aspx/Insert',
                 data: "{'rou':'" + Route + "','sta':'" + Station + "','det':'" + det + "','ser':'" + ser + "'}",
                    dataType: "json",
                    async: false,

                 success: function (data) {
                     if (data.d == "Save") {
                         alert("if u want add more routes then select route and add More ");
                     }
                     else {
                         alert(data.d);
                     }
                    },
                    Error: function (res) {
                        alert("not inserted" + res);

                    }
                });

        }

            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Route Detail</h1>
            <%--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" data-toggle="modal" data-target="#myModal"><i class="fas fa-user-plus  fa-sm text-white-50"></i>Add Steward</a>--%>
          </div>
    <div class=" container">
        <div class=" row">
            <div class="col-sm-12 ">
                <button type="button" class="btn btn-primary btn-lg fa-pull-right" data-toggle="modal" data-target="#myModal1">Add Route Detail</button>
            </div>
        </div>
    </div>

    <div class=" container" id="modal-container1">
   <div class=" row">
   <div class=" col-sm-9">
   
   <div id="myModal1" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      
      
      </div>
      <div class="modal-body">
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Select Route</label>
                      <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
                  </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Select Station</label>
                        <br />
                        <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Detail</label>
                  <input type="text" id="det" />
                  </div>
              </div>
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Service No</label>
                  <input type="text" id="Ser" />
                  </div>
              </div>
          </div>
        
          <br />
         <div class="row">
             <div class=" col-sm-12 text-center">
                 <button type="button" class=" btn btn-primary" onclick="Save();">Save</button>
             </div>
         </div>
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal">Close</button>
      
      </div>
        
    </div>

  </div>
</div>
   </div>
   </div>
   
   </div>



       
    <div class=" container" id="modal-container3">
   <div class=" row">
   <div class=" col-sm-9">
   
   <div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      
      
      </div>
       <div class="modal-body">
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Select Route</label>
                      <asp:DropDownList ID="DropDownList3" runat="server"></asp:DropDownList>
                  </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Select Station</label>
                        <asp:DropDownList ID="DropDownList4" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Detail</label>
                  <input type="text" id="det1" />
                  </div>
              </div>
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Service No</label>
                  <input type="text" id="Ser1" />
                  </div>
              </div>
          </div>
        
          <br />
         <div class="row">
             <div class=" col-sm-12 text-center">
                 <button type="button" class=" btn btn-primary" onclick="Save();">Save</button>
             </div>
         </div>
      </div>
      <div class="modal-footer">
      
        <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal">Close</button>
      
      </div>
        
    </div>

  </div>
</div>
   </div>
   </div>
   
   </div>


    <div>
    <h5>Users</h5>
    <table id="datatable" border="1" style=" border-radius:5px; border-color:blue"> 
       <thead>
                    <tr style=" color:black;">
                        <th>Id</th>
                        <th>Service</th>
                        <th>Station Name</th>
                       <th>Route Name</th>
                        <th>Edit</th>
                    </tr>
                </thead>
    </table><br>
        </div>


</asp:Content>
