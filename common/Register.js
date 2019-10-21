
  

   
//******************************************************************************************************************************-->
          function blank() {
          var user_val = document.forms["myForm"]["username1"].value;
          if (user_val == "") {

          document.getElementById("username_alert").innerHTML = "Error: Username cannot be blank!";
          return 1;
          }

          }

//*******************************************************************************************************************************-->
          function letter_num() {
         var user = document.getElementById("username1");       
         re = /^\w+$/;
         if(!re.test(user.value)) {
         document.getElementById("username_alert").innerHTML = "Error: Username must contain only letters, numbers and underscores!";
         user.focus();
         return 1;
           }
          }

//********************************************************************************************************************************-->
          function pass_length () {
          var pass = document.forms["myForm"]["password1"];
          if(pass.value.length &lt; 6) {
         
          document.getElementById("password1_alert").innerHTML = "Error: Password must contain at least six characters!";
          pass.focus();
          return 1;
          }
          
          }
//********************************************************************************************************************************-->
          function password_format1 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];

          if(pass.value==user.value) {
          document.getElementById("password1_alert").innerHTML = "Error: Password must be different from Username!";
          pass.focus();
          return 1;
          }

          }

//********************************************************************************************************************************-->

//********************************************************************************************************************************-->
          function password_format2 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re = /[0-9]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one number (0-9)!";
          pass.focus();
          return 1;
          }

          }

//********************************************************************************************************************************-->
          function password_format3 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re = /[a-z]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one lowercase letter (a-z)!";
          pass.focus();
          return 1;
          }

          }
//********************************************************************************************************************************-->

          function password_format4 () {
          var pass = document.forms["myForm"]["password1"];
          var user = document.forms["myForm"]["username1"];
          re =  /[A-Z]/;
          if(!re.test(pass.value)) {
          document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one uppercase letter (A-Z)!";
          pass.focus();
          return 1;
          }

          }

//********************************************************************************************************************************-->

          function password_format5 () {
          var pass = document.forms["myForm"]["password1"];
          var pass2 = document.forms["myForm"]["password2"];
          if(pass.value!=pass2.value) {
          document.getElementById("password1_alert").innerHTML = "Error: check your password again.both passwords shuld be the same!";
          pass.focus();
          return 1;
          }

          }

//********************************************************************************************************************************-->
          function validateForm() {
          k=blank();
          if (k=='1'){  return false;}
          k=letter_num();
          if (k=='1'){  return false;}
          k=pass_length();
          if (k=='1'){  return false;}
          k=password_format1();
          if (k=='1'){  return false;}
          k=password_format2();
          if (k=='1'){  return false;}
          k=password_format3();
          if (k=='1'){  return false;}
          k=password_format4();
          if (k=='1'){  return false;}
          k=password_format5();
          if (k=='1'){  return false;}

          }




