<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="Train_System.Admin.Routes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans+Narrow" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
                    $('#datatable').DataTable({
          "aLengthMenu": [[10, 25, 50, 100,5], [10, 25, 50, 100, 5]],
                "iDisplayLength": 5,
                columns: [
           
                   { 'data': 'Root_Id' },
                    { 'data': 'source' },
                    { 'data': 'destination' },
                    
                    {'data':'s_time'},
                    {'data':'e_time'},                     

                    {
                        'data': 'Root_Id',
                        'render': function (webSite) {
                            
                            return ' <button type="button" class=" btn btn-primary" value="'+webSite+'" onclick="Edit(this.value);">Edit</button>';
                        }
                        

                    }

                        ],
                bServerSide: true,
                sAjaxSource: 'Admin_Service.asmx/GetAll_Routes',
                sServerMethod: 'post'
            });


        });
        function Save() {

             var iddl1 = document.getElementById('<%=DropDownList1.ClientID%>');
            var source = iddl1.options[iddl1.selectedIndex].value;

             var iddl2 = document.getElementById('<%=DropDownList2.ClientID%>');
            var destination = iddl2.options[iddl2.selectedIndex].value;


            var s_time = $('#s_time').val();
            var e_time = $('#e_time').val();

            if (s_time != "" && e_time != "") {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Routes.aspx/Insert',
                    data: "{'des':'" + destination + "','sou':'" + source + "','t1':'" + s_time + "','t2':'" + e_time + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {
                        $('#myModal1').modal('hide');

                        Swal.fire({
  position: 'top-center',
  type: 'success',
  title: 'Your work has been saved',
  showConfirmButton: false,
  timer: 1500
                        })


                    },
                    Error: function (res) {
                     
                Swal.fire({
  type: 'error',
  title: 'Error',
  text: '',
  footer: ''
})

                    }
                });
            } else {

                
                Swal.fire({
  type: 'error',
  title: 'Error',
  text: 'Please Insert TimeIn And TimeOut',
  footer: ''
})
            }

        }

        var id="";
        function Edit(Val) {

           // alert(Val);
            id = Val;
       $('#myModal').modal('show');

        }

        function Update() {

             var iddl1 = document.getElementById('<%=DropDownList1.ClientID%>');
            var source = iddl1.options[iddl1.selectedIndex].value;

             var iddl2 = document.getElementById('<%=DropDownList2.ClientID%>');
            var destination = iddl2.options[iddl2.selectedIndex].value;


            var s_time = $('#s_time1').val();
            var e_time = $('#e_time1').val();

            
            if (s_time != "" && e_time != "" && id!="") {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Routes.aspx/Update',
                    data: "{'des':'" + destination + "','sou':'" + source + "','t1':'" + s_time + "','t2':'" + e_time + "','id':'" + id + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {
                                      
           Swal.fire({
  position: 'center',
  type: 'success',
  title: 'The Record has been Update',
  showConfirmButton: false,
  timer: 2000
})

                    },
                    Error: function (res) {
                        alert("not inserted" + res);

                    }
                });
            } else {
                 
                Swal.fire({
  type: 'error',
  title: 'Error',
  text: 'Please Insert TimeIn And TimeOut',
  footer: ''
})


            }

        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <body Style=" font-family: 'PT Sans Narrow', sans-serif;">
 <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Routes</h1>
            <%--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" data-toggle="modal" data-target="#myModal"><i class="fas fa-user-plus  fa-sm text-white-50"></i>Add Steward</a>--%>
          </div>
    <div class=" container">
        <div class=" row">
            <div class="col-sm-12 ">
                <button type="button" class="btn btn-primary btn-lg fa-pull-right" data-toggle="modal" data-target="#myModal1">Add New Route</button>
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
        <label>Source</label>
                      <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>

        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Destination</label>
                        <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Start Time</label>
       <input type="time" id="s_time" />
                      </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>End Time</label>
                    <input type="time" id="e_time" />
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



       
    <div class=" container" id="modal-container">
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
        <label>Source</label>
                      <asp:DropDownList ID="DropDownList3" runat="server"></asp:DropDownList>

        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Destination</label>
                        <asp:DropDownList ID="DropDownList4" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Start Time</label>
       <input type="time" id="s_time1" />
                      </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>End Time</label>
                    <input type="time" id="e_time1" />
                    </div>
      
              </div>
          </div>
        
          <br />
         <div class="row">
             <div class=" col-sm-12 text-center">
                 <button type="button" class=" btn btn-primary" onclick="Update();">Update</button>
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
                    <tr style=" colo">
                        <th>Id</th>
                        <th>Source</th>
                        <th>Destination</th>
                       <th>Start Time</th>
                        <th>End Time</th>
                        <th>Edit</th>
                    </tr>
                </thead>
    </table><br>
        </div>
    </body>
</asp:Content>
