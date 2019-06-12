<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin_Master.Master" AutoEventWireup="true" CodeBehind="Steward_Train.aspx.cs" Inherits="Train_System.Admin.Steward_Train" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script src="Scripts/jquery-1.6.4.min.js"></script>
     
    <script src="Scripts/jquery.signalR-2.4.0.min.js"></script>
    <script src="/signalR/hubs"></script>
    
    

    <script type="text/javascript">
        //var j$ = jQuery.noConflict();
        //$(document).ready(function () {
        //     //  $('#chatbox').hide();
        //    // getData()
        //              $.connection.hub.start();

        //});

         $(function () {
        // Declare a proxy to reference the hub.
        var notifications = $.connection.myHub;
       
        //debugger;
             // Create a function that the hub can call to broadcast messages.
             notifications.client.displayStatus = function () {
                 getData();
           
        };
        // Start the connection.
        $.connection.hub.start().done(function () {
          //  alert("connection started")
            getData();
        }).fail(function (e) {
            alert(e);
        });
    });


//          var job;
//        $(function () {
           
           
//               job = $.connection.myHub;

//            job.client.displayStatus = function () {
//                getData();
//                    console.log("p");
//                };
//            //    //$.connection.hub.start();
//            //    // $.connection.hub.stop();
           
           

//            //   $.connection.hub.start();

//            //getData();
//            //    console.log("start");
//            $.connection.hub.start().done(function () {
//                alert("started");
                
//});
        
           
//});

        function Save() {

            var x = document.getElementById('date');
            date = x.value;

            var timein = $('#time_in').val();
            var timeout = $('#time_out').val();

            
             var ddl = document.getElementById("<%=DropDownList1.ClientID%>");
        var tid = ddl.options[ddl.selectedIndex].value;

            
             var ddl1 = document.getElementById("<%=DropDownList2.ClientID%>");
        var uid = ddl1.options[ddl1.selectedIndex].value;

             var ddl2 = document.getElementById("<%=DropDownList3.ClientID%>");
        var s_id = ddl2.options[ddl2.selectedIndex].value;

             var ddl3 = document.getElementById("<%=DropDownList4.ClientID%>");
        var d_id = ddl3.options[ddl3.selectedIndex].value;

            alert(timein + " " + timeout + " " + tid + " " + " " + uid + " " + s_id + " " + " " + d_id);
            if (date != "" && timein != "" && timeout != "" && tid != "" && uid != ""&& s_id != "" && d_id != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Steward_Train.aspx/Insert',
                    data: "{'timein':'" + timein + "','tout':'" + timeout + "','tid':'" + tid + "','uid':'" + uid + "','s_id':'" + s_id + "','date':'" + date + "','desti':'" + d_id + "'}",
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

            }else {

                alert("Please Fill Form Correctly");
            }
        }

        function getData() {

            var $tbl = $('#tblSteward');

             $.ajax({

                    type: "POST",
                    contentType: "application/json",
                    url: 'Steward_Train.aspx/Get_Data',
                    data: "{}",
                    datatype: "json",
                 success: function (data) {
                     console.log("pakka");
                     debugger;
                            var newdata = data.d;
                        $tbl.empty();
                        $tbl.append('<tr style=" color:black;"><th>ID</th><th>Train_Id</th><th>Name</th><th>Source</th><th>Destination</th><th>Status</th><th>Date</th><th>Time_In</th><th>Time_Out</th><th>Checkin</th><th>CheckOut</th><th>Train_At</th></tr>');
                            var rows = [];
                        for (var i = 0; i < newdata.length; i++) {
             //               alert(newdata[i].train_id);
                                    rows.push('<tr><td>' + newdata[i].steward_id + '</td><td>' + newdata[i].train_id + '</td><td>' + newdata[i].uname + '</td><td>' + newdata[i].source + '</td><td>' + newdata[i].destination + '</td><td>' + newdata[i].status + '</td><td>'+newdata[i].date+'</td><td>'+newdata[i].time_in+'</td><td>'+newdata[i].time_out+'</td><td>'+newdata[i].checkin+'</td><td>'+newdata[i].checkout+'</td><td>'+newdata[i].train_At+'</td></tr>');

                            }
                            $tbl.append(rows.join(''));
                        

                    },
                    error: function (err) {
                        Console.log(err + "errooorr he");
                    }
            });

            
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
 <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Assign Steward</h1>
            <%--<a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" data-toggle="modal" data-target="#myModal"><i class="fas fa-user-plus  fa-sm text-white-50"></i>Add Steward</a>--%>
          </div>
    <div class=" container">
        <div class=" row">
            <div class="col-sm-12 ">
                <button type="button" class="btn btn-primary btn-lg fa-pull-right" data-toggle="modal" data-target="#myModal">Assign New Task</button>
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
        <label>Select Train</label>
                      
                        <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>

                  </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Select Steward</label>
        
                        
                        <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
          <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Select Source</label>
                      
                        <asp:DropDownList ID="DropDownList3" runat="server"></asp:DropDownList>

                  </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Select Destination</label>
        
                        
                        <asp:DropDownList ID="DropDownList4" runat="server"></asp:DropDownList>
                    </div>
      
              </div>
          </div>
        
            <div class="row">
              <div class=" col-sm-6">
                  <div class=" form-group">
        <label>Assign IN Time</label>
                      
                      <input type="time" id="time_in" />
                  </div>
              </div>
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Assign Out Time</label>
        
                    <input type="time" id="time_out" />    
                    
                    </div>
      
              </div>
          </div>
        
              <div class="row">
              
              <div class=" col-sm-6">
                    <div class=" form-group">
        <label>Select Date</label>
        
                    <input type="date" id="date" />    
                    
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
    <h5>Stewards</h5>
    <table id="tblSteward" style=" width:100%; height:400px; overflow:scroll; border-radius:5px;border-color:blue"  border="1"  >
      
    </table><br>
        </div>

</asp:Content>
