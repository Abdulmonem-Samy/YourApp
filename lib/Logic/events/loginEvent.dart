
//////////////////LoginEvent/////////////////
class LoginEvent{
   final String email;
   final String pass;
   const LoginEvent({required this.email,required this.pass});
}


//////////////////CreateEvent/////////////////

class CreateEvent{
   final String name;
   final String email;
   final String pass;
   const CreateEvent({
      required this.name,
      required this.email,
      required this.pass,
      });
}

