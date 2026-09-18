import { Role } from "./role";
import { Staff } from "./staff";

export class User {


  
 Username:string ='';
 RegistrationId: number =0;
 Password:string='';
 RoleId: number =0;
 StaffId: number=0;
 
 Token :  string ='';
 RIsActive: boolean= false;
 RegisteredDate: Date = new Date(); 
Staff : Staff = new Staff();
Role : Role = new Role();
}
