<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Engines.aspx.cs" Inherits="Train_System.Admin.Engines" %>
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
           
                   { 'data': 'eng_id' },
                    { 'data': 'e_name' },
                    { 'data': 'status' },
                    
                    {'data':'modal_num'},
                    {'data':'year_of_manu'},                     
                    {'data':'chasis_no'},
                    {
                        'data': 'eng_id',
                        'render': function (webSite) {
                            
                            return ' <button type="button" class=" btn btn-primary" value="'+webSite+'" onclick="Edit(this.value);">Edit</button>';
                        }
                        

                    }

                        ],
                bServerSide: true,
                sAjaxSource: 'Admin_Service.asmx/GetAll_Engines',
                sServerMethod: 'post'
            });


        });
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
        <label>Name</label>
                      <input type="text" id="name" />

        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Chahis No</label>
                        <input type="text" id="cno" />
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Modal No</label>
       <input type="text" id="modal" />
                      </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>year Of Manu</label>
                    <input type="date" id="manu" />
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
    <table id="datatable" border="1" style=" border-radius:5px; border-color:blue; width:100%;">
       <thead>
                    <tr style=" color:black">
                        <th>Id</th>
                        <th>Name</th>
                        <th>Status</th>
                       <th>Modal No</th>
                        <th>YearOf Manu</th>
                        <th>Chasis No</th>
                        <th>Edit</th>
                    </tr>
                </thead>
    </table><br>
        </div>
    </body>
</asp:Content>
