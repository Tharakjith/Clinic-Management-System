import { Role } from "./role";
import { Staff } from "./staff";

export class Registration {
    Username: string = '';
    RegistrationId: number = 0;
    Password: string = '';
    RoleId: number = 0;
    StaffId: number = 0;
    StaffName: string = '';
    Token: string = '';
    RisActive: boolean = false;
    RoleName: string = '';
    RegisteredDate: Date = new Date();

    Staff: Staff = new Staff();
    Role: Role = new Role();
}