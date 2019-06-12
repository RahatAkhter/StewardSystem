<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Practice.aspx.cs" Inherits="Train_System.Admin.Practice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script src="Scripts/jquery-1.6.4.min.js"></script>
     
    <script src="Scripts/jquery.signalR-2.4.0.min.js"></script>
    <script src="/signalR/hubs"></script>
    
    
  

    <script type="text/javascript">
         $(document).ready(function () {
          //  $('#chatbox').hide();
             getData();
            
           

                           $.connection.hub.start();

        });

          
        var job;
        $(function () {
           
           
                job = $.connection.myHub;

            job.client.displayStatus = function () {
                getData();
                    console.log("p");
                };
                //$.connection.hub.start();
                // $.connection.hub.stop();
           
           

               $.connection.hub.start();

            getData();
                console.log("start");
           myHub.disconnect(function() {
  alert('Server has disconnected');
});
           
});


           function getData() {

            var $tbl = $('#tblSteward');

             $.ajax({

                    type: "POST",
                    contentType: "application/json",
                    url: 'Practice.aspx/Get_Data',
                    data: "{}",
                    datatype: "json",
                 success: function (data) {
                     console.log("pakka");
                     debugger;
                            var newdata = data.d;
                        $tbl.empty();
                        $tbl.append('<tr><th>SNo</th><th>Train_Id</th><th>Name</th><th>Source</th><th>Destination</th><th>Status</th><th>Date</th><th>Time_In</th><th>Time_Out</th><th>Checkin</th><th>CheckOut</th><th>Train_At</th></tr>');
                            var rows = [];
                        for (var i = 0; i < newdata.length; i++) {
             //               alert(newdata[i].train_id);
                                    rows.push('<tr><td>' + newdata[i].steward_id + '</td><td>' + newdata[i].train_id + '</td><td>' + newdata[i].uname + '</td><td>' + newdata[i].source + '</td><td>' + newdata[i].destination + '</td><td>' + newdata[i].status + '</td><td>'+newdata[i].date+'</td><td>'+newdata[i].time_in+'</td><td>'+newdata[i].time_out+'</td><td>'+newdata[i].checkin+'</td><td>'+newdata[i].checkout+'</td><td>'+newdata[i].train_id+'</td></tr>');

                            }
                            $tbl.append(rows.join(''));
                        

                    },
                    error: function (err) {
                        Console.log(err + "errooorr he");
                    }
            });

            //setTimeout(getData, 2000);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
         <div>
    <h5>Stewards</h5>
    <table id="tblSteward" style=" width:100%; height:400px; overflow:scroll;" >
      
    </table><br />
        </div>

    </form>
</body>
</html>
