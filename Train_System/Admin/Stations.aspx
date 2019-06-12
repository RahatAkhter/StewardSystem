<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Stations.aspx.cs" Inherits="Train_System.Admin.Stations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">

        
        $(document).ready(function () {
            
        $('#datatable').DataTable({
          "aLengthMenu": [[10, 25, 50, 100,5], [10, 25, 50, 100, 5]],
                "iDisplayLength": 5,
                columns: [
           
                   { 'data': 'Station_Id' },
                    { 'data': 'St_Name' },
                    { 'data': 'city' },
                    {
                        'data': 'Station_Id',
                        'render': function (webSite) {
                            
                            return ' <button type="button" class=" btn btn-primary" value="'+webSite+'" onclick="Edit(this.value);">Edit</button>';
                        }
                        

                    }       
                                        
                    ],
                bServerSide: true,
                sAjaxSource: 'Admin_Service.asmx/GetAll_Stations',
                sServerMethod: 'post'
            });

        });

        
        function Save() {

            var name = $('#name').val();
            var city = $('#city').val();
            if (name != "" && city != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Stations.aspx/Insert',
                    data: "{'name':'" + name + "','City':'" + city + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {

                        Swal.fire({
                            position: 'center',
                            type: 'success',
                            title: 'The Record has been Saved',
                            showConfirmButton: false,
                            timer: 2000
                        })
                        $('#name').val("");
                        $('#city').val("");
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


            }
            else {

                 Swal.fire({
                            type: 'error',
                            title: 'Error',
                            text: 'Please Fill The Form Correctly',
                            footer: ''
                        })

            }
            }

        var id;

        function Edit(Val) {
            alert(Val);

            
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Stations.aspx/GetData',
                    data: "{'id':'" + Val + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {
                        
                    for (var i = 0; i < data.d.length; i++) {
                           $('#name1').val(data.d[i].St_Name);
                           $('#city1').val(data.d[i].city);
                        id = data.d[i].Station_Id;
                        $('#myModal1').modal('show');

                    }

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
        }


        function Update() {
            var name = $('#name1').val();
            var city = $('#city1').val();

            if (name != "" && city != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Stations.aspx/Update',
                    data: "{'id':'" + id + "','name':'" + name + "','city':'" + city + "'}",
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
                        $('#name1').val("");
                         $('#city1').val("");
                    },
                    Error: function (res) {
                        alert("not inserted" + res);

                    }
                });
            } else {
                  Swal.fire({
  type: 'error',
  title: 'Error',
  text: 'Please Enter Some Text',
  footer: ''
})


            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Stations</h1>
            <%--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" data-toggle="modal" data-target="#myModal"><i class="fas fa-user-plus  fa-sm text-white-50"></i>Add Steward</a>--%>
          </div>
    <div class=" container">
        <div class=" row">
            <div class="col-sm-12 ">
                <button type="button" class="btn btn-primary btn-lg fa-pull-right" data-toggle="modal" data-target="#myModal">Add New Station</button>
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
        <label>Station Name</label>
        <input type="text" class=" form-control" placeholder="Station Name" id="name1" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>City</label>
        <input type="text" class=" form-control" placeholder="City" id="city1" />
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
        <label>Station Name</label>
        <input type="text" class=" form-control" placeholder="Station Name" id="name" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>City</label>
        <input type="text" class=" form-control" placeholder="City" id="city" />
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
    <table id="datatable" style=" border-radius:5px; border-color:blue;" border="1">
       <thead>
                    <tr style=" color:black;">
                        <th>Id</th>
                        <th>Name</th>
                        <th>City</th>
                       <th>Edit</th>
                    </tr>
                </thead>
    </table><br>
        </div>

</asp:Content>
