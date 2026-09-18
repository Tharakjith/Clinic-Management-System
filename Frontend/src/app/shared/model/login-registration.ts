import { Staff } from "./staff";

export class LoginRegistration {
    "RegistrationId":number = 0;
    "StaffId":number = 0;
    RoleId:number = 0;
    "Username":string='';
    "Password":string='';
    "RisActive":boolean = false;
    "RegistrateredDate": Date = new Date();
    
    staff:Staff=new Staff();
}
