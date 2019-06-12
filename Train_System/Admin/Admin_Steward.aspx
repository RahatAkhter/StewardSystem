<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Admin_Steward.aspx.cs" Inherits="Train_System.Admin_Steward" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>

     
<script type="text/javascript"> 
    var id1;
    $(document).ready(function () {

        $('#datatable').DataTable({
          "aLengthMenu": [[10, 25, 50, 100,5], [10, 25, 50, 100, 5]],
                "iDisplayLength": 5,
                columns: [
           
                   { 'data': 'User_Id' },
                    { 'data': 'User_Name' },
                    { 'data': 'Email' },
                    { 'data': 'Password' },
                    { 'data': 'Age' },
                    {
                        'data': 'Img',
                        'render': function (webSite) {
                                    return '<img src="' + webSite + '" class="img " />';
                            
                                //return '<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="img " />';
                            
                        }
                        

                    },
                    { 'data': 'gender' },
                    {
                                'data': 'User_Id',
                                'sortable': false,
                                'searchable': false,
                        'render': function (webSite) {
                            return ' <button type="button" class=" btn btn-primary" value="'+webSite+'" onclick="Edit(this.value);">Edit</button>';       
                                }
                            }
                   
                            
                                        
                    ],
                bServerSide: true,
                sAjaxSource: 'Admin_Service.asmx/GetAll_Users',
                sServerMethod: 'post'
            });

    });

    function Update() {
        
        var name = $('#name1').val();
        var email = $('#email1').val();
        
        var p1 = $('#p11').val();
        var p2 = $('#p21').val();

        var age = $('#age1').val();
       var ddl = document.getElementById("<%=DropDownList2.ClientID%>");
        var gender = ddl.options[ddl.selectedIndex].text;

        //        alert(name+""+email+""+""+p1+""+p1+""+age+""+gender);
        if (name1 != "" && email1 != "" && p11 != "" && p21 != "" && age1 != "" && id1!="") {
            if (p1 == p1) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Admin_Steward.aspx/Update',
                    data: "{'name':'" + name + "','email':'" + email + "','p1':'" + p1 + "','p2':'" + p2 + "','gen':'" + gender + "','age':'" + age + "','id':'" + id1 + "'}",
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
                        id1 = "";
                        $('#name').val("");
                        $('#p1').val("");
                        $('#p2').val("");
                        $('#age').val("");
                        $('#email').val("");
                    },
                    Error: function (res) {
                        alert("not inserted" + res);

                    }
                });
            }
            else {

                Swal.fire({
  type: 'error',
  title: 'Password Dont Match',
  text: '',
  footer: ''
})
            }
        }else {
              Swal.fire({
  type: 'error',
  title: 'Error!',
  text: 'Please Fill The Form Correctly',
  footer: ''
})
        }
    }


    

    function Edit(Val) {

        

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Admin_Steward.aspx/Get_Data',
                    data: "{'id':'" + Val + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {
                        
                    for (var i = 0; i < data.d.length; i++) {
                           $('#name1').val(data.d[i].User_Name);
                        $('#p11').val(data.d[i].Password);
                        $('#p21').val(data.d[i].Password);
                        $('#age1').val(data.d[i].Age);
                        $('#email1').val(data.d[i].Email);
                        id1 = data.d[i].User_Id;
                        $('#myModal1').modal('show');

                    }

                    },
                    Error: function (res) {
                    Swal.fire({
  type: 'error',
  title: 'Oops...',
  text: 'Something went wrong!',
  footer: ''
})

                    }
                });

    }


    function Save() {


        var name = $('#name').val();
        var email = $('#email').val();
        
        var p1 = $('#p1').val();
        var p2 = $('#p2').val();

        var age = $('#age').val();
       var ddl = document.getElementById("<%=DropDownList1.ClientID%>");
        var gender = ddl.options[ddl.selectedIndex].text;

        //        alert(name+""+email+""+""+p1+""+p1+""+age+""+gender);
        if (name != "" && email != "" && p1 != "" && p2 != "" && age != "") {
            if (p1 == p1) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Admin_Steward.aspx/Insert',
                    data: "{'name':'" + name + "','email':'" + email + "','p1':'" + p1 + "','p2':'" + p2 + "','gen':'" + gender + "','age':'" + age + "'}",
                    dataType: "json",
                    async: false,

                    success: function (data) {

                        Swal.fire({
  position: 'center',
  type: 'success',
  title: 'Your work has been saved',
  showConfirmButton: false,
  timer: 2000
})
                        $('#name').val("");
                        $('#p1').val("");
                        $('#p2').val("");
                        $('#age').val("");
                        $('#email').val("");
                    },
                    Error: function (res) {
                       Swal.fire({
  type: 'error',
  title: 'Error',
  text: 'Something went wrong!',
  footer: ''
})

                    }
                });
            }
            else {

                alert("Retype Password Dont match");
            }
        }else {
              Swal.fire({
  type: 'error',
  title: 'Error',
  text: 'Please Fill The Form Correctly',
  footer: ''
})
        }
    }
    

</script>
    <style>
        .img{
            height:50px;
            width:50px;
        }
        .bc{
            border-color: blue;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Stewards</h1>
            <%--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" data-toggle="modal" data-target="#myModal"><i class="fas fa-user-plus  fa-sm text-white-50"></i>Add Steward</a>--%>
          </div>
    <div class=" container">
        <div class=" row">
            <div class="col-sm-12 ">
                <button type="button" class="btn btn-primary btn-lg fa-pull-right" data-toggle="modal" data-target="#myModal">Add New Steward</button>
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
        <label>User Name</label>
        <input type="text" class=" form-control" placeholder="User Name" id="name" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Email</label>
        <input type="email" class=" form-control" placeholder="User Email" id="email" />
        </div>
      
              </div>
          </div>
        
      
      
      

        
        <div class="row">
           <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Password</label>
        <input type="password" class=" form-control" placeholder="Password" id="p1" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Retype Password</label>
        <input type="Password" class=" form-control" placeholder="Password" id="p2" />
        </div>
      
              </div>
        </div>
        <div class=" row">
            <div class="col-sm-6">
                <div class=" form-group">
        <label for=" comment">User Age</label>
        <input type="number" id="age" class=" form-control" placeholder="Age" min="2" max="2"  />
        
        </div>
        
            </div>
            <div class="col-sm-6">
                        <div class=" form-group">
        <label for=" comment">Gender</label>
                            <asp:DropDownList ID="DropDownList1" style=" width:100%;" runat="server">
                                <asp:ListItem Text="Male" Value="0" />
         <asp:ListItem Text="Femail" Value="1" />
                            </asp:DropDownList>
        </div>
        
            </div>
        </div>
          <div class="row">
              <div class="col-sm-12 text-center">
                  <button type="button" class="btn btn-primary" onclick=" Save()">Save</button>
                  
              </div>
          </div>
       <br />
          <hr />

          <div class="row">
                  <!--//Image/Untitled3.png-->
              <div class=" col-sm-12">
      <div class="text-center">
        <h6>Upload a different photo...</h6>

    <asp:FileUpload ID="FileUpload1" runat="server"  CssClass=" text-center"/>
    <br />
    <asp:Button ID="btn_img_save" runat="server" Text="Save Image" 
              CssClass=" btn btn-primary btn-md"  onclick="btn_img_save_Click" />      
      </div>
                  </div>
          </div>
      </div>
      <div class="modal-footer">
      
        <button class=" btn btn-primary btn-lg" type="button" onclick="Save();" value="ppp" id="btnsave" runat="server">Save</button>
        <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal">Close</button>
      
      </div>
        
    </div>

  </div>
</div>
   </div>
   </div>
   
   </div>
    <!--Yahan Se Shuru Hoga-->

    
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
        <label>User Name</label>
        <input type="text" class=" form-control" placeholder="User Name" id="name1" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Email</label>
        <input type="email" class=" form-control" placeholder="User Email" id="email1" />
        </div>
      
              </div>
          </div>
        
      
      
      

        
        <div class="row">
           <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Password</label>
        <input type="password" class=" form-control" placeholder="Password" id="p11" maxlength="30" />
        </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Retype Password</label>
        <input type="Password" class=" form-control" placeholder="Password" id="p21" />
        </div>
      
              </div>
        </div>
        <div class=" row">
            <div class="col-sm-6">
                <div class=" form-group">
        <label for=" comment">User Age</label>
        <input type="number" id="age1" class=" form-control" placeholder="Age"   />
        
        </div>
        
            </div>
            <div class="col-sm-6">
                        <div class=" form-group">
        <label for=" comment">Gender</label>
                            <asp:DropDownList ID="DropDownList2" style=" width:100%;" runat="server">
                                <asp:ListItem Text="Male" Value="0" />
         <asp:ListItem Text="Femail" Value="1" />
                            </asp:DropDownList>
        </div>
        
            </div>
        </div>
          <div class="row">
              <div class="col-sm-12 text-center">
                  <button type="button" class="btn btn-primary" onclick=" Update()">Update1</button>
                  
              </div>
          </div>
       <br />
          <hr />

          <div class="row">
                  <!--//Image/Untitled3.png-->
              <div class=" col-sm-12">
      <div class="text-center">
        <h6>Upload a different photo...</h6>

    <asp:FileUpload ID="FileUpload2" runat="server"  CssClass=" text-center"/>
    <br />
    <asp:Button ID="btn_img_save1" runat="server" Text="Update Image" 
              CssClass=" btn btn-primary btn-md"  onclick="btn_img_save_Click1" />      
      </div>
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
    <table id="datatable" class="cell-border bc" style=" border-radius:5px; border-color:blue" border="1">
       <thead>
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Age</th>
                        <th>Picture</th>
                        <th>Gender</th>
                       <th>Edit</th>
                    </tr>
                </thead>
    </table><br>
        </div>
</asp:Content>
